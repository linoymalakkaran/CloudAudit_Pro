import { IsString, IsOptional, IsEnum, IsDateString, IsBoolean, IsNumber } from 'class-validator';
import { Type } from 'class-transformer';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export enum StatementType {
  INCOME_STATEMENT = 'INCOME_STATEMENT',
  BALANCE_SHEET = 'BALANCE_SHEET',
  CASH_FLOW = 'CASH_FLOW',
  STATEMENT_OF_EQUITY = 'STATEMENT_OF_EQUITY',
  COMPREHENSIVE_INCOME = 'COMPREHENSIVE_INCOME',
}

export enum StatementFormat {
  STANDARD = 'STANDARD',
  COMPARATIVE = 'COMPARATIVE',
  CONSOLIDATED = 'CONSOLIDATED',
  INTERIM = 'INTERIM',
}

export enum ExportFormat {
  JSON = 'JSON',
  PDF = 'PDF',
  EXCEL = 'EXCEL',
  CSV = 'CSV',
  HTML = 'HTML',
}

export class GenerateStatementDto {
  @ApiProperty({ description: 'Company ID' })
  @IsString()
  companyId: string;

  @ApiProperty({ description: 'Period ID' })
  @IsString()
  periodId: string;

  @ApiProperty({ 
    enum: StatementType,
    description: 'Type of financial statement to generate' 
  })
  @IsEnum(StatementType)
  statementType: StatementType;

  @ApiPropertyOptional({ 
    enum: StatementFormat,
    description: 'Statement format',
    default: StatementFormat.STANDARD
  })
  @IsOptional()
  @IsEnum(StatementFormat)
  format?: StatementFormat = StatementFormat.STANDARD;

  @ApiPropertyOptional({ description: 'As of date (for Balance Sheet)' })
  @IsOptional()
  @IsDateString()
  asOfDate?: string;

  @ApiPropertyOptional({ description: 'Start date (for Income Statement/Cash Flow)' })
  @IsOptional()
  @IsDateString()
  startDate?: string;

  @ApiPropertyOptional({ description: 'End date (for Income Statement/Cash Flow)' })
  @IsOptional()
  @IsDateString()
  endDate?: string;

  @ApiPropertyOptional({ description: 'Include prior period comparison' })
  @IsOptional()
  @IsBoolean()
  includePriorPeriod?: boolean = false;

  @ApiPropertyOptional({ description: 'Include zero balance items' })
  @IsOptional()
  @IsBoolean()
  includeZeroBalances?: boolean = false;

  @ApiPropertyOptional({ description: 'Round amounts to nearest dollar' })
  @IsOptional()
  @IsBoolean()
  roundAmounts?: boolean = false;

  @ApiPropertyOptional({ description: 'Include detailed account breakdown' })
  @IsOptional()
  @IsBoolean()
  includeAccountDetail?: boolean = false;
}

export class StatementFilterDto {
  @ApiPropertyOptional({ description: 'Company ID to filter by' })
  @IsOptional()
  @IsString()
  companyId?: string;

  @ApiPropertyOptional({ description: 'Period ID to filter by' })
  @IsOptional()
  @IsString()
  periodId?: string;

  @ApiPropertyOptional({ 
    enum: StatementType,
    description: 'Statement type to filter by' 
  })
  @IsOptional()
  @IsEnum(StatementType)
  statementType?: StatementType;

  @ApiPropertyOptional({ 
    enum: StatementFormat,
    description: 'Format to filter by' 
  })
  @IsOptional()
  @IsEnum(StatementFormat)
  format?: StatementFormat;

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

  @ApiPropertyOptional({ description: 'Items per page', minimum: 1, maximum: 50, default: 20 })
  @IsOptional()
  @IsNumber()
  @Type(() => Number)
  limit?: number = 20;
}

export class ExportStatementDto {
  @ApiProperty({ 
    enum: ExportFormat,
    description: 'Export format' 
  })
  @IsEnum(ExportFormat)
  format: ExportFormat;

  @ApiPropertyOptional({ description: 'Include company header and logo' })
  @IsOptional()
  @IsBoolean()
  includeHeader?: boolean = true;

  @ApiPropertyOptional({ description: 'Include footer with generation info' })
  @IsOptional()
  @IsBoolean()
  includeFooter?: boolean = true;

  @ApiPropertyOptional({ description: 'Include notes and disclaimers' })
  @IsOptional()
  @IsBoolean()
  includeNotes?: boolean = true;

  @ApiPropertyOptional({ description: 'Landscape orientation for PDF' })
  @IsOptional()
  @IsBoolean()
  landscapeOrientation?: boolean = false;
}