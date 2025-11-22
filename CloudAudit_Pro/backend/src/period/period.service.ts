import { Injectable, NotFoundException, ForbiddenException, ConflictException } from '@nestjs/common';
import { PrismaService } from '../database/prisma.service';

export interface CreatePeriodDto {
  name: string;
  startDate: Date;
  endDate: Date;
  companyId: string;
  tenantId: string;
  description?: string;
  fiscalYear: string;
  periodType: 'ANNUAL' | 'QUARTERLY' | 'MONTHLY';
}

export interface UpdatePeriodDto {
  name?: string;
  startDate?: Date;
  endDate?: Date;
  description?: string;
  periodType?: 'ANNUAL' | 'QUARTERLY' | 'MONTHLY';
  isActive?: boolean;
}

@Injectable()
export class PeriodService {
  constructor(private prisma: PrismaService) {}

  async createPeriod(data: CreatePeriodDto) {
    // Validate that company belongs to tenant
    const company = await this.prisma.company.findUnique({
      where: { 
        id: data.companyId,
        tenantId: data.tenantId,
      },
    });

    if (!company) {
      throw new NotFoundException('Company not found');
    }

    // Check for overlapping periods
    const overlappingPeriod = await this.prisma.period.findFirst({
      where: {
        companyId: data.companyId,
        AND: [
          { startDate: { lte: data.endDate } },
          { endDate: { gte: data.startDate } },
        ],
        isActive: true,
      },
    });

    if (overlappingPeriod) {
      throw new ConflictException('Period dates overlap with existing period');
    }

    return this.prisma.period.create({
      data: {
        name: data.name,
        startDate: data.startDate,
        endDate: data.endDate,
        description: data.description,
        fiscalYear: data.fiscalYear,
        periodType: data.periodType,
        companyId: data.companyId,
        tenantId: data.tenantId,
        status: 'PLANNING',
        isActive: true,
      },
    });
  }

  async getPeriodsByCompany(companyId: string, tenantId: string) {
    // Verify company belongs to tenant
    const company = await this.prisma.company.findUnique({
      where: { 
        id: companyId,
        tenantId,
      },
    });

    if (!company) {
      throw new NotFoundException('Company not found');
    }

    return this.prisma.period.findMany({
      where: {
        companyId,
        tenantId,
        isActive: true,
      },
      orderBy: { startDate: 'desc' },
      include: {
        company: {
          select: { name: true, businessType: true },
        },
        _count: {
          select: {
            accounts: true,
            procedures: true,
            journalEntries: true,
          },
        },
      },
    });
  }

  async getPeriodsByTenant(tenantId: string) {
    return this.prisma.period.findMany({
      where: {
        tenantId,
        isActive: true,
      },
      orderBy: { startDate: 'desc' },
      include: {
        company: {
          select: { name: true, businessType: true },
        },
        _count: {
          select: {
            accounts: true,
            procedures: true,
            journalEntries: true,
          },
        },
      },
    });
  }

  async getPeriodById(id: string, tenantId: string) {
    const period = await this.prisma.period.findUnique({
      where: {
        id,
        tenantId,
      },
      include: {
        company: true,
        accounts: {
          where: { isActive: true },
          orderBy: { accountNumber: 'asc' },
        },
        procedures: {
          where: { isActive: true },
          orderBy: { createdAt: 'desc' },
        },
        _count: {
          select: {
            accounts: true,
            procedures: true,
            journalEntries: true,
            documents: true,
          },
        },
      },
    });

    if (!period) {
      throw new NotFoundException('Period not found');
    }

    return period;
  }

  async updatePeriod(id: string, tenantId: string, data: UpdatePeriodDto) {
    const period = await this.getPeriodById(id, tenantId);

    // If updating dates, check for overlaps
    if (data.startDate || data.endDate) {
      const startDate = data.startDate || period.startDate;
      const endDate = data.endDate || period.endDate;

      const overlappingPeriod = await this.prisma.period.findFirst({
        where: {
          companyId: period.companyId,
          id: { not: id },
          AND: [
            { startDate: { lte: endDate } },
            { endDate: { gte: startDate } },
          ],
          isActive: true,
        },
      });

      if (overlappingPeriod) {
        throw new ConflictException('Period dates overlap with existing period');
      }
    }

    return this.prisma.period.update({
      where: { id },
      data: {
        ...data,
        updatedAt: new Date(),
      },
    });
  }

  async closePeriod(id: string, tenantId: string) {
    const period = await this.getPeriodById(id, tenantId);

    if (period.status === 'CLOSED') {
      throw new ConflictException('Period is already closed');
    }

    // Check if all procedures are completed
    const incompleteProcedures = await this.prisma.procedure.count({
      where: {
        periodId: id,
        status: { not: 'COMPLETED' },
        isActive: true,
      },
    });

    if (incompleteProcedures > 0) {
      throw new ConflictException(
        `Cannot close period with ${incompleteProcedures} incomplete procedures`
      );
    }

    return this.prisma.period.update({
      where: { id },
      data: {
        status: 'CLOSED',
        closedDate: new Date(),
        updatedAt: new Date(),
      },
    });
  }

  async reopenPeriod(id: string, tenantId: string) {
    const period = await this.getPeriodById(id, tenantId);

    if (period.status !== 'CLOSED') {
      throw new ConflictException('Only closed periods can be reopened');
    }

    return this.prisma.period.update({
      where: { id },
      data: {
        status: 'IN_PROGRESS',
        closedDate: null,
        updatedAt: new Date(),
      },
    });
  }

  async deletePeriod(id: string, tenantId: string) {
    const period = await this.getPeriodById(id, tenantId);

    if (period.status === 'CLOSED') {
      throw new ForbiddenException('Cannot delete a closed period');
    }

    // Check if period has any data
    const hasData = period._count.accounts > 0 || 
                   period._count.procedures > 0 || 
                   period._count.journalEntries > 0;

    if (hasData) {
      throw new ForbiddenException('Cannot delete period with existing data');
    }

    return this.prisma.period.update({
      where: { id },
      data: {
        isActive: false,
        updatedAt: new Date(),
      },
    });
  }

  async getPeriodStats(tenantId: string) {
    const [totalPeriods, activePeriods, closedPeriods, inProgressPeriods] = await Promise.all([
      this.prisma.period.count({
        where: { tenantId },
      }),
      this.prisma.period.count({
        where: { 
          tenantId,
          isActive: true,
        },
      }),
      this.prisma.period.count({
        where: {
          tenantId,
          status: 'CLOSED',
          isActive: true,
        },
      }),
      this.prisma.period.count({
        where: {
          tenantId,
          status: 'IN_PROGRESS',
          isActive: true,
        },
      }),
    ]);

    return {
      totalPeriods,
      activePeriods,
      closedPeriods,
      inProgressPeriods,
      planningPeriods: activePeriods - inProgressPeriods - closedPeriods,
    };
  }

  async searchPeriods(tenantId: string, query: string) {
    return this.prisma.period.findMany({
      where: {
        tenantId,
        isActive: true,
        OR: [
          { name: { contains: query, mode: 'insensitive' } },
          { description: { contains: query, mode: 'insensitive' } },
          { fiscalYear: { contains: query, mode: 'insensitive' } },
          { company: { name: { contains: query, mode: 'insensitive' } } },
        ],
      },
      include: {
        company: {
          select: { name: true, businessType: true },
        },
      },
      orderBy: { startDate: 'desc' },
    });
  }
}