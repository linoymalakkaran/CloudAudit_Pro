import { Module } from '@nestjs/common';
import { FinancialStatementController } from './financial-statement.controller';
import { FinancialStatementService } from './financial-statement.service';
import { DatabaseModule } from '../database/database.module';
import { LedgerModule } from '../ledger/ledger.module';
import { TrialBalanceModule } from '../trial-balance/trial-balance.module';

@Module({
  imports: [DatabaseModule, LedgerModule, TrialBalanceModule],
  controllers: [FinancialStatementController],
  providers: [FinancialStatementService],
  exports: [FinancialStatementService],
})
export class FinancialStatementModule {}