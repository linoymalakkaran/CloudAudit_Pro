import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

async function seedBaseCurrency() {
  try {
    console.log('🌱 Seeding base currency...');
    
    // Check if base currency already exists
    const existingBase = await prisma.currency.findFirst({
      where: { isBaseCurrency: true },
    });

    if (existingBase) {
      console.log('✅ Base currency already exists:', existingBase.code);
      return existingBase;
    }

    // Check if USD exists
    const usdCurrency = await prisma.currency.findFirst({
      where: { code: 'USD' },
    });

    if (usdCurrency) {
      // Update existing USD to be base currency
      const updated = await prisma.currency.update({
        where: { id: usdCurrency.id },
        data: { isBaseCurrency: true, isActive: true },
      });
      console.log('✅ Updated USD to base currency');
      return updated;
    }

    // Create USD as base currency
    const baseCurrency = await prisma.currency.create({
      data: {
        code: 'USD',
        name: 'US Dollar',
        symbol: '$',
        decimalPlaces: 2,
        isBaseCurrency: true,
        isActive: true,
      },
    });

    console.log('✅ Created base currency:', baseCurrency.code);
    return baseCurrency;
  } catch (error) {
    console.error('❌ Error seeding base currency:', error);
    throw error;
  }
}

async function main() {
  console.log('Starting database seeding...');
  await seedBaseCurrency();
  console.log('✅ Seeding completed successfully!');
}

main()
  .catch((e) => {
    console.error('❌ Seeding failed:', e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
