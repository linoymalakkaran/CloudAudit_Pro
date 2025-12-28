import axios from 'axios';

const API_URL = import.meta.env.VITE_API_URL || 'http://localhost:3000';

export enum FinalizationStatus {
  DRAFT = 'DRAFT',
  IN_PROGRESS = 'IN_PROGRESS',
  REVIEW = 'REVIEW',
  APPROVED = 'APPROVED',
  FINALIZED = 'FINALIZED',
  ISSUED = 'ISSUED',
}

export enum OpinionType {
  UNQUALIFIED = 'UNQUALIFIED',
  QUALIFIED = 'QUALIFIED',
  ADVERSE = 'ADVERSE',
  DISCLAIMER = 'DISCLAIMER',
}

export interface AuditFinalization {
  id: string;
  tenantId: string;
  companyId: string;
  periodId: string;
  title: string;
  status: FinalizationStatus;
  opinionType?: OpinionType;
  opinionText?: string;
  executiveSummary?: string;
  keyFindings?: string;
  recommendations?: string;
  materialityThreshold?: number;
  totalProcedures?: number;
  proceduresPassed?: number;
  totalFindings?: number;
  openFindings?: number;
  auditStartDate?: string;
  auditEndDate?: string;
  reportIssueDate?: string;
  requiresPartnerApproval: boolean;
  isFinalized: boolean;
  finalizedBy?: string;
  finalizedAt?: string;
  notes?: string;
  createdAt: string;
  updatedAt: string;
  createdBy: string;
  updatedBy: string;
}

export interface CreateAuditFinalizationDto {
  companyId: string;
  periodId: string;
  title: string;
  status?: FinalizationStatus;
  opinionType?: OpinionType;
  opinionText?: string;
  executiveSummary?: string;
  keyFindings?: string;
  recommendations?: string;
  materialityThreshold?: number;
  totalProcedures?: number;
  proceduresPassed?: number;
  totalFindings?: number;
  openFindings?: number;
  auditStartDate?: string;
  auditEndDate?: string;
  reportIssueDate?: string;
  requiresPartnerApproval?: boolean;
  isFinalized?: boolean;
  finalizedBy?: string;
  finalizedAt?: string;
  notes?: string;
}

export interface UpdateAuditFinalizationDto extends Partial<CreateAuditFinalizationDto> {}

export interface AuditSummary {
  finalization?: AuditFinalization;
  procedures: {
    total: number;
    completed: number;
    inProgress: number;
    notStarted: number;
  };
  findings: {
    total: number;
    open: number;
    closed: number;
    bySeverity: {
      critical: number;
      high: number;
      medium: number;
      low: number;
    };
  };
  reviewPoints: {
    total: number;
    outstanding: number;
    cleared: number;
  };
}

class AuditFinalizationService {
  private getAuthHeaders() {
    const token = localStorage.getItem('token');
    return {
      Authorization: `Bearer ${token}`,
      'Content-Type': 'application/json',
    };
  }

  async createAuditFinalization(data: CreateAuditFinalizationDto): Promise<AuditFinalization> {
    const response = await axios.post(`${API_URL}/audit-finalization`, data, {
      headers: this.getAuthHeaders(),
    });
    return response.data;
  }

  async getAuditFinalizations(params?: {
    companyId?: string;
    periodId?: string;
    status?: FinalizationStatus;
  }): Promise<AuditFinalization[]> {
    const response = await axios.get(`${API_URL}/audit-finalization`, {
      headers: this.getAuthHeaders(),
      params,
    });
    return response.data;
  }

  async getAuditFinalizationById(id: string): Promise<AuditFinalization> {
    const response = await axios.get(`${API_URL}/audit-finalization/${id}`, {
      headers: this.getAuthHeaders(),
    });
    return response.data;
  }

  async getByCompanyAndPeriod(companyId: string, periodId: string): Promise<AuditFinalization> {
    const response = await axios.get(`${API_URL}/audit-finalization/by-company-period`, {
      headers: this.getAuthHeaders(),
      params: { companyId, periodId },
    });
    return response.data;
  }

  async updateAuditFinalization(
    id: string,
    data: UpdateAuditFinalizationDto
  ): Promise<AuditFinalization> {
    const response = await axios.patch(`${API_URL}/audit-finalization/${id}`, data, {
      headers: this.getAuthHeaders(),
    });
    return response.data;
  }

  async finalizeAudit(id: string): Promise<AuditFinalization> {
    const response = await axios.post(
      `${API_URL}/audit-finalization/${id}/finalize`,
      {},
      {
        headers: this.getAuthHeaders(),
      }
    );
    return response.data;
  }

  async issueReport(id: string): Promise<AuditFinalization> {
    const response = await axios.post(
      `${API_URL}/audit-finalization/${id}/issue`,
      {},
      {
        headers: this.getAuthHeaders(),
      }
    );
    return response.data;
  }

  async deleteAuditFinalization(id: string): Promise<void> {
    await axios.delete(`${API_URL}/audit-finalization/${id}`, {
      headers: this.getAuthHeaders(),
    });
  }

  async getAuditSummary(companyId: string, periodId: string): Promise<AuditSummary> {
    const response = await axios.get(`${API_URL}/audit-finalization/summary`, {
      headers: this.getAuthHeaders(),
      params: { companyId, periodId },
    });
    return response.data;
  }
}

export default new AuditFinalizationService();
