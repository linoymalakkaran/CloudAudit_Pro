import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../database/prisma.service';
import { CreateFindingDto, UpdateFindingDto, QueryFindingDto, FindingStatus } from './dto';
import { Severity } from '@prisma/client';

@Injectable()
export class FindingService {
  constructor(private readonly prisma: PrismaService) {}

  async create(
    tenantId: string,
    userId: string,
    createDto: CreateFindingDto,
  ) {
    // Verify procedure exists and belongs to tenant
    const procedure = await this.prisma.auditProcedure.findFirst({
      where: { id: createDto.procedureId, tenantId },
    });

    if (!procedure) {
      throw new NotFoundException('Audit procedure not found');
    }

    // Verify company and period
    const company = await this.prisma.company.findFirst({
      where: { id: createDto.companyId, tenantId },
    });

    if (!company) {
      throw new NotFoundException('Company not found');
    }

    const period = await this.prisma.period.findFirst({
      where: { id: createDto.periodId, companyId: createDto.companyId },
    });

    if (!period) {
      throw new NotFoundException('Period not found');
    }

    return this.prisma.finding.create({
      data: {
        tenantId,
        procedureId: createDto.procedureId,
        companyId: createDto.companyId,
        periodId: createDto.periodId,
        title: createDto.title,
        description: createDto.description,
        severity: createDto.severity as Severity,
        recommendation: createDto.recommendation,
        identifiedBy: userId,
      },
      include: {
        procedure: { select: { id: true, name: true, category: true } },
        company: { select: { id: true, name: true, code: true } },
        period: { select: { id: true, name: true } },
        identifier: { select: { id: true, firstName: true, lastName: true, email: true } },
      },
    });
  }

  async findAll(tenantId: string, query: QueryFindingDto) {
    const where: any = { tenantId };

    if (query.procedureId) where.procedureId = query.procedureId;
    if (query.companyId) where.companyId = query.companyId;
    if (query.periodId) where.periodId = query.periodId;
    if (query.status) where.status = query.status;
    if (query.severity) where.severity = query.severity;

    return this.prisma.finding.findMany({
      where,
      include: {
        procedure: { select: { id: true, name: true, category: true } },
        company: { select: { id: true, name: true, code: true } },
        period: { select: { id: true, name: true } },
        identifier: { select: { id: true, firstName: true, lastName: true, email: true } },
        resolver: { select: { id: true, firstName: true, lastName: true, email: true } },
      },
      orderBy: [
        { severity: 'desc' },
        { identifiedAt: 'desc' },
      ],
    });
  }

  async findOne(tenantId: string, id: string) {
    const finding = await this.prisma.finding.findFirst({
      where: { id, tenantId },
      include: {
        procedure: {
          include: {
            company: { select: { name: true, code: true } },
            period: { select: { name: true } },
          },
        },
        company: { select: { id: true, name: true, code: true } },
        period: { select: { id: true, name: true } },
        identifier: { select: { id: true, firstName: true, lastName: true, email: true } },
        resolver: { select: { id: true, firstName: true, lastName: true, email: true } },
      },
    });

    if (!finding) {
      throw new NotFoundException('Finding not found');
    }

    return finding;
  }

  async update(
    tenantId: string,
    userId: string,
    id: string,
    updateDto: UpdateFindingDto,
  ) {
    const finding = await this.prisma.finding.findFirst({
      where: { id, tenantId },
    });

    if (!finding) {
      throw new NotFoundException('Finding not found');
    }

    const updates: any = { ...updateDto };

    // Track resolution
    if (updateDto.status === FindingStatus.RESOLVED && !finding.resolvedAt) {
      updates.resolvedBy = userId;
      updates.resolvedAt = new Date();
    }

    return this.prisma.finding.update({
      where: { id },
      data: updates,
      include: {
        identifier: { select: { id: true, firstName: true, lastName: true, email: true } },
        resolver: { select: { id: true, firstName: true, lastName: true, email: true } },
      },
    });
  }

  async resolve(
    tenantId: string,
    userId: string,
    id: string,
    managementResponse?: string,
  ) {
    const finding = await this.prisma.finding.findFirst({
      where: { id, tenantId },
    });

    if (!finding) {
      throw new NotFoundException('Finding not found');
    }

    return this.prisma.finding.update({
      where: { id },
      data: {
        status: FindingStatus.RESOLVED,
        resolvedBy: userId,
        resolvedAt: new Date(),
        managementResponse,
      },
      include: {
        resolver: { select: { id: true, firstName: true, lastName: true, email: true } },
      },
    });
  }

  async delete(tenantId: string, id: string) {
    const finding = await this.prisma.finding.findFirst({
      where: { id, tenantId },
    });

    if (!finding) {
      throw new NotFoundException('Finding not found');
    }

    return this.prisma.finding.delete({
      where: { id },
    });
  }

  async getStatistics(tenantId: string, companyId?: string, periodId?: string) {
    const where: any = { tenantId };
    if (companyId) where.companyId = companyId;
    if (periodId) where.periodId = periodId;

    const [total, byStatus, bySeverity, openCritical] = await Promise.all([
      this.prisma.finding.count({ where }),
      this.prisma.finding.groupBy({
        by: ['status'],
        where,
        _count: true,
      }),
      this.prisma.finding.groupBy({
        by: ['severity'],
        where,
        _count: true,
      }),
      this.prisma.finding.count({
        where: {
          ...where,
          status: { in: [FindingStatus.OPEN, FindingStatus.IN_PROGRESS] },
          severity: { in: ['MATERIAL', 'CRITICAL'] },
        },
      }),
    ]);

    return {
      total,
      byStatus: byStatus.reduce((acc, item) => {
        acc[item.status] = item._count;
        return acc;
      }, {} as Record<string, number>),
      bySeverity: bySeverity.reduce((acc, item) => {
        acc[item.severity] = item._count;
        return acc;
      }, {} as Record<string, number>),
      openCritical,
    };
  }
}
