import { IsString, IsOptional, IsBoolean, IsNumber, IsJSON } from 'class-validator';

export class CreateProcedureTemplateDto {
  @IsString()
  name: string;

  @IsOptional()
  @IsString()
  description?: string;

  @IsOptional()
  @IsString()
  category?: string;

  @IsString()
  procedureText: string;

  @IsOptional()
  @IsBoolean()
  isMandatory?: boolean;

  @IsOptional()
  @IsNumber()
  estimatedHours?: number;

  @IsOptional()
  @IsJSON()
  requiredSkills?: any;

  @IsOptional()
  @IsBoolean()
  isActive?: boolean;
}
