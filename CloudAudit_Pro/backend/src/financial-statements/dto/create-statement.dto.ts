import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { IsNotEmpty, IsString, IsOptional, IsEnum, IsObject, IsNumber, IsArray } from 'class-validator';
import { StatementType } from '@prisma/client';

export class CreateStatementDto {
  @ApiProperty({ description: 'Company ID' })
  @IsNotEmpty()
  @IsString()
  companyId: string;

  @ApiProperty({ description: 'Period ID' })
  @IsNotEmpty()
  @IsString()
  periodId: string;

  @ApiProperty({ description: 'Statement type', enum: StatementType })
  @IsNotEmpty()
  @IsEnum(StatementType)
  statementType: StatementType;

  @ApiProperty({ description: 'Statement date' })
  @IsNotEmpty()
  statementDate: Date;

  @ApiPropertyOptional({ description: 'Statement period description' })
  @IsOptional()
  @IsString()
  statementPeriod?: string;

  @ApiPropertyOptional({ description: 'Currency code', default: 'USD' })
  @IsOptional()
  @IsString()
  currency?: string;

  @ApiPropertyOptional({ description: 'Currency conversion rate', default: 1.0 })
  @IsOptional()
  @IsNumber()
  conversionRate?: number;

  @ApiPropertyOptional({ description: 'Statement data' })
  @IsOptional()
  @IsObject()
  data?: any;

  @ApiPropertyOptional({ description: 'Statement notes' })
  @IsOptional()
  @IsArray()
  notes?: any[];
}
