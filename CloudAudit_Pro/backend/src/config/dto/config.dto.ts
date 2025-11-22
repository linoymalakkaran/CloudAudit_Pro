import { IsString, IsBoolean, IsNumber, IsOptional, IsEnum, IsObject, IsArray, ValidateNested } from 'class-validator';
import { Type } from 'class-transformer';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export enum ConfigurationType {
  SYSTEM = 'SYSTEM',
  SECURITY = 'SECURITY',
  AUDIT = 'AUDIT',
  FINANCIAL = 'FINANCIAL',
  REPORTING = 'REPORTING',
  NOTIFICATION = 'NOTIFICATION',
  INTEGRATION = 'INTEGRATION',
  APPEARANCE = 'APPEARANCE'
}

export enum SettingDataType {
  STRING = 'STRING',
  NUMBER = 'NUMBER',
  BOOLEAN = 'BOOLEAN',
  JSON = 'JSON',
  ARRAY = 'ARRAY',
  FILE = 'FILE'
}

export enum NotificationType {
  EMAIL = 'EMAIL',
  SMS = 'SMS',
  PUSH = 'PUSH',
  WEBHOOK = 'WEBHOOK'
}

export class ConfigSettingDto {
  @ApiProperty({ description: 'Setting key identifier' })
  @IsString()
  key: string;

  @ApiProperty({ description: 'Setting value' })
  value: any;

  @ApiProperty({ description: 'Setting data type', enum: SettingDataType })
  @IsEnum(SettingDataType)
  dataType: SettingDataType;

  @ApiPropertyOptional({ description: 'Setting description' })
  @IsOptional()
  @IsString()
  description?: string;

  @ApiPropertyOptional({ description: 'Whether setting is required' })
  @IsOptional()
  @IsBoolean()
  isRequired?: boolean;

  @ApiPropertyOptional({ description: 'Whether setting is sensitive (encrypted)' })
  @IsOptional()
  @IsBoolean()
  isSensitive?: boolean;

  @ApiPropertyOptional({ description: 'Validation rules for the setting' })
  @IsOptional()
  @IsObject()
  validation?: any;
}

export class SystemConfigDto {
  @ApiProperty({ description: 'Application name' })
  @IsString()
  applicationName: string;

  @ApiProperty({ description: 'Application version' })
  @IsString()
  version: string;

  @ApiProperty({ description: 'Default timezone' })
  @IsString()
  timezone: string;

  @ApiProperty({ description: 'Default language' })
  @IsString()
  defaultLanguage: string;

  @ApiPropertyOptional({ description: 'Maintenance mode enabled' })
  @IsOptional()
  @IsBoolean()
  maintenanceMode?: boolean;

  @ApiPropertyOptional({ description: 'Debug mode enabled' })
  @IsOptional()
  @IsBoolean()
  debugMode?: boolean;

  @ApiPropertyOptional({ description: 'Maximum file upload size (MB)' })
  @IsOptional()
  @IsNumber()
  maxFileUploadSize?: number;

  @ApiPropertyOptional({ description: 'Session timeout (minutes)' })
  @IsOptional()
  @IsNumber()
  sessionTimeout?: number;
}

export class SecurityConfigDto {
  @ApiProperty({ description: 'Password minimum length' })
  @IsNumber()
  passwordMinLength: number;

  @ApiProperty({ description: 'Password requires uppercase' })
  @IsBoolean()
  passwordRequireUppercase: boolean;

  @ApiProperty({ description: 'Password requires lowercase' })
  @IsBoolean()
  passwordRequireLowercase: boolean;

  @ApiProperty({ description: 'Password requires numbers' })
  @IsBoolean()
  passwordRequireNumbers: boolean;

  @ApiProperty({ description: 'Password requires special characters' })
  @IsBoolean()
  passwordRequireSpecialChars: boolean;

  @ApiProperty({ description: 'Maximum login attempts' })
  @IsNumber()
  maxLoginAttempts: number;

  @ApiProperty({ description: 'Account lockout duration (minutes)' })
  @IsNumber()
  lockoutDuration: number;

  @ApiProperty({ description: 'Two-factor authentication required' })
  @IsBoolean()
  twoFactorRequired: boolean;

  @ApiPropertyOptional({ description: 'IP whitelist for admin access' })
  @IsOptional()
  @IsArray()
  @IsString({ each: true })
  ipWhitelist?: string[];

  @ApiPropertyOptional({ description: 'Data encryption enabled' })
  @IsOptional()
  @IsBoolean()
  dataEncryptionEnabled?: boolean;
}

export class AuditConfigDto {
  @ApiProperty({ description: 'Default audit procedure timeout (days)' })
  @IsNumber()
  defaultProcedureTimeout: number;

  @ApiProperty({ description: 'Automatic procedure assignment enabled' })
  @IsBoolean()
  autoAssignmentEnabled: boolean;

  @ApiProperty({ description: 'Email notifications for overdue procedures' })
  @IsBoolean()
  overdueNotificationsEnabled: boolean;

  @ApiProperty({ description: 'Days before due date to send reminder' })
  @IsNumber()
  reminderDaysBefore: number;

  @ApiProperty({ description: 'Require supervisor approval for completion' })
  @IsBoolean()
  supervisorApprovalRequired: boolean;

  @ApiPropertyOptional({ description: 'Custom audit workflow templates' })
  @IsOptional()
  @IsArray()
  workflowTemplates?: string[];

  @ApiPropertyOptional({ description: 'Risk assessment mandatory' })
  @IsOptional()
  @IsBoolean()
  riskAssessmentMandatory?: boolean;

  @ApiPropertyOptional({ description: 'Document attachment required' })
  @IsOptional()
  @IsBoolean()
  documentAttachmentRequired?: boolean;
}

export class FinancialConfigDto {
  @ApiProperty({ description: 'Default currency' })
  @IsString()
  defaultCurrency: string;

  @ApiProperty({ description: 'Decimal places for amounts' })
  @IsNumber()
  decimalPlaces: number;

  @ApiProperty({ description: 'Thousands separator' })
  @IsString()
  thousandsSeparator: string;

  @ApiProperty({ description: 'Decimal separator' })
  @IsString()
  decimalSeparator: string;

  @ApiProperty({ description: 'Financial year start month (1-12)' })
  @IsNumber()
  fiscalYearStartMonth: number;

  @ApiPropertyOptional({ description: 'Automatic journal entry numbering' })
  @IsOptional()
  @IsBoolean()
  autoJournalNumbering?: boolean;

  @ApiPropertyOptional({ description: 'Require journal entry approval' })
  @IsOptional()
  @IsBoolean()
  journalApprovalRequired?: boolean;

  @ApiPropertyOptional({ description: 'Allow backdated entries' })
  @IsOptional()
  @IsBoolean()
  allowBackdatedEntries?: boolean;
}

export class ReportingConfigDto {
  @ApiProperty({ description: 'Default report format' })
  @IsString()
  defaultFormat: string;

  @ApiProperty({ description: 'Include company logo in reports' })
  @IsBoolean()
  includeCompanyLogo: boolean;

  @ApiProperty({ description: 'Show watermark on reports' })
  @IsBoolean()
  showWatermark: boolean;

  @ApiProperty({ description: 'Automatic report archival (days)' })
  @IsNumber()
  archivalDays: number;

  @ApiPropertyOptional({ description: 'Custom report templates' })
  @IsOptional()
  @IsArray()
  customTemplates?: string[];

  @ApiPropertyOptional({ description: 'Enable scheduled reports' })
  @IsOptional()
  @IsBoolean()
  scheduledReportsEnabled?: boolean;

  @ApiPropertyOptional({ description: 'Maximum concurrent report generations' })
  @IsOptional()
  @IsNumber()
  maxConcurrentGenerations?: number;
}

export class NotificationConfigDto {
  @ApiProperty({ description: 'Email notifications enabled' })
  @IsBoolean()
  emailEnabled: boolean;

  @ApiProperty({ description: 'SMS notifications enabled' })
  @IsBoolean()
  smsEnabled: boolean;

  @ApiProperty({ description: 'Push notifications enabled' })
  @IsBoolean()
  pushEnabled: boolean;

  @ApiProperty({ description: 'Default notification types', enum: NotificationType, isArray: true })
  @IsArray()
  @IsEnum(NotificationType, { each: true })
  defaultTypes: NotificationType[];

  @ApiPropertyOptional({ description: 'SMTP server configuration' })
  @IsOptional()
  @IsObject()
  smtpConfig?: {
    host: string;
    port: number;
    secure: boolean;
    username: string;
    password: string;
  };

  @ApiPropertyOptional({ description: 'SMS gateway configuration' })
  @IsOptional()
  @IsObject()
  smsConfig?: {
    provider: string;
    apiKey: string;
    senderId: string;
  };

  @ApiPropertyOptional({ description: 'Webhook URLs for notifications' })
  @IsOptional()
  @IsArray()
  @IsString({ each: true })
  webhookUrls?: string[];
}

export class IntegrationConfigDto {
  @ApiPropertyOptional({ description: 'API rate limiting enabled' })
  @IsOptional()
  @IsBoolean()
  rateLimitingEnabled?: boolean;

  @ApiPropertyOptional({ description: 'Requests per minute limit' })
  @IsOptional()
  @IsNumber()
  requestsPerMinute?: number;

  @ApiPropertyOptional({ description: 'External API configurations' })
  @IsOptional()
  @IsObject()
  externalApis?: any;

  @ApiPropertyOptional({ description: 'Database sync configurations' })
  @IsOptional()
  @IsObject()
  databaseSync?: any;

  @ApiPropertyOptional({ description: 'Third-party integrations' })
  @IsOptional()
  @IsArray()
  thirdPartyIntegrations?: any[];
}

export class AppearanceConfigDto {
  @ApiProperty({ description: 'Application theme' })
  @IsString()
  theme: string;

  @ApiProperty({ description: 'Primary brand color' })
  @IsString()
  primaryColor: string;

  @ApiProperty({ description: 'Secondary brand color' })
  @IsString()
  secondaryColor: string;

  @ApiPropertyOptional({ description: 'Company logo URL' })
  @IsOptional()
  @IsString()
  logoUrl?: string;

  @ApiPropertyOptional({ description: 'Favicon URL' })
  @IsOptional()
  @IsString()
  faviconUrl?: string;

  @ApiPropertyOptional({ description: 'Custom CSS styles' })
  @IsOptional()
  @IsString()
  customCss?: string;

  @ApiPropertyOptional({ description: 'Dark mode enabled' })
  @IsOptional()
  @IsBoolean()
  darkModeEnabled?: boolean;
}

export class CreateConfigurationDto {
  @ApiProperty({ description: 'Configuration type', enum: ConfigurationType })
  @IsEnum(ConfigurationType)
  type: ConfigurationType;

  @ApiProperty({ description: 'Configuration name' })
  @IsString()
  name: string;

  @ApiPropertyOptional({ description: 'Configuration description' })
  @IsOptional()
  @IsString()
  description?: string;

  @ApiProperty({ description: 'Configuration settings' })
  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => ConfigSettingDto)
  settings: ConfigSettingDto[];

  @ApiPropertyOptional({ description: 'Company-specific configuration' })
  @IsOptional()
  @IsString()
  companyId?: string;

  @ApiPropertyOptional({ description: 'Configuration is active' })
  @IsOptional()
  @IsBoolean()
  isActive?: boolean;
}

export class UpdateConfigurationDto {
  @ApiPropertyOptional({ description: 'Configuration name' })
  @IsOptional()
  @IsString()
  name?: string;

  @ApiPropertyOptional({ description: 'Configuration description' })
  @IsOptional()
  @IsString()
  description?: string;

  @ApiPropertyOptional({ description: 'Configuration settings' })
  @IsOptional()
  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => ConfigSettingDto)
  settings?: ConfigSettingDto[];

  @ApiPropertyOptional({ description: 'Configuration is active' })
  @IsOptional()
  @IsBoolean()
  isActive?: boolean;
}

export class ConfigQueryDto {
  @ApiPropertyOptional({ description: 'Configuration type', enum: ConfigurationType })
  @IsOptional()
  @IsEnum(ConfigurationType)
  type?: ConfigurationType;

  @ApiPropertyOptional({ description: 'Company ID for filtering' })
  @IsOptional()
  @IsString()
  companyId?: string;

  @ApiPropertyOptional({ description: 'Search in configuration names' })
  @IsOptional()
  @IsString()
  search?: string;

  @ApiPropertyOptional({ description: 'Filter by active status' })
  @IsOptional()
  @IsBoolean()
  isActive?: boolean;

  @ApiPropertyOptional({ description: 'Page number' })
  @IsOptional()
  @IsNumber()
  page?: number;

  @ApiPropertyOptional({ description: 'Items per page' })
  @IsOptional()
  @IsNumber()
  limit?: number;
}