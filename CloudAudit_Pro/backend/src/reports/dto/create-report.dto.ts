import { IsNotEmpty, IsString, IsEnum, IsOptional, IsBoolean, IsArray } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';
import { ReportType, ReportCategory, ScheduleFrequency } from '@prisma/client';

export class CreateReportDto {
  @ApiProperty({ description: 'Company ID' })
  @IsNotEmpty()
  @IsString()
  companyId: string;

  @ApiProperty({ description: 'Period ID', required: false })
  @IsOptional()
  @IsString()
  periodId?: string;

  @ApiProperty({ description: 'Report name' })
  @IsNotEmpty()
  @IsString()
  name: string;

  @ApiProperty({ description: 'Description', required: false })
  @IsOptional()
  @IsString()
  description?: string;

  @ApiProperty({ enum: ReportType, description: 'Report type' })
  @IsNotEmpty()
  @IsEnum(ReportType)
  reportType: ReportType;

  @ApiProperty({ enum: ReportCategory, description: 'Report category' })
  @IsNotEmpty()
  @IsEnum(ReportCategory)
  category: ReportCategory;

  @ApiProperty({ description: 'Template ID', required: false })
  @IsOptional()
  @IsString()
  templateId?: string;

  @ApiProperty({ description: 'Report parameters', required: false })
  @IsOptional()
  parameters?: any;

  @ApiProperty({ description: 'Report filters', required: false })
  @IsOptional()
  filters?: any;

  @ApiProperty({ description: 'Schedule report', required: false })
  @IsOptional()
  @IsBoolean()
  isScheduled?: boolean;

  @ApiProperty({ enum: ScheduleFrequency, required: false })
  @IsOptional()
  @IsEnum(ScheduleFrequency)
  scheduleFrequency?: ScheduleFrequency;

  @ApiProperty({ description: 'Email recipients', required: false })
  @IsOptional()
  @IsArray()
  recipients?: string[];

  @ApiProperty({ description: 'Email on completion', required: false })
  @IsOptional()
  @IsBoolean()
  emailOnCompletion?: boolean;
}
