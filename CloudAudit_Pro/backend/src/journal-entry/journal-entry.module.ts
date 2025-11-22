import { Module } from '@nestjs/common';
import { JournalEntryController } from './journal-entry.controller';
import { JournalEntryService } from './journal-entry.service';
import { DatabaseModule } from '../database/database.module';

@Module({
  imports: [DatabaseModule],
  controllers: [JournalEntryController],
  providers: [JournalEntryService],
  exports: [JournalEntryService],
})
export class JournalEntryModule {}