import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { IsNotEmpty, IsString, IsOptional, IsBoolean, IsEnum, IsObject, IsArray } from 'class-validator';
import { ScheduleFrequency } from '@prisma/client';

export class CreateScheduleDto {
  @ApiPropertyOptional({ description: 'Report ID (if using existing report)' })
  @IsOptional()
  @IsString()
  reportId?: string;

  @ApiPropertyOptional({ description: 'Report template ID (if using template)' })
  @IsOptional()
  @IsString()
  reportTemplateId?: string;

  @ApiProperty({ description: 'Company ID' })
  @IsNotEmpty()
  @IsString()
  companyId: string;

  @ApiPropertyOptional({ description: 'Period ID' })
  @IsOptional()
  @IsString()
  periodId?: string;

  @ApiProperty({ description: 'Schedule frequency', enum: ScheduleFrequency })
  @IsNotEmpty()
  @IsEnum(ScheduleFrequency)
  frequency: ScheduleFrequency;

  @ApiPropertyOptional({ description: 'Schedule time (HH:MM format)' })
  @IsOptional()
  @IsString()
  scheduleTime?: string;

  @ApiPropertyOptional({ description: 'Timezone', default: 'UTC' })
  @IsOptional()
  @IsString()
  timezone?: string;

  @ApiPropertyOptional({ description: 'Is active', default: true })
  @IsOptional()
  @IsBoolean()
  isActive?: boolean;

  @ApiPropertyOptional({ description: 'Report parameters' })
  @IsOptional()
  @IsObject()
  parameters?: any;

  @ApiPropertyOptional({ description: 'Report filters' })
  @IsOptional()
  @IsObject()
  filters?: any;

  @ApiPropertyOptional({ description: 'Email recipients' })
  @IsOptional()
  @IsArray()
  recipients?: string[];

  @ApiPropertyOptional({ description: 'Email subject' })
  @IsOptional()
  @IsString()
  emailSubject?: string;

  @ApiPropertyOptional({ description: 'Email body' })
  @IsOptional()
  @IsString()
  emailBody?: string;
}
