import { PartialType } from '@nestjs/swagger';
import { CreateInternalControlDto } from './create-internal-control.dto';

export class UpdateInternalControlDto extends PartialType(CreateInternalControlDto) {}
