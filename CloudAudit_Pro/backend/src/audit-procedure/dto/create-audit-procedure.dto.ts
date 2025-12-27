import { IsString, IsEnum, IsOptional, IsDateString, IsNumber, IsUUID } from 'class-validator';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export enum ProcedureCategory {
  CASH_AND_BANK = 'CASH_AND_BANK',
  ACCOUNTS_RECEIVABLE = 'ACCOUNTS_RECEIVABLE',
  INVENTORY = 'INVENTORY',
  FIXED_ASSETS = 'FIXED_ASSETS',
  ACCOUNTS_PAYABLE = 'ACCOUNTS_PAYABLE',
  REVENUE = 'REVENUE',
  EXPENSES = 'EXPENSES',
  EQUITY = 'EQUITY',
  ANALYTICAL_PROCEDURES = 'ANALYTICAL_PROCEDURES',
  INTERNAL_CONTROLS = 'INTERNAL_CONTROLS',
  COMPLIANCE = 'COMPLIANCE',
  SUBSTANTIVE_TESTING = 'SUBSTANTIVE_TESTING',
  OTHER = 'OTHER',
}

export enum RiskLevel {
  LOW = 'LOW',
  MEDIUM = 'MEDIUM',
  HIGH = 'HIGH',
  CRITICAL = 'CRITICAL',
}

export enum Priority {
  LOW = 'LOW',
  MEDIUM = 'MEDIUM',
  HIGH = 'HIGH',
  URGENT = 'URGENT',
}

export class CreateAuditProcedureDto {
  @ApiProperty()
  @IsUUID()
  companyId: string;

  @ApiProperty()
  @IsUUID()
  periodId: string;

  @ApiPropertyOptional()
  @IsOptional()
  @IsUUID()
  templateId?: string;

  @ApiProperty()
  @IsString()
  name: string;

  @ApiPropertyOptional()
  @IsOptional()
  @IsString()
  description?: string;

  @ApiProperty({ enum: ProcedureCategory })
  @IsEnum(ProcedureCategory)
  category: ProcedureCategory;

  @ApiProperty({ enum: RiskLevel })
  @IsEnum(RiskLevel)
  riskLevel: RiskLevel;

  @ApiProperty({ enum: Priority, default: Priority.MEDIUM })
  @IsEnum(Priority)
  @IsOptional()
  priority?: Priority;

  @ApiPropertyOptional()
  @IsOptional()
  @IsUUID()
  assignedToId?: string;

  @ApiPropertyOptional()
  @IsOptional()
  @IsDateString()
  dueDate?: string;
}
