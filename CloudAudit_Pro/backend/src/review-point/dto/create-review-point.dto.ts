import { IsNotEmpty, IsString, IsOptional, IsEnum, IsDateString, MaxLength } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';
import { ReviewPointStatus } from '@prisma/client';

export enum ReviewCategory {
  AUDIT_FINDING = 'AUDIT_FINDING',
  CLIENT_QUERY = 'CLIENT_QUERY',
  TECHNICAL_ISSUE = 'TECHNICAL_ISSUE',
  DOCUMENTATION = 'DOCUMENTATION',
  COMPLIANCE = 'COMPLIANCE',
  OTHER = 'OTHER',
}

export enum ReviewPriority {
  LOW = 'LOW',
  MEDIUM = 'MEDIUM',
  HIGH = 'HIGH',
  URGENT = 'URGENT',
}

export class CreateReviewPointDto {
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

  @ApiProperty({ description: 'Review point title' })
  @IsNotEmpty()
  @IsString()
  @MaxLength(500)
  title: string;

  @ApiProperty({ description: 'Detailed description' })
  @IsNotEmpty()
  @IsString()
  description: string;

  @ApiProperty({ description: 'Review category', enum: ReviewCategory })
  @IsNotEmpty()
  @IsEnum(ReviewCategory)
  category: ReviewCategory;

  @ApiProperty({ description: 'Priority level', enum: ReviewPriority })
  @IsNotEmpty()
  @IsEnum(ReviewPriority)
  priority: ReviewPriority;

  @ApiProperty({ description: 'Status', enum: ReviewPointStatus, required: false })
  @IsOptional()
  @IsEnum(ReviewPointStatus)
  status?: ReviewPointStatus;

  @ApiProperty({ description: 'Assigned to user ID', required: false })
  @IsOptional()
  @IsString()
  assignedTo?: string;

  @ApiProperty({ description: 'Due date', required: false })
  @IsOptional()
  @IsDateString()
  dueDate?: string;

  @ApiProperty({ description: 'Target date', required: false })
  @IsOptional()
  @IsDateString()
  targetDate?: string;

  @ApiProperty({ description: 'Response text', required: false })
  @IsOptional()
  @IsString()
  response?: string;

  @ApiProperty({ description: 'Clearance notes', required: false })
  @IsOptional()
  @IsString()
  clearanceNotes?: string;

  @ApiProperty({ description: 'Impact assessment', required: false })
  @IsOptional()
  @IsString()
  impact?: string;

  @ApiProperty({ description: 'Related review point IDs', type: [String], required: false })
  @IsOptional()
  relatedReviewIds?: string[];
}
