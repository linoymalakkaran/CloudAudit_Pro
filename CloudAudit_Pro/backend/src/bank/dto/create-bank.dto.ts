import { IsNotEmpty, IsString, IsBoolean, IsOptional, MaxLength, IsEnum } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';
import { BankType } from '@prisma/client';

export class CreateBankDto {
  @ApiProperty({ description: 'Bank name', example: 'Chase Bank' })
  @IsNotEmpty()
  @IsString()
  @MaxLength(200)
  name: string;

  @ApiProperty({ description: 'Bank code', example: 'CHASE01', required: false })
  @IsOptional()
  @IsString()
  @MaxLength(50)
  code?: string;

  @ApiProperty({ description: 'SWIFT code', example: 'CHASUS33', required: false })
  @IsOptional()
  @IsString()
  @MaxLength(50)
  swiftCode?: string;

  @ApiProperty({ description: 'Bank type', enum: BankType })
  @IsOptional()
  @IsEnum(BankType)
  bankType?: BankType;

  @ApiProperty({ description: 'Country ID', required: false })
  @IsOptional()
  @IsString()
  countryId?: string;

  @ApiProperty({ description: 'Currency ID', required: false })
  @IsOptional()
  @IsString()
  currencyId?: string;

  @ApiProperty({ description: 'Contact phone', required: false })
  @IsOptional()
  @IsString()
  phone?: string;

  @ApiProperty({ description: 'Email address', required: false })
  @IsOptional()
  @IsString()
  email?: string;

  @ApiProperty({ description: 'Website URL', required: false })
  @IsOptional()
  @IsString()
  website?: string;

  @ApiProperty({ description: 'Whether the bank is active', default: true })
  @IsOptional()
  @IsBoolean()
  isActive?: boolean;
}
