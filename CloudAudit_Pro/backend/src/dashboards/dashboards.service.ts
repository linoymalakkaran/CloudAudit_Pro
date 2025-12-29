import { Injectable, NotFoundException, BadRequestException } from '@nestjs/common';
import { PrismaService } from '../database/prisma.service';
import { CreateDashboardDto } from './dto/create-dashboard.dto';
import { UpdateDashboardDto } from './dto/update-dashboard.dto';
import { WidgetDataRequestDto, WidgetDataPeriod } from './dto/widget-data.dto';

@Injectable()
export class DashboardsService {
  constructor(private prisma: PrismaService) {}

  async create(createDashboardDto: CreateDashboardDto, tenantId: string, userId: string) {
    // If setting as default, unset other defaults
    if (createDashboardDto.isDefault) {
      await this.prisma.dashboard.updateMany({
        where: { tenantId, isDefault: true },
        data: { isDefault: false },
      });
    }

    return this.prisma.dashboard.create({
      data: {
        tenantId,
        name: createDashboardDto.name,
        description: createDashboardDto.description,
        layout: createDashboardDto.layout,
        widgets: createDashboardDto.widgets as any,
        companyId: createDashboardDto.companyId,
        periodId: createDashboardDto.periodId,
        sharedWith: createDashboardDto.sharedWith || [],
        isPublic: createDashboardDto.isPublic || false,
        isDefault: createDashboardDto.isDefault || false,
        createdBy: userId,
        updatedBy: userId,
      },
      include: {
        company: { select: { name: true } },
        period: { select: { name: true } },
        createdByUser: { select: { id: true, email: true, firstName: true, lastName: true } },
      },
    });
  }

  async findAll(tenantId: string, companyId?: string, userId?: string) {
    const where: any = {
      tenantId,
      OR: [
        { isPublic: true },
        { createdBy: userId },
        { sharedWith: { has: userId } },
      ],
    };

    if (companyId) {
      where.companyId = companyId;
    }

    return this.prisma.dashboard.findMany({
      where,
      include: {
        company: { select: { name: true } },
        period: { select: { name: true } },
        createdByUser: { select: { email: true, firstName: true, lastName: true } },
      },
      orderBy: [{ isDefault: 'desc' }, { createdAt: 'desc' }],
    });
  }

  async findOne(id: string, tenantId: string, userId: string) {
    const dashboard = await this.prisma.dashboard.findFirst({
      where: {
        id,
        tenantId,
        OR: [
          { isPublic: true },
          { createdBy: userId },
          { sharedWith: { has: userId } },
        ],
      },
      include: {
        company: true,
        period: true,
        createdByUser: { select: { id: true, email: true, firstName: true, lastName: true } },
      },
    });

    if (!dashboard) {
      throw new NotFoundException(`Dashboard with ID ${id} not found`);
    }

    return dashboard;
  }

  async findDefault(tenantId: string, userId: string) {
    const dashboard = await this.prisma.dashboard.findFirst({
      where: {
        tenantId,
        isDefault: true,
        OR: [
          { isPublic: true },
          { createdBy: userId },
          { sharedWith: { has: userId } },
        ],
      },
      include: {
        company: { select: { name: true } },
        period: { select: { name: true } },
      },
    });

    if (!dashboard) {
      throw new NotFoundException('No default dashboard found');
    }

    return dashboard;
  }

  async update(
    id: string,
    updateDashboardDto: UpdateDashboardDto,
    tenantId: string,
    userId: string,
  ) {
    const dashboard = await this.findOne(id, tenantId, userId);

    // Check ownership for updates
    if (dashboard.createdBy !== userId) {
      throw new BadRequestException('You can only update your own dashboards');
    }

    // If setting as default, unset other defaults
    if (updateDashboardDto.isDefault) {
      await this.prisma.dashboard.updateMany({
        where: { tenantId, isDefault: true, id: { not: id } },
        data: { isDefault: false },
      });
    }

    return this.prisma.dashboard.update({
      where: { id },
      data: {
        name: updateDashboardDto.name,
        description: updateDashboardDto.description,
        layout: updateDashboardDto.layout,
        widgets: updateDashboardDto.widgets as any,
        companyId: updateDashboardDto.companyId,
        periodId: updateDashboardDto.periodId,
        sharedWith: updateDashboardDto.sharedWith,
        isPublic: updateDashboardDto.isPublic,
        isDefault: updateDashboardDto.isDefault,
        updatedBy: userId,
      },
      include: {
        company: true,
        period: true,
      },
    });
  }

  async remove(id: string, tenantId: string, userId: string) {
    const dashboard = await this.findOne(id, tenantId, userId);

    // Check ownership for deletion
    if (dashboard.createdBy !== userId) {
      throw new BadRequestException('You can only delete your own dashboards');
    }

    return this.prisma.dashboard.delete({
      where: { id },
    });
  }

  async duplicate(id: string, tenantId: string, userId: string) {
    const dashboard = await this.findOne(id, tenantId, userId);
    const { id: _, createdAt, updatedAt, isDefault, ...dashboardData } = dashboard;

    return this.prisma.dashboard.create({
      data: {
        tenantId: dashboard.tenantId,
        name: `${dashboard.name} (Copy)`,
        description: dashboard.description,
        layout: dashboard.layout,
        widgets: dashboard.widgets,
        companyId: dashboard.companyId,
        periodId: dashboard.periodId,
        sharedWith: dashboard.sharedWith,
        isPublic: dashboard.isPublic,
        isDefault: false,
        createdBy: userId,
        updatedBy: userId,
      },
    });
  }

  async setDefault(id: string, tenantId: string, userId: string) {
    const dashboard = await this.findOne(id, tenantId, userId);

    // Unset other defaults
    await this.prisma.dashboard.updateMany({
      where: { tenantId, isDefault: true },
      data: { isDefault: false },
    });

    return this.prisma.dashboard.update({
      where: { id },
      data: { isDefault: true, updatedBy: userId },
    });
  }

  async share(id: string, userIds: string[], tenantId: string, userId: string) {
    const dashboard = await this.findOne(id, tenantId, userId);

    // Check ownership
    if (dashboard.createdBy !== userId) {
      throw new BadRequestException('You can only share your own dashboards');
    }

    const currentShared = dashboard.sharedWith || [];
    const newShared = Array.from(new Set([...currentShared, ...userIds]));

    return this.prisma.dashboard.update({
      where: { id },
      data: { sharedWith: newShared, updatedBy: userId },
    });
  }

  async unshare(id: string, userIds: string[], tenantId: string, userId: string) {
    const dashboard = await this.findOne(id, tenantId, userId);

    // Check ownership
    if (dashboard.createdBy !== userId) {
      throw new BadRequestException('You can only unshare your own dashboards');
    }

    const currentShared = dashboard.sharedWith || [];
    const newShared = currentShared.filter(uid => !userIds.includes(uid));

    return this.prisma.dashboard.update({
      where: { id },
      data: { sharedWith: newShared, updatedBy: userId },
    });
  }

  async getWidgetData(
    widgetDataRequest: WidgetDataRequestDto,
    tenantId: string,
  ): Promise<any> {
    const { widgetType, companyId, periodId, filters } = widgetDataRequest;

    switch (widgetType) {
      case 'financial-summary':
        return this.getFinancialSummary(tenantId, companyId, periodId);
      case 'audit-progress':
        return this.getAuditProgress(tenantId, companyId, periodId);
      case 'recent-activities':
        return this.getRecentActivities(tenantId, companyId);
      case 'outstanding-items':
        return this.getOutstandingItems(tenantId, companyId, periodId);
      case 'document-stats':
        return this.getDocumentStats(tenantId, companyId);
      case 'team-workload':
        return this.getTeamWorkload(tenantId, companyId);
      default:
        throw new BadRequestException(`Unknown widget type: ${widgetType}`);
    }
  }

  private async getFinancialSummary(tenantId: string, companyId?: string, periodId?: string) {
    const where: any = { tenantId };
    if (companyId) where.companyId = companyId;
    if (periodId) where.periodId = periodId;

    const [trialBalance, ledgerCount, accountCount] = await Promise.all([
      this.prisma.trialBalanceEntry.aggregate({
        where,
        _sum: { debitBalance: true, creditBalance: true },
      }),
      this.prisma.ledger.count({ where }),
      this.prisma.accountHead.count({ where: { tenantId, ...(companyId && { companyId }) } }),
    ]);

    return {
      totalDebit: trialBalance._sum.debitBalance || 0,
      totalCredit: trialBalance._sum.creditBalance || 0,
      totalTransactions: ledgerCount,
      totalAccounts: accountCount,
      isBalanced: trialBalance._sum.debitBalance === trialBalance._sum.creditBalance,
    };
  }

  private async getAuditProgress(tenantId: string, companyId?: string, periodId?: string) {
    const where: any = { tenantId };
    if (companyId) where.companyId = companyId;
    if (periodId) where.periodId = periodId;

    const [total, byStatus] = await Promise.all([
      this.prisma.auditProcedure.count({ where }),
      this.prisma.auditProcedure.groupBy({
        by: ['status'],
        where,
        _count: true,
      }),
    ]);

    const statusCounts = byStatus.reduce((acc, item) => {
      acc[item.status] = item._count;
      return acc;
    }, {} as Record<string, number>);

    return {
      totalItems: total,
      statusBreakdown: statusCounts,
      completionPercentage: total > 0 ? ((statusCounts['COMPLETED'] || 0) / total) * 100 : 0,
    };
  }

  private async getRecentActivities(tenantId: string, companyId?: string) {
    const where: any = { tenantId };
    if (companyId) where.companyId = companyId;

    const activities = await this.prisma.auditLog.findMany({
      where,
      take: 10,
      include: {
        user: { select: { email: true, firstName: true, lastName: true } },
      },
    });

    return activities.map(activity => ({
      id: activity.id,
      action: activity.action,
      entity: activity.entityType,
      user: activity.user ? `${activity.user.firstName} ${activity.user.lastName}` : activity.user?.email,
      timestamp: activity.timestamp,
      description: activity.description,
    }));
  }

  private async getOutstandingItems(tenantId: string, companyId?: string, periodId?: string) {
    const where: any = { tenantId, status: { not: 'COMPLETED' } };
    if (companyId) where.companyId = companyId;
    if (periodId) where.periodId = periodId;

    const items = await this.prisma.auditProcedure.findMany({
      where,
      orderBy: { dueDate: 'asc' },
      take: 20,
    });

    return items.map(item => ({
      id: item.id,
      title: item.name,
      status: item.status,
      dueDate: item.dueDate,
      isOverdue: item.dueDate && item.dueDate < new Date(),
    }));
  }

  private async getDocumentStats(tenantId: string, companyId?: string) {
    const where: any = { tenantId };
    if (companyId) where.companyId = companyId;

    const total = await this.prisma.document.count({ where });

    return {
      totalDocuments: total,
      byType: {},
      byStatus: {},
    };
  }

  private async getTeamWorkload(tenantId: string, companyId?: string) {
    const where: any = { tenantId };
    if (companyId) where.companyId = companyId;

    // TODO: Implement proper team workload aggregation without circular groupBy
    return [];
  }
}
