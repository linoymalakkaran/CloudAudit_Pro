import { Module } from '@nestjs/common';
import { FinancialStatementsService } from './financial-statements.service';
import { FinancialStatementsController } from './financial-statements.controller';
import { DatabaseModule } from '../database/database.module';

@Module({
  imports: [DatabaseModule],
  controllers: [FinancialStatementsController],
  providers: [FinancialStatementsService],
  exports: [FinancialStatementsService],
})
export class FinancialStatementsModule {}
