import { Test, TestingModule } from '@nestjs/testing';
import { INestApplication, ValidationPipe } from '@nestjs/common';
import * as request from 'supertest';
import { AppModule } from '../src/app.module';
import { PrismaService } from '../src/prisma/prisma.service';

describe('Ledger Integration Tests (e2e)', () => {
  let app: INestApplication;
  let prisma: PrismaService;
  let authToken: string;
  let testCompanyId: string;
  let testPeriodId: string;
  let testAccountId: string;
  let testJournalEntryId: string;

  beforeAll(async () => {
    const moduleFixture: TestingModule = await Test.createTestingModule({
      imports: [AppModule],
    }).compile();

    app = moduleFixture.createNestApplication();
    app.useGlobalPipes(new ValidationPipe({ whitelist: true, transform: true }));
    await app.init();

    prisma = moduleFixture.get<PrismaService>(PrismaService);

    // Setup test data
    await setupTestData();
  });

  afterAll(async () => {
    // Cleanup
    await cleanupTestData();
    await app.close();
  });

  const setupTestData = async () => {
    // Create test user and get auth token
    const userResponse = await request(app.getHttpServer())
      .post('/auth/register')
      .send({
        email: 'ledger-test@test.com',
        password: 'Test123!@#',
        firstName: 'Ledger',
        lastName: 'Test',
        role: 'ADMIN',
      });

    const loginResponse = await request(app.getHttpServer())
      .post('/auth/login')
      .send({
        email: 'ledger-test@test.com',
        password: 'Test123!@#',
      });

    authToken = loginResponse.body.access_token;

    // Create test company
    const companyResponse = await request(app.getHttpServer())
      .post('/companies')
      .set('Authorization', `Bearer ${authToken}`)
      .send({
        name: 'Test Company for Ledger',
        code: 'TESTLEDGER',
        baseCurrency: 'USD',
      });

    testCompanyId = companyResponse.body.id;

    // Create test period
    const periodResponse = await request(app.getHttpServer())
      .post('/periods')
      .set('Authorization', `Bearer ${authToken}`)
      .send({
        companyId: testCompanyId,
        name: '2024 Fiscal Year',
        startDate: '2024-01-01',
        endDate: '2024-12-31',
      });

    testPeriodId = periodResponse.body.id;

    // Create test account
    const accountResponse = await request(app.getHttpServer())
      .post('/accounts')
      .set('Authorization', `Bearer ${authToken}`)
      .send({
        companyId: testCompanyId,
        name: 'Cash',
        code: '1000',
        accountTypeId: 1, // Asset
        openingBalance: 10000,
      });

    testAccountId = accountResponse.body.id;
  };

  const cleanupTestData = async () => {
    if (testCompanyId) {
      await prisma.company.delete({ where: { id: testCompanyId } }).catch(() => {});
    }
  };

  describe('POST /ledger/generate', () => {
    it('should generate ledger entries from a posted journal entry', async () => {
      // Create and post a journal entry
      const journalResponse = await request(app.getHttpServer())
        .post('/journal-entries')
        .set('Authorization', `Bearer ${authToken}`)
        .send({
          companyId: testCompanyId,
          periodId: testPeriodId,
          entryNumber: 'JE-001',
          entryDate: '2024-01-15',
          description: 'Test journal entry',
          lineItems: [
            {
              accountId: testAccountId,
              debitAmount: 1000,
              creditAmount: 0,
              description: 'Debit entry',
            },
            {
              accountId: testAccountId,
              debitAmount: 0,
              creditAmount: 1000,
              description: 'Credit entry',
            },
          ],
        });

      testJournalEntryId = journalResponse.body.id;

      // Post the journal entry
      await request(app.getHttpServer())
        .post(`/journal-entries/${testJournalEntryId}/post`)
        .set('Authorization', `Bearer ${authToken}`)
        .expect(200);

      // Verify ledger entries were created
      const response = await request(app.getHttpServer())
        .get('/ledger')
        .set('Authorization', `Bearer ${authToken}`)
        .query({
          companyId: testCompanyId,
          periodId: testPeriodId,
          accountId: testAccountId,
        })
        .expect(200);

      expect(response.body.entries).toHaveLength(2);
      expect(response.body.entries[0]).toHaveProperty('runningBalance');
      expect(response.body.entries[1]).toHaveProperty('runningBalance');
    });
  });

  describe('GET /ledger', () => {
    it('should retrieve ledger entries with correct running balances', async () => {
      const response = await request(app.getHttpServer())
        .get('/ledger')
        .set('Authorization', `Bearer ${authToken}`)
        .query({
          companyId: testCompanyId,
          periodId: testPeriodId,
          accountId: testAccountId,
        })
        .expect(200);

      expect(response.body).toHaveProperty('openingBalance');
      expect(response.body).toHaveProperty('entries');
      expect(response.body).toHaveProperty('closingBalance');
      expect(Array.isArray(response.body.entries)).toBe(true);
    });

    it('should filter ledger entries by date range', async () => {
      const response = await request(app.getHttpServer())
        .get('/ledger')
        .set('Authorization', `Bearer ${authToken}`)
        .query({
          companyId: testCompanyId,
          periodId: testPeriodId,
          accountId: testAccountId,
          startDate: '2024-01-01',
          endDate: '2024-01-31',
        })
        .expect(200);

      expect(response.body.entries).toBeDefined();
      response.body.entries.forEach((entry: any) => {
        const entryDate = new Date(entry.transactionDate);
        expect(entryDate).toBeInstanceOf(Date);
      });
    });

    it('should return 400 for missing required parameters', async () => {
      await request(app.getHttpServer())
        .get('/ledger')
        .set('Authorization', `Bearer ${authToken}`)
        .query({
          companyId: testCompanyId,
          // Missing periodId and accountId
        })
        .expect(400);
    });
  });

  describe('POST /ledger/recalculate', () => {
    it('should recalculate running balances for an account', async () => {
      const response = await request(app.getHttpServer())
        .post('/ledger/recalculate')
        .set('Authorization', `Bearer ${authToken}`)
        .send({
          companyId: testCompanyId,
          periodId: testPeriodId,
          accountId: testAccountId,
        })
        .expect(200);

      expect(response.body).toHaveProperty('updated');
      expect(typeof response.body.updated).toBe('number');
    });
  });

  describe('GET /ledger/export', () => {
    it('should export ledger to Excel', async () => {
      const response = await request(app.getHttpServer())
        .get('/ledger/export')
        .set('Authorization', `Bearer ${authToken}`)
        .query({
          companyId: testCompanyId,
          periodId: testPeriodId,
          accountId: testAccountId,
          format: 'EXCEL',
        })
        .expect(200);

      expect(response.headers['content-type']).toContain('spreadsheetml');
    });

    it('should export ledger to CSV', async () => {
      const response = await request(app.getHttpServer())
        .get('/ledger/export')
        .set('Authorization', `Bearer ${authToken}`)
        .query({
          companyId: testCompanyId,
          periodId: testPeriodId,
          accountId: testAccountId,
          format: 'CSV',
        })
        .expect(200);

      expect(response.headers['content-type']).toContain('text/csv');
    });
  });

  describe('Journal Entry Integration', () => {
    it('should automatically create ledger entries when posting journal', async () => {
      // Create new journal entry
      const journalResponse = await request(app.getHttpServer())
        .post('/journal-entries')
        .set('Authorization', `Bearer ${authToken}`)
        .send({
          companyId: testCompanyId,
          periodId: testPeriodId,
          entryNumber: 'JE-002',
          entryDate: '2024-01-20',
          description: 'Another test entry',
          lineItems: [
            {
              accountId: testAccountId,
              debitAmount: 500,
              creditAmount: 0,
              description: 'Test debit',
            },
            {
              accountId: testAccountId,
              debitAmount: 0,
              creditAmount: 500,
              description: 'Test credit',
            },
          ],
        });

      const newJournalId = journalResponse.body.id;

      // Get ledger entries before posting
      const beforeResponse = await request(app.getHttpServer())
        .get('/ledger')
        .set('Authorization', `Bearer ${authToken}`)
        .query({
          companyId: testCompanyId,
          periodId: testPeriodId,
          accountId: testAccountId,
        });

      const entriesBeforeCount = beforeResponse.body.entries.length;

      // Post the journal entry
      await request(app.getHttpServer())
        .post(`/journal-entries/${newJournalId}/post`)
        .set('Authorization', `Bearer ${authToken}`)
        .expect(200);

      // Get ledger entries after posting
      const afterResponse = await request(app.getHttpServer())
        .get('/ledger')
        .set('Authorization', `Bearer ${authToken}`)
        .query({
          companyId: testCompanyId,
          periodId: testPeriodId,
          accountId: testAccountId,
        });

      const entriesAfterCount = afterResponse.body.entries.length;

      // Should have 2 more entries (one for each line item)
      expect(entriesAfterCount).toBe(entriesBeforeCount + 2);
    });

    it('should maintain correct running balance sequence', async () => {
      const response = await request(app.getHttpServer())
        .get('/ledger')
        .set('Authorization', `Bearer ${authToken}`)
        .query({
          companyId: testCompanyId,
          periodId: testPeriodId,
          accountId: testAccountId,
        });

      const entries = response.body.entries;
      
      // Verify running balances are sequential
      for (let i = 1; i < entries.length; i++) {
        const prevBalance = parseFloat(entries[i - 1].runningBalance);
        const currBalance = parseFloat(entries[i].runningBalance);
        const debit = parseFloat(entries[i].debitAmount);
        const credit = parseFloat(entries[i].creditAmount);

        // Check that current balance = previous balance + debit - credit
        const expectedBalance = prevBalance + debit - credit;
        expect(Math.abs(currBalance - expectedBalance)).toBeLessThan(0.01); // Allow for rounding
      }
    });
  });
});
