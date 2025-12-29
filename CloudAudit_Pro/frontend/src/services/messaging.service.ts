import apiClient from './api';

export interface Message {
  id: string;
  subject: string;
  message: string;
  threadId?: string;
  senderId: string;
  sender: {
    id: string;
    firstName: string;
    lastName: string;
    role: string;
  };
  recipientId?: string;
  recipient?: {
    id: string;
    firstName: string;
    lastName: string;
  };
  companyId: string;
  isRead: boolean;
  createdAt: string;
  updatedAt: string;
}

export interface MessageThread {
  id: string;
  subject: string;
  companyId: string;
  participants: Array<{
    id: string;
    firstName: string;
    lastName: string;
    role: string;
  }>;
  messages: Message[];
  lastMessageAt: string;
  unreadCount: number;
}

export interface SendMessageDto {
  subject: string;
  message: string;
  companyId: string;
  recipientId?: string;
  threadId?: string;
}

class MessagingService {
  async sendMessage(data: SendMessageDto): Promise<Message> {
    try {
      const response = await apiClient.post('/messages', data);
      return response.data;
    } catch (error) {
      console.error('Failed to send message:', error);
      throw error;
    }
  }

  async getMessages(filters?: { 
    companyId?: string; 
    threadId?: string;
    unreadOnly?: boolean;
  }): Promise<Message[]> {
    try {
      const response = await apiClient.get('/messages', { params: filters });
      return Array.isArray(response.data) ? response.data : response.data.data || [];
    } catch (error) {
      console.error('Failed to fetch messages:', error);
      throw error;
    }
  }

  async getThreads(companyId?: string): Promise<MessageThread[]> {
    try {
      const response = await apiClient.get('/messages/threads', { 
        params: { companyId } 
      });
      return Array.isArray(response.data) ? response.data : response.data.data || [];
    } catch (error) {
      console.error('Failed to fetch threads:', error);
      throw error;
    }
  }

  async getThread(threadId: string): Promise<MessageThread> {
    try {
      const response = await apiClient.get(`/messages/threads/${threadId}`);
      return response.data;
    } catch (error) {
      console.error('Failed to fetch thread:', error);
      throw error;
    }
  }

  async markAsRead(messageId: string): Promise<void> {
    try {
      await apiClient.patch(`/messages/${messageId}/read`);
    } catch (error) {
      console.error('Failed to mark message as read:', error);
      throw error;
    }
  }

  async markThreadAsRead(threadId: string): Promise<void> {
    try {
      await apiClient.patch(`/messages/threads/${threadId}/read`);
    } catch (error) {
      console.error('Failed to mark thread as read:', error);
      throw error;
    }
  }

  async deleteMessage(messageId: string): Promise<void> {
    try {
      await apiClient.delete(`/messages/${messageId}`);
    } catch (error) {
      console.error('Failed to delete message:', error);
      throw error;
    }
  }

  async getUnreadCount(companyId?: string): Promise<number> {
    try {
      const response = await apiClient.get('/messages/unread-count', {
        params: { companyId }
      });
      return response.data.count || 0;
    } catch (error) {
      console.error('Failed to fetch unread count:', error);
      return 0;
    }
  }
}

export const messagingService = new MessagingService();
