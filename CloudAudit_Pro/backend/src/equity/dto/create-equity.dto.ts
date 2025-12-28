import { IsNotEmpty, IsString, IsNumber, IsDateString, IsOptional, IsBoolean } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class CreateEquityDto {
  @ApiProperty({ description: 'Company ID' })
  @IsNotEmpty()
  @IsString()
  companyId: string;

  @ApiProperty({ description: 'Period ID' })
  @IsNotEmpty()
  @IsString()
  periodId: string;

  @ApiProperty({ description: 'Equity type (e.g., Share Capital, Retained Earnings)' })
  @IsNotEmpty()
  @IsString()
  type: string;

  @ApiProperty({ description: 'Description' })
  @IsNotEmpty()
  @IsString()
  description: string;

  @ApiProperty({ description: 'Opening balance' })
  @IsNotEmpty()
  @IsNumber()
  openingBalance: number;

  @ApiProperty({ description: 'Additions during period' })
  @IsOptional()
  @IsNumber()
  additions?: number;

  @ApiProperty({ description: 'Reductions during period' })
  @IsOptional()
  @IsNumber()
  reductions?: number;

  @ApiProperty({ description: 'Closing balance' })
  @IsNotEmpty()
  @IsNumber()
  closingBalance: number;

  @ApiProperty({ description: 'Transaction date', required: false })
  @IsOptional()
  @IsDateString()
  transactionDate?: string;

  @ApiProperty({ description: 'Reference number', required: false })
  @IsOptional()
  @IsString()
  referenceNumber?: string;

  @ApiProperty({ description: 'Notes', required: false })
  @IsOptional()
  @IsString()
  notes?: string;

  @ApiProperty({ description: 'Is finished', default: false })
  @IsOptional()
  @IsBoolean()
  isFinished?: boolean;
}
