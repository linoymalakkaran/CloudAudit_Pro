import { IsString, IsOptional, IsNumber, IsEnum, IsDateString, IsBoolean } from 'class-validator';
import { Type } from 'class-transformer';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export enum TrialBalanceFormat {
  STANDARD = 'STANDARD',
  ADJUSTED = 'ADJUSTED',
  POST_CLOSING = 'POST_CLOSING',
  COMPARATIVE = 'COMPARATIVE',
}

export enum ExportFormat {
  JSON = 'JSON',
  PDF = 'PDF',
  EXCEL = 'EXCEL',
  CSV = 'CSV',
}

export class GenerateTrialBalanceDto {
  @ApiProperty({ description: 'Company ID' })
  @IsString()
  companyId: string;

  @ApiProperty({ description: 'Period ID' })
  @IsString()
  periodId: string;

  @ApiPropertyOptional({ description: 'As of date (defaults to period end date)' })
  @IsOptional()
  @IsDateString()
  asOfDate?: string;

  @ApiPropertyOptional({ 
    enum: TrialBalanceFormat,
    description: 'Trial balance format type',
    default: TrialBalanceFormat.STANDARD
  })
  @IsOptional()
  @IsEnum(TrialBalanceFormat)
  format?: TrialBalanceFormat = TrialBalanceFormat.STANDARD;

  @ApiPropertyOptional({ 
    description: 'Include accounts with zero balances',
    default: false 
  })
  @IsOptional()
  @IsBoolean()
  includeZeroBalances?: boolean = false;

  @ApiPropertyOptional({ 
    description: 'Include inactive accounts',
    default: false 
  })
  @IsOptional()
  @IsBoolean()
  includeInactiveAccounts?: boolean = false;

  @ApiPropertyOptional({ 
    description: 'Group by account type',
    default: true 
  })
  @IsOptional()
  @IsBoolean()
  groupByAccountType?: boolean = true;

  @ApiPropertyOptional({ 
    description: 'Account type IDs to include (empty = all types)' 
  })
  @IsOptional()
  @IsNumber({}, { each: true })
  @Type(() => Number)
  accountTypeIds?: number[];

  @ApiPropertyOptional({ 
    description: 'Include only accounts marked for trial balance',
    default: true 
  })
  @IsOptional()
  @IsBoolean()
  includeTrialBalanceOnly?: boolean = true;
}

export class TrialBalanceFilterDto {
  @ApiPropertyOptional({ description: 'Company ID to filter by' })
  @IsOptional()
  @IsString()
  companyId?: string;

  @ApiPropertyOptional({ description: 'Period ID to filter by' })
  @IsOptional()
  @IsString()
  periodId?: string;

  @ApiPropertyOptional({ 
    enum: TrialBalanceFormat,
    description: 'Format type to filter by' 
  })
  @IsOptional()
  @IsEnum(TrialBalanceFormat)
  format?: TrialBalanceFormat;

  @ApiPropertyOptional({ description: 'Start date for date range filter' })
  @IsOptional()
  @IsDateString()
  startDate?: string;

  @ApiPropertyOptional({ description: 'End date for date range filter' })
  @IsOptional()
  @IsDateString()
  endDate?: string;

  @ApiPropertyOptional({ description: 'Page number for pagination', minimum: 1, default: 1 })
  @IsOptional()
  @IsNumber()
  @Type(() => Number)
  page?: number = 1;

  @ApiPropertyOptional({ description: 'Items per page', minimum: 1, maximum: 100, default: 20 })
  @IsOptional()
  @IsNumber()
  @Type(() => Number)
  limit?: number = 20;
}

export class ExportTrialBalanceDto {
  @ApiProperty({ 
    enum: ExportFormat,
    description: 'Export format' 
  })
  @IsEnum(ExportFormat)
  format: ExportFormat;

  @ApiPropertyOptional({ description: 'Include company header' })
  @IsOptional()
  @IsBoolean()
  includeHeader?: boolean = true;

  @ApiPropertyOptional({ description: 'Include summary totals' })
  @IsOptional()
  @IsBoolean()
  includeTotals?: boolean = true;

  @ApiPropertyOptional({ description: 'Include account codes' })
  @IsOptional()
  @IsBoolean()
  includeAccountCodes?: boolean = true;
}

export class TrialBalanceValidationDto {
  @ApiProperty({ description: 'Company ID' })
  @IsString()
  companyId: string;

  @ApiProperty({ description: 'Period ID' })
  @IsString()
  periodId: string;

  @ApiPropertyOptional({ description: 'As of date for validation' })
  @IsOptional()
  @IsDateString()
  asOfDate?: string;

  @ApiPropertyOptional({ description: 'Include detailed variance analysis' })
  @IsOptional()
  @IsBoolean()
  includeVarianceAnalysis?: boolean = false;
}