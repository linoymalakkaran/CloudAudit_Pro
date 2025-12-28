import api from './api';

export interface SystemConfiguration {
  id: string;
  tenantId: string;
  configKey: string;
  configValue: any;
  category: string;
  description?: string;
  dataType: string;
  isEncrypted: boolean;
  updatedBy: string;
  updatedAt: Date;
  createdAt: Date;
}

export interface CreateConfigDto {
  configKey: string;
  configValue: any;
  category: string;
  description?: string;
  dataType: string;
  isEncrypted?: boolean;
}

const systemConfigService = {
  async getAll(): Promise<SystemConfiguration[]> {
    const response = await api.get('/system-config');
    return response.data;
  },

  async getByKey(key: string): Promise<SystemConfiguration> {
    const response = await api.get(`/system-config/${key}`);
    return response.data;
  },

  async getByCategory(category: string): Promise<SystemConfiguration[]> {
    const response = await api.get(`/system-config/category/${category}`);
    return response.data;
  },

  async create(data: CreateConfigDto): Promise<SystemConfiguration> {
    const response = await api.post('/system-config', data);
    return response.data;
  },

  async update(key: string, data: Partial<CreateConfigDto>): Promise<SystemConfiguration> {
    const response = await api.patch(`/system-config/${key}`, data);
    return response.data;
  },

  async delete(key: string): Promise<void> {
    await api.delete(`/system-config/${key}`);
  },

  async bulkUpdate(configs: Array<{ configKey: string; configValue: any }>): Promise<void> {
    await api.post('/system-config/bulk', { configs });
  },

  async exportConfigs(): Promise<Blob> {
    const response = await api.get('/system-config/export', { responseType: 'blob' });
    return response.data;
  },

  async importConfigs(file: File): Promise<void> {
    const formData = new FormData();
    formData.append('file', file);
    await api.post('/system-config/import', formData, {
      headers: { 'Content-Type': 'multipart/form-data' },
    });
  },

  async getDefaults(): Promise<SystemConfiguration[]> {
    const response = await api.get('/system-config/defaults');
    return response.data;
  },

  async resetToDefaults(): Promise<void> {
    await api.post('/system-config/reset');
  },
};

export default systemConfigService;
