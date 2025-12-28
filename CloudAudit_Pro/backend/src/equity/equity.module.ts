import { Module } from '@nestjs/common';
import { EquityService } from './equity.service';
import { EquityController } from './equity.controller';
import { DatabaseModule } from '../database/database.module';

@Module({
  imports: [DatabaseModule],
  controllers: [EquityController],
  providers: [EquityService],
  exports: [EquityService],
})
export class EquityModule {}
