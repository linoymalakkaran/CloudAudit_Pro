import apiClient from './api';

export interface Notification {
  id: string;
  userId: string;
  title: string;
  message: string;
  type: 'INFO' | 'SUCCESS' | 'WARNING' | 'ERROR' | 'DOCUMENT_REQUEST' | 'AUDIT_UPDATE' | 'MESSAGE';
  isRead: boolean;
  link?: string;
  metadata?: Record<string, any>;
  createdAt: string;
}

export interface CreateNotificationDto {
  userId?: string;
  companyId?: string;
  title: string;
  message: string;
  type: 'INFO' | 'SUCCESS' | 'WARNING' | 'ERROR' | 'DOCUMENT_REQUEST' | 'AUDIT_UPDATE' | 'MESSAGE';
  link?: string;
  metadata?: Record<string, any>;
}

class NotificationService {
  async getNotifications(filters?: { 
    unreadOnly?: boolean;
    type?: string;
  }): Promise<Notification[]> {
    try {
      const response = await apiClient.get('/notifications', { params: filters });
      return Array.isArray(response.data) ? response.data : response.data.data || [];
    } catch (error) {
      console.error('Failed to fetch notifications:', error);
      throw error;
    }
  }

  async markAsRead(notificationId: string): Promise<void> {
    try {
      await apiClient.patch(`/notifications/${notificationId}/read`);
    } catch (error) {
      console.error('Failed to mark notification as read:', error);
      throw error;
    }
  }

  async markAllAsRead(): Promise<void> {
    try {
      await apiClient.patch('/notifications/mark-all-read');
    } catch (error) {
      console.error('Failed to mark all notifications as read:', error);
      throw error;
    }
  }

  async deleteNotification(notificationId: string): Promise<void> {
    try {
      await apiClient.delete(`/notifications/${notificationId}`);
    } catch (error) {
      console.error('Failed to delete notification:', error);
      throw error;
    }
  }

  async getUnreadCount(): Promise<number> {
    try {
      const response = await apiClient.get('/notifications/unread-count');
      return response.data.count || 0;
    } catch (error) {
      console.error('Failed to fetch unread count:', error);
      return 0;
    }
  }

  async createNotification(data: CreateNotificationDto): Promise<Notification> {
    try {
      const response = await apiClient.post('/notifications', data);
      return response.data;
    } catch (error) {
      console.error('Failed to create notification:', error);
      throw error;
    }
  }

  // Subscribe to real-time notifications (using WebSocket or polling)
  subscribeToNotifications(callback: (notification: Notification) => void): () => void {
    // For now, use polling every 30 seconds
    const interval = setInterval(async () => {
      try {
        const notifications = await this.getNotifications({ unreadOnly: true });
        if (notifications.length > 0) {
          notifications.forEach(callback);
        }
      } catch (error) {
        console.error('Failed to poll notifications:', error);
      }
    }, 30000); // 30 seconds

    // Return cleanup function
    return () => clearInterval(interval);
  }
}

export const notificationService = new NotificationService();
