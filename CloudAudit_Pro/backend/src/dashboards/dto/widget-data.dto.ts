import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { IsNotEmpty, IsString, IsOptional, IsObject, IsEnum } from 'class-validator';

export enum WidgetDataPeriod {
  TODAY = 'TODAY',
  THIS_WEEK = 'THIS_WEEK',
  THIS_MONTH = 'THIS_MONTH',
  THIS_QUARTER = 'THIS_QUARTER',
  THIS_YEAR = 'THIS_YEAR',
  CUSTOM = 'CUSTOM',
}

export class WidgetDataRequestDto {
  @ApiProperty({ description: 'Widget type' })
  @IsNotEmpty()
  @IsString()
  widgetType: string;

  @ApiPropertyOptional({ description: 'Company ID' })
  @IsOptional()
  @IsString()
  companyId?: string;

  @ApiPropertyOptional({ description: 'Period ID' })
  @IsOptional()
  @IsString()
  periodId?: string;

  @ApiPropertyOptional({ description: 'Time period for data', enum: WidgetDataPeriod })
  @IsOptional()
  @IsEnum(WidgetDataPeriod)
  period?: WidgetDataPeriod;

  @ApiPropertyOptional({ description: 'Additional filters' })
  @IsOptional()
  @IsObject()
  filters?: any;

  @ApiPropertyOptional({ description: 'Widget-specific parameters' })
  @IsOptional()
  @IsObject()
  parameters?: any;
}
