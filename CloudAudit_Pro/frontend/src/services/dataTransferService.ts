import api from './api';

export interface DataImport {
  id: string;
  tenantId: string;
  companyId: string;
  importType: string;
  fileName: string;
  filePath: string;
  fileSize: number;
  status: string;
  recordsTotal: number;
  recordsProcessed: number;
  recordsFailed: number;
  mapping?: any;
  errorDetails?: any;
  processedBy?: string;
  processedAt?: Date;
  createdBy: string;
  createdAt: Date;
}

export interface DataExport {
  id: string;
  tenantId: string;
  companyId: string;
  exportType: string;
  format: string;
  status: string;
  fileName?: string;
  filePath?: string;
  fileSize?: number;
  recordsCount?: number;
  filters?: any;
  options?: any;
  expiresAt?: Date;
  processedBy?: string;
  processedAt?: Date;
  createdBy: string;
  createdAt: Date;
}

export interface CreateImportDto {
  companyId: string;
  importType: string;
  mapping?: any;
}

export interface CreateExportDto {
  companyId: string;
  exportType: string;
  format: string;
  filters?: any;
  options?: any;
}

const dataImportService = {
  async upload(file: File, data: CreateImportDto): Promise<DataImport> {
    const formData = new FormData();
    formData.append('file', file);
    formData.append('companyId', data.companyId);
    formData.append('importType', data.importType);
    if (data.mapping) {
      formData.append('mapping', JSON.stringify(data.mapping));
    }
    
    const response = await api.post('/data-import', formData, {
      headers: { 'Content-Type': 'multipart/form-data' },
    });
    return response.data;
  },

  async getAll(): Promise<DataImport[]> {
    const response = await api.get('/data-import');
    return response.data;
  },

  async getById(id: string): Promise<DataImport> {
    const response = await api.get(`/data-import/${id}`);
    return response.data;
  },

  async validate(id: string): Promise<any> {
    const response = await api.post(`/data-import/${id}/validate`);
    return response.data;
  },

  async process(id: string): Promise<DataImport> {
    const response = await api.post(`/data-import/${id}/process`);
    return response.data;
  },

  async rollback(id: string): Promise<void> {
    await api.post(`/data-import/${id}/rollback`);
  },

  async delete(id: string): Promise<void> {
    await api.delete(`/data-import/${id}`);
  },

  async getTemplate(importType: string): Promise<Blob> {
    const response = await api.get(`/data-import/templates/${importType}`, {
      responseType: 'blob',
    });
    return response.data;
  },

  async downloadErrors(id: string): Promise<Blob> {
    const response = await api.get(`/data-import/${id}/download-errors`, {
      responseType: 'blob',
    });
    return response.data;
  },
};

const dataExportService = {
  async create(data: CreateExportDto): Promise<DataExport> {
    const response = await api.post('/data-export', data);
    return response.data;
  },

  async getAll(): Promise<DataExport[]> {
    const response = await api.get('/data-export');
    return response.data;
  },

  async getById(id: string): Promise<DataExport> {
    const response = await api.get(`/data-export/${id}`);
    return response.data;
  },

  async process(id: string): Promise<DataExport> {
    const response = await api.post(`/data-export/${id}/process`);
    return response.data;
  },

  async download(id: string): Promise<Blob> {
    const response = await api.get(`/data-export/${id}/download`, {
      responseType: 'blob',
    });
    return response.data;
  },

  async quickExport(data: CreateExportDto): Promise<Blob> {
    const response = await api.post('/data-export/quick', data, {
      responseType: 'blob',
    });
    return response.data;
  },

  async delete(id: string): Promise<void> {
    await api.delete(`/data-export/${id}`);
  },
};

export { dataImportService, dataExportService };
