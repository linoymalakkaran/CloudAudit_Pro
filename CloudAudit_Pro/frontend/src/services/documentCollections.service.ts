import axios from 'axios';

const API_URL = process.env.REACT_APP_API_URL || 'http://localhost:3000/api';

export interface DocumentCollection {
  id: string;
  name: string;
  description?: string;
  collectionType: string;
  status: string;
  companyId: string;
  periodId?: string;
  dueDate?: string;
  assignedTo?: string;
  sentDate?: string;
  completedDate?: string;
  createdAt: string;
  company?: any;
  period?: any;
  assignedToUser?: any;
  items?: DocumentCollectionItem[];
}

export interface DocumentCollectionItem {
  id: string;
  collectionId: string;
  documentType: string;
  requiredDocument: string;
  status: string;
  notes?: string;
  documentId?: string;
  uploadedBy?: string;
  uploadedAt?: string;
  document?: any;
  uploadedByUser?: any;
}

export interface CreateDocumentCollectionDto {
  companyId: string;
  periodId?: string;
  name: string;
  description?: string;
  collectionType: string;
  dueDate?: string;
  assignedTo?: string;
}

export interface CreateCollectionItemDto {
  documentType: string;
  requiredDocument: string;
  notes?: string;
}

export const documentCollectionsService = {
  async getAll(companyId?: string, periodId?: string, status?: string, collectionType?: string) {
    const params: any = {};
    if (companyId) params.companyId = companyId;
    if (periodId) params.periodId = periodId;
    if (status) params.status = status;
    if (collectionType) params.collectionType = collectionType;
    
    const response = await axios.get(`${API_URL}/document-collections`, { params });
    return response.data;
  },

  async getById(id: string) {
    const response = await axios.get(`${API_URL}/document-collections/${id}`);
    return response.data;
  },

  async create(data: CreateDocumentCollectionDto) {
    const response = await axios.post(`${API_URL}/document-collections`, data);
    return response.data;
  },

  async update(id: string, data: Partial<CreateDocumentCollectionDto>) {
    const response = await axios.patch(`${API_URL}/document-collections/${id}`, data);
    return response.data;
  },

  async delete(id: string) {
    await axios.delete(`${API_URL}/document-collections/${id}`);
  },

  async updateStatus(id: string, status: string) {
    const response = await axios.post(`${API_URL}/document-collections/${id}/status`, { status });
    return response.data;
  },

  async getProgress(id: string) {
    const response = await axios.get(`${API_URL}/document-collections/${id}/progress`);
    return response.data;
  },

  // Collection Items
  async addItem(collectionId: string, data: CreateCollectionItemDto) {
    const response = await axios.post(`${API_URL}/document-collections/${collectionId}/items`, data);
    return response.data;
  },

  async updateItem(itemId: string, data: Partial<CreateCollectionItemDto>) {
    const response = await axios.patch(`${API_URL}/document-collections/items/${itemId}`, data);
    return response.data;
  },

  async removeItem(itemId: string) {
    await axios.delete(`${API_URL}/document-collections/items/${itemId}`);
  },

  async uploadDocument(itemId: string, documentId: string) {
    const response = await axios.post(`${API_URL}/document-collections/items/${itemId}/upload`, {
      documentId,
    });
    return response.data;
  },
};
