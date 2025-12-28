import { Module } from '@nestjs/common';
import { ReportSchedulesService } from './report-schedules.service';
import { ReportSchedulesController } from './report-schedules.controller';
import { DatabaseModule } from '../database/database.module';

@Module({
  imports: [DatabaseModule],
  controllers: [ReportSchedulesController],
  providers: [ReportSchedulesService],
  exports: [ReportSchedulesService],
})
export class ReportSchedulesModule {}
