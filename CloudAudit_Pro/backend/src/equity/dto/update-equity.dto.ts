import { PartialType } from '@nestjs/swagger';
import { CreateEquityDto } from './create-equity.dto';

export class UpdateEquityDto extends PartialType(CreateEquityDto) {}
