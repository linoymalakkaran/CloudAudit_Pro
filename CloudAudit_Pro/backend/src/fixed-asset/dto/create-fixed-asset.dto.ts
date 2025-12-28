import { IsNotEmpty, IsString, IsNumber, IsDateString, IsOptional, IsEnum, IsBoolean } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';
import { DepreciationMethod, AssetStatus } from '@prisma/client';

export class CreateFixedAssetDto {
  @ApiProperty({ description: 'Company ID' })
  @IsNotEmpty()
  @IsString()
  companyId: string;

  @ApiProperty({ description: 'Period ID' })
  @IsNotEmpty()
  @IsString()
  periodId: string;

  @ApiProperty({ description: 'Asset category (e.g., Building, Equipment)' })
  @IsNotEmpty()
  @IsString()
  category: string;

  @ApiProperty({ description: 'Asset description' })
  @IsNotEmpty()
  @IsString()
  description: string;

  @ApiProperty({ description: 'Asset reference number', required: false })
  @IsOptional()
  @IsString()
  referenceNumber?: string;

  @ApiProperty({ description: 'Purchase date' })
  @IsNotEmpty()
  @IsDateString()
  purchaseDate: string;

  @ApiProperty({ description: 'Original cost' })
  @IsNotEmpty()
  @IsNumber()
  originalCost: number;

  @ApiProperty({ description: 'Accumulated depreciation at start' })
  @IsOptional()
  @IsNumber()
  accumulatedDepreciation?: number;

  @ApiProperty({ description: 'Depreciation method', enum: DepreciationMethod })
  @IsNotEmpty()
  @IsEnum(DepreciationMethod)
  depreciationMethod: DepreciationMethod;

  @ApiProperty({ description: 'Useful life in years' })
  @IsNotEmpty()
  @IsNumber()
  usefulLife: number;

  @ApiProperty({ description: 'Salvage value', required: false })
  @IsOptional()
  @IsNumber()
  salvageValue?: number;

  @ApiProperty({ description: 'Location', required: false })
  @IsOptional()
  @IsString()
  location?: string;

  @ApiProperty({ description: 'Notes', required: false })
  @IsOptional()
  @IsString()
  notes?: string;

  @ApiProperty({ description: 'Asset status', enum: AssetStatus })
  @IsOptional()
  @IsEnum(AssetStatus)
  status?: AssetStatus;

  @ApiProperty({ description: 'Disposal date', required: false })
  @IsOptional()
  @IsDateString()
  disposalDate?: string;

  @ApiProperty({ description: 'Disposal amount', required: false })
  @IsOptional()
  @IsNumber()
  disposalAmount?: number;

  @ApiProperty({ description: 'Is finished', default: false })
  @IsOptional()
  @IsBoolean()
  isFinished?: boolean;
}
