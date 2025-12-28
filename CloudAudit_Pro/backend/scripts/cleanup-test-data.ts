import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

async function cleanupTestData() {
  console.log('🧹 Cleaning up test data...');

  try {
    // Delete test data based on email/subdomain patterns
    const testEmailPattern = '%test%';
    const testSubdomainPattern = '%tenant%';

    // First, get all test tenants
    const testTenants = await prisma.tenant.findMany({
      where: {
        OR: [
          { subdomain: { contains: 'tenant' } },
          { name: { contains: 'Test' } },
          { name: { contains: 'test' } },
        ],
      },
      select: { id: true },
    });

    console.log(`🏢 Found ${testTenants.length} test tenants to clean`);

    // Get all test tenant users
    const testTenantUsers = await prisma.tenantUser.findMany({
      where: {
        OR: [
          { email: { contains: 'test' } },
          { email: { contains: 'Test' } },
        ],
      },
      select: { id: true },
    });

    // Delete ALL tenant approval requests (for test tenants OR requested by test users)
    console.log('📋 Deleting tenant approval requests...');
    await prisma.tenantApprovalRequest.deleteMany({
      where: {
        OR: [
          { tenantId: { in: testTenants.map(t => t.id) } },
          { requestedBy: { in: testTenantUsers.map(u => u.id) } },
        ],
      },
    });

    console.log('📧 Deleting test tenant users...');
    const deletedTenantUsers = await prisma.tenantUser.deleteMany({
      where: {
        OR: [
          { email: { contains: 'test' } },
          { email: { contains: 'Test' } },
        ],
      },
    });
    console.log(`  ✓ Deleted ${deletedTenantUsers.count} tenant users`);

    console.log('👤 Deleting test users...');
    const deletedUsers = await prisma.user.deleteMany({
      where: {
        OR: [
          { email: { contains: 'test' } },
          { email: { contains: 'Test' } },
        ],
      },
    });
    console.log(`  ✓ Deleted ${deletedUsers.count} users`);

    console.log('🏢 Deleting test tenants and related data...');

    for (const tenant of testTenants) {
      // Delete in correct order due to foreign key constraints
      
      // Delete ledger entries
      await prisma.ledger.deleteMany({
        where: { tenantId: tenant.id },
      });

      // Delete journal entries
      await prisma.journalEntry.deleteMany({
        where: { tenantId: tenant.id },
      });

      // Delete findings
      await prisma.finding.deleteMany({
        where: { tenantId: tenant.id },
      });

      // Delete workpapers
      await prisma.workpaper.deleteMany({
        where: { tenantId: tenant.id },
      });

      // Delete audit procedures
      await prisma.auditProcedure.deleteMany({
        where: { tenantId: tenant.id },
      });

      // Delete documents
      await prisma.document.deleteMany({
        where: { tenantId: tenant.id },
      });

      // Delete account heads
      await prisma.accountHead.deleteMany({
        where: { tenantId: tenant.id },
      });

      // Delete periods
      await prisma.period.deleteMany({
        where: { tenantId: tenant.id },
      });

      // Delete companies and configurations
      const companies = await prisma.company.findMany({
        where: { tenantId: tenant.id },
        select: { id: true },
      });
      
      for (const company of companies) {
        await prisma.configuration.deleteMany({
          where: { companyId: company.id },
        });
      }

      await prisma.company.deleteMany({
        where: { tenantId: tenant.id },
      });

      // Tenant approval requests already deleted above

      // Finally delete the tenant
      await prisma.tenant.delete({
        where: { id: tenant.id },
      });
    }

    console.log(`  ✓ Deleted ${testTenants.length} tenants and all related data`);

    console.log('✨ Cleanup completed successfully!');
    console.log('');
    console.log('Summary:');
    console.log(`  - Tenant Users: ${deletedTenantUsers.count}`);
    console.log(`  - Users: ${deletedUsers.count}`);
    console.log(`  - Tenants (with cascaded data): ${testTenants.length}`);
  } catch (error) {
    console.error('❌ Cleanup failed:', error);
    throw error;
  }
}

// Run if called directly
if (require.main === module) {
  cleanupTestData()
    .catch((e) => {
      console.error(e);
      process.exit(1);
    })
    .finally(async () => {
      await prisma.$disconnect();
    });
}

export { cleanupTestData };
