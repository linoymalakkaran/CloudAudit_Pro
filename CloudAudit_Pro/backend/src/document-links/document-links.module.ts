import { Module } from '@nestjs/common';
import { DocumentLinksService } from './document-links.service';
import { DocumentLinksController } from './document-links.controller';
import { DatabaseModule } from '../database/database.module';

@Module({
  imports: [DatabaseModule],
  controllers: [DocumentLinksController],
  providers: [DocumentLinksService],
  exports: [DocumentLinksService],
})
export class DocumentLinksModule {}
