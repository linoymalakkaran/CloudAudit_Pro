import { PartialType } from '@nestjs/swagger';
import { CreateAuditFinalizationDto } from './create-audit-finalization.dto';

export class UpdateAuditFinalizationDto extends PartialType(CreateAuditFinalizationDto) {}
