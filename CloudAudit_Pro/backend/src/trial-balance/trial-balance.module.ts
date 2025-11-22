import { Module } from '@nestjs/common';
import { TrialBalanceController } from './trial-balance.controller';
import { TrialBalanceService } from './trial-balance.service';
import { DatabaseModule } from '../database/database.module';

@Module({
  imports: [DatabaseModule],
  controllers: [TrialBalanceController],
  providers: [TrialBalanceService],
  exports: [TrialBalanceService],
})
export class TrialBalanceModule {}