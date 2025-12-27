import { Module } from '@nestjs/common';
import { TrialBalanceController } from './trial-balance.controller';
import { TrialBalanceService } from './trial-balance.service';
import { DatabaseModule } from '../database/database.module';
import { LedgerModule } from '../ledger/ledger.module';

@Module({
  imports: [DatabaseModule, LedgerModule],
  controllers: [TrialBalanceController],
  providers: [TrialBalanceService],
  exports: [TrialBalanceService],
})
export class TrialBalanceModule {}