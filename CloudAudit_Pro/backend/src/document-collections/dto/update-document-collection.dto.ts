import { PartialType } from '@nestjs/swagger';
import { CreateDocumentCollectionDto } from './create-document-collection.dto';

export class UpdateDocumentCollectionDto extends PartialType(CreateDocumentCollectionDto) {}
