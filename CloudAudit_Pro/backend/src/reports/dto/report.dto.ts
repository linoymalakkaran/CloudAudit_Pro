import { IsString, IsOptional, IsArray, IsDateString, IsEnum, ValidateNested, IsBoolean } from 'class-validator';
import { Type } from 'class-transformer';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export enum ReportType {
  FINANCIAL_POSITION = 'FINANCIAL_POSITION',
  INCOME_STATEMENT = 'INCOME_STATEMENT',
  CASH_FLOW = 'CASH_FLOW',
  TRIAL_BALANCE = 'TRIAL_BALANCE',
  GENERAL_LEDGER = 'GENERAL_LEDGER',
  AGED_RECEIVABLES = 'AGED_RECEIVABLES',
  AGED_PAYABLES = 'AGED_PAYABLES',
  JOURNAL_REGISTER = 'JOURNAL_REGISTER',
  AUDIT_SUMMARY = 'AUDIT_SUMMARY',
  PROCEDURE_STATUS = 'PROCEDURE_STATUS',
  FINDINGS_REPORT = 'FINDINGS_REPORT',
  COMPLIANCE_REPORT = 'COMPLIANCE_REPORT',
  RISK_ASSESSMENT = 'RISK_ASSESSMENT',
  CUSTOM = 'CUSTOM'
}

export enum ReportFormat {
  PDF = 'PDF',
  EXCEL = 'EXCEL',
  CSV = 'CSV',
  JSON = 'JSON',
  HTML = 'HTML'
}

export enum ReportFrequency {
  DAILY = 'DAILY',
  WEEKLY = 'WEEKLY',
  MONTHLY = 'MONTHLY',
  QUARTERLY = 'QUARTERLY',
  ANNUALLY = 'ANNUALLY',
  ON_DEMAND = 'ON_DEMAND'
}

export enum GroupBy {
  ACCOUNT = 'ACCOUNT',
  CATEGORY = 'CATEGORY',
  DEPARTMENT = 'DEPARTMENT',
  MONTH = 'MONTH',
  QUARTER = 'QUARTER',
  YEAR = 'YEAR',
  ASSIGNEE = 'ASSIGNEE',
  STATUS = 'STATUS'
}

export class ReportFilterDto {
  @ApiPropertyOptional({ description: 'Start date for the report period' })
  @IsOptional()
  @IsDateString()
  startDate?: string;

  @ApiPropertyOptional({ description: 'End date for the report period' })
  @IsOptional()
  @IsDateString()
  endDate?: string;

  @ApiPropertyOptional({ description: 'Specific account IDs to include' })
  @IsOptional()
  @IsArray()
  @IsString({ each: true })
  accountIds?: string[];

  @ApiPropertyOptional({ description: 'Account categories to include' })
  @IsOptional()
  @IsArray()
  @IsString({ each: true })
  categories?: string[];

  @ApiPropertyOptional({ description: 'Departments to include' })
  @IsOptional()
  @IsArray()
  @IsString({ each: true })
  departments?: string[];

  @ApiPropertyOptional({ description: 'Currency code for filtering' })
  @IsOptional()
  @IsString()
  currency?: string;

  @ApiPropertyOptional({ description: 'Minimum amount threshold' })
  @IsOptional()
  minAmount?: number;

  @ApiPropertyOptional({ description: 'Maximum amount threshold' })
  @IsOptional()
  maxAmount?: number;

  @ApiPropertyOptional({ description: 'Include inactive accounts' })
  @IsOptional()
  @IsBoolean()
  includeInactive?: boolean;

  @ApiPropertyOptional({ description: 'Include zero balance accounts' })
  @IsOptional()
  @IsBoolean()
  includeZeroBalances?: boolean;
}

export class ReportConfigurationDto {
  @ApiPropertyOptional({ description: 'Group data by specific field', enum: GroupBy })
  @IsOptional()
  @IsEnum(GroupBy)
  groupBy?: GroupBy;

  @ApiPropertyOptional({ description: 'Sort field' })
  @IsOptional()
  @IsString()
  sortBy?: string;

  @ApiPropertyOptional({ description: 'Sort order', enum: ['asc', 'desc'] })
  @IsOptional()
  @IsEnum(['asc', 'desc'])
  sortOrder?: 'asc' | 'desc';

  @ApiPropertyOptional({ description: 'Include comparative data' })
  @IsOptional()
  @IsBoolean()
  includeComparative?: boolean;

  @ApiPropertyOptional({ description: 'Comparative period start date' })
  @IsOptional()
  @IsDateString()
  comparativeStartDate?: string;

  @ApiPropertyOptional({ description: 'Comparative period end date' })
  @IsOptional()
  @IsDateString()
  comparativeEndDate?: string;

  @ApiPropertyOptional({ description: 'Show percentage changes' })
  @IsOptional()
  @IsBoolean()
  showPercentageChange?: boolean;

  @ApiPropertyOptional({ description: 'Include summary statistics' })
  @IsOptional()
  @IsBoolean()
  includeSummary?: boolean;

  @ApiPropertyOptional({ description: 'Include detailed breakdowns' })
  @IsOptional()
  @IsBoolean()
  includeDetails?: boolean;

  @ApiPropertyOptional({ description: 'Number of decimal places' })
  @IsOptional()
  decimalPlaces?: number;

  @ApiPropertyOptional({ description: 'Currency symbol to display' })
  @IsOptional()
  @IsString()
  currencySymbol?: string;
}

export class CreateReportDto {
  @ApiProperty({ description: 'Company ID', example: 'company-123' })
  @IsString()
  companyId: string;

  @ApiProperty({ description: 'Period ID', example: 'period-123' })
  @IsString()
  periodId: string;

  @ApiProperty({ description: 'Report type', enum: ReportType })
  @IsEnum(ReportType)
  reportType: ReportType;

  @ApiProperty({ description: 'Report name', example: 'Monthly Financial Position' })
  @IsString()
  name: string;

  @ApiPropertyOptional({ description: 'Report description' })
  @IsOptional()
  @IsString()
  description?: string;

  @ApiProperty({ description: 'Output format', enum: ReportFormat })
  @IsEnum(ReportFormat)
  format: ReportFormat;

  @ApiPropertyOptional({ description: 'Report filters' })
  @IsOptional()
  @ValidateNested()
  @Type(() => ReportFilterDto)
  filters?: ReportFilterDto;

  @ApiPropertyOptional({ description: 'Report configuration' })
  @IsOptional()
  @ValidateNested()
  @Type(() => ReportConfigurationDto)
  configuration?: ReportConfigurationDto;

  @ApiPropertyOptional({ description: 'Schedule for automatic generation' })
  @IsOptional()
  @IsEnum(ReportFrequency)
  schedule?: ReportFrequency;

  @ApiPropertyOptional({ description: 'Email recipients for scheduled reports' })
  @IsOptional()
  @IsArray()
  @IsString({ each: true })
  recipients?: string[];
}

export class UpdateReportDto {
  @ApiPropertyOptional({ description: 'Report name' })
  @IsOptional()
  @IsString()
  name?: string;

  @ApiPropertyOptional({ description: 'Report description' })
  @IsOptional()
  @IsString()
  description?: string;

  @ApiPropertyOptional({ description: 'Output format', enum: ReportFormat })
  @IsOptional()
  @IsEnum(ReportFormat)
  format?: ReportFormat;

  @ApiPropertyOptional({ description: 'Report filters' })
  @IsOptional()
  @ValidateNested()
  @Type(() => ReportFilterDto)
  filters?: ReportFilterDto;

  @ApiPropertyOptional({ description: 'Report configuration' })
  @IsOptional()
  @ValidateNested()
  @Type(() => ReportConfigurationDto)
  configuration?: ReportConfigurationDto;

  @ApiPropertyOptional({ description: 'Schedule for automatic generation' })
  @IsOptional()
  @IsEnum(ReportFrequency)
  schedule?: ReportFrequency;

  @ApiPropertyOptional({ description: 'Email recipients for scheduled reports' })
  @IsOptional()
  @IsArray()
  @IsString({ each: true })
  recipients?: string[];

  @ApiPropertyOptional({ description: 'Report active status' })
  @IsOptional()
  @IsBoolean()
  isActive?: boolean;
}

export class ExecuteReportDto {
  @ApiProperty({ description: 'Company ID', example: 'company-123' })
  @IsString()
  companyId: string;

  @ApiPropertyOptional({ description: 'Period ID (if not specified in report template)' })
  @IsOptional()
  @IsString()
  periodId?: string;

  @ApiPropertyOptional({ description: 'Override report filters' })
  @IsOptional()
  @ValidateNested()
  @Type(() => ReportFilterDto)
  filters?: ReportFilterDto;

  @ApiPropertyOptional({ description: 'Override report configuration' })
  @IsOptional()
  @ValidateNested()
  @Type(() => ReportConfigurationDto)
  configuration?: ReportConfigurationDto;

  @ApiPropertyOptional({ description: 'Override output format' })
  @IsOptional()
  @IsEnum(ReportFormat)
  format?: ReportFormat;

  @ApiPropertyOptional({ description: 'Save generated report' })
  @IsOptional()
  @IsBoolean()
  saveReport?: boolean;
}

export class ReportQueryDto {
  @ApiPropertyOptional({ description: 'Page number', example: 1 })
  @IsOptional()
  page?: number;

  @ApiPropertyOptional({ description: 'Items per page', example: 20 })
  @IsOptional()
  limit?: number;

  @ApiPropertyOptional({ description: 'Filter by company' })
  @IsOptional()
  @IsString()
  companyId?: string;

  @ApiPropertyOptional({ description: 'Filter by report type', enum: ReportType })
  @IsOptional()
  @IsEnum(ReportType)
  reportType?: ReportType;

  @ApiPropertyOptional({ description: 'Filter by format', enum: ReportFormat })
  @IsOptional()
  @IsEnum(ReportFormat)
  format?: ReportFormat;

  @ApiPropertyOptional({ description: 'Search in name and description' })
  @IsOptional()
  @IsString()
  search?: string;

  @ApiPropertyOptional({ description: 'Sort field', example: 'createdAt' })
  @IsOptional()
  @IsString()
  sortBy?: string;

  @ApiPropertyOptional({ description: 'Sort order', enum: ['asc', 'desc'] })
  @IsOptional()
  @IsEnum(['asc', 'desc'])
  sortOrder?: 'asc' | 'desc';

  @ApiPropertyOptional({ description: 'Filter by active status' })
  @IsOptional()
  @IsBoolean()
  isActive?: boolean;

  @ApiPropertyOptional({ description: 'Created date from' })
  @IsOptional()
  @IsDateString()
  createdFrom?: string;

  @ApiPropertyOptional({ description: 'Created date to' })
  @IsOptional()
  @IsDateString()
  createdTo?: string;
}

export class BulkReportDto {
  @ApiProperty({ description: 'Company ID', example: 'company-123' })
  @IsString()
  companyId: string;

  @ApiProperty({ description: 'Period ID', example: 'period-123' })
  @IsString()
  periodId: string;

  @ApiProperty({ description: 'Report types to generate', enum: ReportType, isArray: true })
  @IsArray()
  @IsEnum(ReportType, { each: true })
  reportTypes: ReportType[];

  @ApiProperty({ description: 'Output format', enum: ReportFormat })
  @IsEnum(ReportFormat)
  format: ReportFormat;

  @ApiPropertyOptional({ description: 'Common filters for all reports' })
  @IsOptional()
  @ValidateNested()
  @Type(() => ReportFilterDto)
  commonFilters?: ReportFilterDto;

  @ApiPropertyOptional({ description: 'Email recipient for bulk report package' })
  @IsOptional()
  @IsString()
  emailTo?: string;

  @ApiPropertyOptional({ description: 'Include comparative data' })
  @IsOptional()
  @IsBoolean()
  includeComparative?: boolean;
}