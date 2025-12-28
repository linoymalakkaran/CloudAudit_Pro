import { IsString, IsEnum, IsBoolean, IsOptional, IsObject } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';
import { IntegrationType } from '@prisma/client';

export class CreateIntegrationDto {
  @ApiProperty({ enum: IntegrationType, description: 'Type of integration' })
  @IsEnum(IntegrationType)
  integrationType: IntegrationType;

  @ApiProperty({ description: 'Integration name' })
  @IsString()
  name: string;

  @ApiProperty({ required: false, description: 'Integration description' })
  @IsOptional()
  @IsString()
  description?: string;

  @ApiProperty({ description: 'Integration configuration (API keys, endpoints, etc.)' })
  @IsObject()
  configuration: any;

  @ApiProperty({ required: false, description: 'Sync frequency in minutes' })
  @IsOptional()
  @IsString()
  syncFrequency?: string;

  @ApiProperty({ default: true, description: 'Is integration active' })
  @IsBoolean()
  isActive: boolean;
}
