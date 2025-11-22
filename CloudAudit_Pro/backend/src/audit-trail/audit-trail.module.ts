import { Module } from '@nestjs/common';
import { AuditTrailController } from './audit-trail.controller';
import { AuditTrailService } from './audit-trail.service';
import { DatabaseModule } from '../database/database.module';

@Module({
  imports: [DatabaseModule],
  controllers: [AuditTrailController],
  providers: [AuditTrailService],
  exports: [AuditTrailService],
})
export class AuditTrailModule {}