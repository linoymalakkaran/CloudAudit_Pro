import { IsNotEmpty, IsString, IsOptional, IsEnum, IsDateString, IsBoolean } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export enum ReviewLevel {
  MANAGER = 'MANAGER',
  PARTNER = 'PARTNER',
  QUALITY_CONTROL = 'QUALITY_CONTROL',
}

export enum ManagerReviewStatus {
  NOT_STARTED = 'NOT_STARTED',
  IN_PROGRESS = 'IN_PROGRESS',
  COMPLETED = 'COMPLETED',
  APPROVED = 'APPROVED',
  REJECTED = 'REJECTED',
  REQUIRES_CHANGES = 'REQUIRES_CHANGES',
}

export class CreateManagerReviewDto {
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

  @ApiProperty({ description: 'Review level', enum: ReviewLevel })
  @IsNotEmpty()
  @IsEnum(ReviewLevel)
  reviewLevel: ReviewLevel;

  @ApiProperty({ description: 'Review status', enum: ManagerReviewStatus, required: false })
  @IsOptional()
  @IsEnum(ManagerReviewStatus)
  status?: ManagerReviewStatus;

  @ApiProperty({ description: 'Reviewer user ID' })
  @IsNotEmpty()
  @IsString()
  reviewerId: string;

  @ApiProperty({ description: 'Review title' })
  @IsNotEmpty()
  @IsString()
  title: string;

  @ApiProperty({ description: 'Review comments', required: false })
  @IsOptional()
  @IsString()
  comments?: string;

  @ApiProperty({ description: 'Review findings', required: false })
  @IsOptional()
  @IsString()
  findings?: string;

  @ApiProperty({ description: 'Recommendations', required: false })
  @IsOptional()
  @IsString()
  recommendations?: string;

  @ApiProperty({ description: 'Due date', required: false })
  @IsOptional()
  @IsDateString()
  dueDate?: string;

  @ApiProperty({ description: 'Completed date', required: false })
  @IsOptional()
  @IsDateString()
  completedAt?: string;

  @ApiProperty({ description: 'Is signed off', default: false })
  @IsOptional()
  @IsBoolean()
  isSignedOff?: boolean;

  @ApiProperty({ description: 'Sign off notes', required: false })
  @IsOptional()
  @IsString()
  signOffNotes?: string;
}
