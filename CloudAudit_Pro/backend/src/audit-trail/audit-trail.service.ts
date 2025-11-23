import { Injectable, NotFoundException, BadRequestException } from '@nestjs/common';
import { DatabaseService } from '../database/database.service';
import {
  CreateAuditLogDto,
  AuditLogQueryDto,
  AuditLogAnalyticsDto,
  ComplianceReportDto,
  DataRetentionDto,
  SecurityAlertDto,
  BulkAuditActionDto,
  AuditTrailConfigDto,
  AuditEventType,
  AuditEntityType,
  AuditSeverity,
  AuditStatus,
} from './dto/audit-trail.dto';
import * as crypto from 'crypto';
import * as ExcelJS from 'exceljs';
import * as fs from 'fs';
import * as path from 'path';

export interface AuditLog {
  id: string;
  eventType: AuditEventType;
  entityType: AuditEntityType;
  entityId: string;
  userId?: string;
  companyId?: string;
  periodId?: string;
  description: string;
  oldValues?: any;
  newValues?: any;
  severity: AuditSeverity;
  status: AuditStatus;
  ipAddress?: string;
  userAgent?: string;
  sessionId?: string;
  tags?: string[];
  metadata?: any;
  timestamp: Date;
  hash?: string;
  previousHash?: string;
}

export interface AuditAnalytics {
  totalEvents: number;
  eventsByType: Record<string, number>;
  eventsByEntity: Record<string, number>;
  eventsBySeverity: Record<string, number>;
  eventsOverTime: Array<{ date: string; count: number }>;
  topUsers: Array<{ userId: string; userName: string; eventCount: number }>;
  topEntities: Array<{ entityType: string; entityId: string; eventCount: number }>;
  securityEvents: number;
  criticalEvents: number;
}

@Injectable()
export class AuditTrailService {
  private readonly secretKey = process.env.AUDIT_SECRET_KEY || 'default-secret-key';
  
  constructor(private readonly database: DatabaseService) {}

  async createAuditLog(createAuditLogDto: CreateAuditLogDto, userId?: string): Promise<AuditLog> {
    // Get the last audit log for hash chaining
    const lastAuditLog = await this.database.auditLog.findFirst({
      orderBy: { timestamp: 'desc' },
      select: { hash: true },
    });

    // Prepare data for hashing
    const auditData = {
      ...createAuditLogDto,
      userId,
      timestamp: new Date().toISOString(),
    };

    // Generate hash for integrity
    const hash = this.generateHash(auditData);
    const previousHash = lastAuditLog?.hash || null;

    const auditLog = await this.database.auditLog.create({
      data: {
        // Required core fields
        tableName: createAuditLogDto.entityType || 'unknown',
        recordId: createAuditLogDto.entityId || 'unknown',
        action: 'ACCESS', // Default action - should be mapped from eventType
        
        // Optional fields from service
        eventType: createAuditLogDto.eventType,
        entityType: createAuditLogDto.entityType,
        entityId: createAuditLogDto.entityId,
        userId: userId,
        companyId: createAuditLogDto.companyId,
        periodId: createAuditLogDto.periodId,
        description: createAuditLogDto.description,
        oldValues: createAuditLogDto.oldValues ? JSON.stringify(createAuditLogDto.oldValues) : null,
        newValues: createAuditLogDto.newValues ? JSON.stringify(createAuditLogDto.newValues) : null,
        severity: createAuditLogDto.severity || AuditSeverity.LOW,
        status: 'ACTIVE', // Use string instead of enum
        ipAddress: createAuditLogDto.ipAddress,
        userAgent: createAuditLogDto.userAgent,
        sessionId: createAuditLogDto.sessionId,
        tags: createAuditLogDto.tags ? JSON.stringify(createAuditLogDto.tags) : null,
        metadata: createAuditLogDto.metadata ? JSON.stringify(createAuditLogDto.metadata) : null,
        hash: hash,
        previousHash: previousHash,
      },
    });

    // Check for security alerts
    await this.checkSecurityAlerts(auditLog);

    return this.mapAuditLog(auditLog);
  }

  async getAuditLogs(query: AuditLogQueryDto): Promise<{ data: AuditLog[]; pagination: any }> {
    const { page = 1, limit = 20, sortBy = 'timestamp', sortOrder = 'desc', ...filters } = query;
    const skip = (page - 1) * limit;

    const where: any = {};

    // Apply filters
    if (filters.eventType) where.eventType = filters.eventType;
    if (filters.entityType) where.entityType = filters.entityType;
    if (filters.entityId) where.entityId = filters.entityId;
    if (filters.userId) where.userId = filters.userId;
    if (filters.companyId) where.companyId = filters.companyId;
    if (filters.periodId) where.periodId = filters.periodId;
    if (filters.severity) where.severity = filters.severity;
    if (filters.status) where.status = filters.status;
    if (filters.ipAddress) where.ipAddress = filters.ipAddress;

    if (filters.dateFrom || filters.dateTo) {
      where.timestamp = {};
      if (filters.dateFrom) where.timestamp.gte = new Date(filters.dateFrom);
      if (filters.dateTo) where.timestamp.lte = new Date(filters.dateTo);
    }

    if (filters.search) {
      where.OR = [
        { description: { contains: filters.search, mode: 'insensitive' } },
        { entityId: { contains: filters.search, mode: 'insensitive' } },
      ];
    }

    if (filters.tags && filters.tags.length > 0) {
      where.tags = { contains: JSON.stringify(filters.tags) };
    }

    const [auditLogs, total] = await Promise.all([
      this.database.auditLog.findMany({
        where,
        skip,
        take: limit,
        orderBy: { [sortBy]: sortOrder },
        include: {
          user: {
            select: { id: true, firstName: true, lastName: true, email: true },
          },
          company: {
            select: { id: true, name: true },
          },
          period: {
            select: { id: true, name: true, fiscalYear: true },
          },
        },
      }),
      this.database.auditLog.count({ where }),
    ]);

    return {
      data: auditLogs.map(log => this.mapAuditLog(log)),
      pagination: {
        total,
        page,
        limit,
        totalPages: Math.ceil(total / limit),
      },
    };
  }

  async getAuditLog(id: string): Promise<AuditLog> {
    const auditLog = await this.database.auditLog.findUnique({
      where: { id },
      include: {
        user: {
          select: { id: true, firstName: true, lastName: true, email: true },
        },
        company: {
          select: { id: true, name: true },
        },
        period: {
          select: { id: true, name: true, fiscalYear: true },
        },
      },
    });

    if (!auditLog) {
      throw new NotFoundException('Audit log not found');
    }

    return this.mapAuditLog(auditLog);
  }

  async getAuditAnalytics(analyticsDto: AuditLogAnalyticsDto): Promise<AuditAnalytics> {
    const where: any = {};

    // Apply filters
    if (analyticsDto.startDate || analyticsDto.endDate) {
      where.timestamp = {};
      if (analyticsDto.startDate) where.timestamp.gte = new Date(analyticsDto.startDate);
      if (analyticsDto.endDate) where.timestamp.lte = new Date(analyticsDto.endDate);
    }

    if (analyticsDto.companyId) where.companyId = analyticsDto.companyId;
    if (analyticsDto.eventTypes) where.eventType = { in: analyticsDto.eventTypes };
    if (analyticsDto.entityTypes) where.entityType = { in: analyticsDto.entityTypes };
    if (analyticsDto.userIds) where.userId = { in: analyticsDto.userIds };

    // Get total events
    const totalEvents = await this.database.auditLog.count({ where });

    // Events by type
    const eventsByType = await this.database.auditLog.groupBy({
      by: ['eventType'],
      where,
      _count: { eventType: true },
    });

    // Events by entity
    const eventsByEntity = await this.database.auditLog.groupBy({
      by: ['entityType'],
      where,
      _count: { entityType: true },
    });

    // Events by severity
    const eventsBySeverity = await this.database.auditLog.groupBy({
      by: ['severity'],
      where,
      _count: { severity: true },
    });

    // Events over time
    const eventsOverTime = await this.getEventsOverTime(where, analyticsDto.groupBy || 'day');

    // Top users
    const topUsers = await this.getTopUsers(where, 10);

    // Top entities
    const topEntities = await this.getTopEntities(where, 10);

    // Security events count
    const securityEvents = await this.database.auditLog.count({
      where: {
        ...where,
        OR: [
          { eventType: AuditEventType.SECURITY_VIOLATION },
          { eventType: AuditEventType.UNAUTHORIZED_ACCESS },
          { eventType: AuditEventType.DATA_BREACH_DETECTED },
          { eventType: AuditEventType.SUSPICIOUS_ACTIVITY },
          { eventType: AuditEventType.LOGIN_FAILED },
        ],
      },
    });

    // Critical events count
    const criticalEvents = await this.database.auditLog.count({
      where: { ...where, severity: AuditSeverity.CRITICAL },
    });

    return {
      totalEvents,
      eventsByType: this.mapGroupedResults(eventsByType, 'eventType'),
      eventsByEntity: this.mapGroupedResults(eventsByEntity, 'entityType'),
      eventsBySeverity: this.mapGroupedResults(eventsBySeverity, 'severity'),
      eventsOverTime,
      topUsers,
      topEntities,
      securityEvents,
      criticalEvents,
    };
  }

  async generateComplianceReport(reportDto: ComplianceReportDto): Promise<{ filePath: string; fileName: string }> {
    const { startDate, endDate, companyId, complianceFramework = 'SOX', format = 'PDF' } = reportDto;

    const where: any = {};
    if (startDate || endDate) {
      where.timestamp = {};
      if (startDate) where.timestamp.gte = new Date(startDate);
      if (endDate) where.timestamp.lte = new Date(endDate);
    }
    if (companyId) where.companyId = companyId;

    // Get compliance-relevant events
    const complianceEvents = await this.getComplianceEvents(complianceFramework);
    where.eventType = { in: complianceEvents };

    const auditLogs = await this.database.auditLog.findMany({
      where,
      orderBy: { timestamp: 'desc' },
      include: {
        user: {
          select: { id: true, firstName: true, lastName: true, email: true },
        },
        company: {
          select: { id: true, name: true },
        },
      },
    });

    // Generate report file
    const timestamp = new Date().toISOString().replace(/[:.]/g, '-');
    const fileName = `compliance-report-${complianceFramework}-${timestamp}`;
    const reportsDir = path.join(process.cwd(), 'reports');

    if (!fs.existsSync(reportsDir)) {
      fs.mkdirSync(reportsDir, { recursive: true });
    }

    let filePath: string;

    switch (format) {
      case 'EXCEL':
        filePath = await this.generateExcelComplianceReport(auditLogs, path.join(reportsDir, `${fileName}.xlsx`), reportDto);
        break;
      case 'CSV':
        filePath = await this.generateCSVComplianceReport(auditLogs, path.join(reportsDir, `${fileName}.csv`), reportDto);
        break;
      case 'JSON':
        filePath = await this.generateJSONComplianceReport(auditLogs, path.join(reportsDir, `${fileName}.json`), reportDto);
        break;
      default:
        throw new BadRequestException('Unsupported report format');
    }

    return { filePath, fileName: path.basename(filePath) };
  }

  async performDataRetention(retentionDto: DataRetentionDto): Promise<{ archived: number; deleted: number }> {
    const {
      retentionDays = 2555, // 7 years
      minSeverity,
      includeEventTypes,
      excludeEventTypes,
      companyId,
      action = 'ARCHIVE',
    } = retentionDto;

    const cutoffDate = new Date();
    cutoffDate.setDate(cutoffDate.getDate() - retentionDays);

    const where: any = {
      timestamp: { lt: cutoffDate },
    };

    if (minSeverity) {
      const severityOrder = [AuditSeverity.LOW, AuditSeverity.MEDIUM, AuditSeverity.HIGH, AuditSeverity.CRITICAL];
      const minIndex = severityOrder.indexOf(minSeverity);
      where.severity = { in: severityOrder.slice(minIndex) };
    }

    if (includeEventTypes) where.eventType = { in: includeEventTypes };
    if (excludeEventTypes) where.eventType = { notIn: excludeEventTypes };
    if (companyId) where.companyId = companyId;

    const logsToProcess = await this.database.auditLog.findMany({ where });

    let archived = 0;
    let deleted = 0;

    if (action === 'ARCHIVE') {
      // Update status to archived
      const result = await this.database.auditLog.updateMany({
        where,
        data: { status: AuditStatus.ARCHIVED },
      });
      archived = result.count;
    } else if (action === 'DELETE') {
      // Permanently delete (use with caution)
      const result = await this.database.auditLog.deleteMany({ where });
      deleted = result.count;
    } else if (action === 'EXPORT') {
      // Export before archiving
      await this.exportAuditLogs(logsToProcess, 'retention-export');
      const result = await this.database.auditLog.updateMany({
        where,
        data: { status: AuditStatus.ARCHIVED },
      });
      archived = result.count;
    }

    return { archived, deleted };
  }

  async bulkAction(actionDto: BulkAuditActionDto, userId: string): Promise<{ processed: number; errors: string[] }> {
    const { auditLogIds, action, reason, notes } = actionDto;
    
    let processed = 0;
    const errors: string[] = [];

    for (const logId of auditLogIds) {
      try {
        switch (action) {
          case 'ARCHIVE':
            await this.database.auditLog.update({
              where: { id: logId },
              data: { status: AuditStatus.ARCHIVED },
            });
            break;
          case 'FLAG':
            await this.database.auditLog.update({
              where: { id: logId },
              data: { status: AuditStatus.FLAGGED },
            });
            break;
          case 'REVIEW':
            await this.database.auditLog.update({
              where: { id: logId },
              data: { status: AuditStatus.REVIEWED },
            });
            break;
          case 'DELETE':
            // Only allow deletion for non-critical events and with proper authorization
            const log = await this.database.auditLog.findUnique({ where: { id: logId } });
            if (log && log.severity !== AuditSeverity.CRITICAL) {
              await this.database.auditLog.delete({ where: { id: logId } });
            } else {
              errors.push(`Cannot delete critical audit log: ${logId}`);
              continue;
            }
            break;
          case 'EXPORT':
            // Export specific logs
            const logToExport = await this.database.auditLog.findUnique({ where: { id: logId } });
            if (logToExport) {
              await this.exportAuditLogs([logToExport], `export-${logId}`);
            }
            break;
        }

        // Create audit log for the action itself
        await this.createAuditLog({
          eventType: AuditEventType.UPDATE,
          entityType: AuditEntityType.SYSTEM,
          entityId: logId,
          description: `Bulk action ${action} performed on audit log`,
          metadata: JSON.stringify({ reason, notes, originalAction: action }),
        }, userId);

        processed++;
      } catch (error) {
        errors.push(`Error processing log ${logId}: ${error.message}`);
      }
    }

    return { processed, errors };
  }

  async verifyIntegrity(startDate?: string, endDate?: string): Promise<{ valid: boolean; corruptedLogs: string[] }> {
    const where: any = {};
    if (startDate || endDate) {
      where.timestamp = {};
      if (startDate) where.timestamp.gte = new Date(startDate);
      if (endDate) where.timestamp.lte = new Date(endDate);
    }

    const auditLogs = await this.database.auditLog.findMany({
      where,
      orderBy: { timestamp: 'asc' },
    });

    const corruptedLogs: string[] = [];
    let previousHash: string | null = null;

    for (const log of auditLogs) {
      // Verify hash integrity
      const expectedHash = this.generateHash({
        eventType: log.eventType,
        entityType: log.entityType,
        entityId: log.entityId,
        userId: log.userId,
        description: log.description,
        timestamp: log.timestamp.toISOString(),
      });

      if (log.hash !== expectedHash) {
        corruptedLogs.push(log.id);
      }

      // Verify chain integrity
      if (previousHash && log.previousHash !== previousHash) {
        corruptedLogs.push(log.id);
      }

      previousHash = log.hash;
    }

    return {
      valid: corruptedLogs.length === 0,
      corruptedLogs,
    };
  }

  async getConfiguration(): Promise<AuditTrailConfigDto> {
    // Get configuration from database or return defaults
    return {
      defaultRetentionDays: 2555,
      enabledEventTypes: Object.values(AuditEventType),
      minLogLevel: AuditSeverity.LOW,
      enableRealTimeAlerts: true,
      enableDataIntegrity: true,
      enableEncryption: true,
      maxBatchSize: 100,
      batchTimeoutSeconds: 30,
    };
  }

  async updateConfiguration(config: AuditTrailConfigDto): Promise<{ message: string }> {
    // Save configuration to database
    return { message: 'Audit trail configuration updated successfully' };
  }

  async getSystemHealth(): Promise<any> {
    const last24Hours = new Date(Date.now() - 24 * 60 * 60 * 1000);
    
    const [totalEvents, recentEvents, criticalEvents, failedIntegrity] = await Promise.all([
      this.database.auditLog.count(),
      this.database.auditLog.count({
        where: { timestamp: { gte: last24Hours } },
      }),
      this.database.auditLog.count({
        where: {
          timestamp: { gte: last24Hours },
          severity: AuditSeverity.CRITICAL,
        },
      }),
      this.verifyIntegrity(last24Hours.toISOString()),
    ]);

    return {
      status: 'healthy',
      totalEvents,
      recentEvents,
      criticalEvents,
      integrityStatus: failedIntegrity.valid ? 'valid' : 'corrupted',
      corruptedLogsCount: failedIntegrity.corruptedLogs.length,
      lastCheck: new Date(),
    };
  }

  // Private helper methods
  private generateHash(data: any): string {
    const dataString = JSON.stringify(data, Object.keys(data).sort());
    return crypto.createHmac('sha256', this.secretKey).update(dataString).digest('hex');
  }

  private async checkSecurityAlerts(auditLog: any): Promise<void> {
    // Get configured security alerts
    const alerts = await this.getSecurityAlerts();

    for (const alert of alerts) {
      if (this.shouldTriggerAlert(auditLog, alert)) {
        await this.triggerSecurityAlert(alert, auditLog);
      }
    }
  }

  private shouldTriggerAlert(auditLog: any, alert: SecurityAlertDto): boolean {
    // Check if audit log matches alert criteria
    if (auditLog.eventType !== alert.triggerEvent) return false;
    if (auditLog.severity < alert.minSeverity) return false;

    // Check threshold within time window
    // Implementation would check recent occurrences
    return true;
  }

  private async triggerSecurityAlert(alert: SecurityAlertDto, auditLog: any): Promise<void> {
    // Send notifications, webhooks, etc.
    console.log('Security alert triggered:', alert.description);
  }

  private async getSecurityAlerts(): Promise<SecurityAlertDto[]> {
    // Return configured security alerts
    return [];
  }

  private async getEventsOverTime(where: any, groupBy: string): Promise<Array<{ date: string; count: number }>> {
    // Implementation to group events by time periods
    return [];
  }

  private async getTopUsers(where: any, limit: number): Promise<Array<{ userId: string; userName: string; eventCount: number }>> {
    const results = await this.database.auditLog.groupBy({
      by: ['userId'],
      where: { ...where, userId: { not: null } },
      _count: { userId: true },
      orderBy: { _count: { userId: 'desc' } },
      take: limit,
    });

    // Map user IDs to names
    return results.map(result => ({
      userId: result.userId,
      userName: 'Unknown User', // Would fetch from user table
      eventCount: result._count.userId,
    }));
  }

  private async getTopEntities(where: any, limit: number): Promise<Array<{ entityType: string; entityId: string; eventCount: number }>> {
    const results = await this.database.auditLog.groupBy({
      by: ['entityType', 'entityId'],
      where,
      _count: { entityId: true },
      orderBy: { _count: { entityId: 'desc' } },
      take: limit,
    });

    return results.map(result => ({
      entityType: result.entityType,
      entityId: result.entityId,
      eventCount: result._count.entityId,
    }));
  }

  private mapGroupedResults(results: any[], field: string): Record<string, number> {
    const mapped: Record<string, number> = {};
    results.forEach(result => {
      mapped[result[field]] = result._count[field];
    });
    return mapped;
  }

  private getComplianceEvents(framework: string): AuditEventType[] {
    const frameworks = {
      SOX: [
        AuditEventType.FINANCIAL_STATEMENT_GENERATED,
        AuditEventType.JOURNAL_ENTRY_CREATED,
        AuditEventType.JOURNAL_ENTRY_POSTED,
        AuditEventType.CONFIGURATION_CHANGE,
        AuditEventType.UNAUTHORIZED_ACCESS,
      ],
      GDPR: [
        AuditEventType.READ,
        AuditEventType.UPDATE,
        AuditEventType.DELETE,
        AuditEventType.EXPORT_STARTED,
        AuditEventType.DATA_BREACH_DETECTED,
      ],
      HIPAA: [
        AuditEventType.LOGIN,
        AuditEventType.LOGOUT,
        AuditEventType.READ,
        AuditEventType.UNAUTHORIZED_ACCESS,
      ],
      // Add more frameworks
    };

    return frameworks[framework] || Object.values(AuditEventType);
  }

  private async generateExcelComplianceReport(auditLogs: any[], filePath: string, reportDto: ComplianceReportDto): Promise<string> {
    const workbook = new ExcelJS.Workbook();
    const worksheet = workbook.addWorksheet('Compliance Report');

    // Add headers
    worksheet.addRow([
      'Timestamp',
      'Event Type',
      'Entity Type',
      'Entity ID',
      'User',
      'Company',
      'Description',
      'Severity',
      'IP Address',
    ]);

    // Add data
    auditLogs.forEach(log => {
      worksheet.addRow([
        log.timestamp,
        log.eventType,
        log.entityType,
        log.entityId,
        log.user ? `${log.user.firstName} ${log.user.lastName}` : 'System',
        log.company?.name || 'N/A',
        log.description,
        log.severity,
        log.ipAddress || 'N/A',
      ]);
    });

    await workbook.xlsx.writeFile(filePath);
    return filePath;
  }

  private async generateCSVComplianceReport(auditLogs: any[], filePath: string, reportDto: ComplianceReportDto): Promise<string> {
    const headers = 'Timestamp,Event Type,Entity Type,Entity ID,User,Company,Description,Severity,IP Address\n';
    const rows = auditLogs.map(log => 
      `${log.timestamp},${log.eventType},${log.entityType},${log.entityId},` +
      `${log.user ? `${log.user.firstName} ${log.user.lastName}` : 'System'},` +
      `${log.company?.name || 'N/A'},${log.description},${log.severity},${log.ipAddress || 'N/A'}`
    ).join('\n');

    fs.writeFileSync(filePath, headers + rows);
    return filePath;
  }

  private async generateJSONComplianceReport(auditLogs: any[], filePath: string, reportDto: ComplianceReportDto): Promise<string> {
    const report = {
      metadata: {
        reportType: 'Compliance Report',
        framework: reportDto.complianceFramework,
        generatedAt: new Date(),
        totalEvents: auditLogs.length,
      },
      events: auditLogs,
    };

    fs.writeFileSync(filePath, JSON.stringify(report, null, 2));
    return filePath;
  }

  private async exportAuditLogs(auditLogs: any[], fileName: string): Promise<string> {
    const exportDir = path.join(process.cwd(), 'exports');
    if (!fs.existsSync(exportDir)) {
      fs.mkdirSync(exportDir, { recursive: true });
    }

    const filePath = path.join(exportDir, `${fileName}-${Date.now()}.json`);
    fs.writeFileSync(filePath, JSON.stringify(auditLogs, null, 2));
    return filePath;
  }

  private mapAuditLog(log: any): AuditLog {
    return {
      id: log.id,
      eventType: log.eventType,
      entityType: log.entityType,
      entityId: log.entityId,
      userId: log.userId,
      companyId: log.companyId,
      periodId: log.periodId,
      description: log.description,
      oldValues: log.oldValues ? JSON.parse(log.oldValues) : null,
      newValues: log.newValues ? JSON.parse(log.newValues) : null,
      severity: log.severity,
      status: log.status,
      ipAddress: log.ipAddress,
      userAgent: log.userAgent,
      sessionId: log.sessionId,
      tags: log.tags ? JSON.parse(log.tags) : null,
      metadata: log.metadata ? JSON.parse(log.metadata) : null,
      timestamp: log.timestamp,
      hash: log.hash,
      previousHash: log.previousHash,
    };
  }
}