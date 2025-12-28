import { Module } from '@nestjs/common';
import { DocumentCollectionsService } from './document-collections.service';
import { DocumentCollectionsController } from './document-collections.controller';
import { DatabaseModule } from '../database/database.module';

@Module({
  imports: [DatabaseModule],
  controllers: [DocumentCollectionsController],
  providers: [DocumentCollectionsService],
  exports: [DocumentCollectionsService],
})
export class DocumentCollectionsModule {}
