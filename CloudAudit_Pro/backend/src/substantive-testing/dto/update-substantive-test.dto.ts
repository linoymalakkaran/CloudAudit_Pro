import { PartialType } from '@nestjs/swagger';
import { CreateSubstantiveTestDto } from './create-substantive-test.dto';

export class UpdateSubstantiveTestDto extends PartialType(CreateSubstantiveTestDto) {}
