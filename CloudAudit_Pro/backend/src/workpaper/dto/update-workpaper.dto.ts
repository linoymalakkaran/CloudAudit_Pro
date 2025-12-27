import { PartialType } from '@nestjs/swagger';
import { CreateWorkpaperDto } from './create-workpaper.dto';
import { IsString, IsOptional } from 'class-validator';
import { ApiPropertyOptional } from '@nestjs/swagger';

export class UpdateWorkpaperDto extends PartialType(CreateWorkpaperDto) {
  @ApiPropertyOptional()
  @IsOptional()
  @IsString()
  reviewNotes?: string;
}
