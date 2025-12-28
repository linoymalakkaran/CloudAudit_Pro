import { IsNotEmpty, IsString } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class UploadCollectionItemDto {
  @ApiProperty({ description: 'Document ID to associate with item' })
  @IsNotEmpty()
  @IsString()
  documentId: string;
}
