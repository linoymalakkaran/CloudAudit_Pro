import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../database/prisma.service';
import { AnalyticsQueryDto, CreateSnapshotDto, AnalyticsMetric } from './dto/analytics-query.dto';

@Injectable()
export class AnalyticsService {
  constructor(private prisma: PrismaService) {}

  async getOverview(tenantId: string, companyId: string, periodId?: string) {
    const where: any = { tenantId, companyId };
    if (periodId) where.periodId = periodId;

    const [
      totalTransactions,
      totalDocuments,
      totalFindings,
      auditProgress,
      financialSummary,
    ] = await Promise.all([
      this.prisma.ledger.count({ where }),
      this.prisma.document.count({ where }),
      this.prisma.finding.count({ where }),
      this.getAuditProgress(tenantId, companyId, periodId),
      this.getFinancialSummary(tenantId, companyId, periodId),
    ]);

    return {
      summary: {
        totalTransactions,
        totalDocuments,
        totalFindings,
        auditCompletion: auditProgress.completionPercentage,
      },
      financial: financialSummary,
      auditProgress,
      timestamp: new Date(),
    };
  }

  async customQuery(analyticsQuery: AnalyticsQueryDto, tenantId: string) {
    const { companyId, periodId, metrics, timeframe, filters } = analyticsQuery;
    
    const results = await Promise.all(
      metrics?.map(metric => this.getMetricData(metric, tenantId, companyId, periodId)) || []
    );

    return {
      companyId,
      periodId,
      timeframe,
      metrics: results.reduce((acc, result, index) => {
        acc[metrics[index]] = result;
        return acc;
      }, {}),
      generatedAt: new Date(),
    };
  }

  async financialRatios(tenantId: string, companyId: string, periodId?: string) {
    const where: any = { tenantId, companyId };
    if (periodId) where.periodId = periodId;

    // Get financial data
    const [assets, liabilities, equity, revenue, expenses] = await Promise.all([
      this.prisma.accountHead.aggregate({
        where: { ...where, accountType: 'ASSET' },
        _sum: { balance: true },
      }),
      this.prisma.liability.aggregate({
        where,
        _sum: { currentAmount: true },
      }),
      this.prisma.equity.aggregate({
        where,
        _sum: { amount: true },
      }),
      this.prisma.ledger.aggregate({
        where: {
          ...where,
          account: { accountType: 'REVENUE' },
        },
        _sum: { credit: true },
      }),
      this.prisma.ledger.aggregate({
        where: {
          ...where,
          account: { accountType: 'EXPENSE' },
        },
        _sum: { debit: true },
      }),
    ]);

    const totalAssets = Number(assets._sum.balance || 0);
    const totalLiabilities = Number(liabilities._sum.currentAmount || 0);
    const totalEquity = Number(equity._sum.amount || 0);
    const totalRevenue = Number(revenue._sum.credit || 0);
    const totalExpenses = Number(expenses._sum.debit || 0);

    const netIncome = totalRevenue - totalExpenses;
    
    // Current assets (simplified - should filter by current vs non-current)
    const currentAssets = totalAssets * 0.6; // Simplified assumption
    const currentLiabilities = totalLiabilities * 0.7; // Simplified assumption

    return {
      liquidityRatios: {
        currentRatio: currentLiabilities > 0 ? currentAssets / currentLiabilities : 0,
        quickRatio: currentLiabilities > 0 ? (currentAssets * 0.8) / currentLiabilities : 0,
      },
      profitabilityRatios: {
        grossProfitMargin: totalRevenue > 0 ? (netIncome / totalRevenue) * 100 : 0,
        netProfitMargin: totalRevenue > 0 ? (netIncome / totalRevenue) * 100 : 0,
        returnOnAssets: totalAssets > 0 ? (netIncome / totalAssets) * 100 : 0,
        returnOnEquity: totalEquity > 0 ? (netIncome / totalEquity) * 100 : 0,
      },
      leverageRatios: {
        debtToAssets: totalAssets > 0 ? (totalLiabilities / totalAssets) * 100 : 0,
        debtToEquity: totalEquity > 0 ? (totalLiabilities / totalEquity) * 100 : 0,
        equityRatio: totalAssets > 0 ? (totalEquity / totalAssets) * 100 : 0,
      },
      amounts: {
        totalAssets,
        totalLiabilities,
        totalEquity,
        totalRevenue,
        totalExpenses,
        netIncome,
      },
    };
  }

  async trendAnalysis(tenantId: string, companyId: string, metric: AnalyticsMetric, periods: number = 12) {
    // Get historical periods
    const historicalPeriods = await this.prisma.period.findMany({
      where: { tenantId, companyId },
      orderBy: { startDate: 'desc' },
      take: periods,
    });

    const trends = await Promise.all(
      historicalPeriods.map(async period => {
        const value = await this.getMetricData(metric, tenantId, companyId, period.id);
        return {
          periodId: period.id,
          periodName: period.name,
          startDate: period.startDate,
          endDate: period.endDate,
          value,
        };
      })
    );

    // Calculate trend direction
    const values = trends.map(t => Number(t.value));
    const averageChange = values.length > 1 
      ? (values[0] - values[values.length - 1]) / (values.length - 1)
      : 0;
    
    return {
      metric,
      periods: trends.reverse(),
      summary: {
        latestValue: values[0],
        averageChange,
        trendDirection: averageChange > 0 ? 'INCREASING' : averageChange < 0 ? 'DECREASING' : 'STABLE',
        percentageChange: values[values.length - 1] !== 0 
          ? ((values[0] - values[values.length - 1]) / values[values.length - 1]) * 100
          : 0,
      },
    };
  }

  async varianceAnalysis(tenantId: string, companyId: string, periodId: string, comparisonPeriodId: string) {
    const [currentData, comparisonData] = await Promise.all([
      this.getFinancialSummary(tenantId, companyId, periodId),
      this.getFinancialSummary(tenantId, companyId, comparisonPeriodId),
    ]);

    const variance = {
      revenue: {
        current: currentData.totalRevenue,
        comparison: comparisonData.totalRevenue,
        variance: currentData.totalRevenue - comparisonData.totalRevenue,
        variancePercent: comparisonData.totalRevenue !== 0 
          ? ((currentData.totalRevenue - comparisonData.totalRevenue) / comparisonData.totalRevenue) * 100
          : 0,
      },
      expenses: {
        current: currentData.totalExpenses,
        comparison: comparisonData.totalExpenses,
        variance: currentData.totalExpenses - comparisonData.totalExpenses,
        variancePercent: comparisonData.totalExpenses !== 0
          ? ((currentData.totalExpenses - comparisonData.totalExpenses) / comparisonData.totalExpenses) * 100
          : 0,
      },
      netIncome: {
        current: currentData.netIncome,
        comparison: comparisonData.netIncome,
        variance: currentData.netIncome - comparisonData.netIncome,
        variancePercent: comparisonData.netIncome !== 0
          ? ((currentData.netIncome - comparisonData.netIncome) / comparisonData.netIncome) * 100
          : 0,
      },
    };

    return {
      currentPeriodId: periodId,
      comparisonPeriodId,
      variance,
      generatedAt: new Date(),
    };
  }

  async agingAnalysis(tenantId: string, companyId: string) {
    // Analyze aging of receivables/payables
    const currentDate = new Date();
    
    const liabilities = await this.prisma.liability.findMany({
      where: { tenantId, companyId },
      select: {
        id: true,
        description: true,
        currentAmount: true,
        dueDate: true,
      },
    });

    const aging = {
      current: 0,      // 0-30 days
      days30to60: 0,   // 31-60 days
      days60to90: 0,   // 61-90 days
      over90: 0,       // 90+ days
    };

    liabilities.forEach(liability => {
      if (!liability.dueDate) {
        aging.current += Number(liability.currentAmount);
        return;
      }

      const daysOverdue = Math.floor(
        (currentDate.getTime() - liability.dueDate.getTime()) / (1000 * 60 * 60 * 24)
      );

      if (daysOverdue <= 30) {
        aging.current += Number(liability.currentAmount);
      } else if (daysOverdue <= 60) {
        aging.days30to60 += Number(liability.currentAmount);
      } else if (daysOverdue <= 90) {
        aging.days60to90 += Number(liability.currentAmount);
      } else {
        aging.over90 += Number(liability.currentAmount);
      }
    });

    return {
      aging,
      total: aging.current + aging.days30to60 + aging.days60to90 + aging.over90,
      count: liabilities.length,
    };
  }

  async materialityCalculation(tenantId: string, companyId: string, periodId?: string) {
    const where: any = { tenantId, companyId };
    if (periodId) where.periodId = periodId;

    const [assets, revenue] = await Promise.all([
      this.prisma.accountHead.aggregate({
        where: { ...where, accountType: 'ASSET' },
        _sum: { balance: true },
      }),
      this.prisma.ledger.aggregate({
        where: {
          ...where,
          account: { accountType: 'REVENUE' },
        },
        _sum: { credit: true },
      }),
    ]);

    const totalAssets = Number(assets._sum.balance || 0);
    const totalRevenue = Number(revenue._sum.credit || 0);

    // Common materiality benchmarks
    const performanceMateriality = totalAssets * 0.01; // 1% of total assets
    const specificMateriality = totalRevenue * 0.005; // 0.5% of revenue
    const overallMateriality = Math.max(performanceMateriality, specificMateriality);

    return {
      overallMateriality,
      performanceMateriality,
      specificMateriality,
      benchmarks: {
        totalAssets,
        totalRevenue,
      },
      thresholds: {
        trivial: overallMateriality * 0.05, // 5% of materiality
        minor: overallMateriality * 0.25,    // 25% of materiality
        major: overallMateriality * 0.75,    // 75% of materiality
      },
    };
  }

  async createSnapshot(createSnapshotDto: CreateSnapshotDto, tenantId: string, userId: string) {
    const { companyId, periodId, snapshotType, snapshotDate } = createSnapshotDto;

    // Gather comprehensive metrics
    const [overview, ratios] = await Promise.all([
      this.getOverview(tenantId, companyId, periodId),
      this.financialRatios(tenantId, companyId, periodId),
    ]);

    return this.prisma.analyticsSnapshot.create({
      data: {
        tenantId,
        companyId,
        periodId,
        snapshotType: snapshotType as any || 'DAILY',
        snapshotDate: snapshotDate || new Date(),
        metrics: {
          overview: overview.summary,
          financial: overview.financial,
          ratios: ratios,
        },
        trends: {},
        alerts: [],
        createdBy: userId,
      },
      include: {
        company: { select: { name: true } },
        period: { select: { name: true } },
      },
    });
  }

  async getSnapshots(tenantId: string, companyId?: string, periodId?: string, limit: number = 30) {
    const where: any = { tenantId };
    if (companyId) where.companyId = companyId;
    if (periodId) where.periodId = periodId;

    return this.prisma.analyticsSnapshot.findMany({
      where,
      take: limit,
      orderBy: { snapshotDate: 'desc' },
      include: {
        company: { select: { name: true } },
        period: { select: { name: true } },
      },
    });
  }

  private async getMetricData(metric: AnalyticsMetric, tenantId: string, companyId: string, periodId?: string): Promise<number> {
    const where: any = { tenantId, companyId };
    if (periodId) where.periodId = periodId;

    switch (metric) {
      case AnalyticsMetric.REVENUE:
        const revenue = await this.prisma.ledger.aggregate({
          where: { ...where, account: { accountType: 'REVENUE' } },
          _sum: { credit: true },
        });
        return Number(revenue._sum.credit || 0);

      case AnalyticsMetric.EXPENSES:
        const expenses = await this.prisma.ledger.aggregate({
          where: { ...where, account: { accountType: 'EXPENSE' } },
          _sum: { debit: true },
        });
        return Number(expenses._sum.debit || 0);

      case AnalyticsMetric.DOCUMENT_COUNT:
        return await this.prisma.document.count({ where });

      case AnalyticsMetric.FINDING_SEVERITY:
        const findings = await this.prisma.finding.count({
          where: { ...where, severity: 'HIGH' },
        });
        return findings;

      default:
        return 0;
    }
  }

  private async getFinancialSummary(tenantId: string, companyId: string, periodId?: string) {
    const where: any = { tenantId, companyId };
    if (periodId) where.periodId = periodId;

    const [revenue, expenses] = await Promise.all([
      this.prisma.ledger.aggregate({
        where: { ...where, account: { accountType: 'REVENUE' } },
        _sum: { credit: true },
      }),
      this.prisma.ledger.aggregate({
        where: { ...where, account: { accountType: 'EXPENSE' } },
        _sum: { debit: true },
      }),
    ]);

    const totalRevenue = Number(revenue._sum.credit || 0);
    const totalExpenses = Number(expenses._sum.debit || 0);

    return {
      totalRevenue,
      totalExpenses,
      netIncome: totalRevenue - totalExpenses,
      profitMargin: totalRevenue > 0 ? ((totalRevenue - totalExpenses) / totalRevenue) * 100 : 0,
    };
  }

  private async getAuditProgress(tenantId: string, companyId: string, periodId?: string) {
    const where: any = { tenantId, companyId };
    if (periodId) where.periodId = periodId;

    const [total, completed] = await Promise.all([
      this.prisma.auditChecklistItem.count({ where }),
      this.prisma.auditChecklistItem.count({ where: { ...where, status: 'COMPLETED' } }),
    ]);

    return {
      total,
      completed,
      completionPercentage: total > 0 ? (completed / total) * 100 : 0,
    };
  }
}
