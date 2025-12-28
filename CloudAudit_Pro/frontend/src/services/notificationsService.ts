import api from './api';

export interface Notification {
  id: string;
  tenantId: string;
  userId: string;
  title: string;
  message: string;
  notificationType: string;
  priority: string;
  status: string;
  actionUrl?: string;
  actionText?: string;
  relatedEntityType?: string;
  relatedEntityId?: string;
  readAt?: Date;
  dismissedAt?: Date;
  expiresAt?: Date;
  createdBy: string;
  createdAt: Date;
}

export interface CreateNotificationDto {
  userId: string;
  title: string;
  message: string;
  notificationType: string;
  priority?: string;
  actionUrl?: string;
  actionText?: string;
  relatedEntityType?: string;
  relatedEntityId?: string;
}

const notificationsService = {
  async getAll(status?: string): Promise<Notification[]> {
    const params = status ? { status } : {};
    const response = await api.get('/notifications', { params });
    return response.data;
  },

  async getUnread(): Promise<Notification[]> {
    const response = await api.get('/notifications/unread');
    return response.data;
  },

  async getUnreadCount(): Promise<number> {
    const response = await api.get('/notifications/unread-count');
    return response.data.count;
  },

  async getById(id: string): Promise<Notification> {
    const response = await api.get(`/notifications/${id}`);
    return response.data;
  },

  async create(data: CreateNotificationDto): Promise<Notification> {
    const response = await api.post('/notifications', data);
    return response.data;
  },

  async markAsRead(id: string): Promise<Notification> {
    const response = await api.post(`/notifications/${id}/read`);
    return response.data;
  },

  async markAllAsRead(): Promise<void> {
    await api.post('/notifications/mark-all-read');
  },

  async dismiss(id: string): Promise<Notification> {
    const response = await api.post(`/notifications/${id}/dismiss`);
    return response.data;
  },

  async bulkDismiss(ids: string[]): Promise<void> {
    await api.post('/notifications/bulk-dismiss', { ids });
  },

  async delete(id: string): Promise<void> {
    await api.delete(`/notifications/${id}`);
  },

  async clearRead(): Promise<void> {
    await api.delete('/notifications/clear-read');
  },
};

export default notificationsService;
