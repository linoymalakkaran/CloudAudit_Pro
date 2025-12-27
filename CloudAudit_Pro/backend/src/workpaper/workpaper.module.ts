import { Module } from '@nestjs/common';
import { WorkpaperController } from './workpaper.controller';
import { WorkpaperService } from './workpaper.service';
import { DatabaseModule } from '../database/database.module';

@Module({
  imports: [DatabaseModule],
  controllers: [WorkpaperController],
  providers: [WorkpaperService],
  exports: [WorkpaperService],
})
export class WorkpaperModule {}
