import { IsString, IsOptional, IsDateString, IsEnum, IsArray, IsBoolean } from 'class-validator';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export enum DashboardType {
  EXECUTIVE = 'EXECUTIVE',
  FINANCIAL = 'FINANCIAL',
  AUDIT = 'AUDIT',
  OPERATIONAL = 'OPERATIONAL',
  COMPLIANCE = 'COMPLIANCE',
  CUSTOM = 'CUSTOM'
}

export enum MetricType {
  COUNTER = 'COUNTER',
  PERCENTAGE = 'PERCENTAGE',
  CURRENCY = 'CURRENCY',
  RATIO = 'RATIO',
  TREND = 'TREND',
  STATUS = 'STATUS'
}

export enum Timeframe {
  TODAY = 'TODAY',
  THIS_WEEK = 'THIS_WEEK',
  THIS_MONTH = 'THIS_MONTH',
  THIS_QUARTER = 'THIS_QUARTER',
  THIS_YEAR = 'THIS_YEAR',
  LAST_30_DAYS = 'LAST_30_DAYS',
  LAST_90_DAYS = 'LAST_90_DAYS',
  CUSTOM = 'CUSTOM'
}

export enum ChartType {
  LINE = 'LINE',
  BAR = 'BAR',
  PIE = 'PIE',
  DOUGHNUT = 'DOUGHNUT',
  AREA = 'AREA',
  GAUGE = 'GAUGE',
  HEATMAP = 'HEATMAP'
}

export class DashboardFilterDto {
  @ApiPropertyOptional({ description: 'Company ID for filtering' })
  @IsOptional()
  @IsString()
  companyId?: string;

  @ApiPropertyOptional({ description: 'Period ID for filtering' })
  @IsOptional()
  @IsString()
  periodId?: string;

  @ApiPropertyOptional({ description: 'Timeframe for metrics', enum: Timeframe })
  @IsOptional()
  @IsEnum(Timeframe)
  timeframe?: Timeframe;

  @ApiPropertyOptional({ description: 'Custom start date for filtering' })
  @IsOptional()
  @IsDateString()
  startDate?: string;

  @ApiPropertyOptional({ description: 'Custom end date for filtering' })
  @IsOptional()
  @IsDateString()
  endDate?: string;

  @ApiPropertyOptional({ description: 'Specific departments to include' })
  @IsOptional()
  @IsArray()
  @IsString({ each: true })
  departments?: string[];

  @ApiPropertyOptional({ description: 'Include comparative data' })
  @IsOptional()
  @IsBoolean()
  includeComparative?: boolean;

  @ApiPropertyOptional({ description: 'Refresh frequency in seconds' })
  @IsOptional()
  refreshInterval?: number;
}

export class MetricDefinitionDto {
  @ApiProperty({ description: 'Metric identifier' })
  @IsString()
  id: string;

  @ApiProperty({ description: 'Metric name' })
  @IsString()
  name: string;

  @ApiProperty({ description: 'Metric description' })
  @IsString()
  description: string;

  @ApiProperty({ description: 'Metric type', enum: MetricType })
  @IsEnum(MetricType)
  type: MetricType;

  @ApiPropertyOptional({ description: 'Target/benchmark value' })
  @IsOptional()
  target?: number;

  @ApiPropertyOptional({ description: 'Unit of measurement' })
  @IsOptional()
  @IsString()
  unit?: string;

  @ApiPropertyOptional({ description: 'Format pattern for display' })
  @IsOptional()
  @IsString()
  formatPattern?: string;
}

export class ChartConfigDto {
  @ApiProperty({ description: 'Chart identifier' })
  @IsString()
  id: string;

  @ApiProperty({ description: 'Chart title' })
  @IsString()
  title: string;

  @ApiProperty({ description: 'Chart type', enum: ChartType })
  @IsEnum(ChartType)
  type: ChartType;

  @ApiProperty({ description: 'Data source query or metric IDs' })
  @IsArray()
  @IsString({ each: true })
  dataSource: string[];

  @ApiPropertyOptional({ description: 'Chart configuration options' })
  @IsOptional()
  options?: any;

  @ApiPropertyOptional({ description: 'Chart position and size' })
  @IsOptional()
  layout?: {
    x: number;
    y: number;
    width: number;
    height: number;
  };
}

export class DashboardConfigDto {
  @ApiProperty({ description: 'Dashboard name' })
  @IsString()
  name: string;

  @ApiProperty({ description: 'Dashboard type', enum: DashboardType })
  @IsEnum(DashboardType)
  type: DashboardType;

  @ApiPropertyOptional({ description: 'Dashboard description' })
  @IsOptional()
  @IsString()
  description?: string;

  @ApiPropertyOptional({ description: 'Metrics to display' })
  @IsOptional()
  @IsArray()
  metrics?: MetricDefinitionDto[];

  @ApiPropertyOptional({ description: 'Charts to display' })
  @IsOptional()
  @IsArray()
  charts?: ChartConfigDto[];

  @ApiPropertyOptional({ description: 'Default filters' })
  @IsOptional()
  defaultFilters?: DashboardFilterDto;

  @ApiPropertyOptional({ description: 'Auto-refresh interval in seconds' })
  @IsOptional()
  refreshInterval?: number;

  @ApiPropertyOptional({ description: 'Dashboard layout configuration' })
  @IsOptional()
  layoutConfig?: any;
}

export class KPIDto {
  @ApiProperty({ description: 'KPI identifier' })
  @IsString()
  id: string;

  @ApiProperty({ description: 'KPI name' })
  @IsString()
  name: string;

  @ApiProperty({ description: 'Current value' })
  value: number;

  @ApiPropertyOptional({ description: 'Previous period value' })
  @IsOptional()
  previousValue?: number;

  @ApiPropertyOptional({ description: 'Target value' })
  @IsOptional()
  target?: number;

  @ApiPropertyOptional({ description: 'Percentage change from previous period' })
  @IsOptional()
  change?: number;

  @ApiPropertyOptional({ description: 'Trend direction' })
  @IsOptional()
  @IsEnum(['UP', 'DOWN', 'STABLE'])
  trend?: 'UP' | 'DOWN' | 'STABLE';

  @ApiPropertyOptional({ description: 'Performance status' })
  @IsOptional()
  @IsEnum(['GOOD', 'WARNING', 'CRITICAL'])
  status?: 'GOOD' | 'WARNING' | 'CRITICAL';

  @ApiPropertyOptional({ description: 'Unit of measurement' })
  @IsOptional()
  @IsString()
  unit?: string;

  @ApiPropertyOptional({ description: 'Format pattern' })
  @IsOptional()
  @IsString()
  format?: string;
}

export class AlertDto {
  @ApiProperty({ description: 'Alert identifier' })
  @IsString()
  id: string;

  @ApiProperty({ description: 'Alert title' })
  @IsString()
  title: string;

  @ApiProperty({ description: 'Alert message' })
  @IsString()
  message: string;

  @ApiProperty({ description: 'Alert severity' })
  @IsEnum(['INFO', 'WARNING', 'ERROR', 'CRITICAL'])
  severity: 'INFO' | 'WARNING' | 'ERROR' | 'CRITICAL';

  @ApiProperty({ description: 'Alert category' })
  @IsString()
  category: string;

  @ApiProperty({ description: 'Alert creation time' })
  createdAt: Date;

  @ApiPropertyOptional({ description: 'Alert acknowledgment status' })
  @IsOptional()
  @IsBoolean()
  acknowledged?: boolean;

  @ApiPropertyOptional({ description: 'Related entity ID' })
  @IsOptional()
  @IsString()
  entityId?: string;

  @ApiPropertyOptional({ description: 'Related entity type' })
  @IsOptional()
  @IsString()
  entityType?: string;

  @ApiPropertyOptional({ description: 'Action required' })
  @IsOptional()
  @IsString()
  actionRequired?: string;
}