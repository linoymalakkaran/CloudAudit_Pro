import { Module } from '@nestjs/common';
import { ProcedureTemplateController } from './procedure-template.controller';
import { ProcedureTemplateService } from './procedure-template.service';
import { DatabaseModule } from '../database/database.module';

@Module({
  imports: [DatabaseModule],
  controllers: [ProcedureTemplateController],
  providers: [ProcedureTemplateService],
  exports: [ProcedureTemplateService],
})
export class ProcedureTemplateModule {}
