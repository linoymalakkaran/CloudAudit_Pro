import { IsNotEmpty, IsString, IsBoolean, IsOptional, MaxLength } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class CreateCountryDto {
  @ApiProperty({ description: 'Country name', example: 'United States' })
  @IsNotEmpty()
  @IsString()
  @MaxLength(100)
  name: string;

  @ApiProperty({ description: 'Country code (ISO 3166-1 alpha-2)', example: 'US' })
  @IsNotEmpty()
  @IsString()
  @MaxLength(2)
  code: string;

  @ApiProperty({ description: 'Phone code', example: '+1', required: false })
  @IsOptional()
  @IsString()
  @MaxLength(10)
  dialCode?: string;

  @ApiProperty({ description: 'Whether the country is active', default: true })
  @IsOptional()
  @IsBoolean()
  isActive?: boolean;
}
