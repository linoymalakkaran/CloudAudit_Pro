import { IsString, IsEnum, IsOptional, IsNumber, IsObject } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';
import { ImportType } from '@prisma/client';

export class CreateDataImportDto {
  @ApiProperty({ description: 'Company ID' })
  @IsString()
  companyId: string;

  @ApiProperty({ enum: ImportType, description: 'Type of import' })
  @IsEnum(ImportType)
  importType: ImportType;

  @ApiProperty({ description: 'Original file name' })
  @IsString()
  fileName: string;

  @ApiProperty({ description: 'File path in storage' })
  @IsString()
  filePath: string;

  @ApiProperty({ description: 'File size in bytes' })
  @IsNumber()
  fileSize: number;

  @ApiProperty({ required: false, description: 'Field mapping configuration' })
  @IsOptional()
  @IsObject()
  mapping?: any;
}
