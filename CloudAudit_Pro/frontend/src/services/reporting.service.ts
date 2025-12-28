import axios from 'axios';

const API_URL = import.meta.env.VITE_API_URL || 'http://localhost:3000';

export interface ReportTemplate {
  id: string;
  tenantId: string;
  name: string;
  description?: string;
  reportType: string;
  category: string;
  isStandard: boolean;
  isActive: boolean;
  templateDefinition?: any;
  dataSource?: any;
  formatting?: any;
  parameters?: any;
  createdAt: Date;
  updatedAt: Date;
}

export interface ReportSchedule {
  id: string;
  tenantId: string;
  reportId?: string;
  reportTemplateId?: string;
  companyId: string;
  periodId?: string;
  frequency: string;
  scheduleTime?: string;
  timezone: string;
  isActive: boolean;
  lastRunAt?: Date;
  nextRunAt?: Date;
  parameters?: any;
  filters?: any;
  recipients?: string[];
  emailSubject?: string;
  emailBody?: string;
  createdAt: Date;
  updatedAt: Date;
}

class ReportingService {
  private getAuthHeaders() {
    const token = localStorage.getItem('accessToken');
    return {
      headers: {
        Authorization: `Bearer ${token}`,
        'Content-Type': 'application/json',
      },
    };
  }

  // Report Templates
  async getTemplates(reportType?: string, isActive?: boolean): Promise<ReportTemplate[]> {
    const params = new URLSearchParams();
    if (reportType) params.append('reportType', reportType);
    if (isActive !== undefined) params.append('isActive', isActive.toString());

    const response = await axios.get(
      `${API_URL}/report-templates?${params.toString()}`,
      this.getAuthHeaders()
    );
    return response.data;
  }

  async getTemplate(id: string): Promise<ReportTemplate> {
    const response = await axios.get(
      `${API_URL}/report-templates/${id}`,
      this.getAuthHeaders()
    );
    return response.data;
  }

  async getStandardTemplates(): Promise<ReportTemplate[]> {
    const response = await axios.get(
      `${API_URL}/report-templates/standard`,
      this.getAuthHeaders()
    );
    return response.data;
  }

  async createTemplate(data: Partial<ReportTemplate>): Promise<ReportTemplate> {
    const response = await axios.post(
      `${API_URL}/report-templates`,
      data,
      this.getAuthHeaders()
    );
    return response.data;
  }

  async updateTemplate(id: string, data: Partial<ReportTemplate>): Promise<ReportTemplate> {
    const response = await axios.patch(
      `${API_URL}/report-templates/${id}`,
      data,
      this.getAuthHeaders()
    );
    return response.data;
  }

  async deleteTemplate(id: string): Promise<void> {
    await axios.delete(`${API_URL}/report-templates/${id}`, this.getAuthHeaders());
  }

  async duplicateTemplate(id: string): Promise<ReportTemplate> {
    const response = await axios.post(
      `${API_URL}/report-templates/${id}/duplicate`,
      {},
      this.getAuthHeaders()
    );
    return response.data;
  }

  async toggleTemplateActive(id: string): Promise<ReportTemplate> {
    const response = await axios.post(
      `${API_URL}/report-templates/${id}/toggle-active`,
      {},
      this.getAuthHeaders()
    );
    return response.data;
  }

  // Report Schedules
  async getSchedules(companyId?: string, isActive?: boolean): Promise<ReportSchedule[]> {
    const params = new URLSearchParams();
    if (companyId) params.append('companyId', companyId);
    if (isActive !== undefined) params.append('isActive', isActive.toString());

    const response = await axios.get(
      `${API_URL}/report-schedules?${params.toString()}`,
      this.getAuthHeaders()
    );
    return response.data;
  }

  async getSchedule(id: string): Promise<ReportSchedule> {
    const response = await axios.get(
      `${API_URL}/report-schedules/${id}`,
      this.getAuthHeaders()
    );
    return response.data;
  }

  async getUpcomingSchedules(companyId?: string, days?: number): Promise<ReportSchedule[]> {
    const params = new URLSearchParams();
    if (companyId) params.append('companyId', companyId);
    if (days) params.append('days', days.toString());

    const response = await axios.get(
      `${API_URL}/report-schedules/upcoming?${params.toString()}`,
      this.getAuthHeaders()
    );
    return response.data;
  }

  async getScheduleHistory(companyId?: string, limit?: number): Promise<ReportSchedule[]> {
    const params = new URLSearchParams();
    if (companyId) params.append('companyId', companyId);
    if (limit) params.append('limit', limit.toString());

    const response = await axios.get(
      `${API_URL}/report-schedules/history?${params.toString()}`,
      this.getAuthHeaders()
    );
    return response.data;
  }

  async createSchedule(data: Partial<ReportSchedule>): Promise<ReportSchedule> {
    const response = await axios.post(
      `${API_URL}/report-schedules`,
      data,
      this.getAuthHeaders()
    );
    return response.data;
  }

  async updateSchedule(id: string, data: Partial<ReportSchedule>): Promise<ReportSchedule> {
    const response = await axios.patch(
      `${API_URL}/report-schedules/${id}`,
      data,
      this.getAuthHeaders()
    );
    return response.data;
  }

  async deleteSchedule(id: string): Promise<void> {
    await axios.delete(`${API_URL}/report-schedules/${id}`, this.getAuthHeaders());
  }

  async runScheduleNow(id: string): Promise<any> {
    const response = await axios.post(
      `${API_URL}/report-schedules/${id}/run-now`,
      {},
      this.getAuthHeaders()
    );
    return response.data;
  }

  async toggleScheduleActive(id: string): Promise<ReportSchedule> {
    const response = await axios.post(
      `${API_URL}/report-schedules/${id}/toggle-active`,
      {},
      this.getAuthHeaders()
    );
    return response.data;
  }
}

export default new ReportingService();
