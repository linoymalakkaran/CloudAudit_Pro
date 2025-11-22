import { IsString, IsOptional, IsEnum, IsArray, IsBoolean, IsDateString, ValidateNested } from 'class-validator';
import { Type } from 'class-transformer';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export enum ExportFormat {
  JSON = 'JSON',
  CSV = 'CSV',
  EXCEL = 'EXCEL',
  XML = 'XML',
  PDF = 'PDF'
}

export enum ImportFormat {
  JSON = 'JSON',
  CSV = 'CSV',
  EXCEL = 'EXCEL',
  XML = 'XML'
}

export enum DataType {
  COMPANIES = 'COMPANIES',
  ACCOUNTS = 'ACCOUNTS',
  JOURNAL_ENTRIES = 'JOURNAL_ENTRIES',
  TRIAL_BALANCES = 'TRIAL_BALANCES',
  DOCUMENTS = 'DOCUMENTS',
  USERS = 'USERS',
  AUDIT_PROCEDURES = 'AUDIT_PROCEDURES',
  CONFIGURATIONS = 'CONFIGURATIONS',
  REPORTS = 'REPORTS',
  PERIODS = 'PERIODS',
  ALL = 'ALL'
}

export enum ExportStatus {
  PENDING = 'PENDING',
  IN_PROGRESS = 'IN_PROGRESS',
  COMPLETED = 'COMPLETED',
  FAILED = 'FAILED',
  CANCELLED = 'CANCELLED'
}

export enum ImportStatus {
  PENDING = 'PENDING',
  VALIDATING = 'VALIDATING',
  IN_PROGRESS = 'IN_PROGRESS',
  COMPLETED = 'COMPLETED',
  FAILED = 'FAILED',
  PARTIAL = 'PARTIAL'
}

export class ExportOptionsDto {
  @ApiPropertyOptional({ description: 'Include related data' })
  @IsOptional()
  @IsBoolean()
  includeRelated?: boolean;

  @ApiPropertyOptional({ description: 'Include inactive records' })
  @IsOptional()
  @IsBoolean()
  includeInactive?: boolean;

  @ApiPropertyOptional({ description: 'Include audit trail' })
  @IsOptional()
  @IsBoolean()
  includeAuditTrail?: boolean;

  @ApiPropertyOptional({ description: 'Compress output file' })
  @IsOptional()
  @IsBoolean()
  compress?: boolean;

  @ApiPropertyOptional({ description: 'Password protect file' })
  @IsOptional()
  @IsString()
  password?: string;

  @ApiPropertyOptional({ description: 'Custom field mapping' })
  @IsOptional()
  fieldMapping?: { [key: string]: string };

  @ApiPropertyOptional({ description: 'Date format for export' })
  @IsOptional()
  @IsString()
  dateFormat?: string;

  @ApiPropertyOptional({ description: 'Number format for export' })
  @IsOptional()
  @IsString()
  numberFormat?: string;
}

export class ImportOptionsDto {
  @ApiPropertyOptional({ description: 'Skip validation errors' })
  @IsOptional()
  @IsBoolean()
  skipValidationErrors?: boolean;

  @ApiPropertyOptional({ description: 'Update existing records' })
  @IsOptional()
  @IsBoolean()
  updateExisting?: boolean;

  @ApiPropertyOptional({ description: 'Create missing references' })
  @IsOptional()
  @IsBoolean()
  createMissingReferences?: boolean;

  @ApiPropertyOptional({ description: 'Dry run mode' })
  @IsOptional()
  @IsBoolean()
  dryRun?: boolean;

  @ApiPropertyOptional({ description: 'Batch size for processing' })
  @IsOptional()
  batchSize?: number;

  @ApiPropertyOptional({ description: 'Field mapping configuration' })
  @IsOptional()
  fieldMapping?: { [key: string]: string };

  @ApiPropertyOptional({ description: 'Default values for missing fields' })
  @IsOptional()
  defaultValues?: { [key: string]: any };
}

export class CreateExportDto {
  @ApiProperty({ description: 'Export name' })
  @IsString()
  name: string;

  @ApiProperty({ description: 'Data types to export', enum: DataType, isArray: true })
  @IsArray()
  @IsEnum(DataType, { each: true })
  dataTypes: DataType[];

  @ApiProperty({ description: 'Export format', enum: ExportFormat })
  @IsEnum(ExportFormat)
  format: ExportFormat;

  @ApiPropertyOptional({ description: 'Company ID for filtering' })
  @IsOptional()
  @IsString()
  companyId?: string;

  @ApiPropertyOptional({ description: 'Period ID for filtering' })
  @IsOptional()
  @IsString()
  periodId?: string;

  @ApiPropertyOptional({ description: 'Date range start' })
  @IsOptional()
  @IsDateString()
  startDate?: string;

  @ApiPropertyOptional({ description: 'Date range end' })
  @IsOptional()
  @IsDateString()
  endDate?: string;

  @ApiPropertyOptional({ description: 'Export options' })
  @IsOptional()
  @ValidateNested()
  @Type(() => ExportOptionsDto)
  options?: ExportOptionsDto;

  @ApiPropertyOptional({ description: 'Send email when complete' })
  @IsOptional()
  @IsString()
  emailOnComplete?: string;

  @ApiPropertyOptional({ description: 'Schedule export for later' })
  @IsOptional()
  @IsDateString()
  scheduledFor?: string;
}

export class CreateImportDto {
  @ApiProperty({ description: 'Import name' })
  @IsString()
  name: string;

  @ApiProperty({ description: 'Data type being imported', enum: DataType })
  @IsEnum(DataType)
  dataType: DataType;

  @ApiProperty({ description: 'Import format', enum: ImportFormat })
  @IsEnum(ImportFormat)
  format: ImportFormat;

  @ApiProperty({ description: 'File path or URL' })
  @IsString()
  filePath: string;

  @ApiPropertyOptional({ description: 'Company ID for import' })
  @IsOptional()
  @IsString()
  companyId?: string;

  @ApiPropertyOptional({ description: 'Period ID for import' })
  @IsOptional()
  @IsString()
  periodId?: string;

  @ApiPropertyOptional({ description: 'Import options' })
  @IsOptional()
  @ValidateNested()
  @Type(() => ImportOptionsDto)
  options?: ImportOptionsDto;

  @ApiPropertyOptional({ description: 'Send email when complete' })
  @IsOptional()
  @IsString()
  emailOnComplete?: string;
}

export class ExportQueryDto {
  @ApiPropertyOptional({ description: 'Page number' })
  @IsOptional()
  page?: number;

  @ApiPropertyOptional({ description: 'Items per page' })
  @IsOptional()
  limit?: number;

  @ApiPropertyOptional({ description: 'Filter by status', enum: ExportStatus })
  @IsOptional()
  @IsEnum(ExportStatus)
  status?: ExportStatus;

  @ApiPropertyOptional({ description: 'Filter by data type', enum: DataType })
  @IsOptional()
  @IsEnum(DataType)
  dataType?: DataType;

  @ApiPropertyOptional({ description: 'Filter by format', enum: ExportFormat })
  @IsOptional()
  @IsEnum(ExportFormat)
  format?: ExportFormat;

  @ApiPropertyOptional({ description: 'Search in export names' })
  @IsOptional()
  @IsString()
  search?: string;

  @ApiPropertyOptional({ description: 'Created date from' })
  @IsOptional()
  @IsDateString()
  createdFrom?: string;

  @ApiPropertyOptional({ description: 'Created date to' })
  @IsOptional()
  @IsDateString()
  createdTo?: string;
}

export class ImportQueryDto {
  @ApiPropertyOptional({ description: 'Page number' })
  @IsOptional()
  page?: number;

  @ApiPropertyOptional({ description: 'Items per page' })
  @IsOptional()
  limit?: number;

  @ApiPropertyOptional({ description: 'Filter by status', enum: ImportStatus })
  @IsOptional()
  @IsEnum(ImportStatus)
  status?: ImportStatus;

  @ApiPropertyOptional({ description: 'Filter by data type', enum: DataType })
  @IsOptional()
  @IsEnum(DataType)
  dataType?: DataType;

  @ApiPropertyOptional({ description: 'Filter by format', enum: ImportFormat })
  @IsOptional()
  @IsEnum(ImportFormat)
  format?: ImportFormat;

  @ApiPropertyOptional({ description: 'Search in import names' })
  @IsOptional()
  @IsString()
  search?: string;

  @ApiPropertyOptional({ description: 'Created date from' })
  @IsOptional()
  @IsDateString()
  createdFrom?: string;

  @ApiPropertyOptional({ description: 'Created date to' })
  @IsOptional()
  @IsDateString()
  createdTo?: string;
}

export class FieldMappingDto {
  @ApiProperty({ description: 'Source field name' })
  @IsString()
  sourceField: string;

  @ApiProperty({ description: 'Target field name' })
  @IsString()
  targetField: string;

  @ApiPropertyOptional({ description: 'Field transformation function' })
  @IsOptional()
  @IsString()
  transformation?: string;

  @ApiPropertyOptional({ description: 'Default value if source is empty' })
  @IsOptional()
  defaultValue?: any;

  @ApiPropertyOptional({ description: 'Field is required' })
  @IsOptional()
  @IsBoolean()
  required?: boolean;
}

export class ValidationResultDto {
  @ApiProperty({ description: 'Row number where error occurred' })
  row: number;

  @ApiProperty({ description: 'Field name with error' })
  field: string;

  @ApiProperty({ description: 'Error message' })
  message: string;

  @ApiPropertyOptional({ description: 'Error severity' })
  @IsOptional()
  @IsEnum(['ERROR', 'WARNING', 'INFO'])
  severity?: 'ERROR' | 'WARNING' | 'INFO';

  @ApiPropertyOptional({ description: 'Suggested value' })
  @IsOptional()
  suggestedValue?: any;
}

export class ImportPreviewDto {
  @ApiProperty({ description: 'Total records to import' })
  totalRecords: number;

  @ApiProperty({ description: 'Valid records count' })
  validRecords: number;

  @ApiProperty({ description: 'Invalid records count' })
  invalidRecords: number;

  @ApiProperty({ description: 'Validation errors' })
  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => ValidationResultDto)
  validationErrors: ValidationResultDto[];

  @ApiProperty({ description: 'Sample of first few records' })
  sampleData: any[];

  @ApiProperty({ description: 'Detected field mappings' })
  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => FieldMappingDto)
  detectedMappings: FieldMappingDto[];
}

export class BulkOperationDto {
  @ApiProperty({ description: 'Operation type' })
  @IsEnum(['DELETE', 'UPDATE_STATUS', 'RETRY', 'CANCEL'])
  operation: 'DELETE' | 'UPDATE_STATUS' | 'RETRY' | 'CANCEL';

  @ApiProperty({ description: 'Job IDs to operate on' })
  @IsArray()
  @IsString({ each: true })
  jobIds: string[];

  @ApiPropertyOptional({ description: 'Additional parameters for operation' })
  @IsOptional()
  parameters?: any;
}

export class TemplateDto {
  @ApiProperty({ description: 'Template name' })
  @IsString()
  name: string;

  @ApiProperty({ description: 'Data type this template is for', enum: DataType })
  @IsEnum(DataType)
  dataType: DataType;

  @ApiProperty({ description: 'Template description' })
  @IsString()
  description: string;

  @ApiProperty({ description: 'Template format', enum: ImportFormat })
  @IsEnum(ImportFormat)
  format: ImportFormat;

  @ApiProperty({ description: 'Field mappings' })
  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => FieldMappingDto)
  fieldMappings: FieldMappingDto[];

  @ApiPropertyOptional({ description: 'Default import options' })
  @IsOptional()
  @ValidateNested()
  @Type(() => ImportOptionsDto)
  defaultOptions?: ImportOptionsDto;

  @ApiPropertyOptional({ description: 'Template is active' })
  @IsOptional()
  @IsBoolean()
  isActive?: boolean;
}