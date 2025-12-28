import api from './api';

export interface UserPreference {
  id: string;
  userId: string;
  tenantId: string;
  preferenceKey: string;
  preferenceValue: string;
  category: string;
  dataType: string;
  updatedAt: Date;
  createdAt: Date;
}

export interface CreatePreferenceDto {
  preferenceKey: string;
  preferenceValue: string;
  category: string;
  dataType?: string;
}

const userPreferencesService = {
  async getAll(): Promise<UserPreference[]> {
    const response = await api.get('/user-preferences');
    return response.data;
  },

  async getByKey(key: string): Promise<UserPreference> {
    const response = await api.get(`/user-preferences/${key}`);
    return response.data;
  },

  async getByCategory(category: string): Promise<UserPreference[]> {
    const response = await api.get(`/user-preferences/category/${category}`);
    return response.data;
  },

  async create(data: CreatePreferenceDto): Promise<UserPreference> {
    const response = await api.post('/user-preferences', data);
    return response.data;
  },

  async update(key: string, data: Partial<CreatePreferenceDto>): Promise<UserPreference> {
    const response = await api.patch(`/user-preferences/${key}`, data);
    return response.data;
  },

  async delete(key: string): Promise<void> {
    await api.delete(`/user-preferences/${key}`);
  },

  async bulkUpdate(preferences: CreatePreferenceDto[]): Promise<UserPreference[]> {
    const response = await api.post('/user-preferences/bulk-update', { preferences });
    return response.data;
  },

  async exportPreferences(): Promise<Blob> {
    const response = await api.get('/user-preferences/export', {
      responseType: 'blob',
    });
    return response.data;
  },

  async importPreferences(file: File): Promise<void> {
    const formData = new FormData();
    formData.append('file', file);
    await api.post('/user-preferences/import', formData, {
      headers: { 'Content-Type': 'multipart/form-data' },
    });
  },

  async resetToDefaults(): Promise<void> {
    await api.post('/user-preferences/reset-defaults');
  },
};

export default userPreferencesService;
