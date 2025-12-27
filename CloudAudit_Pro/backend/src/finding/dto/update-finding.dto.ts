import { PartialType } from '@nestjs/swagger';
import { CreateFindingDto } from './create-finding.dto';
import { IsString, IsEnum, IsOptional } from 'class-validator';
import { ApiPropertyOptional } from '@nestjs/swagger';

export enum FindingStatus {
  OPEN = 'OPEN',
  IN_PROGRESS = 'IN_PROGRESS',
  RESOLVED = 'RESOLVED',
  CLOSED = 'CLOSED',
  DEFERRED = 'DEFERRED',
}

export class UpdateFindingDto extends PartialType(CreateFindingDto) {
  @ApiPropertyOptional({ enum: FindingStatus })
  @IsOptional()
  @IsEnum(FindingStatus)
  status?: FindingStatus;

  @ApiPropertyOptional()
  @IsOptional()
  @IsString()
  managementResponse?: string;
}
