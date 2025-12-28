import { Module } from '@nestjs/common';
import { AuditFinalizationService } from './audit-finalization.service';
import { AuditFinalizationController } from './audit-finalization.controller';
import { DatabaseModule } from '../database/database.module';

@Module({
  imports: [DatabaseModule],
  controllers: [AuditFinalizationController],
  providers: [AuditFinalizationService],
  exports: [AuditFinalizationService],
})
export class AuditFinalizationModule {}
