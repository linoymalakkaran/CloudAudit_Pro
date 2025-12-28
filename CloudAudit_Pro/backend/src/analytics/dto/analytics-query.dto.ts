import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { IsNotEmpty, IsString, IsOptional, IsEnum, IsArray, IsObject } from 'class-validator';

export enum AnalyticsMetric {
  REVENUE = 'REVENUE',
  EXPENSES = 'EXPENSES',
  PROFIT_MARGIN = 'PROFIT_MARGIN',
  LIQUIDITY_RATIO = 'LIQUIDITY_RATIO',
  DEBT_RATIO = 'DEBT_RATIO',
  ROA = 'ROA',
  ROE = 'ROE',
  CASH_FLOW = 'CASH_FLOW',
  AUDIT_COMPLETION = 'AUDIT_COMPLETION',
  DOCUMENT_COUNT = 'DOCUMENT_COUNT',
  FINDING_SEVERITY = 'FINDING_SEVERITY',
}

export enum AnalyticsTimeframe {
  DAY = 'DAY',
  WEEK = 'WEEK',
  MONTH = 'MONTH',
  QUARTER = 'QUARTER',
  YEAR = 'YEAR',
  CUSTOM = 'CUSTOM',
}

export class AnalyticsQueryDto {
  @ApiProperty({ description: 'Company ID' })
  @IsNotEmpty()
  @IsString()
  companyId: string;

  @ApiPropertyOptional({ description: 'Period ID' })
  @IsOptional()
  @IsString()
  periodId?: string;

  @ApiPropertyOptional({ description: 'Metrics to analyze', enum: AnalyticsMetric, isArray: true })
  @IsOptional()
  @IsArray()
  @IsEnum(AnalyticsMetric, { each: true })
  metrics?: AnalyticsMetric[];

  @ApiPropertyOptional({ description: 'Timeframe', enum: AnalyticsTimeframe })
  @IsOptional()
  @IsEnum(AnalyticsTimeframe)
  timeframe?: AnalyticsTimeframe;

  @ApiPropertyOptional({ description: 'Start date (for CUSTOM timeframe)' })
  @IsOptional()
  startDate?: Date;

  @ApiPropertyOptional({ description: 'End date (for CUSTOM timeframe)' })
  @IsOptional()
  endDate?: Date;

  @ApiPropertyOptional({ description: 'Additional filters' })
  @IsOptional()
  @IsObject()
  filters?: any;
}

export class CreateSnapshotDto {
  @ApiProperty({ description: 'Company ID' })
  @IsNotEmpty()
  @IsString()
  companyId: string;

  @ApiProperty({ description: 'Period ID' })
  @IsNotEmpty()
  @IsString()
  periodId: string;

  @ApiPropertyOptional({ description: 'Snapshot type', enum: ['DAILY', 'WEEKLY', 'MONTHLY', 'QUARTERLY', 'ANNUAL'] })
  @IsOptional()
  @IsEnum(['DAILY', 'WEEKLY', 'MONTHLY', 'QUARTERLY', 'ANNUAL'])
  snapshotType?: string;

  @ApiPropertyOptional({ description: 'Snapshot date' })
  @IsOptional()
  snapshotDate?: Date;
}
