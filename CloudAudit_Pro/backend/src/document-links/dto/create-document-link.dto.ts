import { IsNotEmpty, IsString, IsEnum, IsOptional } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';
import { LinkedEntityType, LinkType } from '@prisma/client';

export class CreateDocumentLinkDto {
  @ApiProperty({ description: 'Document ID', example: 'clxxx...' })
  @IsNotEmpty()
  @IsString()
  documentId: string;

  @ApiProperty({ enum: LinkedEntityType, description: 'Type of linked entity' })
  @IsNotEmpty()
  @IsEnum(LinkedEntityType)
  linkedEntityType: LinkedEntityType;

  @ApiProperty({ description: 'ID of the linked entity' })
  @IsNotEmpty()
  @IsString()
  linkedEntityId: string;

  @ApiProperty({ enum: LinkType, description: 'Type of link', required: false })
  @IsOptional()
  @IsEnum(LinkType)
  linkType?: LinkType;

  @ApiProperty({ description: 'Description of the link', required: false })
  @IsOptional()
  @IsString()
  linkDescription?: string;
}
