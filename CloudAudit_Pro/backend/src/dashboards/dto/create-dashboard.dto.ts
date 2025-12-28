import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import {
  IsNotEmpty,
  IsString,
  IsOptional,
  IsBoolean,
  IsArray,
  IsObject,
  ValidateNested,
} from 'class-validator';
import { Type } from 'class-transformer';

export class WidgetConfigDto {
  @ApiProperty({ description: 'Widget type' })
  @IsNotEmpty()
  @IsString()
  type: string;

  @ApiProperty({ description: 'Widget title' })
  @IsNotEmpty()
  @IsString()
  title: string;

  @ApiPropertyOptional({ description: 'Widget size configuration' })
  @IsOptional()
  @IsObject()
  size?: { width: number; height: number };

  @ApiPropertyOptional({ description: 'Widget position' })
  @IsOptional()
  @IsObject()
  position?: { x: number; y: number };

  @ApiPropertyOptional({ description: 'Widget data source configuration' })
  @IsOptional()
  @IsObject()
  dataSource?: any;

  @ApiPropertyOptional({ description: 'Widget visualization settings' })
  @IsOptional()
  @IsObject()
  settings?: any;
}

export class CreateDashboardDto {
  @ApiProperty({ description: 'Dashboard name' })
  @IsNotEmpty()
  @IsString()
  name: string;

  @ApiPropertyOptional({ description: 'Dashboard description' })
  @IsOptional()
  @IsString()
  description?: string;

  @ApiPropertyOptional({ description: 'Company ID (for company-specific dashboard)' })
  @IsOptional()
  @IsString()
  companyId?: string;

  @ApiPropertyOptional({ description: 'Period ID (for period-specific dashboard)' })
  @IsOptional()
  @IsString()
  periodId?: string;

  @ApiPropertyOptional({ description: 'Layout configuration' })
  @IsOptional()
  @IsObject()
  layout?: any;

  @ApiPropertyOptional({ description: 'Widget configurations', type: [WidgetConfigDto] })
  @IsOptional()
  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => WidgetConfigDto)
  widgets?: WidgetConfigDto[];

  @ApiPropertyOptional({ description: 'User IDs to share dashboard with' })
  @IsOptional()
  @IsArray()
  sharedWith?: string[];

  @ApiPropertyOptional({ description: 'Is dashboard public', default: false })
  @IsOptional()
  @IsBoolean()
  isPublic?: boolean;

  @ApiPropertyOptional({ description: 'Is default dashboard', default: false })
  @IsOptional()
  @IsBoolean()
  isDefault?: boolean;
}
