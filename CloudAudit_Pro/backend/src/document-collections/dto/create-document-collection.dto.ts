import { IsNotEmpty, IsString, IsEnum, IsOptional, IsDateString } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';
import { CollectionType } from '@prisma/client';

export class CreateDocumentCollectionDto {
  @ApiProperty({ description: 'Company ID' })
  @IsNotEmpty()
  @IsString()
  companyId: string;

  @ApiProperty({ description: 'Period ID', required: false })
  @IsOptional()
  @IsString()
  periodId?: string;

  @ApiProperty({ description: 'Collection name' })
  @IsNotEmpty()
  @IsString()
  name: string;

  @ApiProperty({ description: 'Collection description', required: false })
  @IsOptional()
  @IsString()
  description?: string;

  @ApiProperty({ enum: CollectionType, description: 'Collection type' })
  @IsNotEmpty()
  @IsEnum(CollectionType)
  collectionType: CollectionType;

  @ApiProperty({ description: 'Due date', required: false })
  @IsOptional()
  @IsDateString()
  dueDate?: string;

  @ApiProperty({ description: 'Assigned to user ID', required: false })
  @IsOptional()
  @IsString()
  assignedTo?: string;
}
