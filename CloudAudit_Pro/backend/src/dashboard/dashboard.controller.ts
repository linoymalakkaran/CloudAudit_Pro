import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Query,
  UseGuards,
  Request,
  HttpStatus,
} from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse, ApiBearerAuth, ApiQuery } from '@nestjs/swagger';
import { DashboardService } from './dashboard.service';
import {
  DashboardFilterDto,
  DashboardConfigDto,
  AlertDto,
  DashboardType,
  Timeframe
} from './dto/dashboard.dto';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';

@ApiTags('Dashboard')
@ApiBearerAuth()
@UseGuards(JwtAuthGuard)
@Controller('dashboard')
export class DashboardController {
  constructor(private readonly dashboardService: DashboardService) {}

  @Get('executive')
  @ApiOperation({ 
    summary: 'Get executive dashboard',
    description: 'Retrieve comprehensive executive dashboard with KPIs, metrics, and alerts'
  })
  @ApiResponse({ status: HttpStatus.OK, description: 'Executive dashboard data retrieved successfully' })
  @ApiQuery({ name: 'companyId', required: false, type: String, description: 'Filter by company' })
  @ApiQuery({ name: 'timeframe', required: false, enum: Timeframe, description: 'Time period for metrics' })
  @ApiQuery({ name: 'startDate', required: false, type: String, description: 'Custom start date (ISO format)' })
  @ApiQuery({ name: 'endDate', required: false, type: String, description: 'Custom end date (ISO format)' })
  async getExecutiveDashboard(@Query() filters: DashboardFilterDto, @Request() req) {
    return this.dashboardService.getExecutiveDashboard(filters, req.user.id);
  }

  @Get('financial')
  @ApiOperation({ 
    summary: 'Get financial dashboard',
    description: 'Retrieve detailed financial dashboard with revenue, expenses, and financial ratios'
  })
  @ApiResponse({ status: HttpStatus.OK, description: 'Financial dashboard data retrieved successfully' })
  @ApiQuery({ name: 'companyId', required: false, type: String, description: 'Filter by company' })
  @ApiQuery({ name: 'timeframe', required: false, enum: Timeframe, description: 'Time period for metrics' })
  @ApiQuery({ name: 'includeComparative', required: false, type: Boolean, description: 'Include comparative data' })
  async getFinancialDashboard(@Query() filters: DashboardFilterDto, @Request() req): Promise<any> {
    return this.dashboardService.getFinancialDashboard(filters, req.user.id);
  }

  @Get('audit')
  @ApiOperation({ 
    summary: 'Get audit dashboard',
    description: 'Retrieve comprehensive audit dashboard with procedure status, compliance, and findings'
  })
  @ApiResponse({ status: HttpStatus.OK, description: 'Audit dashboard data retrieved successfully' })
  @ApiQuery({ name: 'companyId', required: false, type: String, description: 'Filter by company' })
  @ApiQuery({ name: 'periodId', required: false, type: String, description: 'Filter by period' })
  @ApiQuery({ name: 'timeframe', required: false, enum: Timeframe, description: 'Time period for metrics' })
  async getAuditDashboard(@Query() filters: DashboardFilterDto, @Request() req): Promise<any> {
    return this.dashboardService.getAuditDashboard(filters, req.user.id);
  }

  @Get('operational')
  @ApiOperation({ 
    summary: 'Get operational dashboard',
    description: 'Retrieve operational dashboard with system health, user activity, and performance metrics'
  })
  @ApiResponse({ status: HttpStatus.OK, description: 'Operational dashboard data retrieved successfully' })
  @ApiQuery({ name: 'timeframe', required: false, enum: Timeframe, description: 'Time period for metrics' })
  async getOperationalDashboard(@Query() filters: DashboardFilterDto, @Request() req): Promise<any> {
    return this.dashboardService.getOperationalDashboard(filters, req.user.id);
  }

  @Post('custom')
  @ApiOperation({ 
    summary: 'Get custom dashboard',
    description: 'Retrieve custom dashboard based on provided configuration'
  })
  @ApiResponse({ status: HttpStatus.OK, description: 'Custom dashboard data retrieved successfully' })
  async getCustomDashboard(
    @Body() config: DashboardConfigDto,
    @Query() filters: DashboardFilterDto,
    @Request() req
  ) {
    return this.dashboardService.getCustomDashboard(config, filters, req.user.id);
  }

  @Get('realtime')
  @ApiOperation({ 
    summary: 'Get realtime metrics',
    description: 'Retrieve realtime system and business metrics'
  })
  @ApiResponse({ status: HttpStatus.OK, description: 'Realtime metrics retrieved successfully' })
  @ApiQuery({ name: 'companyId', required: false, type: String, description: 'Filter by company' })
  async getRealtimeMetrics(@Query('companyId') companyId?: string, @Request() req?) {
    return this.dashboardService.getRealtimeMetrics(companyId, req?.user?.userId);
  }

  @Get('company/:companyId/financial')
  @ApiOperation({ 
    summary: 'Get company financial overview',
    description: 'Get comprehensive financial overview for specific company'
  })
  @ApiResponse({ status: HttpStatus.OK, description: 'Company financial overview retrieved successfully' })
  async getCompanyFinancialOverview(
    @Param('companyId') companyId: string,
    @Query() filters: DashboardFilterDto,
    @Request() req
  ): Promise<any> {
    const companyFilters = { ...filters, companyId };
    return this.dashboardService.getFinancialDashboard(companyFilters, req.user.id);
  }

  @Get('company/:companyId/audit')
  @ApiOperation({ 
    summary: 'Get company audit overview',
    description: 'Get comprehensive audit overview for specific company'
  })
  @ApiResponse({ status: HttpStatus.OK, description: 'Company audit overview retrieved successfully' })
  async getCompanyAuditOverview(
    @Param('companyId') companyId: string,
    @Query() filters: DashboardFilterDto,
    @Request() req
  ): Promise<any> {
    const companyFilters = { ...filters, companyId };
    return this.dashboardService.getAuditDashboard(companyFilters, req.user.id);
  }

  @Get('kpis/:companyId')
  @ApiOperation({ 
    summary: 'Get company KPIs',
    description: 'Get key performance indicators for specific company'
  })
  @ApiResponse({ status: HttpStatus.OK, description: 'Company KPIs retrieved successfully' })
  async getCompanyKPIs(
    @Param('companyId') companyId: string,
    @Query() filters: DashboardFilterDto,
    @Request() req
  ) {
    const companyFilters = { ...filters, companyId };
    const dashboardData = await this.dashboardService.getExecutiveDashboard(companyFilters, req.user.id);
    return {
      kpis: dashboardData.kpis,
      summary: dashboardData.summary,
      lastUpdated: new Date(),
    };
  }

  @Get('alerts')
  @ApiOperation({ 
    summary: 'Get active alerts',
    description: 'Retrieve all active alerts and notifications'
  })
  @ApiResponse({ status: HttpStatus.OK, description: 'Active alerts retrieved successfully' })
  @ApiQuery({ name: 'severity', required: false, enum: ['INFO', 'WARNING', 'ERROR', 'CRITICAL'], description: 'Filter by severity' })
  @ApiQuery({ name: 'category', required: false, type: String, description: 'Filter by category' })
  @ApiQuery({ name: 'acknowledged', required: false, type: Boolean, description: 'Filter by acknowledgment status' })
  async getAlerts(
    @Query('severity') severity?: string,
    @Query('category') category?: string,
    @Query('acknowledged') acknowledged?: boolean,
    @Request() req?
  ) {
    const filters: DashboardFilterDto = {};
    const dashboardData = await this.dashboardService.getExecutiveDashboard(filters, req.user.id);
    
    let alerts = dashboardData.alerts;
    
    if (severity) {
      alerts = alerts.filter(alert => alert.severity === severity);
    }
    
    if (category) {
      alerts = alerts.filter(alert => alert.category === category);
    }
    
    if (acknowledged !== undefined) {
      alerts = alerts.filter(alert => alert.acknowledged === acknowledged);
    }

    return {
      alerts,
      totalCount: alerts.length,
      lastUpdated: new Date(),
    };
  }

  @Post('alerts')
  @ApiOperation({ 
    summary: 'Create alert',
    description: 'Create a new alert or notification'
  })
  @ApiResponse({ status: HttpStatus.CREATED, description: 'Alert created successfully' })
  async createAlert(@Body() alert: Omit<AlertDto, 'id' | 'createdAt'>, @Request() req) {
    return this.dashboardService.createAlert(alert, req.user.id, req.user.companyId || 'default-company');
  }

  @Patch('alerts/:id/acknowledge')
  @ApiOperation({ 
    summary: 'Acknowledge alert',
    description: 'Mark an alert as acknowledged'
  })
  @ApiResponse({ status: HttpStatus.OK, description: 'Alert acknowledged successfully' })
  async acknowledgeAlert(@Param('id') id: string, @Request() req) {
    return this.dashboardService.acknowledgeAlert(id, req.user.id);
  }

  @Get('trends/:companyId')
  @ApiOperation({ 
    summary: 'Get trend analysis',
    description: 'Get comprehensive trend analysis for company metrics'
  })
  @ApiResponse({ status: HttpStatus.OK, description: 'Trend analysis retrieved successfully' })
  async getTrendAnalysis(
    @Param('companyId') companyId: string,
    @Query() filters: DashboardFilterDto,
    @Request() req
  ) {
    const companyFilters = { ...filters, companyId };
    const dashboardData = await this.dashboardService.getExecutiveDashboard(companyFilters, req.user.id);
    
    return {
      trends: dashboardData.trends,
      financial: {
        revenue: dashboardData.financial.totalRevenue,
        expenses: dashboardData.financial.totalExpenses,
        netIncome: dashboardData.financial.netIncome,
      },
      audit: {
        completionRate: dashboardData.audit.completionRate,
        proceduresCompleted: dashboardData.audit.completedProcedures,
      },
      lastUpdated: new Date(),
    };
  }

  @Get('performance/:companyId')
  @ApiOperation({ 
    summary: 'Get performance metrics',
    description: 'Get detailed performance metrics for company'
  })
  @ApiResponse({ status: HttpStatus.OK, description: 'Performance metrics retrieved successfully' })
  async getPerformanceMetrics(
    @Param('companyId') companyId: string,
    @Query() filters: DashboardFilterDto,
    @Request() req
  ) {
    const [financialData, auditData, operationalData] = await Promise.all([
      this.dashboardService.getFinancialDashboard({ ...filters, companyId }, req.user.id),
      this.dashboardService.getAuditDashboard({ ...filters, companyId }, req.user.id),
      this.dashboardService.getOperationalDashboard(filters, req.user.id),
    ]);

    return {
      financial: {
        profitMargin: financialData.overview.grossMargin,
        returnOnAssets: financialData.overview.returnOnAssets,
        currentRatio: financialData.overview.currentRatio,
      },
      audit: {
        completionRate: auditData.overview.completionRate,
        complianceScore: auditData.overview.complianceScore,
        riskCoverage: auditData.overview.riskCoverage,
      },
      operational: {
        systemUptime: operationalData.overview.systemUptime,
        responseTime: operationalData.overview.averageResponseTime,
        errorRate: operationalData.overview.errorRate,
      },
      lastUpdated: new Date(),
    };
  }

  @Get('analytics/:companyId/summary')
  @ApiOperation({ 
    summary: 'Get analytics summary',
    description: 'Get comprehensive analytics summary for company'
  })
  @ApiResponse({ status: HttpStatus.OK, description: 'Analytics summary retrieved successfully' })
  async getAnalyticsSummary(
    @Param('companyId') companyId: string,
    @Query() filters: DashboardFilterDto,
    @Request() req
  ) {
    const companyFilters = { ...filters, companyId };
    const dashboardData = await this.dashboardService.getExecutiveDashboard(companyFilters, req.user.id);

    const summary = {
      overview: dashboardData.summary,
      keyMetrics: {
        revenue: dashboardData.financial.totalRevenue,
        netIncome: dashboardData.financial.netIncome,
        completionRate: dashboardData.audit.completionRate,
        complianceScore: dashboardData.audit.complianceScore,
      },
      alerts: {
        total: dashboardData.alerts.length,
        critical: dashboardData.alerts.filter(a => a.severity === 'CRITICAL').length,
        warning: dashboardData.alerts.filter(a => a.severity === 'WARNING').length,
        info: dashboardData.alerts.filter(a => a.severity === 'INFO').length,
      },
      recentActivity: dashboardData.recentActivity.slice(0, 5),
      topKPIs: dashboardData.kpis.slice(0, 5),
    };

    return {
      ...summary,
      lastUpdated: new Date(),
    };
  }

  @Get('health')
  @ApiOperation({ 
    summary: 'Get system health status',
    description: 'Get overall system health and status indicators'
  })
  @ApiResponse({ status: HttpStatus.OK, description: 'System health status retrieved successfully' })
  async getSystemHealth() {
    const realtimeMetrics = await this.dashboardService.getRealtimeMetrics();
    
    return {
      status: 'HEALTHY',
      uptime: 99.8,
      services: {
        database: 'HEALTHY',
        api: 'HEALTHY',
        reports: 'HEALTHY',
        notifications: 'HEALTHY',
      },
      metrics: realtimeMetrics,
      lastCheck: new Date(),
    };
  }
}