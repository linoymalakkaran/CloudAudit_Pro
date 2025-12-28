import axios from 'axios';

const API_URL = process.env.REACT_APP_API_URL || 'http://localhost:3000/api';

export interface DocumentLink {
  id: string;
  documentId: string;
  linkedEntityType: string;
  linkedEntityId: string;
  linkType: string;
  linkDescription?: string;
  createdAt: string;
  document?: any;
}

export interface CreateDocumentLinkDto {
  documentId: string;
  linkedEntityType: string;
  linkedEntityId: string;
  linkType: string;
  linkDescription?: string;
}

export const documentLinksService = {
  async getAll() {
    const response = await axios.get(`${API_URL}/document-links`);
    return response.data;
  },

  async getById(id: string) {
    const response = await axios.get(`${API_URL}/document-links/${id}`);
    return response.data;
  },

  async getByDocument(documentId: string) {
    const response = await axios.get(`${API_URL}/document-links/document/${documentId}`);
    return response.data;
  },

  async getByEntity(entityType: string, entityId: string) {
    const response = await axios.get(`${API_URL}/document-links/entity/${entityType}/${entityId}`);
    return response.data;
  },

  async create(data: CreateDocumentLinkDto) {
    const response = await axios.post(`${API_URL}/document-links`, data);
    return response.data;
  },

  async createBulk(links: CreateDocumentLinkDto[]) {
    const response = await axios.post(`${API_URL}/document-links/bulk`, { links });
    return response.data;
  },

  async update(id: string, data: Partial<CreateDocumentLinkDto>) {
    const response = await axios.patch(`${API_URL}/document-links/${id}`, data);
    return response.data;
  },

  async delete(id: string) {
    await axios.delete(`${API_URL}/document-links/${id}`);
  },
};
