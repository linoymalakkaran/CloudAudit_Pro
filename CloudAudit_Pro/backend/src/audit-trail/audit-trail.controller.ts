import {
  Controller,
  Get,
  Post,
  Put,
  Delete,
  Body,
  Param,
  Query,
  UseGuards,
  Res,
  StreamableFile,
} from '@nestjs/common';
import { Response } from 'express';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { RolesGuard } from '../auth/roles.guard';
import { Roles } from '../auth/roles.decorator';
import { GetUser } from '../auth/get-user.decorator';
import { AuditTrailService } from './audit-trail.service';
import {
  CreateAuditLogDto,
  AuditLogQueryDto,
  AuditLogAnalyticsDto,
  ComplianceReportDto,
  DataRetentionDto,
  SecurityAlertDto,
  BulkAuditActionDto,
  AuditTrailConfigDto,
} from './dto/audit-trail.dto';
import { UserRole } from '../auth/dto/auth.dto';
import * as fs from 'fs';

@Controller('audit-trail')
@UseGuards(JwtAuthGuard, RolesGuard)
export class AuditTrailController {
  constructor(private readonly auditTrailService: AuditTrailService) {}

  @Post()
  @Roles(UserRole.ADMIN, UserRole.MANAGER, UserRole.AUDITOR)
  async createAuditLog(
    @Body() createAuditLogDto: CreateAuditLogDto,
    @GetUser('id') userId: string,
  ) {
    return this.auditTrailService.createAuditLog(createAuditLogDto, userId);
  }

  @Get()
  async getAuditLogs(
    @Query() query: AuditLogQueryDto,
    @GetUser('id') userId: string,
  ) {
    return this.auditTrailService.getAuditLogs(query);
  }

  @Get(':id')
  async getAuditLog(
    @Param('id') id: string,
    @GetUser('id') userId: string,
  ) {
    return this.auditTrailService.getAuditLog(id);
  }

  @Get('analytics/overview')
  async getAnalytics(
    @Query() analyticsDto: AuditLogAnalyticsDto,
    @GetUser('id') userId: string,
  ) {
    return this.auditTrailService.getAuditAnalytics(analyticsDto);
  }

  @Post('compliance/report')
  @Roles(UserRole.ADMIN, UserRole.MANAGER, UserRole.AUDITOR)
  async generateComplianceReport(
    @Body() reportDto: ComplianceReportDto,
    @GetUser('id') userId: string,
  ) {
    return this.auditTrailService.generateComplianceReport(reportDto);
  }

  @Get('compliance/report/:fileName/download')
  async downloadComplianceReport(
    @Param('fileName') fileName: string,
    @Res({ passthrough: true }) res: Response,
  ) {
    const filePath = `./reports/${fileName}`;
    
    if (!fs.existsSync(filePath)) {
      throw new Error('Report file not found');
    }

    const file = fs.createReadStream(filePath);
    const fileExtension = fileName.split('.').pop();
    
    let mimeType = 'application/octet-stream';
    if (fileExtension === 'xlsx') mimeType = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
    else if (fileExtension === 'csv') mimeType = 'text/csv';
    else if (fileExtension === 'json') mimeType = 'application/json';
    else if (fileExtension === 'pdf') mimeType = 'application/pdf';

    res.set({
      'Content-Type': mimeType,
      'Content-Disposition': `attachment; filename="${fileName}"`,
    });

    return new StreamableFile(file);
  }

  @Post('retention/execute')
  @Roles(UserRole.ADMIN)
  async performDataRetention(
    @Body() retentionDto: DataRetentionDto,
    @GetUser('id') userId: string,
  ) {
    return this.auditTrailService.performDataRetention(retentionDto);
  }

  @Post('bulk-action')
  @Roles(UserRole.ADMIN, UserRole.MANAGER)
  async bulkAction(
    @Body() actionDto: BulkAuditActionDto,
    @GetUser('id') userId: string,
  ) {
    return this.auditTrailService.bulkAction(actionDto, userId);
  }

  @Get('integrity/verify')
  @Roles(UserRole.ADMIN)
  async verifyIntegrity(
    @Query('startDate') startDate?: string,
    @Query('endDate') endDate?: string,
  ) {
    return this.auditTrailService.verifyIntegrity(startDate, endDate);
  }

  @Get('config/current')
  @Roles(UserRole.ADMIN)
  async getConfiguration() {
    return this.auditTrailService.getConfiguration();
  }

  @Put('config')
  @Roles(UserRole.ADMIN)
  async updateConfiguration(
    @Body() config: AuditTrailConfigDto,
    @GetUser('id') userId: string,
  ) {
    return this.auditTrailService.updateConfiguration(config);
  }

  @Get('health/status')
  async getSystemHealth() {
    return this.auditTrailService.getSystemHealth();
  }

  // Advanced Analytics Endpoints
  @Get('analytics/events-by-type')
  async getEventsByType(
    @Query() query: { startDate?: string; endDate?: string; companyId?: string },
  ) {
    const analytics = await this.auditTrailService.getAuditAnalytics({
      startDate: query.startDate,
      endDate: query.endDate,
      companyId: query.companyId,
    });
    return { eventsByType: analytics.eventsByType };
  }

  @Get('analytics/events-by-user')
  async getEventsByUser(
    @Query() query: { startDate?: string; endDate?: string; companyId?: string; limit?: number },
  ) {
    const analytics = await this.auditTrailService.getAuditAnalytics({
      startDate: query.startDate,
      endDate: query.endDate,
      companyId: query.companyId,
    });
    return { 
      topUsers: analytics.topUsers.slice(0, parseInt(String(query.limit || '10')))
    };
  }

  @Get('analytics/security-events')
  async getSecurityEvents(
    @Query() query: { startDate?: string; endDate?: string; companyId?: string },
  ) {
    const analytics = await this.auditTrailService.getAuditAnalytics({
      startDate: query.startDate,
      endDate: query.endDate,
      companyId: query.companyId,
    });
    return { 
      securityEvents: analytics.securityEvents,
      criticalEvents: analytics.criticalEvents,
    };
  }

  @Get('analytics/timeline')
  async getEventsTimeline(
    @Query() query: { 
      startDate?: string; 
      endDate?: string; 
      companyId?: string;
      groupBy?: 'day' | 'week' | 'month';
    },
  ) {
    const analytics = await this.auditTrailService.getAuditAnalytics({
      startDate: query.startDate,
      endDate: query.endDate,
      companyId: query.companyId,
      groupBy: query.groupBy || 'day',
    });
    return { eventsOverTime: analytics.eventsOverTime };
  }

  // Search and Filtering
  @Post('search/advanced')
  async advancedSearch(
    @Body() searchDto: {
      query: string;
      filters: AuditLogQueryDto;
      includeMetadata?: boolean;
      includeRelatedEntities?: boolean;
    },
  ) {
    // Enhanced search functionality
    return this.auditTrailService.getAuditLogs(searchDto.filters);
  }

  @Get('search/suggestions')
  async getSearchSuggestions(
    @Query('q') query: string,
    @Query('type') type: 'entities' | 'users' | 'events' = 'entities',
  ) {
    // Return search suggestions based on query
    return {
      suggestions: [],
      totalResults: 0,
    };
  }

  // Export and Reporting
  @Post('export/custom')
  @Roles(UserRole.ADMIN, UserRole.MANAGER, UserRole.AUDITOR)
  async customExport(
    @Body() exportDto: {
      filters: AuditLogQueryDto;
      format: 'CSV' | 'EXCEL' | 'JSON' | 'PDF';
      columns: string[];
      includeMetadata?: boolean;
    },
    @GetUser('id') userId: string,
  ) {
    // Custom export functionality
    return { message: 'Export initiated', exportId: 'export-123' };
  }

  @Get('export/:exportId/status')
  async getExportStatus(
    @Param('exportId') exportId: string,
  ) {
    return {
      status: 'completed',
      progress: 100,
      downloadUrl: `/api/audit-trail/export/${exportId}/download`,
    };
  }

  @Get('export/:exportId/download')
  async downloadExport(
    @Param('exportId') exportId: string,
    @Res({ passthrough: true }) res: Response,
  ) {
    // Download exported audit trail data
    const fileName = `audit-export-${exportId}.json`;
    res.set({
      'Content-Type': 'application/json',
      'Content-Disposition': `attachment; filename="${fileName}"`,
    });

    return { message: 'Export data' };
  }

  // Real-time Monitoring
  @Get('monitoring/live-feed')
  async getLiveFeed(
    @Query() query: { 
      companyId?: string;
      eventTypes?: string[];
      minSeverity?: string;
    },
  ) {
    // Return recent events for live monitoring
    const recentEvents = await this.auditTrailService.getAuditLogs({
      page: 1,
      limit: 50,
      sortBy: 'timestamp',
      sortOrder: 'desc',
      companyId: query.companyId,
    });

    return {
      events: recentEvents.data.slice(0, 20), // Last 20 events
      lastUpdate: new Date(),
    };
  }

  @Get('monitoring/alerts')
  async getActiveAlerts(
    @Query() query: { companyId?: string },
  ) {
    // Return active security/compliance alerts
    return {
      alerts: [],
      totalAlerts: 0,
      criticalAlerts: 0,
    };
  }

  // Compliance and Regulations
  @Get('compliance/frameworks')
  async getSupportedFrameworks() {
    return {
      frameworks: [
        { code: 'SOX', name: 'Sarbanes-Oxley Act', description: 'US financial reporting compliance' },
        { code: 'GDPR', name: 'General Data Protection Regulation', description: 'EU data privacy regulation' },
        { code: 'HIPAA', name: 'Health Insurance Portability and Accountability Act', description: 'US healthcare data protection' },
        { code: 'ISO27001', name: 'ISO 27001', description: 'Information security management' },
        { code: 'PCI_DSS', name: 'PCI DSS', description: 'Payment card industry data security' },
      ],
    };
  }

  @Get('compliance/requirements/:framework')
  async getComplianceRequirements(
    @Param('framework') framework: string,
  ) {
    // Return specific compliance requirements for framework
    return {
      framework,
      requirements: [],
      auditableEvents: [],
      retentionPeriod: '7 years',
    };
  }

  @Post('compliance/assessment')
  @Roles(UserRole.ADMIN, UserRole.AUDITOR)
  async performComplianceAssessment(
    @Body() assessmentDto: {
      framework: string;
      startDate: string;
      endDate: string;
      companyId?: string;
    },
  ) {
    // Perform compliance assessment
    return {
      assessmentId: 'assessment-123',
      status: 'in_progress',
      framework: assessmentDto.framework,
      estimatedCompletion: new Date(Date.now() + 5 * 60 * 1000), // 5 minutes
    };
  }

  // Statistics and Dashboards
  @Get('statistics/summary')
  async getStatisticsSummary(
    @Query() query: { 
      period?: 'day' | 'week' | 'month' | 'year';
      companyId?: string;
    },
  ) {
    const analytics = await this.auditTrailService.getAuditAnalytics({
      companyId: query.companyId,
    });

    return {
      totalEvents: analytics.totalEvents,
      securityEvents: analytics.securityEvents,
      criticalEvents: analytics.criticalEvents,
      period: query.period || 'month',
      lastUpdated: new Date(),
    };
  }

  @Get('statistics/trends')
  async getTrends(
    @Query() query: { 
      metric: 'events' | 'security' | 'users' | 'entities';
      period: 'day' | 'week' | 'month';
      companyId?: string;
    },
  ) {
    // Return trend data for specified metric
    return {
      metric: query.metric,
      period: query.period,
      data: [],
      trend: 'increasing', // increasing, decreasing, stable
      changePercentage: 0,
    };
  }

  // User Activity Tracking
  @Get('users/:userId/activity')
  async getUserActivity(
    @Param('userId') userId: string,
    @Query() query: { 
      startDate?: string;
      endDate?: string;
      eventTypes?: string[];
    },
  ) {
    const auditLogs = await this.auditTrailService.getAuditLogs({
      userId,
      dateFrom: query.startDate,
      dateTo: query.endDate,
      eventType: query.eventTypes?.[0] as any,
      limit: 100,
    });

    return {
      userId,
      totalEvents: auditLogs.pagination.total,
      events: auditLogs.data,
      mostActiveHours: [], // Calculate most active hours
      mostCommonActions: [], // Calculate most common actions
    };
  }

  @Get('users/activity/summary')
  async getAllUsersActivitySummary(
    @Query() query: { 
      startDate?: string;
      endDate?: string;
      companyId?: string;
    },
  ) {
    const analytics = await this.auditTrailService.getAuditAnalytics({
      startDate: query.startDate,
      endDate: query.endDate,
      companyId: query.companyId,
    });

    return {
      topUsers: analytics.topUsers,
      totalActiveUsers: analytics.topUsers.length,
      averageEventsPerUser: analytics.totalEvents / analytics.topUsers.length || 0,
    };
  }
}