import axios from 'axios';

const API_URL = import.meta.env.VITE_API_URL || 'http://localhost:3000';

export enum ReviewLevel {
  MANAGER = 'MANAGER',
  PARTNER = 'PARTNER',
  QUALITY_CONTROL = 'QUALITY_CONTROL',
}

export enum ManagerReviewStatus {
  NOT_STARTED = 'NOT_STARTED',
  IN_PROGRESS = 'IN_PROGRESS',
  COMPLETED = 'COMPLETED',
  APPROVED = 'APPROVED',
  REJECTED = 'REJECTED',
  REQUIRES_CHANGES = 'REQUIRES_CHANGES',
}

export interface ManagerReview {
  id: string;
  tenantId: string;
  companyId: string;
  periodId: string;
  procedureId?: string;
  reviewLevel: ReviewLevel;
  status: ManagerReviewStatus;
  reviewerId: string;
  title: string;
  comments?: string;
  findings?: string;
  recommendations?: string;
  dueDate?: string;
  completedAt?: string;
  isSignedOff: boolean;
  signOffNotes?: string;
  signedOffBy?: string;
  signedOffAt?: string;
  createdAt: string;
  updatedAt: string;
  createdBy: string;
  updatedBy: string;
}

export interface CreateManagerReviewDto {
  companyId: string;
  periodId: string;
  procedureId?: string;
  reviewLevel: ReviewLevel;
  status?: ManagerReviewStatus;
  reviewerId: string;
  title: string;
  comments?: string;
  findings?: string;
  recommendations?: string;
  dueDate?: string;
  completedAt?: string;
  isSignedOff?: boolean;
  signOffNotes?: string;
}

export interface UpdateManagerReviewDto extends Partial<CreateManagerReviewDto> {}

export interface ApproveReviewDto {
  signOffNotes: string;
}

export interface RejectReviewDto {
  comments: string;
}

export interface ManagerReviewSummary {
  total: number;
  byStatus: Record<string, number>;
  byLevel: Record<string, number>;
  notStarted: number;
  inProgress: number;
  completed: number;
  approved: number;
  rejected: number;
}

class ManagerReviewService {
  private getAuthHeaders() {
    const token = localStorage.getItem('token');
    return {
      Authorization: `Bearer ${token}`,
      'Content-Type': 'application/json',
    };
  }

  async createManagerReview(data: CreateManagerReviewDto): Promise<ManagerReview> {
    const response = await axios.post(`${API_URL}/manager-reviews`, data, {
      headers: this.getAuthHeaders(),
    });
    return response.data;
  }

  async getManagerReviews(params?: {
    companyId?: string;
    periodId?: string;
    status?: ManagerReviewStatus;
    reviewLevel?: ReviewLevel;
    reviewerId?: string;
  }): Promise<ManagerReview[]> {
    const response = await axios.get(`${API_URL}/manager-reviews`, {
      headers: this.getAuthHeaders(),
      params,
    });
    return response.data;
  }

  async getManagerReviewById(id: string): Promise<ManagerReview> {
    const response = await axios.get(`${API_URL}/manager-reviews/${id}`, {
      headers: this.getAuthHeaders(),
    });
    return response.data;
  }

  async updateManagerReview(id: string, data: UpdateManagerReviewDto): Promise<ManagerReview> {
    const response = await axios.patch(`${API_URL}/manager-reviews/${id}`, data, {
      headers: this.getAuthHeaders(),
    });
    return response.data;
  }

  async approveReview(id: string, data: ApproveReviewDto): Promise<ManagerReview> {
    const response = await axios.post(`${API_URL}/manager-reviews/${id}/approve`, data, {
      headers: this.getAuthHeaders(),
    });
    return response.data;
  }

  async rejectReview(id: string, data: RejectReviewDto): Promise<ManagerReview> {
    const response = await axios.post(`${API_URL}/manager-reviews/${id}/reject`, data, {
      headers: this.getAuthHeaders(),
    });
    return response.data;
  }

  async deleteManagerReview(id: string): Promise<void> {
    await axios.delete(`${API_URL}/manager-reviews/${id}`, {
      headers: this.getAuthHeaders(),
    });
  }

  async getSummary(companyId: string, periodId: string): Promise<ManagerReviewSummary> {
    const response = await axios.get(`${API_URL}/manager-reviews/summary`, {
      headers: this.getAuthHeaders(),
      params: { companyId, periodId },
    });
    return response.data;
  }
}

export default new ManagerReviewService();
