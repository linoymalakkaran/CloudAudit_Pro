import { IsString, IsNumber, IsOptional, IsArray, ValidateNested, IsEnum, IsDecimal, IsDateString } from 'class-validator';
import { Type } from 'class-transformer';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export enum JournalEntryType {
  GENERAL = 'GENERAL',
  ADJUSTING = 'ADJUSTING',
  CLOSING = 'CLOSING',
  REVERSING = 'REVERSING',
  CORRECTING = 'CORRECTING',
}

export enum JournalEntryStatus {
  DRAFT = 'DRAFT',
  PENDING = 'PENDING',
  APPROVED = 'APPROVED',
  POSTED = 'POSTED',
  REJECTED = 'REJECTED',
}

export class CreateJournalLineItemDto {
  @ApiProperty({ description: 'Account ID for this line item' })
  @IsString()
  accountId: string;

  @ApiPropertyOptional({ description: 'Description for this line item' })
  @IsOptional()
  @IsString()
  description?: string;

  @ApiProperty({ description: 'Debit amount (use 0 if credit)', example: '100.00' })
  @IsDecimal({ decimal_digits: '2' })
  debitAmount: string;

  @ApiProperty({ description: 'Credit amount (use 0 if debit)', example: '100.00' })
  @IsDecimal({ decimal_digits: '2' })
  creditAmount: string;

  @ApiPropertyOptional({ description: 'Reference number or identifier' })
  @IsOptional()
  @IsString()
  reference?: string;
}

export class CreateJournalEntryDto {
  @ApiProperty({ description: 'Company ID' })
  @IsString()
  companyId: string;

  @ApiProperty({ description: 'Period ID' })
  @IsString()
  periodId: string;

  @ApiProperty({ description: 'Journal entry number' })
  @IsString()
  entryNumber: string;

  @ApiProperty({ description: 'Entry date in ISO format' })
  @IsDateString()
  entryDate: string;

  @ApiProperty({ description: 'Journal entry description' })
  @IsString()
  description: string;

  @ApiPropertyOptional({ description: 'Additional notes or explanation' })
  @IsOptional()
  @IsString()
  notes?: string;

  @ApiProperty({ enum: JournalEntryType, description: 'Type of journal entry' })
  @IsEnum(JournalEntryType)
  entryType: JournalEntryType;

  @ApiPropertyOptional({ description: 'Reference document ID' })
  @IsOptional()
  @IsString()
  referenceDocumentId?: string;

  @ApiPropertyOptional({ description: 'Reference number for external systems' })
  @IsOptional()
  @IsString()
  referenceNumber?: string;

  @ApiProperty({ type: [CreateJournalLineItemDto], description: 'Line items for this journal entry' })
  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => CreateJournalLineItemDto)
  lineItems: CreateJournalLineItemDto[];
}

export class UpdateJournalEntryDto {
  @ApiPropertyOptional({ description: 'Entry date in ISO format' })
  @IsOptional()
  @IsDateString()
  entryDate?: string;

  @ApiPropertyOptional({ description: 'Journal entry description' })
  @IsOptional()
  @IsString()
  description?: string;

  @ApiPropertyOptional({ description: 'Additional notes or explanation' })
  @IsOptional()
  @IsString()
  notes?: string;

  @ApiPropertyOptional({ enum: JournalEntryType, description: 'Type of journal entry' })
  @IsOptional()
  @IsEnum(JournalEntryType)
  entryType?: JournalEntryType;

  @ApiPropertyOptional({ description: 'Reference document ID' })
  @IsOptional()
  @IsString()
  referenceDocumentId?: string;

  @ApiPropertyOptional({ description: 'Reference number for external systems' })
  @IsOptional()
  @IsString()
  referenceNumber?: string;

  @ApiPropertyOptional({ type: [CreateJournalLineItemDto], description: 'Line items for this journal entry' })
  @IsOptional()
  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => CreateJournalLineItemDto)
  lineItems?: CreateJournalLineItemDto[];
}

export class JournalEntryFilterDto {
  @ApiPropertyOptional({ description: 'Company ID to filter by' })
  @IsOptional()
  @IsString()
  companyId?: string;

  @ApiPropertyOptional({ description: 'Period ID to filter by' })
  @IsOptional()
  @IsString()
  periodId?: string;

  @ApiPropertyOptional({ enum: JournalEntryType, description: 'Entry type to filter by' })
  @IsOptional()
  @IsEnum(JournalEntryType)
  entryType?: JournalEntryType;

  @ApiPropertyOptional({ enum: JournalEntryStatus, description: 'Status to filter by' })
  @IsOptional()
  @IsEnum(JournalEntryStatus)
  status?: JournalEntryStatus;

  @ApiPropertyOptional({ description: 'Start date for date range filter' })
  @IsOptional()
  @IsDateString()
  startDate?: string;

  @ApiPropertyOptional({ description: 'End date for date range filter' })
  @IsOptional()
  @IsDateString()
  endDate?: string;

  @ApiPropertyOptional({ description: 'Account ID to filter by' })
  @IsOptional()
  @IsString()
  accountId?: string;

  @ApiPropertyOptional({ description: 'Search term for description or notes' })
  @IsOptional()
  @IsString()
  search?: string;

  @ApiPropertyOptional({ description: 'Page number for pagination', minimum: 1, default: 1 })
  @IsOptional()
  @IsNumber()
  @Type(() => Number)
  page?: number = 1;

  @ApiPropertyOptional({ description: 'Items per page for pagination', minimum: 1, maximum: 100, default: 20 })
  @IsOptional()
  @IsNumber()
  @Type(() => Number)
  limit?: number = 20;

  @ApiPropertyOptional({ description: 'Sort field', default: 'entryDate' })
  @IsOptional()
  @IsString()
  sortBy?: string = 'entryDate';

  @ApiPropertyOptional({ description: 'Sort order', enum: ['asc', 'desc'], default: 'desc' })
  @IsOptional()
  @IsString()
  sortOrder?: 'asc' | 'desc' = 'desc';
}

export class JournalEntryApprovalDto {
  @ApiPropertyOptional({ description: 'Approval notes' })
  @IsOptional()
  @IsString()
  notes?: string;
}

export class JournalEntryReviewDto {
  @ApiProperty({ description: 'Review notes' })
  @IsString()
  reviewNotes: string;

  @ApiProperty({ description: 'Whether to approve or reject', enum: ['approve', 'reject'] })
  @IsEnum(['approve', 'reject'])
  action: 'approve' | 'reject';
}