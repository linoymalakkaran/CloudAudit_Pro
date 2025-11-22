import { Module } from '@nestjs/common';
import { AuditProcedureController } from './audit-procedure.controller';
import { AuditProcedureService } from './audit-procedure.service';
import { DatabaseModule } from '../database/database.module';

@Module({
  imports: [DatabaseModule],
  controllers: [AuditProcedureController],
  providers: [AuditProcedureService],
  exports: [AuditProcedureService],
})
export class AuditProcedureModule {}