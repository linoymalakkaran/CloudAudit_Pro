import { IsNotEmpty, IsString, IsEnum, IsOptional, IsBoolean } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';
import { TemplateType } from '@prisma/client';

export class CreateDocumentTemplateDto {
  @ApiProperty({ description: 'Template name' })
  @IsNotEmpty()
  @IsString()
  name: string;

  @ApiProperty({ description: 'Template description', required: false })
  @IsOptional()
  @IsString()
  description?: string;

  @ApiProperty({ description: 'Template category' })
  @IsNotEmpty()
  @IsString()
  category: string;

  @ApiProperty({ enum: TemplateType, description: 'Template type' })
  @IsNotEmpty()
  @IsEnum(TemplateType)
  templateType: TemplateType;

  @ApiProperty({ description: 'Is template active', default: true })
  @IsOptional()
  @IsBoolean()
  isActive?: boolean;

  @ApiProperty({ description: 'Template fields definition (JSON)', required: false })
  @IsOptional()
  fields?: any;
}
