import { PartialType } from '@nestjs/swagger';
import { CreateAuditProcedureDto } from './create-audit-procedure.dto';
import { IsString, IsEnum, IsOptional, IsNumber } from 'class-validator';
import { ApiPropertyOptional } from '@nestjs/swagger';

export enum ProcedureStatus {
  NOT_STARTED = 'NOT_STARTED',
  IN_PROGRESS = 'IN_PROGRESS',
  COMPLETED = 'COMPLETED',
  ON_HOLD = 'ON_HOLD',
  CANCELLED = 'CANCELLED',
}

export enum ReviewStatus {
  NOT_REVIEWED = 'NOT_REVIEWED',
  IN_REVIEW = 'IN_REVIEW',
  REVIEWED = 'REVIEWED',
  APPROVED = 'APPROVED',
  REJECTED = 'REJECTED',
  REQUIRES_CHANGES = 'REQUIRES_CHANGES',
}

export class UpdateAuditProcedureDto extends PartialType(CreateAuditProcedureDto) {
  @ApiPropertyOptional({ enum: ProcedureStatus })
  @IsOptional()
  @IsEnum(ProcedureStatus)
  status?: ProcedureStatus;

  @ApiPropertyOptional({ enum: ReviewStatus })
  @IsOptional()
  @IsEnum(ReviewStatus)
  reviewStatus?: ReviewStatus;

  @ApiPropertyOptional()
  @IsOptional()
  @IsNumber()
  actualHours?: number;

  @ApiPropertyOptional()
  @IsOptional()
  @IsString()
  reviewNotes?: string;
}
