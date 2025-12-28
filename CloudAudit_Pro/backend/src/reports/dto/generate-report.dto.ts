import { IsNotEmpty, IsString, IsEnum, IsOptional } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';
import { ExportFormat } from '@prisma/client';

export class GenerateReportDto {
  @ApiProperty({ description: 'Company ID' })
  @IsNotEmpty()
  @IsString()
  companyId: string;

  @ApiProperty({ description: 'Period ID', required: false })
  @IsOptional()
  @IsString()
  periodId?: string;

  @ApiProperty({ description: 'Report parameters', required: false })
  @IsOptional()
  parameters?: any;

  @ApiProperty({ description: 'Report filters', required: false })
  @IsOptional()
  filters?: any;

  @ApiProperty({ enum: ExportFormat, required: false })
  @IsOptional()
  @IsEnum(ExportFormat)
  format?: ExportFormat;
}
