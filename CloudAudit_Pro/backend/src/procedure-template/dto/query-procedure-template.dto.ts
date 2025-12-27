import { IsOptional, IsString, IsBoolean } from 'class-validator';

export class QueryProcedureTemplateDto {
  @IsOptional()
  @IsString()
  category?: string;

  @IsOptional()
  @IsBoolean()
  isActive?: boolean;

  @IsOptional()
  @IsBoolean()
  isMandatory?: boolean;

  @IsOptional()
  @IsString()
  search?: string;
}
