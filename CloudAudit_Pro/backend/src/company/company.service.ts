import { Injectable, NotFoundException, ForbiddenException } from '@nestjs/common';
import { PrismaService } from '../database/prisma.service';

export interface CreateCompanyDto {
  name: string;
  registrationNumber?: string;
  taxId?: string;
  businessType: string;
  industry?: string;
  address?: {
    street?: string;
    city?: string;
    state?: string;
    country?: string;
    postalCode?: string;
  };
  contactInfo?: {
    phone?: string;
    email?: string;
    website?: string;
  };
  tenantId: string;
}

export interface UpdateCompanyDto {
  name?: string;
  registrationNumber?: string;
  taxId?: string;
  businessType?: string;
  industry?: string;
  address?: {
    street?: string;
    city?: string;
    state?: string;
    country?: string;
    postalCode?: string;
  };
  contactInfo?: {
    phone?: string;
    email?: string;
    website?: string;
  };
  isActive?: boolean;
}

@Injectable()
export class CompanyService {
  constructor(private prisma: PrismaService) {}

  async createCompany(data: CreateCompanyDto) {
    // Generate a unique code from name + random suffix
    const namePrefix = data.name.substring(0, 6).toUpperCase().replace(/[^A-Z0-9]/g, '') || 'COMP';
    const randomSuffix = Math.random().toString(36).substring(2, 6).toUpperCase();
    const uniqueCode = `${namePrefix}${randomSuffix}`;
    
    return this.prisma.company.create({
      data: {
        name: data.name,
        code: uniqueCode,
        registrationNumber: data.registrationNumber,
        taxId: data.taxId,
        businessType: data.businessType,
        industry: data.industry,
        address: typeof data.address === 'string' ? data.address : JSON.stringify(data.address),
        tenantId: data.tenantId,
        isActive: true,
      },
    });
  }

  async getCompaniesByTenant(tenantId: string) {
    return this.prisma.company.findMany({
      where: { 
        tenantId,
        isActive: true,
      },
      orderBy: { createdAt: 'desc' },
    });
  }

  async getCompanyById(id: string, tenantId: string) {
    const company = await this.prisma.company.findUnique({
      where: { 
        id,
        tenantId,
      },
      include: {
        periods: {
          where: { isActive: true },
          orderBy: { startDate: 'desc' },
        },
        _count: {
          select: {
            periods: true,
            accountHeads: true,
            procedures: true,
          },
        },
      },
    });

    if (!company) {
      throw new NotFoundException('Company not found');
    }

    return company;
  }

  async updateCompany(id: string, tenantId: string, data: UpdateCompanyDto) {
    // Verify company exists and belongs to tenant
    await this.getCompanyById(id, tenantId);

    return this.prisma.company.update({
      where: { id },
      data: {
        name: data.name,
        registrationNumber: data.registrationNumber,
        taxId: data.taxId,
        businessType: data.businessType,
        industry: data.industry,
        address: typeof data.address === 'string' ? data.address : JSON.stringify(data.address),
        isActive: data.isActive,
        updatedAt: new Date(),
      },
    });
  }

  async deleteCompany(id: string, tenantId: string) {
    // Verify company exists and belongs to tenant
    await this.getCompanyById(id, tenantId);

    // Check if company has any active periods
    const activePeriods = await this.prisma.period.count({
      where: { 
        companyId: id,
        isActive: true,
      },
    });

    if (activePeriods > 0) {
      throw new ForbiddenException('Cannot delete company with active audit periods');
    }

    // Soft delete
    return this.prisma.company.update({
      where: { id },
      data: { 
        isActive: false,
        updatedAt: new Date(),
      },
    });
  }

  async getCompanyStats(tenantId: string) {
    const [totalCompanies, activeCompanies, companiesWithActivePeriods] = await Promise.all([
      this.prisma.company.count({
        where: { tenantId },
      }),
      this.prisma.company.count({
        where: { 
          tenantId,
          isActive: true,
        },
      }),
      this.prisma.company.count({
        where: {
          tenantId,
          isActive: true,
          periods: {
            some: { isActive: true },
          },
        },
      }),
    ]);

    return {
      totalCompanies,
      activeCompanies,
      companiesWithActivePeriods,
    };
  }

  async searchCompanies(tenantId: string, query: string) {
    return this.prisma.company.findMany({
      where: {
        tenantId,
        isActive: true,
        OR: [
          { name: { contains: query, mode: 'insensitive' } },
          { registrationNumber: { contains: query, mode: 'insensitive' } },
          { taxId: { contains: query, mode: 'insensitive' } },
          { industry: { contains: query, mode: 'insensitive' } },
        ],
      },
      orderBy: { name: 'asc' },
    });
  }
}