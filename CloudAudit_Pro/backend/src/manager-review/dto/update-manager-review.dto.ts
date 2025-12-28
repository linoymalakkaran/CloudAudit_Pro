import { PartialType } from '@nestjs/swagger';
import { CreateManagerReviewDto } from './create-manager-review.dto';

export class UpdateManagerReviewDto extends PartialType(CreateManagerReviewDto) {}
