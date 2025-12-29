import apiClient from './api';

export interface Invitation {
  id: string;
  email: string;
  firstName?: string;
  lastName?: string;
  role: 'AUDITOR' | 'CLIENT' | 'MANAGER' | 'ADMIN';
  companyId: string;
  token: string;
  status: 'PENDING' | 'ACCEPTED' | 'EXPIRED';
  expiresAt: string;
  createdAt: string;
  createdBy: {
    id: string;
    firstName: string;
    lastName: string;
  };
}

export interface CreateInvitationDto {
  email: string;
  firstName?: string;
  lastName?: string;
  role: 'AUDITOR' | 'CLIENT' | 'MANAGER' | 'ADMIN';
  companyId?: string;
  message?: string;
}

export interface ValidateInvitationResponse {
  valid: boolean;
  invitation?: Invitation;
  error?: string;
}

class InvitationService {
  async createInvitation(data: CreateInvitationDto): Promise<Invitation> {
    try {
      const response = await apiClient.post('/invitations', data);
      return response.data;
    } catch (error) {
      console.error('Failed to create invitation:', error);
      throw error;
    }
  }

  async getInvitations(filters?: { status?: string; role?: string }): Promise<Invitation[]> {
    try {
      const response = await apiClient.get('/invitations', { params: filters });
      return Array.isArray(response.data) ? response.data : response.data.data || [];
    } catch (error) {
      console.error('Failed to fetch invitations:', error);
      throw error;
    }
  }

  async validateInvitation(token: string): Promise<ValidateInvitationResponse> {
    try {
      const response = await apiClient.get(`/invitations/validate/${token}`);
      return response.data;
    } catch (error: any) {
      return {
        valid: false,
        error: error.response?.data?.message || 'Invalid or expired invitation',
      };
    }
  }

  async resendInvitation(invitationId: string): Promise<void> {
    try {
      await apiClient.post(`/invitations/${invitationId}/resend`);
    } catch (error) {
      console.error('Failed to resend invitation:', error);
      throw error;
    }
  }

  async cancelInvitation(invitationId: string): Promise<void> {
    try {
      await apiClient.delete(`/invitations/${invitationId}`);
    } catch (error) {
      console.error('Failed to cancel invitation:', error);
      throw error;
    }
  }

  async acceptInvitation(token: string, userData: {
    password: string;
    firstName?: string;
    lastName?: string;
  }): Promise<{ user: any; token: string }> {
    try {
      const response = await apiClient.post(`/invitations/accept/${token}`, userData);
      return response.data;
    } catch (error) {
      console.error('Failed to accept invitation:', error);
      throw error;
    }
  }
}

export const invitationService = new InvitationService();
