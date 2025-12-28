import { PartialType } from '@nestjs/swagger';
import { CreateReviewPointDto } from './create-review-point.dto';

export class UpdateReviewPointDto extends PartialType(CreateReviewPointDto) {}
