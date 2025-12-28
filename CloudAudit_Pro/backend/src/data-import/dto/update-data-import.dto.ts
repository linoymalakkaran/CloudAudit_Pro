import { PartialType } from '@nestjs/swagger';
import { CreateDataImportDto } from './create-data-import.dto';

export class UpdateDataImportDto extends PartialType(CreateDataImportDto) {}
