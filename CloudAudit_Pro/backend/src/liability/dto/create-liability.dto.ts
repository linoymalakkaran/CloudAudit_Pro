import { IsNotEmpty, IsString, IsNumber, IsDateString, IsOptional, IsBoolean } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class CreateLiabilityDto {
  @ApiProperty({ description: 'Company ID' })
  @IsNotEmpty()
  @IsString()
  companyId: string;

  @ApiProperty({ description: 'Period ID' })
  @IsNotEmpty()
  @IsString()
  periodId: string;

  @ApiProperty({ description: 'Liability type (e.g., Loan, Accounts Payable)' })
  @IsNotEmpty()
  @IsString()
  type: string;

  @ApiProperty({ description: 'Creditor/Vendor name' })
  @IsNotEmpty()
  @IsString()
  creditorName: string;

  @ApiProperty({ description: 'Description' })
  @IsNotEmpty()
  @IsString()
  description: string;

  @ApiProperty({ description: 'Reference number', required: false })
  @IsOptional()
  @IsString()
  referenceNumber?: string;

  @ApiProperty({ description: 'Original amount' })
  @IsNotEmpty()
  @IsNumber()
  originalAmount: number;

  @ApiProperty({ description: 'Outstanding balance' })
  @IsNotEmpty()
  @IsNumber()
  outstandingBalance: number;

  @ApiProperty({ description: 'Due date' })
  @IsNotEmpty()
  @IsDateString()
  dueDate: string;

  @ApiProperty({ description: 'Interest rate', required: false })
  @IsOptional()
  @IsNumber()
  interestRate?: number;

  @ApiProperty({ description: 'Payment terms', required: false })
  @IsOptional()
  @IsString()
  paymentTerms?: string;

  @ApiProperty({ description: 'Collateral', required: false })
  @IsOptional()
  @IsString()
  collateral?: string;

  @ApiProperty({ description: 'Notes', required: false })
  @IsOptional()
  @IsString()
  notes?: string;

  @ApiProperty({ description: 'Is current liability', default: true })
  @IsOptional()
  @IsBoolean()
  isCurrent?: boolean;

  @ApiProperty({ description: 'Is finished', default: false })
  @IsOptional()
  @IsBoolean()
  isFinished?: boolean;
}
