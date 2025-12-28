import { IsNotEmpty, IsString, IsOptional, IsEnum, IsDateString, IsBoolean, IsNumber } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export enum FinalizationStatus {
  DRAFT = 'DRAFT',
  IN_PROGRESS = 'IN_PROGRESS',
  REVIEW = 'REVIEW',
  APPROVED = 'APPROVED',
  FINALIZED = 'FINALIZED',
  ISSUED = 'ISSUED',
}

export enum OpinionType {
  UNQUALIFIED = 'UNQUALIFIED',
  QUALIFIED = 'QUALIFIED',
  ADVERSE = 'ADVERSE',
  DISCLAIMER = 'DISCLAIMER',
}

export class CreateAuditFinalizationDto {
  @ApiProperty({ description: 'Company ID' })
  @IsNotEmpty()
  @IsString()
  companyId: string;

  @ApiProperty({ description: 'Period ID' })
  @IsNotEmpty()
  @IsString()
  periodId: string;

  @ApiProperty({ description: 'Audit title' })
  @IsNotEmpty()
  @IsString()
  title: string;

  @ApiProperty({ description: 'Finalization status', enum: FinalizationStatus, required: false })
  @IsOptional()
  @IsEnum(FinalizationStatus)
  status?: FinalizationStatus;

  @ApiProperty({ description: 'Audit opinion type', enum: OpinionType, required: false })
  @IsOptional()
  @IsEnum(OpinionType)
  opinionType?: OpinionType;

  @ApiProperty({ description: 'Audit opinion text', required: false })
  @IsOptional()
  @IsString()
  opinionText?: string;

  @ApiProperty({ description: 'Executive summary', required: false })
  @IsOptional()
  @IsString()
  executiveSummary?: string;

  @ApiProperty({ description: 'Key findings', required: false })
  @IsOptional()
  @IsString()
  keyFindings?: string;

  @ApiProperty({ description: 'Recommendations', required: false })
  @IsOptional()
  @IsString()
  recommendations?: string;

  @ApiProperty({ description: 'Materiality threshold', required: false })
  @IsOptional()
  @IsNumber()
  materialityThreshold?: number;

  @ApiProperty({ description: 'Total procedures completed', required: false })
  @IsOptional()
  @IsNumber()
  totalProcedures?: number;

  @ApiProperty({ description: 'Procedures passed', required: false })
  @IsOptional()
  @IsNumber()
  proceduresPassed?: number;

  @ApiProperty({ description: 'Total findings', required: false })
  @IsOptional()
  @IsNumber()
  totalFindings?: number;

  @ApiProperty({ description: 'Open findings', required: false })
  @IsOptional()
  @IsNumber()
  openFindings?: number;

  @ApiProperty({ description: 'Audit start date', required: false })
  @IsOptional()
  @IsDateString()
  auditStartDate?: string;

  @ApiProperty({ description: 'Audit end date', required: false })
  @IsOptional()
  @IsDateString()
  auditEndDate?: string;

  @ApiProperty({ description: 'Report issue date', required: false })
  @IsOptional()
  @IsDateString()
  reportIssueDate?: string;

  @ApiProperty({ description: 'Partner approval required', default: true })
  @IsOptional()
  @IsBoolean()
  requiresPartnerApproval?: boolean;

  @ApiProperty({ description: 'Is finalized', default: false })
  @IsOptional()
  @IsBoolean()
  isFinalized?: boolean;

  @ApiProperty({ description: 'Finalized by user ID', required: false })
  @IsOptional()
  @IsString()
  finalizedBy?: string;

  @ApiProperty({ description: 'Finalized at date', required: false })
  @IsOptional()
  @IsDateString()
  finalizedAt?: string;

  @ApiProperty({ description: 'Notes', required: false })
  @IsOptional()
  @IsString()
  notes?: string;
}
