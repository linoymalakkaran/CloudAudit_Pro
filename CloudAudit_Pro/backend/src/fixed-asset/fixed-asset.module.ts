import { Module } from '@nestjs/common';
import { FixedAssetService } from './fixed-asset.service';
import { FixedAssetController } from './fixed-asset.controller';
import { DatabaseModule } from '../database/database.module';

@Module({
  imports: [DatabaseModule],
  controllers: [FixedAssetController],
  providers: [FixedAssetService],
  exports: [FixedAssetService],
})
export class FixedAssetModule {}
