import { IsNotEmpty, IsString, IsOptional, IsEnum, IsBoolean, IsDateString } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export enum ControlType {
  PREVENTIVE = 'PREVENTIVE',
  DETECTIVE = 'DETECTIVE',
  CORRECTIVE = 'CORRECTIVE',
  DIRECTIVE = 'DIRECTIVE',
}

export enum ControlNature {
  MANUAL = 'MANUAL',
  AUTOMATED = 'AUTOMATED',
  IT_DEPENDENT_MANUAL = 'IT_DEPENDENT_MANUAL',
}

export enum ControlFrequency {
  CONTINUOUS = 'CONTINUOUS',
  DAILY = 'DAILY',
  WEEKLY = 'WEEKLY',
  MONTHLY = 'MONTHLY',
  QUARTERLY = 'QUARTERLY',
  ANNUALLY = 'ANNUALLY',
  AD_HOC = 'AD_HOC',
}

export enum ControlEffectiveness {
  EFFECTIVE = 'EFFECTIVE',
  PARTIALLY_EFFECTIVE = 'PARTIALLY_EFFECTIVE',
  INEFFECTIVE = 'INEFFECTIVE',
  NOT_TESTED = 'NOT_TESTED',
}

export enum RiskLevel {
  LOW = 'LOW',
  MEDIUM = 'MEDIUM',
  HIGH = 'HIGH',
  CRITICAL = 'CRITICAL',
}

export class CreateInternalControlDto {
  @ApiProperty({ description: 'Company ID' })
  @IsNotEmpty()
  @IsString()
  companyId: string;

  @ApiProperty({ description: 'Period ID' })
  @IsNotEmpty()
  @IsString()
  periodId: string;

  @ApiProperty({ description: 'Process/Area name' })
  @IsNotEmpty()
  @IsString()
  processArea: string;

  @ApiProperty({ description: 'Control ID/Reference' })
  @IsNotEmpty()
  @IsString()
  controlId: string;

  @ApiProperty({ description: 'Control title' })
  @IsNotEmpty()
  @IsString()
  title: string;

  @ApiProperty({ description: 'Control description' })
  @IsNotEmpty()
  @IsString()
  description: string;

  @ApiProperty({ description: 'Control objective', required: false })
  @IsOptional()
  @IsString()
  controlObjective?: string;

  @ApiProperty({ description: 'Control type', enum: ControlType })
  @IsNotEmpty()
  @IsEnum(ControlType)
  controlType: ControlType;

  @ApiProperty({ description: 'Control nature', enum: ControlNature })
  @IsNotEmpty()
  @IsEnum(ControlNature)
  controlNature: ControlNature;

  @ApiProperty({ description: 'Control frequency', enum: ControlFrequency })
  @IsNotEmpty()
  @IsEnum(ControlFrequency)
  controlFrequency: ControlFrequency;

  @ApiProperty({ description: 'Risk addressed', required: false })
  @IsOptional()
  @IsString()
  riskAddressed?: string;

  @ApiProperty({ description: 'Risk level', enum: RiskLevel, required: false })
  @IsOptional()
  @IsEnum(RiskLevel)
  riskLevel?: RiskLevel;

  @ApiProperty({ description: 'Control owner', required: false })
  @IsOptional()
  @IsString()
  controlOwner?: string;

  @ApiProperty({ description: 'Is key control', default: false })
  @IsOptional()
  @IsBoolean()
  isKeyControl?: boolean;

  @ApiProperty({ description: 'Test procedures', required: false })
  @IsOptional()
  @IsString()
  testProcedures?: string;

  @ApiProperty({ description: 'Test result', required: false })
  @IsOptional()
  @IsString()
  testResult?: string;

  @ApiProperty({ description: 'Control effectiveness', enum: ControlEffectiveness, required: false })
  @IsOptional()
  @IsEnum(ControlEffectiveness)
  controlEffectiveness?: ControlEffectiveness;

  @ApiProperty({ description: 'Deficiency identified', default: false })
  @IsOptional()
  @IsBoolean()
  deficiencyIdentified?: boolean;

  @ApiProperty({ description: 'Deficiency description', required: false })
  @IsOptional()
  @IsString()
  deficiencyDescription?: string;

  @ApiProperty({ description: 'Remediation plan', required: false })
  @IsOptional()
  @IsString()
  remediationPlan?: string;

  @ApiProperty({ description: 'Remediation deadline', required: false })
  @IsOptional()
  @IsDateString()
  remediationDeadline?: Date;

  @ApiProperty({ description: 'Management response', required: false })
  @IsOptional()
  @IsString()
  managementResponse?: string;

  @ApiProperty({ description: 'Test performed by', required: false })
  @IsOptional()
  @IsString()
  testPerformedBy?: string;

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

  @ApiProperty({ description: 'Evidence/Documentation', required: false })
  @IsOptional()
  @IsString()
  evidence?: string;

  @ApiProperty({ description: 'Conclusion', required: false })
  @IsOptional()
  @IsString()
  conclusion?: string;
}
