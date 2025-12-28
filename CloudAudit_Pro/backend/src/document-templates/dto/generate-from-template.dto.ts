import { IsNotEmpty, IsString, IsOptional } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class GenerateFromTemplateDto {
  @ApiProperty({ description: 'Generated document name' })
  @IsNotEmpty()
  @IsString()
  name: string;

  @ApiProperty({ description: 'Company ID' })
  @IsNotEmpty()
  @IsString()
  companyId: string;

  @ApiProperty({ description: 'Period ID', required: false })
  @IsOptional()
  @IsString()
  periodId?: string;

  @ApiProperty({ description: 'Field values (JSON)', required: false })
  @IsOptional()
  fieldValues?: any;
}
