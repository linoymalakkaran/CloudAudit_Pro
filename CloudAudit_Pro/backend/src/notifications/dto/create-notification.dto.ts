import { IsString, IsNotEmpty, IsEnum, IsOptional, IsDateString } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';
import { NotificationType, NotificationPriority } from '@prisma/client';

export class CreateNotificationDto {
  @ApiProperty({ description: 'User ID to send notification to' })
  @IsString()
  @IsNotEmpty()
  userId: string;

  @ApiProperty({ description: 'Notification title' })
  @IsString()
  @IsNotEmpty()
  title: string;

  @ApiProperty({ description: 'Notification message' })
  @IsString()
  @IsNotEmpty()
  message: string;

  @ApiProperty({ enum: NotificationType, description: 'Type of notification' })
  @IsEnum(NotificationType)
  @IsNotEmpty()
  notificationType: NotificationType;

  @ApiProperty({ enum: NotificationPriority, description: 'Priority level', default: 'MEDIUM' })
  @IsEnum(NotificationPriority)
  @IsOptional()
  priority?: NotificationPriority;

  @ApiProperty({ description: 'Action URL', required: false })
  @IsString()
  @IsOptional()
  actionUrl?: string;

  @ApiProperty({ description: 'Action button text', required: false })
  @IsString()
  @IsOptional()
  actionText?: string;

  @ApiProperty({ description: 'Related entity type', required: false })
  @IsString()
  @IsOptional()
  relatedEntityType?: string;

  @ApiProperty({ description: 'Related entity ID', required: false })
  @IsString()
  @IsOptional()
  relatedEntityId?: string;

  @ApiProperty({ description: 'Expiration date', required: false })
  @IsDateString()
  @IsOptional()
  expiresAt?: string;
}
