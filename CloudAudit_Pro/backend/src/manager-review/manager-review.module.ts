import { Module } from '@nestjs/common';
import { ManagerReviewService } from './manager-review.service';
import { ManagerReviewController } from './manager-review.controller';
import { DatabaseModule } from '../database/database.module';

@Module({
  imports: [DatabaseModule],
  controllers: [ManagerReviewController],
  providers: [ManagerReviewService],
  exports: [ManagerReviewService],
})
export class ManagerReviewModule {}
