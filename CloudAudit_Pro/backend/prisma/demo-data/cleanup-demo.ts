import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

export async function cleanupDemoData() {
  console.log('🧹 Starting demo data cleanup...');

  try {
    // Find demo tenant
    const demoTenant = await prisma.tenant.findFirst({
      where: {
        subdomain: 'demo-audit-firm',
      },
    });

    if (!demoTenant) {
      console.log('ℹ️  No demo tenant found. Nothing to clean up.');
      return;
    }

    console.log(`🏢 Found demo tenant: ${demoTenant.name}`);

    // Delete in correct order (respecting foreign key constraints)
    console.log('🗑️  Deleting demo data...');

    // 1. Delete trial balance entries (direct query with company filter)
    const deletedTrialBalance = await prisma.trialBalanceEntry.deleteMany({
      where: {
        company: {
          name: {
            contains: '[DEMO]',
          },
        },
      },
    });
    console.log(`   ✓ Deleted ${deletedTrialBalance.count} trial balance entries`);

    // 2. Delete journal entries
    const deletedJournals = await prisma.journalEntry.deleteMany({
      where: {
        period: {
          company: {
            name: {
              contains: '[DEMO]',
            },
          },
        },
      },
    });
    console.log(`   ✓ Deleted ${deletedJournals.count} journal entries`);

    // 3. Delete findings
    const deletedFindings = await prisma.finding.deleteMany({
      where: {
        tenantId: demoTenant.id,
      },
    });
    console.log(`   ✓ Deleted ${deletedFindings.count} findings`);

    // 4. Delete workpapers
    const deletedWorkpapers = await prisma.workpaper.deleteMany({
      where: {
        tenantId: demoTenant.id,
      },
    });
    console.log(`   ✓ Deleted ${deletedWorkpapers.count} workpapers`);

    // 5. Delete audit procedures
    const deletedProcedures = await prisma.auditProcedure.deleteMany({
      where: {
        tenantId: demoTenant.id,
      },
    });
    console.log(`   ✓ Deleted ${deletedProcedures.count} procedures`);

    // 6. Delete account heads
    const deletedAccounts = await prisma.accountHead.deleteMany({
      where: {
        company: {
          name: {
            contains: '[DEMO]',
          },
        },
      },
    });
    console.log(`   ✓ Deleted ${deletedAccounts.count} account heads`);

    // 7. Delete periods
    const deletedPeriods = await prisma.period.deleteMany({
      where: {
        company: {
          name: {
            contains: '[DEMO]',
          },
        },
      },
    });
    console.log(`   ✓ Deleted ${deletedPeriods.count} periods`);

    // 8. Delete companies
    const deletedCompanies = await prisma.company.deleteMany({
      where: {
        name: {
          contains: '[DEMO]',
        },
      },
    });
    console.log(`   ✓ Deleted ${deletedCompanies.count} companies`);

    // 9. Delete documents
    const deletedDocuments = await prisma.document.deleteMany({
      where: {
        tenantId: demoTenant.id,
      },
    });
    console.log(`   ✓ Deleted ${deletedDocuments.count} documents`);

    // 10. Delete reports
    const deletedReports = await prisma.report.deleteMany({
      where: {
        tenantId: demoTenant.id,
      },
    });
    console.log(`   ✓ Deleted ${deletedReports.count} reports`);

    // 11. Delete users
    const deletedUsers = await prisma.tenantUser.deleteMany({
      where: {
        tenantId: demoTenant.id,
      },
    });
    console.log(`   ✓ Deleted ${deletedUsers.count} users`);

    // 12. Delete subscriptions
    const deletedSubscriptions = await prisma.subscription.deleteMany({
      where: {
        tenantId: demoTenant.id,
      },
    });
    console.log(`   ✓ Deleted ${deletedSubscriptions.count} subscriptions`);

    // 13. Delete tenant (last)
    const deletedTenant = await prisma.tenant.delete({
      where: {
        id: demoTenant.id,
      },
    });
    console.log(`   ✓ Deleted tenant: ${deletedTenant.name}`);

    console.log('✅ Demo data cleanup completed successfully!');
  } catch (error) {
    console.error('❌ Error cleaning up demo data:', error);
    throw error;
  }
}

async function main() {
  try {
    await cleanupDemoData();
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
