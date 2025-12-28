import { IsString, IsEnum, IsOptional, IsObject } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';
import { ExportType } from '@prisma/client';

export class CreateDataExportDto {
  @ApiProperty({ description: 'Company ID' })
  @IsString()
  companyId: string;

  @ApiProperty({ enum: ExportType, description: 'Type of export' })
  @IsEnum(ExportType)
  exportType: ExportType;

  @ApiProperty({ required: false, description: 'Filter criteria' })
  @IsOptional()
  @IsObject()
  filters?: any;

  @ApiProperty({ required: false, description: 'Export options' })
  @IsOptional()
  @IsObject()
  options?: any;
}
