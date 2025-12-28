import { IsNotEmpty, IsString, IsBoolean, IsOptional, MaxLength, IsEnum } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';
import { BankAccountType } from '@prisma/client';

export class CreateBankAccountDto {
  @ApiProperty({ description: 'Company ID' })
  @IsNotEmpty()
  @IsString()
  companyId: string;

  @ApiProperty({ description: 'Bank ID' })
  @IsNotEmpty()
  @IsString()
  bankId: string;

  @ApiProperty({ description: 'Account name', example: 'Operating Account' })
  @IsNotEmpty()
  @IsString()
  @MaxLength(200)
  accountName: string;

  @ApiProperty({ description: 'Account number', example: '1234567890' })
  @IsNotEmpty()
  @IsString()
  @MaxLength(100)
  accountNumber: string;

  @ApiProperty({ description: 'Account type', enum: BankAccountType })
  @IsNotEmpty()
  @IsEnum(BankAccountType)
  accountType: BankAccountType;

  @ApiProperty({ description: 'Branch name', required: false })
  @IsOptional()
  @IsString()
  branchName?: string;

  @ApiProperty({ description: 'Branch code', required: false })
  @IsOptional()
  @IsString()
  branchCode?: string;

  @ApiProperty({ description: 'IBAN number', required: false })
  @IsOptional()
  @IsString()
  iban?: string;

  @ApiProperty({ description: 'Whether the account is active', default: true })
  @IsOptional()
  @IsBoolean()
  isActive?: boolean;
}
