import { IsString, IsUUID, IsEnum, IsOptional } from 'class-validator';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export enum Severity {
  MINOR = 'MINOR',
  MODERATE = 'MODERATE',
  SIGNIFICANT = 'SIGNIFICANT',
  MATERIAL = 'MATERIAL',
  CRITICAL = 'CRITICAL',
}

export class CreateFindingDto {
  @ApiProperty()
  @IsUUID()
  procedureId: string;

  @ApiProperty()
  @IsUUID()
  companyId: string;

  @ApiProperty()
  @IsUUID()
  periodId: string;

  @ApiProperty()
  @IsString()
  title: string;

  @ApiProperty()
  @IsString()
  description: string;

  @ApiProperty({ enum: Severity })
  @IsEnum(Severity)
  severity: Severity;

  @ApiPropertyOptional()
  @IsOptional()
  @IsString()
  recommendation?: string;
}
