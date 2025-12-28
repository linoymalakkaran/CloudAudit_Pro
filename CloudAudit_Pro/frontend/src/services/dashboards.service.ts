import axios from 'axios';

const API_URL = import.meta.env.VITE_API_URL || 'http://localhost:3000';

export interface Dashboard {
  id: string;
  tenantId: string;
  name: string;
  description?: string;
  layout?: any;
  isDefault: boolean;
  companyId?: string;
  periodId?: string;
  widgets?: WidgetConfig[];
  sharedWith?: string[];
  isPublic: boolean;
  createdAt: Date;
  updatedAt: Date;
  company?: { name: string };
  period?: { name: string };
  createdByUser?: { email: string; firstName: string; lastName: string };
}

export interface WidgetConfig {
  type: string;
  title: string;
  size?: { width: number; height: number };
  position?: { x: number; y: number };
  dataSource?: any;
  settings?: any;
}

export interface CreateDashboardDto {
  name: string;
  description?: string;
  companyId?: string;
  periodId?: string;
  layout?: any;
  widgets?: WidgetConfig[];
  sharedWith?: string[];
  isPublic?: boolean;
  isDefault?: boolean;
}

export interface WidgetDataRequest {
  widgetType: string;
  companyId?: string;
  periodId?: string;
  period?: 'TODAY' | 'THIS_WEEK' | 'THIS_MONTH' | 'THIS_QUARTER' | 'THIS_YEAR' | 'CUSTOM';
  filters?: any;
  parameters?: any;
}

class DashboardsService {
  private getAuthHeaders() {
    const token = localStorage.getItem('accessToken');
    return {
      headers: {
        Authorization: `Bearer ${token}`,
        'Content-Type': 'application/json',
      },
    };
  }

  async createDashboard(data: CreateDashboardDto): Promise<Dashboard> {
    const response = await axios.post(`${API_URL}/dashboards`, data, this.getAuthHeaders());
    return response.data;
  }

  async getDashboards(companyId?: string): Promise<Dashboard[]> {
    const params = companyId ? `?companyId=${companyId}` : '';
    const response = await axios.get(`${API_URL}/dashboards${params}`, this.getAuthHeaders());
    return response.data;
  }

  async getDefaultDashboard(): Promise<Dashboard> {
    const response = await axios.get(`${API_URL}/dashboards/default`, this.getAuthHeaders());
    return response.data;
  }

  async getDashboard(id: string): Promise<Dashboard> {
    const response = await axios.get(`${API_URL}/dashboards/${id}`, this.getAuthHeaders());
    return response.data;
  }

  async updateDashboard(id: string, data: Partial<CreateDashboardDto>): Promise<Dashboard> {
    const response = await axios.patch(
      `${API_URL}/dashboards/${id}`,
      data,
      this.getAuthHeaders()
    );
    return response.data;
  }

  async deleteDashboard(id: string): Promise<void> {
    await axios.delete(`${API_URL}/dashboards/${id}`, this.getAuthHeaders());
  }

  async duplicateDashboard(id: string): Promise<Dashboard> {
    const response = await axios.post(
      `${API_URL}/dashboards/${id}/duplicate`,
      {},
      this.getAuthHeaders()
    );
    return response.data;
  }

  async setDefaultDashboard(id: string): Promise<Dashboard> {
    const response = await axios.post(
      `${API_URL}/dashboards/${id}/set-default`,
      {},
      this.getAuthHeaders()
    );
    return response.data;
  }

  async shareDashboard(id: string, userIds: string[]): Promise<Dashboard> {
    const response = await axios.post(
      `${API_URL}/dashboards/${id}/share`,
      { userIds },
      this.getAuthHeaders()
    );
    return response.data;
  }

  async unshareDashboard(id: string, userIds: string[]): Promise<Dashboard> {
    const response = await axios.post(
      `${API_URL}/dashboards/${id}/unshare`,
      { userIds },
      this.getAuthHeaders()
    );
    return response.data;
  }

  async getWidgetData(request: WidgetDataRequest): Promise<any> {
    const response = await axios.post(
      `${API_URL}/dashboards/widget-data`,
      request,
      this.getAuthHeaders()
    );
    return response.data;
  }
}

export default new DashboardsService();
