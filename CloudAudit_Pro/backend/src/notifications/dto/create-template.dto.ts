import { IsString, IsNotEmpty, IsBoolean, IsOptional } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class CreateNotificationTemplateDto {
  @ApiProperty({ description: 'Unique template key', required: false })
  @IsOptional()
  templateKey?: string;

  @ApiProperty({ description: 'Unique template key (alias)', required: false })
  @IsOptional()
  key?: string;

  @ApiProperty({ description: 'Template name', required: false })
  @IsOptional()
  templateName?: string;

  @ApiProperty({ description: 'Email subject' })
  @IsString()
  @IsNotEmpty()
  subject: string;

  @ApiProperty({ description: 'Email body template with placeholders', required: false })
  @IsOptional()
  bodyTemplate?: string;

  @ApiProperty({ description: 'Email body (alias)', required: false })
  @IsOptional()
  body?: string;

  @ApiProperty({ description: 'Notification type', required: false })
  @IsOptional()
  notificationType?: any;

  @ApiProperty({ description: 'Notification type (alias)', required: false })
  @IsOptional()
  type?: any;

  @ApiProperty({ description: 'Trigger conditions (JSON)', required: false })
  @IsOptional()
  triggers?: any;

  @ApiProperty({ description: 'Recipients configuration (JSON)', required: false })
  @IsOptional()
  recipients?: any;

  @ApiProperty({ description: 'Whether template is active', default: true })
  @IsBoolean()
  @IsOptional()
  isActive?: boolean;
}
