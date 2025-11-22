import { Module } from '@nestjs/common';
import { ImportExportService } from './import-export.service';
import { ImportExportController } from './import-export.controller';
import { DatabaseModule } from '../database/database.module';

@Module({
  imports: [DatabaseModule],
  controllers: [ImportExportController],
  providers: [ImportExportService],
  exports: [ImportExportService],
})
export class ImportExportModule {}