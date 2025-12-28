import { Module } from '@nestjs/common';
import { InternalControlsService } from './internal-controls.service';
import { InternalControlsController } from './internal-controls.controller';
import { DatabaseModule } from '../database/database.module';

@Module({
  imports: [DatabaseModule],
  controllers: [InternalControlsController],
  providers: [InternalControlsService],
  exports: [InternalControlsService],
})
export class InternalControlsModule {}
