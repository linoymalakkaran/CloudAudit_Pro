import { Module } from '@nestjs/common';
import { SubstantiveTestingService } from './substantive-testing.service';
import { SubstantiveTestingController } from './substantive-testing.controller';
import { DatabaseModule } from '../database/database.module';

@Module({
  imports: [DatabaseModule],
  controllers: [SubstantiveTestingController],
  providers: [SubstantiveTestingService],
  exports: [SubstantiveTestingService],
})
export class SubstantiveTestingModule {}
