import api from './api';

export interface Integration {
  id: string;
  tenantId: string;
  integrationType: string;
  name: string;
  description?: string;
  configuration: any;
  syncFrequency?: string;
  lastSyncAt?: Date;
  nextSyncAt?: Date;
  status: string;
  isActive: boolean;
  errorMessage?: string;
  createdBy: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface IntegrationLog {
  id: string;
  integrationId: string;
  logType: string;
  message: string;
  details?: any;
  createdAt: Date;
}

export interface IntegrationStats {
  totalSyncs: number;
  successfulSyncs: number;
  failedSyncs: number;
  successRate: number;
  totalRecords: number;
  avgDuration: number;
  lastSyncAt?: Date;
}

export interface CreateIntegrationDto {
  integrationType: string;
  name: string;
  description?: string;
  configuration: any;
  syncFrequency?: string;
  isActive?: boolean;
}

const integrationsService = {
  async getAll(): Promise<Integration[]> {
    const response = await api.get('/integrations');
    return response.data;
  },

  async getActive(): Promise<Integration[]> {
    const response = await api.get('/integrations/active');
    return response.data;
  },

  async getById(id: string): Promise<Integration> {
    const response = await api.get(`/integrations/${id}`);
    return response.data;
  },

  async create(data: CreateIntegrationDto): Promise<Integration> {
    const response = await api.post('/integrations', data);
    return response.data;
  },

  async update(id: string, data: Partial<CreateIntegrationDto>): Promise<Integration> {
    const response = await api.patch(`/integrations/${id}`, data);
    return response.data;
  },

  async delete(id: string): Promise<void> {
    await api.delete(`/integrations/${id}`);
  },

  async testConnection(id: string): Promise<any> {
    const response = await api.post(`/integrations/${id}/test`);
    return response.data;
  },

  async sync(id: string): Promise<any> {
    const response = await api.post(`/integrations/${id}/sync`);
    return response.data;
  },

  async enable(id: string): Promise<Integration> {
    const response = await api.post(`/integrations/${id}/enable`);
    return response.data;
  },

  async disable(id: string): Promise<Integration> {
    const response = await api.post(`/integrations/${id}/disable`);
    return response.data;
  },

  async getLogs(id: string): Promise<IntegrationLog[]> {
    const response = await api.get(`/integrations/${id}/logs`);
    return response.data;
  },

  async getStats(id: string): Promise<IntegrationStats> {
    const response = await api.get(`/integrations/${id}/stats`);
    return response.data;
  },
};

export default integrationsService;
