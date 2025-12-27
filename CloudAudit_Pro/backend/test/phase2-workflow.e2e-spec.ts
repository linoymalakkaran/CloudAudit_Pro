import { Test, TestingModule } from '@nestjs/testing';
import { INestApplication, ValidationPipe } from '@nestjs/common';
import * as request from 'supertest';
import { AppModule } from '../src/app.module';
import { PrismaService } from '../src/prisma/prisma.service';

describe('Phase 2 End-to-End Workflow Tests', () => {
  let app: INestApplication;
  let prisma: PrismaService;
  let authToken: string;
  let testCompanyId: string;
  let testPeriodId: string;
  let cashAccountId: string;
  let bankAccountId: string;
  let revenueAccountId: string;

  beforeAll(async () => {
    const moduleFixture: TestingModule = await Test.createTestingModule({
      imports: [AppModule],
    }).compile();

    app = moduleFixture.createNestApplication();
    app.useGlobalPipes(new ValidationPipe({ whitelist: true, transform: true }));
    await app.init();

    prisma = moduleFixture.get<PrismaService>(PrismaService);

    await setupTestEnvironment();
  });

  afterAll(async () => {
    await cleanupTestEnvironment();
    await app.close();
  });

  const setupTestEnvironment = async () => {
    // Register and login
    await request(app.getHttpServer())
      .post('/auth/register')
      .send({
        email: 'e2e-test@test.com',
        password: 'Test123!@#',
        firstName: 'E2E',
        lastName: 'Test',
        role: 'ADMIN',
      });

    const loginResponse = await request(app.getHttpServer())
      .post('/auth/login')
      .send({
        email: 'e2e-test@test.com',
        password: 'Test123!@#',
      });

    authToken = loginResponse.body.access_token;

    // Create company
    const companyResponse = await request(app.getHttpServer())
      .post('/companies')
      .set('Authorization', `Bearer ${authToken}`)
      .send({
        name: 'E2E Test Company',
        code: 'E2E',
        baseCurrency: 'USD',
      });

    testCompanyId = companyResponse.body.id;

    // Create period
    const periodResponse = await request(app.getHttpServer())
      .post('/periods')
      .set('Authorization', `Bearer ${authToken}`)
      .send({
        companyId: testCompanyId,
        name: '2024 Q1',
        startDate: '2024-01-01',
        endDate: '2024-03-31',
      });

    testPeriodId = periodResponse.body.id;

    // Create accounts
    const cashResponse = await request(app.getHttpServer())
      .post('/accounts')
      .set('Authorization', `Bearer ${authToken}`)
      .send({
        companyId: testCompanyId,
        name: 'Cash',
        code: '1000',
        accountTypeId: 1,
        openingBalance: 50000,
      });

    cashAccountId = cashResponse.body.id;

    const bankResponse = await request(app.getHttpServer())
      .post('/accounts')
      .set('Authorization', `Bearer ${authToken}`)
      .send({
        companyId: testCompanyId,
        name: 'Bank Account',
        code: '1010',
        accountTypeId: 1,
        openingBalance: 100000,
      });

    bankAccountId = bankResponse.body.id;

    const revenueResponse = await request(app.getHttpServer())
      .post('/accounts')
      .set('Authorization', `Bearer ${authToken}`)
      .send({
        companyId: testCompanyId,
        name: 'Service Revenue',
        code: '4000',
        accountTypeId: 5, // Revenue
        openingBalance: 0,
      });

    revenueAccountId = revenueResponse.body.id;
  };

  const cleanupTestEnvironment = async () => {
    if (testCompanyId) {
      await prisma.company.delete({ where: { id: testCompanyId } }).catch(() => {});
    }
  };

  describe('Complete Accounting Workflow', () => {
    it('should complete full workflow: Journal → Ledger → Trial Balance → Financial Statements', async () => {
      // Step 1: Create and post multiple journal entries
      const journals = [];
      
      // Journal 1: Cash received for services
      const je1Response = await request(app.getHttpServer())
        .post('/journal-entries')
        .set('Authorization', `Bearer ${authToken}`)
        .send({
          companyId: testCompanyId,
          periodId: testPeriodId,
          entryNumber: 'JE-001',
          entryDate: '2024-01-05',
          description: 'Cash received for services',
          lineItems: [
            {
              accountId: cashAccountId,
              debitAmount: 5000,
              creditAmount: 0,
              description: 'Cash received',
            },
            {
              accountId: revenueAccountId,
              debitAmount: 0,
              creditAmount: 5000,
              description: 'Service revenue',
            },
          ],
        });

      journals.push(je1Response.body.id);

      // Journal 2: Transfer cash to bank
      const je2Response = await request(app.getHttpServer())
        .post('/journal-entries')
        .set('Authorization', `Bearer ${authToken}`)
        .send({
          companyId: testCompanyId,
          periodId: testPeriodId,
          entryNumber: 'JE-002',
          entryDate: '2024-01-10',
          description: 'Transfer to bank',
          lineItems: [
            {
              accountId: bankAccountId,
              debitAmount: 3000,
              creditAmount: 0,
              description: 'Bank deposit',
            },
            {
              accountId: cashAccountId,
              debitAmount: 0,
              creditAmount: 3000,
              description: 'Cash withdrawal',
            },
          ],
        });

      journals.push(je2Response.body.id);

      // Post all journals
      for (const journalId of journals) {
        await request(app.getHttpServer())
          .post(`/journal-entries/${journalId}/post`)
          .set('Authorization', `Bearer ${authToken}`)
          .expect(200);
      }

      // Step 2: Verify ledger entries were created
      const cashLedger = await request(app.getHttpServer())
        .get('/ledger')
        .set('Authorization', `Bearer ${authToken}`)
        .query({
          companyId: testCompanyId,
          periodId: testPeriodId,
          accountId: cashAccountId,
        })
        .expect(200);

      expect(cashLedger.body.entries).toHaveLength(2);
      expect(parseFloat(cashLedger.body.openingBalance)).toBe(50000);
      expect(parseFloat(cashLedger.body.closingBalance)).toBe(52000); // 50000 + 5000 - 3000

      // Step 3: Generate Trial Balance
      const trialBalance = await request(app.getHttpServer())
        .post('/trial-balance/generate')
        .set('Authorization', `Bearer ${authToken}`)
        .send({
          companyId: testCompanyId,
          periodId: testPeriodId,
          format: 'DETAILED',
          includeZeroBalances: false,
        })
        .expect(201);

      expect(trialBalance.body.lineItems.length).toBeGreaterThan(0);
      expect(trialBalance.body.summary.isBalanced).toBe(true);
      expect(trialBalance.body.summary.totalDebits).toBe(trialBalance.body.summary.totalCredits);

      // Step 4: Generate Financial Statements
      
      // Generate Balance Sheet
      const balanceSheet = await request(app.getHttpServer())
        .post('/financial-statements/generate')
        .set('Authorization', `Bearer ${authToken}`)
        .send({
          companyId: testCompanyId,
          periodId: testPeriodId,
          statementType: 'BALANCE_SHEET',
          format: 'DETAILED',
        })
        .expect(201);

      expect(balanceSheet.body.statementType).toBe('BALANCE_SHEET');
      expect(balanceSheet.body.lineItems).toBeDefined();
      expect(balanceSheet.body.totals).toBeDefined();

      // Generate Income Statement
      const incomeStatement = await request(app.getHttpServer())
        .post('/financial-statements/generate')
        .set('Authorization', `Bearer ${authToken}`)
        .send({
          companyId: testCompanyId,
          periodId: testPeriodId,
          statementType: 'INCOME_STATEMENT',
          format: 'DETAILED',
        })
        .expect(201);

      expect(incomeStatement.body.statementType).toBe('INCOME_STATEMENT');
      expect(incomeStatement.body.lineItems).toBeDefined();

      // Step 5: Verify data consistency across all components
      
      // Find revenue account in trial balance
      const revenueInTB = trialBalance.body.lineItems.find(
        (item: any) => item.accountId === revenueAccountId
      );
      expect(revenueInTB).toBeDefined();
      expect(parseFloat(revenueInTB.creditBalance)).toBe(5000);

      // Cash account should show net increase of 2000
      const cashInTB = trialBalance.body.lineItems.find(
        (item: any) => item.accountId === cashAccountId
      );
      expect(cashInTB).toBeDefined();
      expect(parseFloat(cashInTB.debitBalance)).toBe(52000);

      console.log('\n✅ Complete workflow test passed:');
      console.log(`   - Created ${journals.length} journal entries`);
      console.log(`   - Generated ${cashLedger.body.entries.length} ledger entries for cash`);
      console.log(`   - Trial Balance: ${trialBalance.body.lineItems.length} accounts, Balanced: ${trialBalance.body.summary.isBalanced}`);
      console.log(`   - Generated Balance Sheet and Income Statement`);
      console.log(`   - All components consistent and balanced\n`);
    });

    it('should handle running balance calculations correctly', async () => {
      // Get ledger for cash account
      const ledger = await request(app.getHttpServer())
        .get('/ledger')
        .set('Authorization', `Bearer ${authToken}`)
        .query({
          companyId: testCompanyId,
          periodId: testPeriodId,
          accountId: cashAccountId,
        })
        .expect(200);

      let expectedBalance = parseFloat(ledger.body.openingBalance);

      for (const entry of ledger.body.entries) {
        expectedBalance += parseFloat(entry.debitAmount) - parseFloat(entry.creditAmount);
        const actualBalance = parseFloat(entry.runningBalance);
        
        expect(Math.abs(actualBalance - expectedBalance)).toBeLessThan(0.01);
      }
    });

    it('should export all reports successfully', async () => {
      // Export Ledger
      await request(app.getHttpServer())
        .get('/ledger/export')
        .set('Authorization', `Bearer ${authToken}`)
        .query({
          companyId: testCompanyId,
          periodId: testPeriodId,
          accountId: cashAccountId,
          format: 'EXCEL',
        })
        .expect(200);

      // Export Trial Balance
      await request(app.getHttpServer())
        .post('/trial-balance/export')
        .set('Authorization', `Bearer ${authToken}`)
        .send({
          companyId: testCompanyId,
          periodId: testPeriodId,
          format: 'EXCEL',
        })
        .expect(200);

      // Export Financial Statement
      await request(app.getHttpServer())
        .post('/financial-statements/export')
        .set('Authorization', `Bearer ${authToken}`)
        .send({
          companyId: testCompanyId,
          periodId: testPeriodId,
          statementType: 'BALANCE_SHEET',
          format: 'DETAILED',
          exportFormat: 'EXCEL',
        })
        .expect(200);
    });
  });

  describe('Data Integrity Tests', () => {
    it('should maintain accounting equation: Assets = Liabilities + Equity', async () => {
      const balanceSheet = await request(app.getHttpServer())
        .post('/financial-statements/generate')
        .set('Authorization', `Bearer ${authToken}`)
        .send({
          companyId: testCompanyId,
          periodId: testPeriodId,
          statementType: 'BALANCE_SHEET',
          format: 'DETAILED',
        })
        .expect(201);

      const assets = parseFloat(balanceSheet.body.totals.totalAssets || '0');
      const liabilities = parseFloat(balanceSheet.body.totals.totalLiabilities || '0');
      const equity = parseFloat(balanceSheet.body.totals.totalEquity || '0');

      expect(Math.abs(assets - (liabilities + equity))).toBeLessThan(0.01);
    });

    it('should ensure trial balance always balances', async () => {
      const trialBalance = await request(app.getHttpServer())
        .post('/trial-balance/generate')
        .set('Authorization', `Bearer ${authToken}`)
        .send({
          companyId: testCompanyId,
          periodId: testPeriodId,
          format: 'DETAILED',
        })
        .expect(201);

      expect(trialBalance.body.summary.isBalanced).toBe(true);
      
      const debits = parseFloat(trialBalance.body.summary.totalDebits);
      const credits = parseFloat(trialBalance.body.summary.totalCredits);
      
      expect(Math.abs(debits - credits)).toBeLessThan(0.01);
    });
  });
});
