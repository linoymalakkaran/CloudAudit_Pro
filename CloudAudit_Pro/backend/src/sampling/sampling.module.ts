import { Module } from '@nestjs/common';
import { SamplingService } from './sampling.service';
import { SamplingController } from './sampling.controller';
import { DatabaseModule } from '../database/database.module';

@Module({
  imports: [DatabaseModule],
  controllers: [SamplingController],
  providers: [SamplingService],
  exports: [SamplingService],
})
export class SamplingModule {}
