import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

async function main() {
  console.log('🌱 Starting database seeding...');

  // Seed Account Types
  console.log('📊 Seeding account types...');
  
  const accountTypes = [
    {
      id: 1,
      name: 'Asset',
      code: 'AST',
      category: 'ASSETS' as const,
      normalBalance: 'DEBIT' as const,
      displayOrder: 1,
      isActive: true,
    },
    {
      id: 2,
      name: 'Liability',
      code: 'LIA',
      category: 'LIABILITIES' as const,
      normalBalance: 'CREDIT' as const,
      displayOrder: 2,
      isActive: true,
    },
    {
      id: 3,
      name: 'Equity',
      code: 'EQT',
      category: 'EQUITY' as const,
      normalBalance: 'CREDIT' as const,
      displayOrder: 3,
      isActive: true,
    },
    {
      id: 4,
      name: 'Revenue',
      code: 'REV',
      category: 'REVENUE' as const,
      normalBalance: 'CREDIT' as const,
      displayOrder: 4,
      isActive: true,
    },
    {
      id: 5,
      name: 'Expense',
      code: 'EXP',
      category: 'EXPENSES' as const,
      normalBalance: 'DEBIT' as const,
      displayOrder: 5,
      isActive: true,
    },
  ];

  for (const accountType of accountTypes) {
    await prisma.accountType.upsert({
      where: { id: accountType.id },
      update: accountType,
      create: accountType,
    });
  }

  console.log('✅ Account types seeded successfully');
  console.log('🎉 Database seeding completed!');
}

main()
  .catch((e) => {
    console.error('❌ Error seeding database:', e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
