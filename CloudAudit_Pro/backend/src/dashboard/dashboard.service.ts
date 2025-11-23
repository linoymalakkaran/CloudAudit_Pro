import { Injectable, NotFoundException, ForbiddenException } from '@nestjs/common';
import { DatabaseService } from '../database/database.service';
import {
  DashboardFilterDto,
  DashboardConfigDto,
  KPIDto,
  AlertDto,
  DashboardType,
  Timeframe,
  MetricType
} from './dto/dashboard.dto';

interface FinancialMetrics {
  totalRevenue: number;
  totalExpenses: number;
  netIncome: number;
  grossMargin: number;
  operatingMargin: number;
  cashFlow: number;
  currentRatio: number;
  quickRatio: number;
  debtToEquity: number;
  returnOnAssets: number;
}

interface AuditMetrics {
  totalProcedures: number;
  completedProcedures: number;
  pendingProcedures: number;
  overdueProcedures: number;
  completionRate: number;
  averageCompletionTime: number;
  riskCoverage: number;
  findingsCount: number;
  criticalFindings: number;
  complianceScore: number;
}

interface OperationalMetrics {
  activeUsers: number;
  documentsProcessed: number;
  reportGenerated: number;
  systemUptime: number;
  averageResponseTime: number;
  errorRate: number;
  storageUtilization: number;
  backupStatus: string;
}

export interface DashboardData {
  summary: {
    totalCompanies: number;
    activePeriods: number;
    totalUsers: number;
    pendingTasks: number;
  };
  financial: FinancialMetrics;
  audit: AuditMetrics;
  operational: OperationalMetrics;
  kpis: KPIDto[];
  alerts: AlertDto[];
  trends: {
    revenue: number[];
    expenses: number[];
    completionRates: number[];
    userActivity: number[];
  };
  recentActivity: {
    id: string;
    type: string;
    description: string;
    timestamp: Date;
    user: string;
  }[];
}

@Injectable()
export class DashboardService {
  constructor(private readonly database: DatabaseService) {}

  async getExecutiveDashboard(filters: DashboardFilterDto, userId: string): Promise<DashboardData> {
    await this.verifyUserAccess(userId);

    const timeRange = this.getTimeRange(filters.timeframe, filters.startDate, filters.endDate);
    const companyFilter = await this.buildCompanyFilter(filters.companyId, userId);

    const [
      summary,
      financialMetrics,
      auditMetrics,
      operationalMetrics,
      alerts,
      recentActivity,
    ] = await Promise.all([
      this.getSummaryMetrics(companyFilter, timeRange),
      this.getFinancialMetrics(companyFilter, timeRange),
      this.getAuditMetrics(companyFilter, timeRange),
      this.getOperationalMetrics(companyFilter, timeRange),
      this.getActiveAlerts(companyFilter),
      this.getRecentActivity(companyFilter, timeRange),
    ]);

    const kpis = this.buildKPIs(financialMetrics, auditMetrics, operationalMetrics);
    const trends = await this.getTrendData(companyFilter, timeRange);

    return {
      summary,
      financial: financialMetrics,
      audit: auditMetrics,
      operational: operationalMetrics,
      kpis,
      alerts,
      trends,
      recentActivity,
    };
  }

  async getFinancialDashboard(filters: DashboardFilterDto, userId: string) {
    await this.verifyUserAccess(userId);
    
    const timeRange = this.getTimeRange(filters.timeframe, filters.startDate, filters.endDate);
    const companyFilter = await this.buildCompanyFilter(filters.companyId, userId);

    const [
      financialMetrics,
      cashFlowData,
      profitabilityTrends,
      balanceSheetMetrics,
      budgetVariance,
    ] = await Promise.all([
      this.getFinancialMetrics(companyFilter, timeRange),
      this.getCashFlowAnalysis(companyFilter, timeRange),
      this.getProfitabilityTrends(companyFilter, timeRange),
      this.getBalanceSheetAnalysis(companyFilter, timeRange),
      this.getBudgetVarianceAnalysis(companyFilter, timeRange),
    ]);

    return {
      overview: financialMetrics,
      cashFlow: cashFlowData,
      profitability: profitabilityTrends,
      balanceSheet: balanceSheetMetrics,
      budgetVariance,
      lastUpdated: new Date(),
    };
  }

  async getAuditDashboard(filters: DashboardFilterDto, userId: string) {
    await this.verifyUserAccess(userId);
    
    const timeRange = this.getTimeRange(filters.timeframe, filters.startDate, filters.endDate);
    const companyFilter = await this.buildCompanyFilter(filters.companyId, userId);

    const [
      auditMetrics,
      procedureStatus,
      riskAssessment,
      findingsAnalysis,
      complianceMetrics,
      teamWorkload,
    ] = await Promise.all([
      this.getAuditMetrics(companyFilter, timeRange),
      this.getProcedureStatusBreakdown(companyFilter, timeRange),
      this.getRiskAssessmentData(companyFilter, timeRange),
      this.getFindingsAnalysis(companyFilter, timeRange),
      this.getComplianceMetrics(companyFilter, timeRange),
      this.getTeamWorkloadAnalysis(companyFilter, timeRange),
    ]);

    return {
      overview: auditMetrics,
      procedures: procedureStatus,
      riskAssessment,
      findings: findingsAnalysis,
      compliance: complianceMetrics,
      teamWorkload,
      lastUpdated: new Date(),
    };
  }

  async getOperationalDashboard(filters: DashboardFilterDto, userId: string) {
    await this.verifyUserAccess(userId);
    
    const timeRange = this.getTimeRange(filters.timeframe, filters.startDate, filters.endDate);

    const [
      operationalMetrics,
      systemHealth,
      userActivity,
      documentMetrics,
      reportingMetrics,
      performanceMetrics,
    ] = await Promise.all([
      this.getOperationalMetrics({}, timeRange),
      this.getSystemHealthMetrics(),
      this.getUserActivityMetrics(timeRange),
      this.getDocumentMetrics(timeRange),
      this.getReportingMetrics(timeRange),
      this.getPerformanceMetrics(timeRange),
    ]);

    return {
      overview: operationalMetrics,
      systemHealth,
      userActivity,
      documents: documentMetrics,
      reporting: reportingMetrics,
      performance: performanceMetrics,
      lastUpdated: new Date(),
    };
  }

  async getCustomDashboard(config: DashboardConfigDto, filters: DashboardFilterDto, userId: string) {
    await this.verifyUserAccess(userId);
    
    const timeRange = this.getTimeRange(filters.timeframe, filters.startDate, filters.endDate);
    const companyFilter = await this.buildCompanyFilter(filters.companyId, userId);

    const dashboardData: any = {
      config,
      data: {},
      charts: [],
      metrics: [],
      lastUpdated: new Date(),
    };

    // Process custom metrics
    if (config.metrics) {
      for (const metric of config.metrics) {
        const value = await this.calculateCustomMetric(metric, companyFilter, timeRange);
        dashboardData.metrics.push({
          ...metric,
          value,
          timestamp: new Date(),
        });
      }
    }

    // Process custom charts
    if (config.charts) {
      for (const chart of config.charts) {
        const chartData = await this.generateChartData(chart, companyFilter, timeRange);
        dashboardData.charts.push({
          ...chart,
          data: chartData,
        });
      }
    }

    return dashboardData;
  }

  async getRealtimeMetrics(companyId?: string, userId?: string) {
    const companyFilter = companyId ? { companyId } : {};

    const [
      activeUsers,
      ongoingProcedures,
      pendingDocuments,
      systemLoad,
    ] = await Promise.all([
      this.getActiveUserCount(),
      this.getOngoingProceduresCount(companyFilter),
      this.getPendingDocumentsCount(companyFilter),
      this.getSystemLoadMetrics(),
    ]);

    return {
      activeUsers,
      ongoingProcedures,
      pendingDocuments,
      systemLoad,
      timestamp: new Date(),
    };
  }

  async createAlert(alert: Omit<AlertDto, 'id' | 'createdAt'>, userId: string, companyId: string) {
    return this.database.alert.create({
      data: {
        companyId: companyId,
        alertType: 'SYSTEM',
        title: alert.title,
        message: alert.message,
        severity: alert.severity,
        category: alert.category || 'GENERAL',
        entityId: alert.entityId || '',
        entityType: alert.entityType || 'SYSTEM',
        actionRequired: Boolean(alert.actionRequired),
        acknowledged: false,
        createdBy: userId,
      },
    });
  }

  async acknowledgeAlert(alertId: string, userId: string) {
    return this.database.alert.update({
      where: { id: alertId },
      data: {
        acknowledged: true,
        acknowledgedAt: new Date(),
      },
    });
  }

  // Private helper methods
  private async getSummaryMetrics(companyFilter: any, timeRange: any) {
    const [
      totalCompanies,
      activePeriods,
      totalUsers,
      pendingTasks,
    ] = await Promise.all([
      this.database.company.count({ where: companyFilter }),
      this.database.period.count({ 
        where: { 
          ...companyFilter, 
          isActive: true 
        } 
      }),
      this.database.user.count({ where: { isActive: true } }),
      this.database.procedure.count({ 
        where: { 
          ...companyFilter,
          status: { in: ['NOT_STARTED', 'IN_PROGRESS'] }
        } 
      }),
    ]);

    return {
      totalCompanies,
      activePeriods,
      totalUsers,
      pendingTasks,
    };
  }

  private async getFinancialMetrics(companyFilter: any, timeRange: any): Promise<FinancialMetrics> {
    // This would calculate financial metrics from trial balance and journal entries
    const trialBalanceData = await this.database.trialBalance.findMany({
      where: {
        ...companyFilter,
        createdAt: timeRange,
      },
      include: {
        accountHead: {
          select: { accountTypeString: true },
        },
      },
    });

    // Calculate metrics based on account types
    let totalRevenue = 0;
    let totalExpenses = 0;
    let totalAssets = 0;
    let totalLiabilities = 0;
    let totalEquity = 0;

    trialBalanceData.forEach(item => {
      const balance = Number(item.creditBalance) - Number(item.debitBalance);
      
      switch (item.accountHead.accountTypeString) {
        case 'REVENUE':
          totalRevenue += balance;
          break;
        case 'EXPENSE':
          totalExpenses += Math.abs(balance);
          break;
        case 'ASSET':
          totalAssets += Math.abs(balance);
          break;
        case 'LIABILITY':
          totalLiabilities += balance;
          break;
        case 'EQUITY':
          totalEquity += balance;
          break;
      }
    });

    const netIncome = totalRevenue - totalExpenses;
    const grossMargin = totalRevenue > 0 ? (netIncome / totalRevenue) * 100 : 0;
    const operatingMargin = grossMargin; // Simplified
    const currentRatio = totalLiabilities > 0 ? totalAssets / totalLiabilities : 0;
    const debtToEquity = totalEquity > 0 ? totalLiabilities / totalEquity : 0;
    const returnOnAssets = totalAssets > 0 ? (netIncome / totalAssets) * 100 : 0;

    return {
      totalRevenue,
      totalExpenses,
      netIncome,
      grossMargin,
      operatingMargin,
      cashFlow: netIncome, // Simplified
      currentRatio,
      quickRatio: currentRatio * 0.8, // Simplified
      debtToEquity,
      returnOnAssets,
    };
  }

  private async getAuditMetrics(companyFilter: any, timeRange: any): Promise<AuditMetrics> {
    const procedures = await this.database.procedure.findMany({
      where: {
        ...companyFilter,
        createdAt: timeRange,
      },
    });

    const totalProcedures = procedures.length;
    const completedProcedures = procedures.filter(p => p.status === 'COMPLETED').length;
    const pendingProcedures = procedures.filter(p => p.status === 'IN_PROGRESS').length;
    const overdueProcedures = procedures.filter(p => 
      p.dueDate && new Date(p.dueDate) < new Date() && p.status !== 'COMPLETED'
    ).length;

    const completionRate = totalProcedures > 0 ? (completedProcedures / totalProcedures) * 100 : 0;

    return {
      totalProcedures,
      completedProcedures,
      pendingProcedures,
      overdueProcedures,
      completionRate,
      averageCompletionTime: 2.5, // Would calculate from actual data
      riskCoverage: 85, // Would calculate based on risk assessments
      findingsCount: 12, // Would come from findings database
      criticalFindings: 3, // Would filter by severity
      complianceScore: 92, // Would calculate based on compliance checks
    };
  }

  private async getOperationalMetrics(companyFilter: any, timeRange: any): Promise<OperationalMetrics> {
    const [
      activeUsers,
      documentsCount,
      reportsCount,
    ] = await Promise.all([
      this.database.user.count({ where: { isActive: true } }),
      this.database.document.count({ 
        where: { 
          ...companyFilter,
          createdAt: timeRange 
        } 
      }),
      this.database.report.count({ 
        where: { 
          ...companyFilter,
          createdAt: timeRange 
        } 
      }),
    ]);

    return {
      activeUsers,
      documentsProcessed: documentsCount,
      reportGenerated: reportsCount,
      systemUptime: 99.8,
      averageResponseTime: 150,
      errorRate: 0.02,
      storageUtilization: 65.4,
      backupStatus: 'HEALTHY',
    };
  }

  private buildKPIs(financial: FinancialMetrics, audit: AuditMetrics, operational: OperationalMetrics): KPIDto[] {
    return [
      {
        id: 'revenue',
        name: 'Total Revenue',
        value: financial.totalRevenue,
        target: financial.totalRevenue * 1.1,
        change: 15.2,
        trend: 'UP',
        status: 'GOOD',
        unit: 'currency',
        format: '$#,##0.00',
      },
      {
        id: 'net-income',
        name: 'Net Income',
        value: financial.netIncome,
        target: financial.netIncome * 1.05,
        change: 8.7,
        trend: 'UP',
        status: 'GOOD',
        unit: 'currency',
        format: '$#,##0.00',
      },
      {
        id: 'completion-rate',
        name: 'Audit Completion Rate',
        value: audit.completionRate,
        target: 95,
        change: 5.3,
        trend: 'UP',
        status: audit.completionRate >= 90 ? 'GOOD' : audit.completionRate >= 70 ? 'WARNING' : 'CRITICAL',
        unit: 'percentage',
        format: '#0.0%',
      },
      {
        id: 'compliance-score',
        name: 'Compliance Score',
        value: audit.complianceScore,
        target: 95,
        change: 2.1,
        trend: 'UP',
        status: audit.complianceScore >= 90 ? 'GOOD' : 'WARNING',
        unit: 'percentage',
        format: '#0.0%',
      },
      {
        id: 'system-uptime',
        name: 'System Uptime',
        value: operational.systemUptime,
        target: 99.9,
        change: 0.1,
        trend: 'STABLE',
        status: operational.systemUptime >= 99.5 ? 'GOOD' : 'WARNING',
        unit: 'percentage',
        format: '#0.00%',
      },
    ];
  }

  private async getActiveAlerts(companyFilter: any): Promise<AlertDto[]> {
    const alerts = await this.database.alert.findMany({
      where: {
        acknowledged: false,
        // Add company filtering if needed
      },
      orderBy: {
        createdAt: 'desc',
      },
      take: 10,
    });

    return alerts.map(alert => ({
      id: alert.id,
      title: alert.title,
      message: alert.message,
      severity: alert.severity as any,
      category: alert.category,
      createdAt: alert.createdAt,
      acknowledged: alert.acknowledged,
      entityId: alert.entityId,
      entityType: alert.entityType,
      actionRequired: alert.actionRequired ? 'true' : 'false',
    }));
  }

  private async getRecentActivity(companyFilter: any, timeRange: any) {
    // This would fetch recent activity from audit logs
    return [
      {
        id: '1',
        type: 'PROCEDURE_COMPLETED',
        description: 'Bank confirmation procedure completed',
        timestamp: new Date(),
        user: 'John Doe',
      },
      {
        id: '2',
        type: 'REPORT_GENERATED',
        description: 'Financial statements generated',
        timestamp: new Date(Date.now() - 30 * 60 * 1000),
        user: 'Jane Smith',
      },
    ];
  }

  private async getTrendData(companyFilter: any, timeRange: any) {
    // This would calculate trend data over time periods
    return {
      revenue: [100000, 110000, 105000, 120000, 125000, 130000],
      expenses: [75000, 80000, 78000, 85000, 88000, 90000],
      completionRates: [85, 88, 92, 89, 94, 96],
      userActivity: [45, 52, 48, 58, 61, 65],
    };
  }

  // Additional helper methods for specific dashboard calculations
  private async getCashFlowAnalysis(companyFilter: any, timeRange: any) {
    // Implementation for cash flow analysis
    return {
      operating: 50000,
      investing: -10000,
      financing: 5000,
      netCashFlow: 45000,
    };
  }

  private async getProfitabilityTrends(companyFilter: any, timeRange: any) {
    // Implementation for profitability trends
    return {
      grossProfitMargin: [25, 27, 26, 28, 30],
      netProfitMargin: [15, 16, 14, 17, 18],
      periods: ['Q1', 'Q2', 'Q3', 'Q4', 'Q1'],
    };
  }

  private async getBalanceSheetAnalysis(companyFilter: any, timeRange: any) {
    return {
      totalAssets: 1000000,
      totalLiabilities: 600000,
      totalEquity: 400000,
      workingCapital: 200000,
    };
  }

  private async getBudgetVarianceAnalysis(companyFilter: any, timeRange: any) {
    return {
      revenueVariance: 5.2,
      expenseVariance: -2.1,
      overallVariance: 3.8,
    };
  }

  private getTimeRange(timeframe?: Timeframe, startDate?: string, endDate?: string) {
    const now = new Date();
    let start: Date;
    let end: Date = now;

    switch (timeframe) {
      case Timeframe.TODAY:
        start = new Date(now.getFullYear(), now.getMonth(), now.getDate());
        break;
      case Timeframe.THIS_WEEK:
        start = new Date(now.getFullYear(), now.getMonth(), now.getDate() - now.getDay());
        break;
      case Timeframe.THIS_MONTH:
        start = new Date(now.getFullYear(), now.getMonth(), 1);
        break;
      case Timeframe.THIS_QUARTER:
        const quarter = Math.floor(now.getMonth() / 3);
        start = new Date(now.getFullYear(), quarter * 3, 1);
        break;
      case Timeframe.THIS_YEAR:
        start = new Date(now.getFullYear(), 0, 1);
        break;
      case Timeframe.LAST_30_DAYS:
        start = new Date(now.getTime() - 30 * 24 * 60 * 60 * 1000);
        break;
      case Timeframe.LAST_90_DAYS:
        start = new Date(now.getTime() - 90 * 24 * 60 * 60 * 1000);
        break;
      case Timeframe.CUSTOM:
        start = startDate ? new Date(startDate) : new Date(now.getTime() - 30 * 24 * 60 * 60 * 1000);
        end = endDate ? new Date(endDate) : now;
        break;
      default:
        start = new Date(now.getTime() - 30 * 24 * 60 * 60 * 1000);
    }

    return { gte: start, lte: end };
  }

  private async buildCompanyFilter(companyId: string | undefined, userId: string) {
    if (companyId) {
      await this.verifyCompanyAccess(companyId, userId);
      return { companyId };
    }

    const userCompanies = await this.getUserCompanies(userId);
    return { companyId: { in: userCompanies.map(c => c.id) } };
  }

  private async verifyUserAccess(userId: string) {
    const user = await this.database.user.findUnique({
      where: { id: userId },
    });

    if (!user || !user.isActive) {
      throw new ForbiddenException('Access denied');
    }
  }

  private async verifyCompanyAccess(companyId: string, userId: string) {
    const userCompanies = await this.getUserCompanies(userId);
    const hasAccess = userCompanies.some(company => company.id === companyId);
    
    if (!hasAccess) {
      throw new ForbiddenException('Access denied to this company');
    }
  }

  private async getUserCompanies(userId: string) {
    return this.database.company.findMany({
      select: { id: true, name: true },
    });
  }

  private async calculateCustomMetric(metric: any, companyFilter: any, timeRange: any) {
    // Implementation for custom metric calculation
    return Math.random() * 100; // Placeholder
  }

  private async generateChartData(chart: any, companyFilter: any, timeRange: any) {
    // Implementation for custom chart data generation
    return {
      labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May'],
      datasets: [{
        label: chart.title,
        data: [10, 20, 15, 30, 25],
      }],
    };
  }

  private async getActiveUserCount() {
    return this.database.user.count({ where: { isActive: true } });
  }

  private async getOngoingProceduresCount(companyFilter: any) {
    return this.database.procedure.count({
      where: {
        ...companyFilter,
        status: 'IN_PROGRESS',
      },
    });
  }

  private async getPendingDocumentsCount(companyFilter: any) {
    return this.database.document.count({
      where: {
        ...companyFilter,
        status: 'PENDING',
      },
    });
  }

  private async getSystemLoadMetrics() {
    return {
      cpu: 45.2,
      memory: 62.8,
      disk: 78.3,
      network: 23.1,
    };
  }

  private async getProcedureStatusBreakdown(companyFilter: any, timeRange: any) {
    return this.database.procedure.groupBy({
      by: ['status'],
      where: {
        ...companyFilter,
        createdAt: timeRange,
      },
      _count: true,
    });
  }

  private async getRiskAssessmentData(companyFilter: any, timeRange: any) {
    return {
      highRisk: 5,
      mediumRisk: 15,
      lowRisk: 25,
      totalAssessments: 45,
    };
  }

  private async getFindingsAnalysis(companyFilter: any, timeRange: any) {
    return {
      critical: 2,
      high: 8,
      medium: 15,
      low: 23,
      resolved: 35,
      pending: 13,
    };
  }

  private async getComplianceMetrics(companyFilter: any, timeRange: any) {
    return {
      overallScore: 92,
      sox: 95,
      gdpr: 88,
      iso27001: 90,
      custom: 94,
    };
  }

  private async getTeamWorkloadAnalysis(companyFilter: any, timeRange: any) {
    return [
      { name: 'John Doe', procedures: 15, hours: 120, utilization: 85 },
      { name: 'Jane Smith', procedures: 12, hours: 95, utilization: 75 },
      { name: 'Bob Johnson', procedures: 18, hours: 140, utilization: 95 },
    ];
  }

  private async getSystemHealthMetrics() {
    return {
      status: 'HEALTHY',
      uptime: 99.8,
      responseTime: 150,
      errorRate: 0.02,
      lastBackup: new Date(),
    };
  }

  private async getUserActivityMetrics(timeRange: any) {
    return {
      totalLogins: 245,
      uniqueUsers: 45,
      averageSessionTime: 125,
      peakHours: [9, 10, 11, 14, 15],
    };
  }

  private async getDocumentMetrics(timeRange: any) {
    return {
      totalDocuments: 1250,
      uploaded: 125,
      processed: 118,
      pending: 7,
      storageUsed: 2.5,
    };
  }

  private async getReportingMetrics(timeRange: any) {
    return {
      reportsGenerated: 89,
      scheduledReports: 25,
      exportedReports: 156,
      averageGenerationTime: 2.3,
    };
  }

  private async getPerformanceMetrics(timeRange: any) {
    return {
      averageResponseTime: 150,
      slowQueries: 3,
      cacheHitRatio: 94.5,
      throughput: 1250,
    };
  }
}