import { IsString, IsNotEmpty, IsEnum, IsBoolean, IsOptional } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';
import { NotificationType } from '@prisma/client';

export class CreateNotificationTemplateDto {
  @ApiProperty({ description: 'Unique template key' })
  @IsString()
  @IsNotEmpty()
  templateKey: string;

  @ApiProperty({ description: 'Template name' })
  @IsString()
  @IsNotEmpty()
  templateName: string;

  @ApiProperty({ description: 'Email subject' })
  @IsString()
  @IsNotEmpty()
  subject: string;

  @ApiProperty({ description: 'Email body template with placeholders' })
  @IsString()
  @IsNotEmpty()
  bodyTemplate: string;

  @ApiProperty({ enum: NotificationType, description: 'Notification type' })
  @IsEnum(NotificationType)
  @IsNotEmpty()
  notificationType: NotificationType;

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
