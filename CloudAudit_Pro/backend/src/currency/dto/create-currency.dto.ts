import { IsString, IsInt, IsBoolean, IsOptional, MinLength, MaxLength, Min } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class CreateCurrencyDto {
  @ApiProperty({ example: 'USD', description: 'Currency code (ISO 4217)' })
  @IsString()
  @MinLength(3)
  @MaxLength(3)
  code: string;

  @ApiProperty({ example: 'US Dollar', description: 'Currency name' })
  @IsString()
  @MinLength(1)
  @MaxLength(100)
  name: string;

  @ApiProperty({ example: '$', description: 'Currency symbol', required: false })
  @IsOptional()
  @IsString()
  @MaxLength(5)
  symbol?: string;

  @ApiProperty({ example: 2, description: 'Number of decimal places', default: 2 })
  @IsOptional()
  @IsInt()
  @Min(0)
  decimalPlaces?: number;

  @ApiProperty({ example: true, description: 'Whether currency is active', default: true })
  @IsOptional()
  @IsBoolean()
  isActive?: boolean;

  @ApiProperty({ example: false, description: 'Whether this is the base currency', default: false })
  @IsOptional()
  @IsBoolean()
  isBaseCurrency?: boolean;

  @ApiProperty({ example: 1, description: 'Display order', required: false })
  @IsOptional()
  @IsInt()
  @Min(0)
  displayOrder?: number;

  @ApiProperty({ example: 'Primary currency for transactions', description: 'Currency description', required: false })
  @IsOptional()
  @IsString()
  @MaxLength(500)
  description?: string;
}
