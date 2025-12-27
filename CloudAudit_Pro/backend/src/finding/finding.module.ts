import { Module } from '@nestjs/common';
import { FindingController } from './finding.controller';
import { FindingService } from './finding.service';
import { DatabaseModule } from '../database/database.module';

@Module({
  imports: [DatabaseModule],
  controllers: [FindingController],
  providers: [FindingService],
  exports: [FindingService],
})
export class FindingModule {}
