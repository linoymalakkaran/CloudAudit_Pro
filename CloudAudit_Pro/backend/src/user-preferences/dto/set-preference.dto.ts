import { IsString, IsNotEmpty, IsOptional } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class SetPreferenceDto {
  @ApiProperty({ description: 'Preference key (unique per user)' })
  @IsString()
  @IsNotEmpty()
  preferenceKey: string;

  @ApiProperty({ description: 'Preference value (any JSON value)' })
  @IsNotEmpty()
  preferenceValue: any;

  @ApiProperty({ description: 'Preference category', required: false })
  @IsString()
  @IsOptional()
  category?: string;
}
