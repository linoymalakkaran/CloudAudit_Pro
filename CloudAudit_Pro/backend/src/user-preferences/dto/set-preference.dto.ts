import { IsString, IsOptional } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class SetPreferenceDto {
  @ApiProperty({ description: 'Preference key (unique per user)', required: false })
  @IsOptional()
  preferenceKey?: string;

  @ApiProperty({ description: 'Preference key (alias)', required: false })
  @IsOptional()
  key?: string;

  @ApiProperty({ description: 'Preference value (any JSON value)', required: false })
  @IsOptional()
  preferenceValue?: any;

  @ApiProperty({ description: 'Preference value (alias)', required: false })
  @IsOptional()
  value?: any;

  @ApiProperty({ description: 'Preference category', required: false })
  @IsString()
  @IsOptional()
  category?: string;
}
