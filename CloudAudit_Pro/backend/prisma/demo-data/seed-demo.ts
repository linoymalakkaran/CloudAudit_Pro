import { PrismaClient } from '@prisma/client';
import * as bcrypt from 'bcryptjs';

const prisma = new PrismaClient();

export async function seedDemoData() {
  console.log('🎭 Starting demo data seeding...');

  try {
    // 1. Create Demo Tenant
    console.log('🏢 Creating demo tenant...');
    const demoTenant = await prisma.tenant.create({
      data: {
        name: '[DEMO] Global Audit Partners LLP',
        subdomain: 'demo-audit-firm',
        databaseName: 'demo_audit_firm_db',
        subscriptionTier: 'professional',
        maxUsers: 50,
        maxCompanies: 20,
        storageLimitGb: 100,
        status: 'ACTIVE',
        approvalStatus: 'APPROVED',
        featureFlags: {
          enableAdvancedReporting: true,
          enableDocumentManagement: true,
          enableClientPortal: true,
          enableIntegrations: true,
        },
        settings: {
          fiscalYearEnd: '12-31',
          defaultCurrency: 'USD',
          timezone: 'America/New_York',
          dateFormat: 'MM/DD/YYYY',
        },
        contactInfo: {
          phone: '+1-555-AUDIT-01',
          email: 'contact@demoauditfirm.com',
          address: '123 Auditor Lane, Suite 500',
          city: 'New York',
          state: 'NY',
          zipCode: '10001',
          country: 'USA',
        },
      },
    });

    console.log(`✅ Demo tenant created: ${demoTenant.id}`);

    // 2. Create Demo Users
    console.log('👥 Creating demo users...');
    const passwordHash = await bcrypt.hash('Demo@2024!', 10);

    const demoUsers = await Promise.all([
      // Admin User
      prisma.tenantUser.create({
        data: {
          tenantId: demoTenant.id,
          email: 'demo.admin@cloudauditpro.com',
          passwordHash,
          firstName: 'Sarah',
          lastName: 'Anderson',
          role: 'ADMIN',
          status: 'ACTIVE',
          approvalStatus: 'APPROVED',
          isActive: true,
          jobTitle: 'Audit Partner',
          department: 'Audit',
          phoneNumber: '+1-555-0101',
        },
      }),
      // Senior Auditor
      prisma.tenantUser.create({
        data: {
          tenantId: demoTenant.id,
          email: 'demo.senior@cloudauditpro.com',
          passwordHash,
          firstName: 'Michael',
          lastName: 'Chen',
          role: 'AUDITOR',
          status: 'ACTIVE',
          approvalStatus: 'APPROVED',
          isActive: true,
          jobTitle: 'Senior Auditor',
          department: 'Audit',
          phoneNumber: '+1-555-0102',
        },
      }),
      // Staff Auditor
      prisma.tenantUser.create({
        data: {
          tenantId: demoTenant.id,
          email: 'demo.staff@cloudauditpro.com',
          passwordHash,
          firstName: 'Emily',
          lastName: 'Rodriguez',
          role: 'STAFF',
          status: 'ACTIVE',
          approvalStatus: 'APPROVED',
          isActive: true,
          jobTitle: 'Staff Auditor',
          department: 'Audit',
          phoneNumber: '+1-555-0103',
        },
      }),
      // Client User
      prisma.tenantUser.create({
        data: {
          tenantId: demoTenant.id,
          email: 'demo.client@cloudauditpro.com',
          passwordHash,
          firstName: 'David',
          lastName: 'Thompson',
          role: 'CLIENT',
          status: 'ACTIVE',
          approvalStatus: 'APPROVED',
          isActive: true,
          jobTitle: 'CFO',
          department: 'Finance',
          phoneNumber: '+1-555-0104',
        },
      }),
      // Reviewer
      prisma.tenantUser.create({
        data: {
          tenantId: demoTenant.id,
          email: 'demo.reviewer@cloudauditpro.com',
          passwordHash,
          firstName: 'Jessica',
          lastName: 'Martinez',
          role: 'REVIEWER',
          status: 'ACTIVE',
          approvalStatus: 'APPROVED',
          isActive: true,
          jobTitle: 'Quality Review Partner',
          department: 'Quality Control',
          phoneNumber: '+1-555-0105',
        },
      }),
    ]);

    console.log(`✅ Created ${demoUsers.length} demo users`);

    // 3. Create Demo Company (simplified version without country/currency relations)
    console.log('🏭 Creating demo company...');
    const company = await prisma.company.create({
      data: {
        name: '[DEMO] TechVenture Inc.',
        code: 'DEMO-TECHV',
        shortName: 'TechVenture',
        industry: 'Technology',
        taxId: '12-3456789',
        registrationNumber: 'REG-TECH-001',
        address: '456 Innovation Drive',
        phone: '+1-555-TECH-01',
        email: 'finance@techventure.demo',
        website: 'https://www.techventure.demo',
        fiscalYearEnd: new Date('2024-12-31'),
        baseCurrency: 'USD',
        status: 'ACTIVE',
        contactPerson: 'John Smith',
        contactPhone: '+1-555-TECH-02',
        contactEmail: 'john.smith@techventure.demo',
        tenantId: demoTenant.id,
      },
    });

    console.log(`✅ Created demo company: ${company.id}`);

    // 4. Create Audit Period
    console.log('📅 Creating audit period...');
    const period = await prisma.period.create({
      data: {
        companyId: company.id,
        name: '[DEMO] FY2024 Annual Audit',
        startDate: new Date('2024-01-01'),
        endDate: new Date('2024-12-31'),
        auditType: 'ANNUAL',
        fiscalYear: '2024',
        periodType: 'ANNUAL',
        status: 'OPEN',
        isCurrent: true,
        description: `Annual financial statement audit for fiscal year 2024`,
        tenantId: demoTenant.id,
      },
    });

    console.log(`✅ Created audit period: ${period.id}`);

    // 5. Get or create account types
    console.log('📊 Setting up account types...');
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

    console.log(`✅ Account types ready`);

    // 6. Create Chart of Accounts
    console.log('📊 Creating chart of accounts...');
    const accounts = [];
    
    // Assets
    const cash = await prisma.accountHead.create({
      data: {
        companyId: company.id,
        periodId: period.id,
        tenantId: demoTenant.id,
        accountTypeId: accountTypes[0].id,
        code: '1000',
        name: 'Cash and Cash Equivalents',
        level: 1,
      },
    });
    accounts.push(cash);

    const ar = await prisma.accountHead.create({
      data: {
        companyId: company.id,
        periodId: period.id,
        tenantId: demoTenant.id,
        accountTypeId: accountTypes[0].id,
        code: '1100',
        name: 'Accounts Receivable',
        level: 1,
      },
    });
    accounts.push(ar);

    // Liabilities
    const ap = await prisma.accountHead.create({
      data: {
        companyId: company.id,
        periodId: period.id,
        tenantId: demoTenant.id,
        accountTypeId: accountTypes[1].id,
        code: '2000',
        name: 'Accounts Payable',
        level: 1,
      },
    });
    accounts.push(ap);

    // Equity
    const equity = await prisma.accountHead.create({
      data: {
        companyId: company.id,
        periodId: period.id,
        tenantId: demoTenant.id,
        accountTypeId: accountTypes[2].id,
        code: '3000',
        name: 'Share Capital',
        level: 1,
      },
    });
    accounts.push(equity);

    // Revenue
    const revenue = await prisma.accountHead.create({
      data: {
        companyId: company.id,
        periodId: period.id,
        tenantId: demoTenant.id,
        accountTypeId: accountTypes[3].id,
        code: '4000',
        name: 'Product Sales',
        level: 1,
      },
    });
    accounts.push(revenue);

    // Expenses
    const expenses = await prisma.accountHead.create({
      data: {
        companyId: company.id,
        periodId: period.id,
        tenantId: demoTenant.id,
        accountTypeId: accountTypes[4].id,
        code: '5000',
        name: 'Cost of Goods Sold',
        level: 1,
      },
    });
    accounts.push(expenses);

    console.log(`✅ Created ${accounts.length} accounts`);

    // 7. Create Trial Balance Entries
    console.log('💰 Creating trial balance entries...');
    await Promise.all([
      prisma.trialBalanceEntry.create({
        data: {
          companyId: company.id,
          periodId: period.id,
          accountId: cash.id,
          openingDebit: 150000.00,
          periodDebit: 50000.00,
          closingDebit: 200000.00,
          debitBalance: 200000.00,
        },
      }),
      prisma.trialBalanceEntry.create({
        data: {
          companyId: company.id,
          periodId: period.id,
          accountId: ar.id,
          openingDebit: 280000.00,
          periodDebit: 20000.00,
          closingDebit: 300000.00,
          debitBalance: 300000.00,
        },
      }),
      prisma.trialBalanceEntry.create({
        data: {
          companyId: company.id,
          periodId: period.id,
          accountId: ap.id,
          openingCredit: 180000.00,
          periodCredit: 20000.00,
          closingCredit: 200000.00,
          creditBalance: 200000.00,
        },
      }),
      prisma.trialBalanceEntry.create({
        data: {
          companyId: company.id,
          periodId: period.id,
          accountId: equity.id,
          openingCredit: 500000.00,
          closingCredit: 500000.00,
          creditBalance: 500000.00,
        },
      }),
      prisma.trialBalanceEntry.create({
        data: {
          companyId: company.id,
          periodId: period.id,
          accountId: revenue.id,
          periodCredit: 1200000.00,
          closingCredit: 1200000.00,
          creditBalance: 1200000.00,
        },
      }),
      prisma.trialBalanceEntry.create({
        data: {
          companyId: company.id,
          periodId: period.id,
          accountId: expenses.id,
          periodDebit: 720000.00,
          closingDebit: 720000.00,
          debitBalance: 720000.00,
        },
      }),
    ]);

    console.log(`✅ Created trial balance entries`);

    // 8. Create Audit Procedures
    console.log('📋 Creating audit procedures...');
    const procedures = await Promise.all([
      prisma.auditProcedure.create({
        data: {
          tenantId: demoTenant.id,
          companyId: company.id,
          periodId: period.id,
          name: '[DEMO] Cash and Bank Testing',
          description: 'Perform substantive testing on cash and cash equivalents',
          category: 'SUBSTANTIVE_TESTING',
          riskLevel: 'MEDIUM',
          status: 'COMPLETED',
          assignedToId: demoUsers[1].id,
          assignedBy: demoUsers[0].id,
          createdBy: demoUsers[0].id,
          dueDate: new Date('2024-11-30'),
          completedAt: new Date('2024-11-28'),
        },
      }),
      prisma.auditProcedure.create({
        data: {
          tenantId: demoTenant.id,
          companyId: company.id,
          periodId: period.id,
          name: '[DEMO] Accounts Receivable Confirmation',
          description: 'Perform accounts receivable confirmations and aging analysis',
          category: 'SUBSTANTIVE_TESTING',
          riskLevel: 'HIGH',
          status: 'IN_PROGRESS',
          assignedToId: demoUsers[2].id,
          assignedBy: demoUsers[0].id,
          createdBy: demoUsers[0].id,
          dueDate: new Date('2024-12-15'),
        },
      }),
    ]);

    console.log(`✅ Created ${procedures.length} audit procedures`);

    // 9. Create Findings
    console.log('🔍 Creating audit findings...');
    const findings = await Promise.all([
      prisma.finding.create({
        data: {
          tenantId: demoTenant.id,
          companyId: company.id,
          periodId: period.id,
          procedureId: procedures[1].id,
          title: '[DEMO] Aging AR Over 90 Days',
          description: 'Identified accounts receivable balances over 90 days not adequately provided for',
          severity: 'MEDIUM',
          status: 'OPEN',
          identifiedBy: demoUsers[2].id,
          recommendation: 'Review and adjust allowance for doubtful accounts',
        },
      }),
      prisma.finding.create({
        data: {
          tenantId: demoTenant.id,
          companyId: company.id,
          periodId: period.id,
          procedureId: procedures[0].id,
          title: '[DEMO] Bank Reconciliation Items',
          description: 'Minor reconciling items identified in bank reconciliation',
          severity: 'LOW',
          status: 'RESOLVED',
          identifiedBy: demoUsers[1].id,
          resolvedBy: demoUsers[0].id,
          resolvedAt: new Date('2024-12-01'),
          recommendation: 'Clear outstanding items monthly',
          managementResponse: 'Items cleared in December',
        },
      }),
    ]);

    console.log(`✅ Created ${findings.length} findings`);

    console.log('\n✨ Demo data seeding completed successfully!');
    console.log('\n📋 Summary:');
    console.log(`   - Tenant: ${demoTenant.name}`);
    console.log(`   - Users: ${demoUsers.length}`);
    console.log(`   - Company: ${company.name}`);
    console.log(`   - Period: ${period.name}`);
    console.log(`   - Accounts: ${accounts.length}`);
    console.log(`   - Procedures: ${procedures.length}`);
    console.log(`   - Findings: ${findings.length}`);
    console.log('\n🔐 Demo Login:');
    console.log('   Email: demo.admin@cloudauditpro.com');
    console.log('   Password: Demo@2024!');
    console.log('   Subdomain: demo-audit-firm');

    return {
      tenant: demoTenant,
      users: demoUsers,
      company,
      period,
      accounts,
      procedures,
      findings,
    };
  } catch (error) {
    console.error('❌ Error seeding demo data:', error);
    throw error;
  }
}

async function main() {
  try {
    await seedDemoData();
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
