import { IsString, IsNotEmpty, IsEnum, IsBoolean, IsOptional, IsJSON } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';
import { ConfigCategory } from '@prisma/client';

export class CreateConfigDto {
  @ApiProperty({ description: 'Configuration key (unique identifier)' })
  @IsString()
  @IsNotEmpty()
  configKey: string;

  @ApiProperty({ description: 'Configuration value (JSON format)' })
  @IsNotEmpty()
  configValue: any;

  @ApiProperty({ enum: ConfigCategory, description: 'Configuration category' })
  @IsEnum(ConfigCategory)
  @IsNotEmpty()
  category: ConfigCategory;

  @ApiProperty({ description: 'Description of the configuration', required: false })
  @IsString()
  @IsOptional()
  description?: string;

  @ApiProperty({ description: 'Data type of the value', default: 'string' })
  @IsString()
  @IsOptional()
  dataType?: string;

  @ApiProperty({ description: 'Whether the value should be encrypted', default: false })
  @IsBoolean()
  @IsOptional()
  isEncrypted?: boolean;
}
