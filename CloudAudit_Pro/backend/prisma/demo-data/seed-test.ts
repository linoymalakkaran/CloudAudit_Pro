import { PrismaClient } from '@prisma/client';
import * as bcrypt from 'bcryptjs';

const prisma = new PrismaClient();

export async function seedTestData(tenantId?: string) {
  console.log('🧪 Starting test data seeding with fixed IDs...');

  try {
    let testTenant;
    
    // If tenantId is provided, use that tenant
    if (tenantId) {
      console.log(`🏢 Using provided tenant: ${tenantId}`);
      testTenant = await prisma.tenant.findUnique({
        where: { id: tenantId },
      });
      
      if (!testTenant) {
        throw new Error(`Tenant ${tenantId} not found`);
      }
    } else {
      // Otherwise find or create a test tenant
      testTenant = await prisma.tenant.findFirst({
        where: { subdomain: { contains: 'test' } },
      });

      if (!testTenant) {
        console.log('🏢 Creating test tenant...');
        testTenant = await prisma.tenant.create({
          data: {
            name: '[TEST] Test Audit Firm',
            subdomain: 'test-tenant',
            databaseName: 'test_audit_firm_db',
            subscriptionTier: 'professional',
            maxUsers: 50,
            maxCompanies: 20,
            storageLimitGb: 100,
            status: 'ACTIVE',
            approvalStatus: 'APPROVED',
            featureFlags: {},
            settings: {},
            contactInfo: {},
          },
        });
      }
    }

    console.log(`✅ Test tenant: ${testTenant.id}`);

    // Clean up existing test data first
    console.log('🧹 Cleaning up existing test data...');
    await prisma.trialBalanceEntry.deleteMany({
      where: { 
        OR: [
          { companyId: 'test-company-id' },
          { companyId: 'test-company' },
        ]
      },
    });
    await prisma.auditProcedure.deleteMany({
      where: { 
        OR: [
          { companyId: 'test-company-id' },
          { companyId: 'test-company' },
        ]
      },
    });
    await prisma.accountHead.deleteMany({
      where: { 
        OR: [
          { companyId: 'test-company-id' },
          { companyId: 'test-company' },
        ]
      },
    });
    await prisma.period.deleteMany({
      where: { id: 'test-period' },
    });
    await prisma.company.deleteMany({
      where: { 
        OR: [
          { id: 'test-company-id' },
          { id: 'test-company' },
        ]
      },
    });
    console.log('✅ Cleanup complete');

    // Create test company with fixed ID
    console.log('🏭 Creating test company with ID: test-company-id...');
    await prisma.company.upsert({
      where: { id: 'test-company-id' },
      update: {
        tenantId: testTenant.id,
        status: 'ACTIVE',
      },
      create: {
        id: 'test-company-id',
        name: '[TEST] Test Company',
        code: 'TEST-CO',
        shortName: 'TestCo',
        industry: 'Technology',
        baseCurrency: 'USD',
        status: 'ACTIVE',
        tenantId: testTenant.id,
      },
    });

    // Also create with alternate ID
    await prisma.company.upsert({
      where: { id: 'test-company' },
      update: {
        tenantId: testTenant.id,
        status: 'ACTIVE',
      },
      create: {
        id: 'test-company',
        name: '[TEST] Test Company Alt',
        code: 'TEST-CO-ALT',
        shortName: 'TestCoAlt',
        industry: 'Technology',
        baseCurrency: 'USD',
        status: 'ACTIVE',
        tenantId: testTenant.id,
      },
    });

    console.log('✅ Created test companies');

    // Create test period with fixed ID
    console.log('📅 Creating test period with ID: test-period...');
    await prisma.period.upsert({
      where: { id: 'test-period' },
      update: {
        tenantId: testTenant.id,
        isActive: true,
        status: 'OPEN',
      },
      create: {
        id: 'test-period',
        companyId: 'test-company',
        name: '[TEST] Test Period 2024',
        startDate: new Date('2024-01-01'),
        endDate: new Date('2024-12-31'),
        auditType: 'ANNUAL',
        fiscalYear: '2024',
        periodType: 'ANNUAL',
        status: 'OPEN',
        isActive: true,
        isCurrent: true,
        tenantId: testTenant.id,
      },
    });

    console.log('✅ Created test period');

    // Get or create account types
    const accountTypes = await Promise.all([
      prisma.accountType.upsert({
        where: { code: 'ASSETS' },
        update: {},
        create: {
          name: 'Assets',
          code: 'ASSETS',
          category: 'ASSETS',
          normalBalance: 'DEBIT',
          displayOrder: 1,
        },
      }),
      prisma.accountType.upsert({
        where: { code: 'LIABILITIES' },
        update: {},
        create: {
          name: 'Liabilities',
          code: 'LIABILITIES',
          category: 'LIABILITIES',
          normalBalance: 'CREDIT',
          displayOrder: 2,
        },
      }),
      prisma.accountType.upsert({
        where: { code: 'EQUITY' },
        update: {},
        create: {
          name: 'Equity',
          code: 'EQUITY',
          category: 'EQUITY',
          normalBalance: 'CREDIT',
          displayOrder: 3,
        },
      }),
      prisma.accountType.upsert({
        where: { code: 'REVENUE' },
        update: {},
        create: {
          name: 'Revenue',
          code: 'REVENUE',
          category: 'REVENUE',
          normalBalance: 'CREDIT',
          displayOrder: 4,
        },
      }),
      prisma.accountType.upsert({
        where: { code: 'EXPENSES' },
        update: {},
        create: {
          name: 'Expenses',
          code: 'EXPENSES',
          category: 'EXPENSES',
          normalBalance: 'DEBIT',
          displayOrder: 5,
        },
      }),
    ]);

    // Create accounts for test-company
    console.log('📊 Creating test accounts...');
    const accounts = await Promise.all([
      prisma.accountHead.create({
        data: {
          companyId: 'test-company',
          periodId: 'test-period',
          tenantId: testTenant.id,
          accountTypeId: accountTypes[0].id,
          code: '1000',
          name: 'Cash',
          level: 1,
        },
      }),
      prisma.accountHead.create({
        data: {
          companyId: 'test-company',
          periodId: 'test-period',
          tenantId: testTenant.id,
          accountTypeId: accountTypes[3].id,
          code: '4000',
          name: 'Revenue',
          level: 1,
        },
      }),
      prisma.accountHead.create({
        data: {
          companyId: 'test-company',
          periodId: 'test-period',
          tenantId: testTenant.id,
          accountTypeId: accountTypes[4].id,
          code: '5000',
          name: 'Expenses',
          level: 1,
        },
      }),
    ]);

    // Create trial balance entries
    console.log('💰 Creating test trial balance...');
    await Promise.all([
      prisma.trialBalanceEntry.create({
        data: {
          companyId: 'test-company',
          periodId: 'test-period',
          accountId: accounts[0].id,
          openingDebit: 100000.00,
          periodDebit: 50000.00,
          closingDebit: 150000.00,
          debitBalance: 150000.00,
        },
      }),
      prisma.trialBalanceEntry.create({
        data: {
          companyId: 'test-company',
          periodId: 'test-period',
          accountId: accounts[1].id,
          periodCredit: 500000.00,
          closingCredit: 500000.00,
          creditBalance: 500000.00,
        },
      }),
      prisma.trialBalanceEntry.create({
        data: {
          companyId: 'test-company',
          periodId: 'test-period',
          accountId: accounts[2].id,
          periodDebit: 300000.00,
          closingDebit: 300000.00,
          debitBalance: 300000.00,
        },
      }),
    ]);

    // Create test users for the tenant
    console.log('👥 Creating test users...');
    const passwordHash = await bcrypt.hash('Test@2024!', 10);
    
    const testUsers = await Promise.all([
      prisma.tenantUser.upsert({
        where: { tenantId_email: { tenantId: testTenant.id, email: 'test.user@test.com' } },
        update: {},
        create: {
          tenantId: testTenant.id,
          email: 'test.user@test.com',
          passwordHash,
          firstName: 'Test',
          lastName: 'User',
          role: 'ADMIN',
          status: 'ACTIVE',
          approvalStatus: 'APPROVED',
          isActive: true,
        },
      }),
    ]);

    // Create audit procedures
    console.log('📋 Creating test audit procedures...');
    await Promise.all([
      prisma.auditProcedure.create({
        data: {
          tenantId: testTenant.id,
          companyId: 'test-company',
          periodId: 'test-period',
          name: '[TEST] Cash Testing',
          description: 'Test procedure for cash',
          category: 'SUBSTANTIVE_TESTING',
          riskLevel: 'MEDIUM',
          status: 'COMPLETED',
          assignedToId: testUsers[0].id,
          assignedBy: testUsers[0].id,
          createdBy: testUsers[0].id,
          dueDate: new Date('2024-12-31'),
        },
      }),
      prisma.auditProcedure.create({
        data: {
          tenantId: testTenant.id,
          companyId: 'test-company',
          periodId: 'test-period',
          name: '[TEST] Revenue Testing',
          description: 'Test procedure for revenue',
          category: 'SUBSTANTIVE_TESTING',
          riskLevel: 'HIGH',
          status: 'IN_PROGRESS',
          assignedToId: testUsers[0].id,
          assignedBy: testUsers[0].id,
          createdBy: testUsers[0].id,
          dueDate: new Date('2024-12-31'),
        },
      }),
    ]);

    console.log('\n✨ Test data seeding completed successfully!');
    console.log('\n📋 Summary:');
    console.log(`   - Tenant: ${testTenant.name}`);
    console.log(`   - Company ID: test-company-id & test-company`);
    console.log(`   - Period ID: test-period`);
    console.log(`   - Accounts: ${accounts.length}`);
    console.log(`   - Users: ${testUsers.length}`);

    return {
      tenant: testTenant,
      users: testUsers,
    };
  } catch (error) {
    console.error('❌ Error seeding test data:', error);
    throw error;
  }
}

async function main() {
  try {
    // Check if TENANT_ID is provided via env var
    const tenantId = process.env.TENANT_ID;
    if (tenantId) {
      console.log(`📋 Using tenant ID from environment: ${tenantId}`);
    }
    await seedTestData(tenantId);
  } catch (error) {
    console.error(error);
    process.exit(1);
  } finally {
    await prisma.$disconnect();
  }
}

// Run if called directly
if (require.main === module) {
  main();
}
