import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  UseGuards,
  Request,
  Query,
} from '@nestjs/common';
import { ApiTags, ApiOperation, ApiBearerAuth, ApiResponse, ApiQuery } from '@nestjs/swagger';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { NotificationsService } from './notifications.service';
import { CreateNotificationDto } from './dto/create-notification.dto';
import { CreateNotificationTemplateDto } from './dto/create-template.dto';
import { NotificationType, NotificationStatus } from '@prisma/client';

@ApiTags('notifications')
@ApiBearerAuth()
@UseGuards(JwtAuthGuard)
@Controller('notifications')
export class NotificationsController {
  constructor(private readonly notificationsService: NotificationsService) {}

  @Post()
  @ApiOperation({ summary: 'Create a new notification' })
  @ApiResponse({ status: 201, description: 'Notification created successfully' })
  create(@Request() req, @Body() createNotificationDto: CreateNotificationDto) {
    const tenantId = req.user.tenantId;
    const userId = req.user.userId;
    return this.notificationsService.create(tenantId, userId, createNotificationDto);
  }

  @Get()
  @ApiOperation({ summary: 'Get all notifications for current user' })
  @ApiQuery({ name: 'status', enum: NotificationStatus, required: false })
  @ApiQuery({ name: 'type', enum: NotificationType, required: false })
  @ApiResponse({ status: 200, description: 'Returns user notifications' })
  findAll(
    @Request() req,
    @Query('status') status?: NotificationStatus,
    @Query('type') type?: NotificationType,
  ) {
    const userId = req.user.userId;
    return this.notificationsService.findAllForUser(userId, status, type);
  }

  @Get('unread-count')
  @ApiOperation({ summary: 'Get unread notifications count' })
  @ApiResponse({ status: 200, description: 'Returns unread count' })
  getUnreadCount(@Request() req) {
    const userId = req.user.userId;
    return this.notificationsService.getUnreadCount(userId);
  }

  @Post('mark-all-read')
  @ApiOperation({ summary: 'Mark all notifications as read' })
  @ApiResponse({ status: 200, description: 'All notifications marked as read' })
  markAllAsRead(@Request() req) {
    const userId = req.user.userId;
    return this.notificationsService.markAllAsRead(userId);
  }

  @Post('clear-read')
  @ApiOperation({ summary: 'Delete all read/dismissed notifications' })
  @ApiResponse({ status: 200, description: 'Read notifications cleared' })
  clearRead(@Request() req) {
    const userId = req.user.userId;
    return this.notificationsService.clearRead(userId);
  }

  @Post('bulk-send')
  @ApiOperation({ summary: 'Send notification to multiple users' })
  @ApiResponse({ status: 201, description: 'Notifications sent successfully' })
  bulkSend(
    @Request() req,
    @Body() body: { userIds: string[]; notification: Omit<CreateNotificationDto, 'userId'> },
  ) {
    const tenantId = req.user.tenantId;
    const createdBy = req.user.userId;
    return this.notificationsService.bulkSend(
      tenantId,
      createdBy,
      body.userIds,
      body.notification,
    );
  }

  @Get('templates')
  @ApiOperation({ summary: 'Get all notification templates' })
  @ApiQuery({ name: 'isActive', type: Boolean, required: false })
  @ApiResponse({ status: 200, description: 'Returns all templates' })
  findAllTemplates(@Request() req, @Query('isActive') isActive?: boolean) {
    const tenantId = req.user.tenantId;
    return this.notificationsService.findAllTemplates(tenantId, isActive);
  }

  @Post('templates')
  @ApiOperation({ summary: 'Create a notification template' })
  @ApiResponse({ status: 201, description: 'Template created successfully' })
  createTemplate(@Request() req, @Body() createTemplateDto: CreateNotificationTemplateDto) {
    const tenantId = req.user.tenantId;
    const userId = req.user.userId;
    return this.notificationsService.createTemplate(tenantId, userId, createTemplateDto);
  }

  @Get('templates/:key')
  @ApiOperation({ summary: 'Get template by key' })
  @ApiResponse({ status: 200, description: 'Returns the template' })
  @ApiResponse({ status: 404, description: 'Template not found' })
  findTemplate(@Param('key') key: string) {
    return this.notificationsService.findTemplate(key);
  }

  @Patch('templates/:key')
  @ApiOperation({ summary: 'Update a notification template' })
  @ApiResponse({ status: 200, description: 'Template updated successfully' })
  updateTemplate(
    @Request() req,
    @Param('key') key: string,
    @Body() updateTemplateDto: Partial<CreateNotificationTemplateDto>,
  ) {
    const userId = req.user.userId;
    return this.notificationsService.updateTemplate(key, userId, updateTemplateDto);
  }

  @Delete('templates/:key')
  @ApiOperation({ summary: 'Delete a notification template' })
  @ApiResponse({ status: 200, description: 'Template deleted successfully' })
  removeTemplate(@Param('key') key: string) {
    return this.notificationsService.removeTemplate(key);
  }

  @Post('templates/:key/send')
  @ApiOperation({ summary: 'Send notification from template' })
  @ApiResponse({ status: 201, description: 'Notification sent successfully' })
  sendFromTemplate(
    @Request() req,
    @Param('key') key: string,
    @Body() body: { userId: string; variables: Record<string, any> },
  ) {
    const tenantId = req.user.tenantId;
    const createdBy = req.user.userId;
    return this.notificationsService.sendFromTemplate(
      tenantId,
      key,
      body.userId,
      body.variables,
    );
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get notification by ID' })
  @ApiResponse({ status: 200, description: 'Returns the notification' })
  @ApiResponse({ status: 404, description: 'Notification not found' })
  findOne(@Param('id') id: string) {
    return this.notificationsService.findOne(id);
  }

  @Patch(':id/read')
  @ApiOperation({ summary: 'Mark notification as read' })
  @ApiResponse({ status: 200, description: 'Notification marked as read' })
  markAsRead(@Param('id') id: string) {
    return this.notificationsService.markAsRead(id);
  }

  @Patch(':id/dismiss')
  @ApiOperation({ summary: 'Dismiss a notification' })
  @ApiResponse({ status: 200, description: 'Notification dismissed' })
  dismiss(@Param('id') id: string) {
    return this.notificationsService.dismiss(id);
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Delete a notification' })
  @ApiResponse({ status: 200, description: 'Notification deleted successfully' })
  remove(@Param('id') id: string) {
    return this.notificationsService.remove(id);
  }
}
