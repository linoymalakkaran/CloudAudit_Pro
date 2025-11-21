import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { PrismaService } from '../database/prisma.service';
import { Prisma, Tenant, TenantStatus } from '@prisma/client';

@Injectable()
export class TenantService {
  constructor(
    private prisma: PrismaService,
    private configService: ConfigService,
  ) {}

  async createTenant(data: {
    name: string;
    subdomain: string;
    primaryContactEmail: string;
    primaryContactName: string;
    companySize?: string;
    industry?: string;
    timezone?: string;
  }): Promise<Tenant> {
    // Validate subdomain uniqueness
    const existingTenant = await this.prisma.tenant.findUnique({
      where: { subdomain: data.subdomain },
    });

    if (existingTenant) {
      throw new Error('Subdomain is already taken');
    }

    // Create tenant with default settings
    const tenant = await this.prisma.tenant.create({
      data: {
        name: data.name,
        subdomain: data.subdomain,
        status: TenantStatus.ACTIVE,
        settings: {
          timezone: data.timezone || 'UTC',
          dateFormat: 'DD/MM/YYYY',
          currency: 'USD',
          fiscalYearStart: '01-04', // April 1st
          companySize: data.companySize,
          industry: data.industry,
          features: {
            maxUsers: 10, // Default starter plan
            maxCompanies: 1,
            maxStorage: 1024, // 1GB in MB
            advancedReports: false,
            apiAccess: false,
            customBranding: false,
          },
        },
        contactInfo: {
          primaryEmail: data.primaryContactEmail,
          primaryContact: data.primaryContactName,
        },
      },
    });

    // Create tenant-specific database (in production, this would create actual database)
    await this.initializeTenantDatabase(tenant.id);

    return tenant;
  }

  async getTenantBySubdomain(subdomain: string): Promise<Tenant | null> {
    return this.prisma.tenant.findUnique({
      where: { 
        subdomain,
        status: TenantStatus.ACTIVE,
      },
    });
  }

  async getTenantById(id: string): Promise<Tenant | null> {
    return this.prisma.tenant.findUnique({
      where: { 
        id,
        status: TenantStatus.ACTIVE,
      },
    });
  }

  async updateTenantSettings(
    tenantId: string, 
    settings: Partial<Prisma.JsonValue>
  ): Promise<Tenant> {
    return this.prisma.tenant.update({
      where: { id: tenantId },
      data: { 
        settings,
        updatedAt: new Date(),
      },
    });
  }

  async suspendTenant(tenantId: string, reason?: string): Promise<Tenant> {
    return this.prisma.tenant.update({
      where: { id: tenantId },
      data: {
        status: TenantStatus.SUSPENDED,
        metadata: {
          suspensionReason: reason,
          suspendedAt: new Date().toISOString(),
        },
        updatedAt: new Date(),
      },
    });
  }

  async activateTenant(tenantId: string): Promise<Tenant> {
    return this.prisma.tenant.update({
      where: { id: tenantId },
      data: {
        status: TenantStatus.ACTIVE,
        updatedAt: new Date(),
      },
    });
  }

  async getTenantStats(tenantId: string) {
    const [userCount, companyCount, activeUsers] = await Promise.all([
      this.prisma.user.count({
        where: { tenantId },
      }),
      this.prisma.company.count({
        where: { tenantId },
      }),
      this.prisma.user.count({
        where: { 
          tenantId,
          isActive: true,
          lastLoginAt: {
            gte: new Date(Date.now() - 30 * 24 * 60 * 60 * 1000), // Last 30 days
          },
        },
      }),
    ]);

    return {
      totalUsers: userCount,
      activeUsers,
      totalCompanies: companyCount,
    };
  }

  async generateUniqueSubdomain(baseName: string): Promise<string> {
    // Clean the base name
    let subdomain = baseName
      .toLowerCase()
      .replace(/[^a-z0-9\s-]/g, '')
      .replace(/\s+/g, '-')
      .replace(/--+/g, '-')
      .replace(/^-|-$/g, '');

    // Ensure minimum length
    if (subdomain.length < 3) {
      subdomain = subdomain + '-audit';
    }

    // Check uniqueness and add suffix if needed
    let finalSubdomain = subdomain;
    let counter = 1;

    while (await this.prisma.tenant.findUnique({ where: { subdomain: finalSubdomain } })) {
      finalSubdomain = `${subdomain}-${counter}`;
      counter++;
    }

    return finalSubdomain;
  }

  private async initializeTenantDatabase(tenantId: string): Promise<void> {
    // In production, this would:
    // 1. Create a new database for the tenant
    // 2. Run migrations on the tenant database
    // 3. Seed with initial data
    
    // For now, we'll use a shared database with tenant isolation
    console.log(`Initializing database for tenant: ${tenantId}`);
    
    // TODO: Implement actual tenant database provisioning
    // This could involve:
    // - Creating a separate database
    // - Running Prisma migrations
    // - Setting up initial admin user
    // - Creating default company record
  }

  async deleteTenant(tenantId: string): Promise<void> {
    // Mark as deleted rather than hard delete
    await this.prisma.tenant.update({
      where: { id: tenantId },
      data: {
        status: TenantStatus.INACTIVE,
        deletedAt: new Date(),
        updatedAt: new Date(),
      },
    });

    // TODO: In production, also handle:
    // - Data cleanup/archival
    // - Database deletion
    // - Notification to users
  }
}