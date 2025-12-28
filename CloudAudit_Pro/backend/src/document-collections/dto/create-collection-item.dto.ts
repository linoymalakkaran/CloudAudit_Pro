import { IsNotEmpty, IsString, IsOptional } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class CreateCollectionItemDto {
  @ApiProperty({ description: 'Document type' })
  @IsNotEmpty()
  @IsString()
  documentType: string;

  @ApiProperty({ description: 'Required document name/description' })
  @IsNotEmpty()
  @IsString()
  requiredDocument: string;

  @ApiProperty({ description: 'Notes', required: false })
  @IsOptional()
  @IsString()
  notes?: string;
}
