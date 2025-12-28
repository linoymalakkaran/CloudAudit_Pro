import { IsNotEmpty, IsString, IsOptional, IsEnum, IsNumber, IsBoolean, IsDateString } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export enum TestType {
  VOUCHING = 'VOUCHING',
  TRACING = 'TRACING',
  RECALCULATION = 'RECALCULATION',
  CONFIRMATION = 'CONFIRMATION',
  OBSERVATION = 'OBSERVATION',
  INSPECTION = 'INSPECTION',
  ANALYTICAL_PROCEDURE = 'ANALYTICAL_PROCEDURE',
  REPERFORMANCE = 'REPERFORMANCE',
}

export enum TestStatus {
  PLANNED = 'PLANNED',
  IN_PROGRESS = 'IN_PROGRESS',
  COMPLETED = 'COMPLETED',
  REVIEWED = 'REVIEWED',
  EXCEPTION_NOTED = 'EXCEPTION_NOTED',
}

export enum ExceptionSeverity {
  LOW = 'LOW',
  MEDIUM = 'MEDIUM',
  HIGH = 'HIGH',
  CRITICAL = 'CRITICAL',
}

export class CreateSubstantiveTestDto {
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

  @ApiProperty({ description: 'Sampling ID', required: false })
  @IsOptional()
  @IsString()
  samplingId?: string;

  @ApiProperty({ description: 'Test title' })
  @IsNotEmpty()
  @IsString()
  title: string;

  @ApiProperty({ description: 'Test description', required: false })
  @IsOptional()
  @IsString()
  description?: string;

  @ApiProperty({ description: 'Test type', enum: TestType })
  @IsNotEmpty()
  @IsEnum(TestType)
  testType: TestType;

  @ApiProperty({ description: 'Status', enum: TestStatus, required: false })
  @IsOptional()
  @IsEnum(TestStatus)
  status?: TestStatus;

  @ApiProperty({ description: 'Transaction reference', required: false })
  @IsOptional()
  @IsString()
  transactionReference?: string;

  @ApiProperty({ description: 'Transaction date', required: false })
  @IsOptional()
  @IsDateString()
  transactionDate?: Date;

  @ApiProperty({ description: 'Transaction amount', required: false })
  @IsOptional()
  @IsNumber()
  transactionAmount?: number;

  @ApiProperty({ description: 'Source document', required: false })
  @IsOptional()
  @IsString()
  sourceDocument?: string;

  @ApiProperty({ description: 'Expected result', required: false })
  @IsOptional()
  @IsString()
  expectedResult?: string;

  @ApiProperty({ description: 'Actual result', required: false })
  @IsOptional()
  @IsString()
  actualResult?: string;

  @ApiProperty({ description: 'Test procedures performed', required: false })
  @IsOptional()
  @IsString()
  proceduresPerformed?: string;

  @ApiProperty({ description: 'Has exception', default: false })
  @IsOptional()
  @IsBoolean()
  hasException?: boolean;

  @ApiProperty({ description: 'Exception description', required: false })
  @IsOptional()
  @IsString()
  exceptionDescription?: string;

  @ApiProperty({ description: 'Exception severity', enum: ExceptionSeverity, required: false })
  @IsOptional()
  @IsEnum(ExceptionSeverity)
  exceptionSeverity?: ExceptionSeverity;

  @ApiProperty({ description: 'Exception amount', required: false })
  @IsOptional()
  @IsNumber()
  exceptionAmount?: number;

  @ApiProperty({ description: 'Management response', required: false })
  @IsOptional()
  @IsString()
  managementResponse?: string;

  @ApiProperty({ description: 'Conclusion', required: false })
  @IsOptional()
  @IsString()
  conclusion?: string;

  @ApiProperty({ description: 'Performed by', required: false })
  @IsOptional()
  @IsString()
  performedBy?: string;

  @ApiProperty({ description: 'Test date', required: false })
  @IsOptional()
  @IsDateString()
  testDate?: Date;

  @ApiProperty({ description: 'Reviewed by', required: false })
  @IsOptional()
  @IsString()
  reviewedBy?: string;

  @ApiProperty({ description: 'Review date', required: false })
  @IsOptional()
  @IsDateString()
  reviewDate?: Date;
}
