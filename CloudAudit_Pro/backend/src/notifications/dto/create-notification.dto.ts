import { IsString, IsNotEmpty, IsOptional, IsDateString } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class CreateNotificationDto {
  @ApiProperty({ description: 'User ID to send notification to', required: false })
  @IsOptional()
  userId?: string;

  @ApiProperty({ description: 'Notification title', required: false })
  @IsOptional()
  title?: string;

  @ApiProperty({ description: 'Notification message' })
  @IsString()
  @IsNotEmpty()
  message: string;

  @ApiProperty({ description: 'Type of notification', required: false })
  @IsOptional()
  notificationType?: any;

  @ApiProperty({ description: 'Type of notification (alias)', required: false })
  @IsOptional()
  type?: any;

  @ApiProperty({ description: 'Priority level', required: false })
  @IsOptional()
  priority?: any;

  @ApiProperty({ description: 'Action URL', required: false })
  @IsOptional()
  actionUrl?: string;

  @ApiProperty({ description: 'Action button text', required: false })
  @IsOptional()
  actionText?: string;

  @ApiProperty({ description: 'Related entity type', required: false })
  @IsOptional()
  relatedEntityType?: string;

  @ApiProperty({ description: 'Related entity ID', required: false })
  @IsOptional()
  relatedEntityId?: string;

  @ApiProperty({ description: 'Expiration date', required: false })
  @IsDateString()
  @IsOptional()
  expiresAt?: string;
}
