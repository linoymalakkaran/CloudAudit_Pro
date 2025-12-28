import axios from 'axios';
import { ReportType, ReportCategory, ReportStatus, ExportFormat } from '../types/report.types';

const API_URL = import.meta.env.VITE_API_URL || 'http://localhost:3000';

export interface Report {
  id: string;
  tenantId: string;
  companyId: string;
  periodId?: string;
  name: string;
  description?: string;
  reportType: ReportType;
  category: ReportCategory;
  templateId?: string;
  parameters?: any;
  filters?: any;
  status: ReportStatus;
  generatedBy: string;
  generatedAt?: Date;
  filePath?: string;
  fileName?: string;
  fileSize?: number;
  fileType?: string;
  isScheduled: boolean;
  scheduleFrequency?: string;
  lastRunAt?: Date;
  nextRunAt?: Date;
  recipients?: string[];
  emailOnCompletion: boolean;
  createdAt: Date;
  updatedAt: Date;
  company?: { name: string };
  period?: { name: string };
  template?: { name: string };
  createdByUser?: { email: string; firstName: string; lastName: string };
}

export interface CreateReportDto {
  companyId: string;
  periodId?: string;
  name: string;
  description?: string;
  reportType: ReportType;
  category: ReportCategory;
  templateId?: string;
  parameters?: any;
  filters?: any;
  isScheduled?: boolean;
  scheduleFrequency?: string;
  recipients?: string[];
  emailOnCompletion?: boolean;
}

export interface GenerateReportDto {
  companyId: string;
  periodId?: string;
  parameters?: any;
  filters?: any;
  format?: ExportFormat;
}

export interface ReportSummary {
  totalReports: number;
  byType: Record<string, number>;
  byStatus: Record<string, number>;
}

class ReportsService {
  private getAuthHeaders() {
    const token = localStorage.getItem('accessToken');
    return {
      headers: {
        Authorization: `Bearer ${token}`,
        'Content-Type': 'application/json',
      },
    };
  }

  async createReport(data: CreateReportDto): Promise<Report> {
    const response = await axios.post(`${API_URL}/reports`, data, this.getAuthHeaders());
    return response.data;
  }

  async getReports(filters?: {
    companyId?: string;
    periodId?: string;
    reportType?: ReportType;
    status?: ReportStatus;
  }): Promise<Report[]> {
    const params = new URLSearchParams();
    if (filters?.companyId) params.append('companyId', filters.companyId);
    if (filters?.periodId) params.append('periodId', filters.periodId);
    if (filters?.reportType) params.append('reportType', filters.reportType);
    if (filters?.status) params.append('status', filters.status);

    const response = await axios.get(
      `${API_URL}/reports?${params.toString()}`,
      this.getAuthHeaders()
    );
    return response.data;
  }

  async getReport(id: string): Promise<Report> {
    const response = await axios.get(`${API_URL}/reports/${id}`, this.getAuthHeaders());
    return response.data;
  }

  async updateReport(id: string, data: Partial<CreateReportDto>): Promise<Report> {
    const response = await axios.patch(`${API_URL}/reports/${id}`, data, this.getAuthHeaders());
    return response.data;
  }

  async deleteReport(id: string): Promise<void> {
    await axios.delete(`${API_URL}/reports/${id}`, this.getAuthHeaders());
  }

  async generateReport(reportType: ReportType, data: GenerateReportDto): Promise<Report> {
    const response = await axios.post(
      `${API_URL}/reports/generate/${reportType}`,
      data,
      this.getAuthHeaders()
    );
    return response.data;
  }

  async duplicateReport(id: string): Promise<Report> {
    const response = await axios.post(
      `${API_URL}/reports/${id}/duplicate`,
      {},
      this.getAuthHeaders()
    );
    return response.data;
  }

  async getRecentReports(limit: number = 10): Promise<Report[]> {
    const response = await axios.get(
      `${API_URL}/reports/recent?limit=${limit}`,
      this.getAuthHeaders()
    );
    return response.data;
  }

  async getReportSummary(companyId?: string): Promise<ReportSummary> {
    const params = companyId ? `?companyId=${companyId}` : '';
    const response = await axios.get(
      `${API_URL}/reports/summary${params}`,
      this.getAuthHeaders()
    );
    return response.data;
  }
}

export default new ReportsService();
