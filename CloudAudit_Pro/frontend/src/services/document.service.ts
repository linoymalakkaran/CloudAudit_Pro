import axios from 'axios';

const API_URL = process.env.REACT_APP_API_URL || 'http://localhost:3000/api';

export interface Document {
  id: string;
  name: string;
  description?: string;
  type: string;
  status: string;
  category?: string;
  tags?: string[];
  fileName?: string;
  filePath?: string;
  fileSize?: number;
  mimeType?: string;
  companyId: string;
  periodId?: string;
  accountId?: string;
  version?: number;
  isLocked?: boolean;
  checkoutBy?: string;
  checkoutAt?: string;
  createdAt: string;
  updatedAt: string;
  company?: any;
  period?: any;
  account?: any;
  createdByUser?: any;
  versions?: any[];
}

export interface CreateDocumentDto {
  name: string;
  description?: string;
  type: string;
  companyId: string;
  periodId?: string;
  accountId?: string;
  tags?: string[];
}

export const documentService = {
  async getAll(companyId?: string, periodId?: string, type?: string, status?: string) {
    const params: any = {};
    if (companyId) params.companyId = companyId;
    if (periodId) params.periodId = periodId;
    if (type) params.type = type;
    if (status) params.status = status;
    
    const response = await axios.get(`${API_URL}/documents`, { params });
    return response.data;
  },

  async getById(id: string) {
    const response = await axios.get(`${API_URL}/documents/${id}`);
    return response.data;
  },

  async create(data: CreateDocumentDto, file?: File) {
    const formData = new FormData();
    Object.keys(data).forEach(key => {
      const value = (data as any)[key];
      if (value !== undefined && value !== null) {
        if (Array.isArray(value)) {
          value.forEach(v => formData.append(key, v));
        } else {
          formData.append(key, value);
        }
      }
    });
    if (file) {
      formData.append('file', file);
    }

    const response = await axios.post(`${API_URL}/documents`, formData, {
      headers: { 'Content-Type': 'multipart/form-data' },
    });
    return response.data;
  },

  async update(id: string, data: Partial<CreateDocumentDto>) {
    const response = await axios.patch(`${API_URL}/documents/${id}`, data);
    return response.data;
  },

  async delete(id: string) {
    await axios.delete(`${API_URL}/documents/${id}`);
  },

  async download(id: string, fileName: string) {
    const response = await axios.get(`${API_URL}/documents/${id}/download`, {
      responseType: 'blob',
    });
    
    const url = window.URL.createObjectURL(new Blob([response.data]));
    const link = document.createElement('a');
    link.href = url;
    link.setAttribute('download', fileName);
    document.body.appendChild(link);
    link.click();
    link.remove();
  },

  // Version Management
  async getVersions(id: string) {
    const response = await axios.get(`${API_URL}/documents/${id}/versions`);
    return response.data;
  },

  async createVersion(id: string, file: File, comment?: string) {
    const formData = new FormData();
    formData.append('file', file);
    if (comment) formData.append('comment', comment);

    const response = await axios.post(`${API_URL}/documents/${id}/versions`, formData, {
      headers: { 'Content-Type': 'multipart/form-data' },
    });
    return response.data;
  },

  // Checkout/Checkin
  async checkout(id: string) {
    const response = await axios.post(`${API_URL}/documents/${id}/checkout`);
    return response.data;
  },

  async checkin(id: string, file?: File) {
    const formData = new FormData();
    if (file) formData.append('file', file);

    const response = await axios.post(`${API_URL}/documents/${id}/checkin`, formData, {
      headers: { 'Content-Type': 'multipart/form-data' },
    });
    return response.data;
  },

  async unlock(id: string) {
    const response = await axios.post(`${API_URL}/documents/${id}/unlock`);
    return response.data;
  },

  // Advanced Operations
  async duplicate(id: string) {
    const response = await axios.post(`${API_URL}/documents/${id}/duplicate`);
    return response.data;
  },

  async archive(id: string) {
    const response = await axios.post(`${API_URL}/documents/${id}/archive`);
    return response.data;
  },

  async search(searchTerm: string, filters?: any) {
    const params: any = { q: searchTerm };
    if (filters) {
      Object.keys(filters).forEach(key => {
        if (filters[key]) params[key] = filters[key];
      });
    }
    
    const response = await axios.get(`${API_URL}/documents/search`, { params });
    return response.data;
  },

  async getRecent(limit?: number) {
    const params = limit ? { limit } : {};
    const response = await axios.get(`${API_URL}/documents/recent`, { params });
    return response.data;
  },

  async getStatistics(companyId?: string) {
    const params = companyId ? { companyId } : {};
    const response = await axios.get(`${API_URL}/documents/statistics`, { params });
    return response.data;
  },

  // Client Portal Methods
  async getDocuments(params: { companyId: string; type?: string }) {
    const response = await axios.get(`${API_URL}/documents`, { params });
    return response.data;
  },

  async uploadDocument(formData: FormData) {
    const response = await axios.post(`${API_URL}/documents/upload`, formData, {
      headers: { 'Content-Type': 'multipart/form-data' },
    });
    return response.data;
  },

  async downloadDocument(documentId: string) {
    const response = await axios.get(`${API_URL}/documents/${documentId}/download`, {
      responseType: 'blob',
    });
    return response.data;
  },
};
