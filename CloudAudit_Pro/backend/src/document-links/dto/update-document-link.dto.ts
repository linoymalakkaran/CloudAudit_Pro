import { PartialType } from '@nestjs/swagger';
import { CreateDocumentLinkDto } from './create-document-link.dto';

export class UpdateDocumentLinkDto extends PartialType(CreateDocumentLinkDto) {}
