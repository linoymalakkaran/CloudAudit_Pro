import { Module } from '@nestjs/common';
import { ReviewPointService } from './review-point.service';
import { ReviewPointController } from './review-point.controller';
import { DatabaseModule } from '../database/database.module';

@Module({
  imports: [DatabaseModule],
  controllers: [ReviewPointController],
  providers: [ReviewPointService],
  exports: [ReviewPointService],
})
export class ReviewPointModule {}
