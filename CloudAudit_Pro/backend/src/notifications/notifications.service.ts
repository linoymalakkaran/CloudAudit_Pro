import { Injectable, NotFoundException } from '@nestjs/common';
import { DatabaseService } from '../database/database.service';
import { CreateNotificationDto } from './dto/create-notification.dto';
import { CreateNotificationTemplateDto } from './dto/create-template.dto';
import { NotificationType, NotificationStatus, NotificationPriority } from '@prisma/client';

@Injectable()
export class NotificationsService {
  constructor(private readonly db: DatabaseService) {}

  /**
   * Create a new notification
   */
  async create(tenantId: string, createdBy: string, dto: CreateNotificationDto) {
    return this.db.notification.create({
      data: {
        tenantId,
        userId: dto.userId,
        title: dto.title,
        message: dto.message,
        notificationType: dto.notificationType,
        priority: dto.priority || NotificationPriority.MEDIUM,
        status: NotificationStatus.UNREAD,
        actionUrl: dto.actionUrl,
        actionText: dto.actionText,
        relatedEntityType: dto.relatedEntityType,
        relatedEntityId: dto.relatedEntityId,
        expiresAt: dto.expiresAt ? new Date(dto.expiresAt) : null,
        createdBy,
      },
      include: {
        user: {
          select: {
            id: true,
            firstName: true,
            lastName: true,
            email: true,
          },
        },
      },
    });
  }

  /**
   * Get all notifications for a user
   */
  async findAllForUser(
    userId: string,
    status?: NotificationStatus,
    type?: NotificationType,
  ) {
    const where: any = { userId };

    if (status) {
      where.status = status;
    }

    if (type) {
      where.notificationType = type;
    }

    // Filter out expired notifications
    where.OR = [
      { expiresAt: null },
      { expiresAt: { gt: new Date() } },
    ];

    return this.db.notification.findMany({
      where,
      orderBy: [
        { priority: 'desc' },
        { createdAt: 'desc' },
      ],
      include: {
        createdByUser: {
          select: {
            id: true,
            firstName: true,
            lastName: true,
            email: true,
          },
        },
      },
    });
  }

  /**
   * Get unread notifications count for a user
   */
  async getUnreadCount(userId: string) {
    return this.db.notification.count({
      where: {
        userId,
        status: NotificationStatus.UNREAD,
        OR: [
          { expiresAt: null },
          { expiresAt: { gt: new Date() } },
        ],
      },
    });
  }

  /**
   * Get notification by ID
   */
  async findOne(id: string) {
    const notification = await this.db.notification.findUnique({
      where: { id },
      include: {
        user: {
          select: {
            id: true,
            firstName: true,
            lastName: true,
            email: true,
          },
        },
        createdByUser: {
          select: {
            id: true,
            firstName: true,
            lastName: true,
            email: true,
          },
        },
      },
    });

    if (!notification) {
      throw new NotFoundException(`Notification with ID ${id} not found`);
    }

    return notification;
  }

  /**
   * Mark notification as read
   */
  async markAsRead(id: string) {
    await this.findOne(id);

    return this.db.notification.update({
      where: { id },
      data: {
        status: NotificationStatus.READ,
        readAt: new Date(),
      },
    });
  }

  /**
   * Mark all notifications as read for a user
   */
  async markAllAsRead(userId: string) {
    return this.db.notification.updateMany({
      where: {
        userId,
        status: NotificationStatus.UNREAD,
      },
      data: {
        status: NotificationStatus.READ,
        readAt: new Date(),
      },
    });
  }

  /**
   * Dismiss a notification
   */
  async dismiss(id: string) {
    await this.findOne(id);

    return this.db.notification.update({
      where: { id },
      data: {
        status: NotificationStatus.DISMISSED,
        dismissedAt: new Date(),
      },
    });
  }

  /**
   * Delete a notification
   */
  async remove(id: string) {
    await this.findOne(id);

    return this.db.notification.delete({
      where: { id },
    });
  }

  /**
   * Delete all read notifications for a user
   */
  async clearRead(userId: string) {
    return this.db.notification.deleteMany({
      where: {
        userId,
        status: {
          in: [NotificationStatus.READ, NotificationStatus.DISMISSED],
        },
      },
    });
  }

  /**
   * Create a notification template
   */
  async createTemplate(tenantId: string, userId: string, dto: CreateNotificationTemplateDto) {
    return this.db.notificationTemplate.create({
      data: {
        tenantId,
        templateKey: dto.templateKey,
        templateName: dto.templateName,
        subject: dto.subject,
        bodyTemplate: dto.bodyTemplate,
        notificationType: dto.notificationType,
        triggers: dto.triggers || {},
        recipients: dto.recipients || {},
        isActive: dto.isActive !== undefined ? dto.isActive : true,
        createdBy: userId,
        updatedBy: userId,
      },
    });
  }

  /**
   * Get all notification templates
   */
  async findAllTemplates(tenantId: string, isActive?: boolean) {
    const where: any = { tenantId };

    if (isActive !== undefined) {
      where.isActive = isActive;
    }

    return this.db.notificationTemplate.findMany({
      where,
      orderBy: {
        templateName: 'asc',
      },
    });
  }

  /**
   * Get template by key
   */
  async findTemplate(templateKey: string) {
    const template = await this.db.notificationTemplate.findUnique({
      where: { templateKey },
    });

    if (!template) {
      throw new NotFoundException(`Template with key ${templateKey} not found`);
    }

    return template;
  }

  /**
   * Update notification template
   */
  async updateTemplate(templateKey: string, userId: string, dto: Partial<CreateNotificationTemplateDto>) {
    await this.findTemplate(templateKey);

    return this.db.notificationTemplate.update({
      where: { templateKey },
      data: {
        ...(dto.templateName && { templateName: dto.templateName }),
        ...(dto.subject && { subject: dto.subject }),
        ...(dto.bodyTemplate && { bodyTemplate: dto.bodyTemplate }),
        ...(dto.notificationType && { notificationType: dto.notificationType }),
        ...(dto.triggers !== undefined && { triggers: dto.triggers }),
        ...(dto.recipients !== undefined && { recipients: dto.recipients }),
        ...(dto.isActive !== undefined && { isActive: dto.isActive }),
        updatedBy: userId,
        updatedAt: new Date(),
      },
    });
  }

  /**
   * Delete notification template
   */
  async removeTemplate(templateKey: string) {
    await this.findTemplate(templateKey);

    return this.db.notificationTemplate.delete({
      where: { templateKey },
    });
  }

  /**
   * Send notification from template
   */
  async sendFromTemplate(
    tenantId: string,
    templateKey: string,
    userId: string,
    variables: Record<string, any>,
  ) {
    const template = await this.findTemplate(templateKey);

    if (!template.isActive) {
      throw new NotFoundException(`Template ${templateKey} is not active`);
    }

    // Replace variables in title and message
    const title = this.replaceVariables(template.templateName, variables);
    const message = this.replaceVariables(template.bodyTemplate, variables);

    return this.create(tenantId, userId, {
      userId,
      title,
      message,
      notificationType: template.notificationType,
      priority: NotificationPriority.MEDIUM,
    });
  }

  /**
   * Replace variables in template string
   */
  private replaceVariables(template: string, variables: Record<string, any>): string {
    let result = template;
    Object.keys(variables).forEach((key) => {
      const regex = new RegExp(`{{${key}}}`, 'g');
      result = result.replace(regex, variables[key]);
    });
    return result;
  }

  /**
   * Bulk send notifications
   */
  async bulkSend(
    tenantId: string,
    createdBy: string,
    userIds: string[],
    dto: Omit<CreateNotificationDto, 'userId'>,
  ) {
    const notifications = userIds.map((userId) => ({
      tenantId,
      userId,
      title: dto.title,
      message: dto.message,
      notificationType: dto.notificationType,
      priority: dto.priority || NotificationPriority.MEDIUM,
      status: NotificationStatus.UNREAD,
      actionUrl: dto.actionUrl,
      actionText: dto.actionText,
      relatedEntityType: dto.relatedEntityType,
      relatedEntityId: dto.relatedEntityId,
      expiresAt: dto.expiresAt ? new Date(dto.expiresAt) : null,
      createdBy,
    }));

    return this.db.notification.createMany({
      data: notifications,
    });
  }

  /**
   * Clean up expired notifications
   */
  async cleanupExpired() {
    return this.db.notification.updateMany({
      where: {
        expiresAt: {
          lte: new Date(),
        },
        status: {
          not: NotificationStatus.EXPIRED,
        },
      },
      data: {
        status: NotificationStatus.EXPIRED,
      },
    });
  }
}
