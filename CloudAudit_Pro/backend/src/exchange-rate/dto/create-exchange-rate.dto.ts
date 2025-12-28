import { IsString, IsNumber, IsDateString, IsOptional, IsBoolean, Min } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';
import { Type } from 'class-transformer';

export class CreateExchangeRateDto {
  @ApiProperty({ example: 'clxxxxx', description: 'Base currency ID' })
  @IsString()
  baseCurrencyId: string;

  @ApiProperty({ example: 'clyyyyy', description: 'Target currency ID' })
  @IsString()
  targetCurrencyId: string;

  @ApiProperty({ example: 1.2345, description: 'Exchange rate' })
  @IsNumber()
  @Min(0)
  @Type(() => Number)
  rate: number;

  @ApiProperty({ example: '2025-01-01', description: 'Effective date' })
  @IsDateString()
  effectiveDate: string;

  @ApiProperty({ example: '2025-12-31', description: 'Expiry date', required: false })
  @IsOptional()
  @IsDateString()
  expiryDate?: string;

  @ApiProperty({ example: 'Central Bank', description: 'Rate source', required: false })
  @IsOptional()
  @IsString()
  source?: string;

  @ApiProperty({ example: true, description: 'Whether rate is active', default: true })
  @IsOptional()
  @IsBoolean()
  isActive?: boolean;
}
