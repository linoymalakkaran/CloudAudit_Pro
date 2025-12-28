import { Module } from '@nestjs/common';
import { LiabilityService } from './liability.service';
import { LiabilityController } from './liability.controller';
import { DatabaseModule } from '../database/database.module';

@Module({
  imports: [DatabaseModule],
  controllers: [LiabilityController],
  providers: [LiabilityService],
  exports: [LiabilityService],
})
export class LiabilityModule {}
