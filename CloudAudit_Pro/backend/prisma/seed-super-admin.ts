// Seed script for super admin
import { PrismaClient } from '@prisma/client';
import * as bcrypt from 'bcryptjs';

const prisma = new PrismaClient();

async function seedSuperAdmin() {
  try {
    // Check if super admin already exists
    const existingSuperAdmin = await prisma.superAdmin.findUnique({
      where: { email: 'superadmin@cloudaudit.com' },
    });

    if (existingSuperAdmin) {
      console.log('Super admin already exists');
      return;
    }

    // Create super admin
    const hashedPassword = await bcrypt.hash('CloudAudit2024!', 12);
    
    const superAdmin = await prisma.superAdmin.create({
      data: {
        email: 'superadmin@cloudaudit.com',
        passwordHash: hashedPassword,
        firstName: 'Super',
        lastName: 'Administrator',
        role: 'SUPER_ADMIN',
        isActive: true,
      },
    });

    console.log('Super admin created successfully:', {
      id: superAdmin.id,
      email: superAdmin.email,
      role: superAdmin.role,
    });

    console.log('\nSuper Admin Login Credentials:');
    console.log('Email: superadmin@cloudaudit.com');
    console.log('Password: CloudAudit2024!');
  } catch (error) {
    console.error('Error seeding super admin:', error);
  } finally {
    await prisma.$disconnect();
  }
}

seedSuperAdmin();