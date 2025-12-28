import { IsNotEmpty, IsString, IsOptional, IsEnum, IsNumber, IsBoolean, Min, Max } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export enum SamplingMethod {
  RANDOM = 'RANDOM',
  SYSTEMATIC = 'SYSTEMATIC',
  STRATIFIED = 'STRATIFIED',
  MONETARY_UNIT = 'MONETARY_UNIT',
  JUDGMENTAL = 'JUDGMENTAL',
  HAPHAZARD = 'HAPHAZARD',
}

export enum SamplingStatus {
  PLANNED = 'PLANNED',
  IN_PROGRESS = 'IN_PROGRESS',
  COMPLETED = 'COMPLETED',
  REVIEWED = 'REVIEWED',
}

export class CreateSamplingDto {
  @ApiProperty({ description: 'Company ID' })
  @IsNotEmpty()
  @IsString()
  companyId: string;

  @ApiProperty({ description: 'Period ID' })
  @IsNotEmpty()
  @IsString()
  periodId: string;

  @ApiProperty({ description: 'Procedure ID', required: false })
  @IsOptional()
  @IsString()
  procedureId?: string;

  @ApiProperty({ description: 'Account ID', required: false })
  @IsOptional()
  @IsString()
  accountId?: string;

  @ApiProperty({ description: 'Sampling title' })
  @IsNotEmpty()
  @IsString()
  title: string;

  @ApiProperty({ description: 'Sampling description', required: false })
  @IsOptional()
  @IsString()
  description?: string;

  @ApiProperty({ description: 'Sampling method', enum: SamplingMethod })
  @IsNotEmpty()
  @IsEnum(SamplingMethod)
  samplingMethod: SamplingMethod;

  @ApiProperty({ description: 'Status', enum: SamplingStatus, required: false })
  @IsOptional()
  @IsEnum(SamplingStatus)
  status?: SamplingStatus;

  @ApiProperty({ description: 'Population size' })
  @IsNotEmpty()
  @IsNumber()
  @Min(1)
  populationSize: number;

  @ApiProperty({ description: 'Sample size' })
  @IsNotEmpty()
  @IsNumber()
  @Min(1)
  sampleSize: number;

  @ApiProperty({ description: 'Confidence level (e.g., 95)', required: false })
  @IsOptional()
  @IsNumber()
  @Min(0)
  @Max(100)
  confidenceLevel?: number;

  @ApiProperty({ description: 'Tolerable error rate', required: false })
  @IsOptional()
  @IsNumber()
  @Min(0)
  @Max(100)
  tolerableError?: number;

  @ApiProperty({ description: 'Expected error rate', required: false })
  @IsOptional()
  @IsNumber()
  @Min(0)
  @Max(100)
  expectedError?: number;

  @ApiProperty({ description: 'Interval for systematic sampling', required: false })
  @IsOptional()
  @IsNumber()
  samplingInterval?: number;

  @ApiProperty({ description: 'Random seed', required: false })
  @IsOptional()
  @IsNumber()
  randomSeed?: number;

  @ApiProperty({ description: 'Selection criteria', required: false })
  @IsOptional()
  @IsString()
  selectionCriteria?: string;

  @ApiProperty({ description: 'Stratification basis', required: false })
  @IsOptional()
  @IsString()
  stratificationBasis?: string;

  @ApiProperty({ description: 'Number of errors found', required: false })
  @IsOptional()
  @IsNumber()
  @Min(0)
  errorsFound?: number;

  @ApiProperty({ description: 'Sample items tested', required: false })
  @IsOptional()
  @IsNumber()
  @Min(0)
  itemsTested?: number;

  @ApiProperty({ description: 'Conclusion', required: false })
  @IsOptional()
  @IsString()
  conclusion?: string;

  @ApiProperty({ description: 'Is projection required', default: false })
  @IsOptional()
  @IsBoolean()
  requiresProjection?: boolean;

  @ApiProperty({ description: 'Projected error amount', required: false })
  @IsOptional()
  @IsNumber()
  projectedError?: number;
}
