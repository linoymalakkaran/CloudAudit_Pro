import { IsNotEmpty, IsNumber, IsDateString, IsInt } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class CreateExchangeRateDto {
  @ApiProperty({ description: 'From currency ID' })
  @IsNotEmpty()
  @IsInt()
  fromCurrencyId: number;

  @ApiProperty({ description: 'To currency ID' })
  @IsNotEmpty()
  @IsInt()
  toCurrencyId: number;

  @ApiProperty({ description: 'Exchange rate', example: 1.23 })
  @IsNotEmpty()
  @IsNumber()
  rate: number;

  @ApiProperty({ description: 'Effective date', example: '2024-01-01' })
  @IsNotEmpty()
  @IsDateString()
  effectiveDate: string;
}
