import axios from 'axios';

const API_URL = process.env.REACT_APP_API_URL || 'http://localhost:3000/api';

export interface DocumentTemplate {
  id: string;
  name: string;
  description?: string;
  category: string;
  templateType: string;
  fileName?: string;
  filePath?: string;
  fileSize?: number;
  isActive: boolean;
  fields?: any;
  createdAt: string;
  updatedAt: string;
  creator?: any;
  updater?: any;
}

export interface CreateDocumentTemplateDto {
  name: string;
  description?: string;
  category: string;
  templateType: string;
  isActive?: boolean;
  fields?: any;
}

export interface GenerateFromTemplateDto {
  name: string;
  companyId: string;
  periodId?: string;
  fieldValues?: any;
}

export const documentTemplatesService = {
  async getAll(category?: string, templateType?: string, isActive?: boolean) {
    const params: any = {};
    if (category) params.category = category;
    if (templateType) params.templateType = templateType;
    if (isActive !== undefined) params.isActive = isActive;
    
    const response = await axios.get(`${API_URL}/document-templates`, { params });
    return response.data;
  },

  async getById(id: string) {
    const response = await axios.get(`${API_URL}/document-templates/${id}`);
    return response.data;
  },

  async getByCategory(category: string) {
    const response = await axios.get(`${API_URL}/document-templates/category/${category}`);
    return response.data;
  },

  async create(data: CreateDocumentTemplateDto, file?: File) {
    const formData = new FormData();
    Object.keys(data).forEach(key => {
      const value = (data as any)[key];
      if (value !== undefined && value !== null) {
        formData.append(key, typeof value === 'object' ? JSON.stringify(value) : value);
      }
    });
    if (file) {
      formData.append('file', file);
    }

    const response = await axios.post(`${API_URL}/document-templates`, formData, {
      headers: { 'Content-Type': 'multipart/form-data' },
    });
    return response.data;
  },

  async update(id: string, data: Partial<CreateDocumentTemplateDto>, file?: File) {
    const formData = new FormData();
    Object.keys(data).forEach(key => {
      const value = (data as any)[key];
      if (value !== undefined && value !== null) {
        formData.append(key, typeof value === 'object' ? JSON.stringify(value) : value);
      }
    });
    if (file) {
      formData.append('file', file);
    }

    const response = await axios.patch(`${API_URL}/document-templates/${id}`, formData, {
      headers: { 'Content-Type': 'multipart/form-data' },
    });
    return response.data;
  },

  async delete(id: string) {
    await axios.delete(`${API_URL}/document-templates/${id}`);
  },

  async toggleActive(id: string) {
    const response = await axios.post(`${API_URL}/document-templates/${id}/activate`);
    return response.data;
  },

  async generateFromTemplate(id: string, data: GenerateFromTemplateDto) {
    const response = await axios.post(`${API_URL}/document-templates/${id}/generate`, data);
    return response.data;
  },
};
