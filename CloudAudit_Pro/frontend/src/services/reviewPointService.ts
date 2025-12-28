import axios from 'axios';

const API_URL = import.meta.env.VITE_API_URL || 'http://localhost:3000';

export enum ReviewCategory {
  AUDIT_FINDING = 'AUDIT_FINDING',
  CLIENT_QUERY = 'CLIENT_QUERY',
  TECHNICAL_ISSUE = 'TECHNICAL_ISSUE',
  DOCUMENTATION = 'DOCUMENTATION',
  COMPLIANCE = 'COMPLIANCE',
  OTHER = 'OTHER',
}

export enum ReviewPriority {
  LOW = 'LOW',
  MEDIUM = 'MEDIUM',
  HIGH = 'HIGH',
  URGENT = 'URGENT',
}

export enum ReviewPointStatus {
  OUTSTANDING = 'OUTSTANDING',
  IN_PROGRESS = 'IN_PROGRESS',
  PENDING_CLEARANCE = 'PENDING_CLEARANCE',
  CLEARED = 'CLEARED',
  CARRIED_FORWARD = 'CARRIED_FORWARD',
}

export interface ReviewPoint {
  id: string;
  tenantId: string;
  companyId: string;
  periodId: string;
  procedureId?: string;
  accountId?: string;
  reviewNumber: string;
  title: string;
  description?: string;
  category: ReviewCategory;
  priority: ReviewPriority;
  status: ReviewPointStatus;
  raisedBy: string;
  assignedTo?: string;
  clearedBy?: string;
  raisedAt: string;
  assignedAt?: string;
  clearedAt?: string;
  dueDate?: string;
  targetDate?: string;
  response?: string;
  clearanceNotes?: string;
  impact?: string;
  relatedReviewIds: string[];
  createdAt: string;
  updatedAt: string;
  createdBy: string;
  updatedBy: string;
}

export interface CreateReviewPointDto {
  companyId: string;
  periodId: string;
  procedureId?: string;
  accountId?: string;
  title: string;
  description?: string;
  category: ReviewCategory;
  priority: ReviewPriority;
  status?: ReviewPointStatus;
  assignedTo?: string;
  dueDate?: string;
  targetDate?: string;
  response?: string;
  impact?: string;
  relatedReviewIds?: string[];
}

export interface UpdateReviewPointDto extends Partial<CreateReviewPointDto> {}

export interface ClearReviewPointDto {
  clearanceNotes: string;
}

export interface ReviewPointSummary {
  total: number;
  byStatus: Record<string, number>;
  byPriority: Record<string, number>;
  outstanding: number;
  inProgress: number;
  pendingClearance: number;
  cleared: number;
  carriedForward: number;
}

class ReviewPointService {
  private getAuthHeaders() {
    const token = localStorage.getItem('token');
    return {
      Authorization: `Bearer ${token}`,
      'Content-Type': 'application/json',
    };
  }

  async createReviewPoint(data: CreateReviewPointDto): Promise<ReviewPoint> {
    const response = await axios.post(`${API_URL}/review-points`, data, {
      headers: this.getAuthHeaders(),
    });
    return response.data;
  }

  async getReviewPoints(params?: {
    companyId?: string;
    periodId?: string;
    status?: ReviewPointStatus;
    category?: ReviewCategory;
    assignedTo?: string;
  }): Promise<ReviewPoint[]> {
    const response = await axios.get(`${API_URL}/review-points`, {
      headers: this.getAuthHeaders(),
      params,
    });
    return response.data;
  }

  async getReviewPointById(id: string): Promise<ReviewPoint> {
    const response = await axios.get(`${API_URL}/review-points/${id}`, {
      headers: this.getAuthHeaders(),
    });
    return response.data;
  }

  async updateReviewPoint(id: string, data: UpdateReviewPointDto): Promise<ReviewPoint> {
    const response = await axios.patch(`${API_URL}/review-points/${id}`, data, {
      headers: this.getAuthHeaders(),
    });
    return response.data;
  }

  async clearReviewPoint(id: string, data: ClearReviewPointDto): Promise<ReviewPoint> {
    const response = await axios.post(`${API_URL}/review-points/${id}/clear`, data, {
      headers: this.getAuthHeaders(),
    });
    return response.data;
  }

  async deleteReviewPoint(id: string): Promise<void> {
    await axios.delete(`${API_URL}/review-points/${id}`, {
      headers: this.getAuthHeaders(),
    });
  }

  async getSummary(companyId: string, periodId: string): Promise<ReviewPointSummary> {
    const response = await axios.get(`${API_URL}/review-points/summary`, {
      headers: this.getAuthHeaders(),
      params: { companyId, periodId },
    });
    return response.data;
  }
}

export default new ReviewPointService();
