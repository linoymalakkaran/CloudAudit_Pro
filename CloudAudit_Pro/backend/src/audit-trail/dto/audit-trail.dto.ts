import { IsString, IsOptional, IsEnum, IsDateString, IsInt, Min, Max, IsArray, ValidateNested } from 'class-validator';
import { Type } from 'class-transformer';

export enum AuditEventType {
  // Authentication & Authorization
  LOGIN = 'LOGIN',
  LOGOUT = 'LOGOUT',
  LOGIN_FAILED = 'LOGIN_FAILED',
  PASSWORD_CHANGE = 'PASSWORD_CHANGE',
  ROLE_CHANGE = 'ROLE_CHANGE',
  PERMISSION_CHANGE = 'PERMISSION_CHANGE',

  // Data Operations
  CREATE = 'CREATE',
  READ = 'READ',
  UPDATE = 'UPDATE',
  DELETE = 'DELETE',
  BULK_CREATE = 'BULK_CREATE',
  BULK_UPDATE = 'BULK_UPDATE',
  BULK_DELETE = 'BULK_DELETE',

  // Import/Export Operations
  EXPORT_STARTED = 'EXPORT_STARTED',
  EXPORT_COMPLETED = 'EXPORT_COMPLETED',
  EXPORT_FAILED = 'EXPORT_FAILED',
  IMPORT_STARTED = 'IMPORT_STARTED',
  IMPORT_COMPLETED = 'IMPORT_COMPLETED',
  IMPORT_FAILED = 'IMPORT_FAILED',

  // Financial Operations
  JOURNAL_ENTRY_CREATED = 'JOURNAL_ENTRY_CREATED',
  JOURNAL_ENTRY_POSTED = 'JOURNAL_ENTRY_POSTED',
  JOURNAL_ENTRY_REVERSED = 'JOURNAL_ENTRY_REVERSED',
  TRIAL_BALANCE_GENERATED = 'TRIAL_BALANCE_GENERATED',
  FINANCIAL_STATEMENT_GENERATED = 'FINANCIAL_STATEMENT_GENERATED',

  // Audit Operations
  AUDIT_STARTED = 'AUDIT_STARTED',
  AUDIT_COMPLETED = 'AUDIT_COMPLETED',
  PROCEDURE_CREATED = 'PROCEDURE_CREATED',
  PROCEDURE_COMPLETED = 'PROCEDURE_COMPLETED',
  EVIDENCE_UPLOADED = 'EVIDENCE_UPLOADED',
  FINDING_CREATED = 'FINDING_CREATED',
  RECOMMENDATION_CREATED = 'RECOMMENDATION_CREATED',

  // System Operations
  CONFIGURATION_CHANGE = 'CONFIGURATION_CHANGE',
  BACKUP_CREATED = 'BACKUP_CREATED',
  BACKUP_RESTORED = 'BACKUP_RESTORED',
  DATABASE_MIGRATION = 'DATABASE_MIGRATION',
  SYSTEM_MAINTENANCE = 'SYSTEM_MAINTENANCE',

  // Document Operations
  DOCUMENT_UPLOADED = 'DOCUMENT_UPLOADED',
  DOCUMENT_DOWNLOADED = 'DOCUMENT_DOWNLOADED',
  DOCUMENT_DELETED = 'DOCUMENT_DELETED',
  DOCUMENT_SHARED = 'DOCUMENT_SHARED',

  // Reporting Operations
  REPORT_GENERATED = 'REPORT_GENERATED',
  REPORT_EXPORTED = 'REPORT_EXPORTED',
  REPORT_SCHEDULED = 'REPORT_SCHEDULED',
  DASHBOARD_ACCESSED = 'DASHBOARD_ACCESSED',

  // Security Events
  SECURITY_VIOLATION = 'SECURITY_VIOLATION',
  UNAUTHORIZED_ACCESS = 'UNAUTHORIZED_ACCESS',
  DATA_BREACH_DETECTED = 'DATA_BREACH_DETECTED',
  SUSPICIOUS_ACTIVITY = 'SUSPICIOUS_ACTIVITY',
}

export enum AuditEntityType {
  USER = 'USER',
  COMPANY = 'COMPANY',
  ACCOUNT = 'ACCOUNT',
  JOURNAL_ENTRY = 'JOURNAL_ENTRY',
  TRIAL_BALANCE = 'TRIAL_BALANCE',
  FINANCIAL_STATEMENT = 'FINANCIAL_STATEMENT',
  DOCUMENT = 'DOCUMENT',
  PROCEDURE = 'PROCEDURE',
  FINDING = 'FINDING',
  RECOMMENDATION = 'RECOMMENDATION',
  CONFIGURATION = 'CONFIGURATION',
  REPORT = 'REPORT',
  EXPORT_JOB = 'EXPORT_JOB',
  IMPORT_JOB = 'IMPORT_JOB',
  PERIOD = 'PERIOD',
  SYSTEM = 'SYSTEM',
}

export enum AuditSeverity {
  LOW = 'LOW',
  MEDIUM = 'MEDIUM',
  HIGH = 'HIGH',
  CRITICAL = 'CRITICAL',
}

export enum AuditStatus {
  ACTIVE = 'ACTIVE',
  ARCHIVED = 'ARCHIVED',
  FLAGGED = 'FLAGGED',
  REVIEWED = 'REVIEWED',
}

export class CreateAuditLogDto {
  @IsEnum(AuditEventType)
  eventType: AuditEventType;

  @IsEnum(AuditEntityType)
  entityType: AuditEntityType;

  @IsString()
  entityId: string;

  @IsString()
  description: string;

  @IsOptional()
  @IsString()
  oldValues?: string; // JSON string

  @IsOptional()
  @IsString()
  newValues?: string; // JSON string

  @IsOptional()
  @IsEnum(AuditSeverity)
  severity?: AuditSeverity = AuditSeverity.LOW;

  @IsOptional()
  @IsString()
  ipAddress?: string;

  @IsOptional()
  @IsString()
  userAgent?: string;

  @IsOptional()
  @IsString()
  sessionId?: string;

  @IsOptional()
  @IsString()
  companyId?: string;

  @IsOptional()
  @IsString()
  periodId?: string;

  @IsOptional()
  @IsString()
  tags?: string; // JSON array as string

  @IsOptional()
  @IsString()
  metadata?: string; // JSON object as string
}

export class AuditLogQueryDto {
  @IsOptional()
  @IsInt()
  @Min(1)
  @Type(() => Number)
  page?: number = 1;

  @IsOptional()
  @IsInt()
  @Min(1)
  @Max(100)
  @Type(() => Number)
  limit?: number = 20;

  @IsOptional()
  @IsEnum(AuditEventType)
  eventType?: AuditEventType;

  @IsOptional()
  @IsEnum(AuditEntityType)
  entityType?: AuditEntityType;

  @IsOptional()
  @IsString()
  entityId?: string;

  @IsOptional()
  @IsString()
  userId?: string;

  @IsOptional()
  @IsString()
  companyId?: string;

  @IsOptional()
  @IsString()
  periodId?: string;

  @IsOptional()
  @IsEnum(AuditSeverity)
  severity?: AuditSeverity;

  @IsOptional()
  @IsEnum(AuditStatus)
  status?: AuditStatus;

  @IsOptional()
  @IsDateString()
  dateFrom?: string;

  @IsOptional()
  @IsDateString()
  dateTo?: string;

  @IsOptional()
  @IsString()
  search?: string;

  @IsOptional()
  @IsString()
  ipAddress?: string;

  @IsOptional()
  @IsArray()
  @IsString({ each: true })
  tags?: string[];

  @IsOptional()
  @IsString()
  sortBy?: string = 'timestamp';

  @IsOptional()
  @IsEnum(['asc', 'desc'])
  sortOrder?: 'asc' | 'desc' = 'desc';
}

export class AuditLogAnalyticsDto {
  @IsOptional()
  @IsDateString()
  startDate?: string;

  @IsOptional()
  @IsDateString()
  endDate?: string;

  @IsOptional()
  @IsString()
  companyId?: string;

  @IsOptional()
  @IsEnum(['day', 'week', 'month', 'quarter', 'year'])
  groupBy?: string = 'day';

  @IsOptional()
  @IsArray()
  @IsEnum(AuditEventType, { each: true })
  eventTypes?: AuditEventType[];

  @IsOptional()
  @IsArray()
  @IsEnum(AuditEntityType, { each: true })
  entityTypes?: AuditEntityType[];

  @IsOptional()
  @IsArray()
  @IsString({ each: true })
  userIds?: string[];
}

export class ComplianceReportDto {
  @IsOptional()
  @IsDateString()
  startDate?: string;

  @IsOptional()
  @IsDateString()
  endDate?: string;

  @IsOptional()
  @IsString()
  companyId?: string;

  @IsOptional()
  @IsEnum(['SOX', 'GDPR', 'HIPAA', 'ISO27001', 'PCI_DSS', 'CUSTOM'])
  complianceFramework?: string;

  @IsOptional()
  @IsArray()
  @IsString({ each: true })
  includeEvents?: string[];

  @IsOptional()
  @IsArray()
  @IsString({ each: true })
  excludeEvents?: string[];

  @IsOptional()
  @IsEnum(['summary', 'detailed', 'technical'])
  reportType?: string = 'summary';

  @IsOptional()
  @IsEnum(['PDF', 'EXCEL', 'CSV', 'JSON'])
  format?: string = 'PDF';
}

export class DataRetentionDto {
  @IsOptional()
  @IsInt()
  @Min(1)
  retentionDays?: number = 2555; // 7 years default

  @IsOptional()
  @IsEnum(AuditSeverity)
  minSeverity?: AuditSeverity;

  @IsOptional()
  @IsArray()
  @IsEnum(AuditEventType, { each: true })
  includeEventTypes?: AuditEventType[];

  @IsOptional()
  @IsArray()
  @IsEnum(AuditEventType, { each: true })
  excludeEventTypes?: AuditEventType[];

  @IsOptional()
  @IsString()
  companyId?: string;

  @IsOptional()
  @IsEnum(['ARCHIVE', 'DELETE', 'EXPORT'])
  action?: string = 'ARCHIVE';
}

export class SecurityAlertDto {
  @IsEnum(AuditEventType)
  triggerEvent: AuditEventType;

  @IsOptional()
  @IsEnum(AuditSeverity)
  minSeverity?: AuditSeverity = AuditSeverity.HIGH;

  @IsOptional()
  @IsInt()
  @Min(1)
  threshold?: number = 5; // Number of occurrences

  @IsOptional()
  @IsInt()
  @Min(1)
  timeWindowMinutes?: number = 60; // Time window for threshold

  @IsOptional()
  @IsArray()
  @IsString({ each: true })
  notificationEmails?: string[];

  @IsOptional()
  @IsString()
  webhookUrl?: string;

  @IsOptional()
  @IsString()
  description?: string;

  @IsOptional()
  @IsString()
  responseAction?: string;
}

export class BulkAuditActionDto {
  @IsArray()
  @IsString({ each: true })
  auditLogIds: string[];

  @IsEnum(['ARCHIVE', 'FLAG', 'REVIEW', 'DELETE', 'EXPORT'])
  action: string;

  @IsOptional()
  @IsString()
  reason?: string;

  @IsOptional()
  @IsString()
  notes?: string;
}

export class AuditTrailConfigDto {
  @IsOptional()
  @IsInt()
  @Min(1)
  defaultRetentionDays?: number = 2555;

  @IsOptional()
  @IsArray()
  @IsEnum(AuditEventType, { each: true })
  enabledEventTypes?: AuditEventType[];

  @IsOptional()
  @IsArray()
  @IsEnum(AuditEventType, { each: true })
  disabledEventTypes?: AuditEventType[];

  @IsOptional()
  @IsEnum(AuditSeverity)
  minLogLevel?: AuditSeverity = AuditSeverity.LOW;

  @IsOptional()
  @Type(() => Boolean)
  enableRealTimeAlerts?: boolean = true;

  @IsOptional()
  @Type(() => Boolean)
  enableDataIntegrity?: boolean = true;

  @IsOptional()
  @Type(() => Boolean)
  enableEncryption?: boolean = true;

  @IsOptional()
  @IsInt()
  @Min(1)
  @Max(1000)
  maxBatchSize?: number = 100;

  @IsOptional()
  @IsInt()
  @Min(1)
  batchTimeoutSeconds?: number = 30;

  @IsOptional()
  @IsArray()
  @IsString({ each: true })
  autoArchiveEventTypes?: string[];

  @IsOptional()
  @ValidateNested({ each: true })
  @Type(() => SecurityAlertDto)
  securityAlerts?: SecurityAlertDto[];
}