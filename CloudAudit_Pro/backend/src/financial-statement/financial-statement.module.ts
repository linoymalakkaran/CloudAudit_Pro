import { Module } from '@nestjs/common';
import { FinancialStatementController } from './financial-statement.controller';
import { FinancialStatementService } from './financial-statement.service';
import { DatabaseModule } from '../database/database.module';

@Module({
  imports: [DatabaseModule],
  controllers: [FinancialStatementController],
  providers: [FinancialStatementService],
  exports: [FinancialStatementService],
})
export class FinancialStatementModule {}