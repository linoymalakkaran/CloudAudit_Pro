import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { IsNotEmpty, IsString, IsOptional, IsBoolean, IsEnum, IsObject } from 'class-validator';
import { ReportType, ReportCategory } from '@prisma/client';

export class CreateTemplateDto {
  @ApiProperty({ description: 'Template name' })
  @IsNotEmpty()
  @IsString()
  name: string;

  @ApiPropertyOptional({ description: 'Template description' })
  @IsOptional()
  @IsString()
  description?: string;

  @ApiProperty({ description: 'Report type', enum: ReportType })
  @IsNotEmpty()
  @IsEnum(ReportType)
  reportType: ReportType;

  @ApiProperty({ description: 'Report category', enum: ReportCategory })
  @IsNotEmpty()
  @IsEnum(ReportCategory)
  category: ReportCategory;

  @ApiPropertyOptional({ description: 'Is standard template', default: false })
  @IsOptional()
  @IsBoolean()
  isStandard?: boolean;

  @ApiPropertyOptional({ description: 'Is active', default: true })
  @IsOptional()
  @IsBoolean()
  isActive?: boolean;

  @ApiPropertyOptional({ description: 'Template definition (report structure)' })
  @IsOptional()
  @IsObject()
  templateDefinition?: any;

  @ApiPropertyOptional({ description: 'Data source configuration' })
  @IsOptional()
  @IsObject()
  dataSource?: any;

  @ApiPropertyOptional({ description: 'Formatting and styling' })
  @IsOptional()
  @IsObject()
  formatting?: any;

  @ApiPropertyOptional({ description: 'Template parameters' })
  @IsOptional()
  @IsObject()
  parameters?: any;
}
