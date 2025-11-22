import { IsString, IsOptional, IsEnum, IsDateString, IsBoolean, IsNumber, IsArray, ValidateNested } from 'class-validator';
import { Type } from 'class-transformer';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export enum ProcedureType {
  ANALYTICAL = 'ANALYTICAL',
  SUBSTANTIVE = 'SUBSTANTIVE',
  CONTROL_TEST = 'CONTROL_TEST',
  WALK_THROUGH = 'WALK_THROUGH',
  INQUIRY = 'INQUIRY',
  OBSERVATION = 'OBSERVATION',
  INSPECTION = 'INSPECTION',
  RECALCULATION = 'RECALCULATION',
  CONFIRMATION = 'CONFIRMATION',
}

export enum ProcedureStatus {
  NOT_STARTED = 'NOT_STARTED',
  IN_PROGRESS = 'IN_PROGRESS',
  COMPLETED = 'COMPLETED',
  ON_HOLD = 'ON_HOLD',
  CANCELLED = 'CANCELLED',
  REVIEW_REQUIRED = 'REVIEW_REQUIRED',
}

export enum RiskLevel {
  LOW = 'LOW',
  MEDIUM = 'MEDIUM',
  HIGH = 'HIGH',
  CRITICAL = 'CRITICAL',
}

export enum AuditAssertions {
  EXISTENCE = 'EXISTENCE',
  COMPLETENESS = 'COMPLETENESS',
  VALUATION = 'VALUATION',
  RIGHTS_OBLIGATIONS = 'RIGHTS_OBLIGATIONS',
  PRESENTATION = 'PRESENTATION',
  OCCURRENCE = 'OCCURRENCE',
  ACCURACY = 'ACCURACY',
  CUT_OFF = 'CUT_OFF',
  CLASSIFICATION = 'CLASSIFICATION',
}

export class CreateProcedureStepDto {
  @ApiProperty({ description: 'Step description' })
  @IsString()
  description: string;

  @ApiPropertyOptional({ description: 'Step instructions' })
  @IsOptional()
  @IsString()
  instructions?: string;

  @ApiProperty({ description: 'Step order in the procedure' })
  @IsNumber()
  stepOrder: number;

  @ApiPropertyOptional({ description: 'Expected completion time in hours' })
  @IsOptional()
  @IsNumber()
  estimatedHours?: number;

  @ApiPropertyOptional({ description: 'Is this step mandatory' })
  @IsOptional()
  @IsBoolean()
  isMandatory?: boolean = true;

  @ApiPropertyOptional({ description: 'Required evidence type' })
  @IsOptional()
  @IsString()
  requiredEvidence?: string;
}

export class CreateAuditProcedureDto {
  @ApiProperty({ description: 'Company ID' })
  @IsString()
  companyId: string;

  @ApiProperty({ description: 'Period ID' })
  @IsString()
  periodId: string;

  @ApiPropertyOptional({ description: 'Template ID if based on template' })
  @IsOptional()
  @IsString()
  templateId?: string;

  @ApiPropertyOptional({ description: 'Account ID if procedure is account-specific' })
  @IsOptional()
  @IsString()
  accountId?: string;

  @ApiProperty({ description: 'Procedure name' })
  @IsString()
  name: string;

  @ApiProperty({ description: 'Procedure description' })
  @IsString()
  description: string;

  @ApiProperty({ 
    enum: ProcedureType,
    description: 'Type of audit procedure' 
  })
  @IsEnum(ProcedureType)
  procedureType: ProcedureType;

  @ApiProperty({ 
    enum: RiskLevel,
    description: 'Risk level of the area being audited' 
  })
  @IsEnum(RiskLevel)
  riskLevel: RiskLevel;

  @ApiProperty({ 
    enum: AuditAssertions,
    isArray: true,
    description: 'Audit assertions being tested' 
  })
  @IsArray()
  @IsEnum(AuditAssertions, { each: true })
  assertions: AuditAssertions[];

  @ApiPropertyOptional({ description: 'Assigned auditor ID' })
  @IsOptional()
  @IsString()
  assignedTo?: string;

  @ApiPropertyOptional({ description: 'Due date for completion' })
  @IsOptional()
  @IsDateString()
  dueDate?: string;

  @ApiPropertyOptional({ description: 'Estimated hours for completion' })
  @IsOptional()
  @IsNumber()
  estimatedHours?: number;

  @ApiPropertyOptional({ description: 'Procedure objectives' })
  @IsOptional()
  @IsString()
  objectives?: string;

  @ApiPropertyOptional({ description: 'Sample size if applicable' })
  @IsOptional()
  @IsNumber()
  sampleSize?: number;

  @ApiPropertyOptional({ description: 'Population size if applicable' })
  @IsOptional()
  @IsNumber()
  populationSize?: number;

  @ApiPropertyOptional({ description: 'Procedure steps', type: [CreateProcedureStepDto] })
  @IsOptional()
  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => CreateProcedureStepDto)
  steps?: CreateProcedureStepDto[];
}

export class UpdateAuditProcedureDto {
  @ApiPropertyOptional({ description: 'Procedure name' })
  @IsOptional()
  @IsString()
  name?: string;

  @ApiPropertyOptional({ description: 'Procedure description' })
  @IsOptional()
  @IsString()
  description?: string;

  @ApiPropertyOptional({ 
    enum: ProcedureStatus,
    description: 'Procedure status' 
  })
  @IsOptional()
  @IsEnum(ProcedureStatus)
  status?: ProcedureStatus;

  @ApiPropertyOptional({ description: 'Assigned auditor ID' })
  @IsOptional()
  @IsString()
  assignedTo?: string;

  @ApiPropertyOptional({ description: 'Due date for completion' })
  @IsOptional()
  @IsDateString()
  dueDate?: string;

  @ApiPropertyOptional({ description: 'Completion percentage (0-100)' })
  @IsOptional()
  @IsNumber()
  completionPercentage?: number;

  @ApiPropertyOptional({ description: 'Actual hours spent' })
  @IsOptional()
  @IsNumber()
  actualHours?: number;

  @ApiPropertyOptional({ description: 'Work performed notes' })
  @IsOptional()
  @IsString()
  workPerformed?: string;

  @ApiPropertyOptional({ description: 'Findings or exceptions' })
  @IsOptional()
  @IsString()
  findings?: string;

  @ApiPropertyOptional({ description: 'Conclusion reached' })
  @IsOptional()
  @IsString()
  conclusion?: string;
}

export class ProcedureFilterDto {
  @ApiPropertyOptional({ description: 'Company ID to filter by' })
  @IsOptional()
  @IsString()
  companyId?: string;

  @ApiPropertyOptional({ description: 'Period ID to filter by' })
  @IsOptional()
  @IsString()
  periodId?: string;

  @ApiPropertyOptional({ 
    enum: ProcedureType,
    description: 'Procedure type to filter by' 
  })
  @IsOptional()
  @IsEnum(ProcedureType)
  procedureType?: ProcedureType;

  @ApiPropertyOptional({ 
    enum: ProcedureStatus,
    description: 'Status to filter by' 
  })
  @IsOptional()
  @IsEnum(ProcedureStatus)
  status?: ProcedureStatus;

  @ApiPropertyOptional({ 
    enum: RiskLevel,
    description: 'Risk level to filter by' 
  })
  @IsOptional()
  @IsEnum(RiskLevel)
  riskLevel?: RiskLevel;

  @ApiPropertyOptional({ description: 'Assigned auditor ID' })
  @IsOptional()
  @IsString()
  assignedTo?: string;

  @ApiPropertyOptional({ description: 'Account ID to filter by' })
  @IsOptional()
  @IsString()
  accountId?: string;

  @ApiPropertyOptional({ description: 'Due date from' })
  @IsOptional()
  @IsDateString()
  dueDateFrom?: string;

  @ApiPropertyOptional({ description: 'Due date to' })
  @IsOptional()
  @IsDateString()
  dueDateTo?: string;

  @ApiPropertyOptional({ description: 'Search term' })
  @IsOptional()
  @IsString()
  search?: string;

  @ApiPropertyOptional({ description: 'Page number', minimum: 1, default: 1 })
  @IsOptional()
  @IsNumber()
  @Type(() => Number)
  page?: number = 1;

  @ApiPropertyOptional({ description: 'Items per page', minimum: 1, maximum: 100, default: 20 })
  @IsOptional()
  @IsNumber()
  @Type(() => Number)
  limit?: number = 20;

  @ApiPropertyOptional({ description: 'Sort field', default: 'dueDate' })
  @IsOptional()
  @IsString()
  sortBy?: string = 'dueDate';

  @ApiPropertyOptional({ description: 'Sort order', enum: ['asc', 'desc'], default: 'asc' })
  @IsOptional()
  @IsString()
  sortOrder?: 'asc' | 'desc' = 'asc';
}

export class ProcedureReviewDto {
  @ApiProperty({ description: 'Review notes' })
  @IsString()
  reviewNotes: string;

  @ApiProperty({ description: 'Review action', enum: ['approve', 'reject', 'return'] })
  @IsEnum(['approve', 'reject', 'return'])
  action: 'approve' | 'reject' | 'return';

  @ApiPropertyOptional({ description: 'Additional comments' })
  @IsOptional()
  @IsString()
  comments?: string;
}

export class BulkAssignProceduresDto {
  @ApiProperty({ description: 'Procedure IDs to assign', type: [String] })
  @IsArray()
  @IsString({ each: true })
  procedureIds: string[];

  @ApiProperty({ description: 'Auditor ID to assign to' })
  @IsString()
  assignedTo: string;

  @ApiPropertyOptional({ description: 'New due date for all procedures' })
  @IsOptional()
  @IsDateString()
  dueDate?: string;
}