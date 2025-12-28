import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

async function main() {
  console.log('🧹 Starting test data cleanup...');

  // Clean up in reverse order of dependencies
  
  console.log('📝 Cleaning ledger entries...');
  const ledgerDeleted = await prisma.ledger.deleteMany({});
  console.log(`  ✓ Deleted ${ledgerDeleted.count} ledger entries`);

  console.log('📋 Cleaning journal entries...');
  const journalEntriesDeleted = await prisma.journalEntry.deleteMany({});
  console.log(`  ✓ Deleted ${journalEntriesDeleted.count} journal entries`);

  console.log('🔍 Cleaning findings...');
  const findingsDeleted = await prisma.finding.deleteMany({});
  console.log(`  ✓ Deleted ${findingsDeleted.count} findings`);

  console.log('📄 Cleaning workpapers...');
  const workpapersDeleted = await prisma.workpaper.deleteMany({});
  console.log(`  ✓ Deleted ${workpapersDeleted.count} workpapers`);

  console.log('📑 Cleaning audit procedures...');
  const auditProceduresDeleted = await prisma.auditProcedure.deleteMany({});
  console.log(`  ✓ Deleted ${auditProceduresDeleted.count} audit procedures`);

  console.log('📊 Cleaning accounts...');
  const accountsDeleted = await prisma.accountHead.deleteMany({});
  console.log(`  ✓ Deleted ${accountsDeleted.count} accounts`);

  console.log('📅 Cleaning periods...');
  const periodsDeleted = await prisma.period.deleteMany({});
  console.log(`  ✓ Deleted ${periodsDeleted.count} periods`);

  console.log('🏢 Cleaning companies...');
  const companiesDeleted = await prisma.company.deleteMany({});
  console.log(`  ✓ Deleted ${companiesDeleted.count} companies`);

  console.log('📁 Cleaning documents...');
  const documentsDeleted = await prisma.document.deleteMany({});
  console.log(`  ✓ Deleted ${documentsDeleted.count} documents`);

  console.log('⚙️ Cleaning system configs...');
  const configsDeleted = await prisma.systemConfig.deleteMany({});
  console.log(`  ✓ Deleted ${configsDeleted.count} system configs`);

  console.log('👤 Cleaning tenant users...');
  const tenantUsersDeleted = await prisma.tenantUser.deleteMany({});
  console.log(`  ✓ Deleted ${tenantUsersDeleted.count} tenant users`);

  console.log('🏭 Cleaning tenant approval requests...');
  const tenantApprovalsDeleted = await prisma.tenantApprovalRequest.deleteMany({});
  console.log(`  ✓ Deleted ${tenantApprovalsDeleted.count} tenant approval requests`);

  console.log('🏢 Cleaning tenants...');
  const tenantsDeleted = await prisma.tenant.deleteMany({});
  console.log(`  ✓ Deleted ${tenantsDeleted.count} tenants`);

  console.log('👥 Cleaning system users (admin users)...');
  const usersDeleted = await prisma.user.deleteMany({});
  console.log(`  ✓ Deleted ${usersDeleted.count} system users`);

  console.log('');
  console.log('✨ Test data cleanup completed successfully!');
  console.log('');
  console.log('📊 Summary:');
  console.log(`   Total records deleted: ${
    ledgerDeleted.count +
    journalEntriesDeleted.count +
    findingsDeleted.count +
    workpapersDeleted.count +
    auditProceduresDeleted.count +
    accountsDeleted.count +
    periodsDeleted.count +
    companiesDeleted.count +
    documentsDeleted.count +
    configsDeleted.count +
    tenantUsersDeleted.count +
    tenantApprovalsDeleted.count +
    tenantsDeleted.count +
    usersDeleted.count
  }`);
  console.log('');
  console.log('💡 Note: Account types are preserved for system functionality');
}

main()
  .catch((e) => {
    console.error('❌ Error cleaning up test data:', e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
