import { IsString, IsOptional, IsEnum, IsUUID, IsInt, Min, Max } from 'class-validator';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export enum DocumentType {
  FINANCIAL_STATEMENT = 'FINANCIAL_STATEMENT',
  TRIAL_BALANCE = 'TRIAL_BALANCE',
  GENERAL_LEDGER = 'GENERAL_LEDGER',
  BANK_STATEMENT = 'BANK_STATEMENT',
  INVOICE = 'INVOICE',
  RECEIPT = 'RECEIPT',
  CONTRACT = 'CONTRACT',
  CORRESPONDENCE = 'CORRESPONDENCE',
  WORKING_PAPER = 'WORKING_PAPER',
  MANAGEMENT_LETTER = 'MANAGEMENT_LETTER',
  OTHER = 'OTHER'
}

export enum DocumentStatus {
  PENDING = 'PENDING',
  REVIEWED = 'REVIEWED',
  APPROVED = 'APPROVED',
  REJECTED = 'REJECTED'
}

export class CreateDocumentDto {
  @ApiProperty({ description: 'Document name' })
  @IsString()
  name: string;

  @ApiPropertyOptional({ description: 'Document description' })
  @IsOptional()
  @IsString()
  description?: string;

  @ApiProperty({ enum: DocumentType, description: 'Type of document' })
  @IsEnum(DocumentType)
  type: DocumentType;

  @ApiProperty({ description: 'Company ID this document belongs to' })
  @IsUUID()
  companyId: string;

  @ApiPropertyOptional({ description: 'Period ID if document is period-specific' })
  @IsOptional()
  @IsUUID()
  periodId?: string;

  @ApiPropertyOptional({ description: 'Account ID if document is account-specific' })
  @IsOptional()
  @IsUUID()
  accountId?: string;

  @ApiPropertyOptional({ description: 'Tags for document categorization' })
  @IsOptional()
  @IsString({ each: true })
  tags?: string[];
}

export class UpdateDocumentDto {
  @ApiPropertyOptional({ description: 'Document name' })
  @IsOptional()
  @IsString()
  name?: string;

  @ApiPropertyOptional({ description: 'Document description' })
  @IsOptional()
  @IsString()
  description?: string;

  @ApiProperty({ enum: DocumentType, description: 'Type of document' })
  @IsOptional()
  @IsEnum(DocumentType)
  type?: DocumentType;

  @ApiPropertyOptional({ enum: DocumentStatus, description: 'Document status' })
  @IsOptional()
  @IsEnum(DocumentStatus)
  status?: DocumentStatus;

  @ApiPropertyOptional({ description: 'Tags for document categorization' })
  @IsOptional()
  @IsString({ each: true })
  tags?: string[];

  @ApiPropertyOptional({ description: 'Review notes' })
  @IsOptional()
  @IsString()
  reviewNotes?: string;
}

export class DocumentQueryDto {
  @ApiPropertyOptional({ description: 'Company ID to filter documents' })
  @IsOptional()
  @IsUUID()
  companyId?: string;

  @ApiPropertyOptional({ description: 'Period ID to filter documents' })
  @IsOptional()
  @IsUUID()
  periodId?: string;

  @ApiPropertyOptional({ description: 'Account ID to filter documents' })
  @IsOptional()
  @IsUUID()
  accountId?: string;

  @ApiPropertyOptional({ enum: DocumentType, description: 'Document type filter' })
  @IsOptional()
  @IsEnum(DocumentType)
  type?: DocumentType;

  @ApiPropertyOptional({ enum: DocumentStatus, description: 'Document status filter' })
  @IsOptional()
  @IsEnum(DocumentStatus)
  status?: DocumentStatus;

  @ApiPropertyOptional({ description: 'Search query for name/description' })
  @IsOptional()
  @IsString()
  search?: string;

  @ApiPropertyOptional({ description: 'Tags to filter by' })
  @IsOptional()
  @IsString({ each: true })
  tags?: string[];

  @ApiPropertyOptional({ description: 'Page number (1-based)', minimum: 1 })
  @IsOptional()
  @IsInt()
  @Min(1)
  page?: number = 1;

  @ApiPropertyOptional({ description: 'Items per page', minimum: 1, maximum: 100 })
  @IsOptional()
  @IsInt()
  @Min(1)
  @Max(100)
  limit?: number = 20;
}