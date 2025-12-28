import api from './api';

export interface Equity {
  id: string;
  companyId: string;
  periodId: string;
  type: string;
  description: string;
  openingBalance: number;
  additions: number;
  reductions: number;
  movement: number;
  closingBalance: number;
  transactionDate?: string;
  referenceNumber?: string;
  notes?: string;
  isFinished: boolean;
  company: { name: string };
  period: { name: string };
  createdAt: string;
  updatedAt: string;
}

export interface CreateEquityDto {
  companyId: string;
  periodId: string;
  type: string;
  description: string;
  openingBalance: number;
  additions?: number;
  reductions?: number;
  closingBalance: number;
  transactionDate?: string;
  referenceNumber?: string;
  notes?: string;
  isFinished?: boolean;
}

export interface UpdateEquityDto extends Partial<CreateEquityDto> {}

const equityService = {
  getAll: (companyId?: string, periodId?: string, type?: string) => {
    const params = new URLSearchParams();
    if (companyId) params.append('companyId', companyId);
    if (periodId) params.append('periodId', periodId);
    if (type) params.append('type', type);
    const queryString = params.toString();
    return api.get<Equity[]>(`/equity${queryString ? '?' + queryString : ''}`);
  },

  getById: (id: string) => {
    return api.get<Equity>(`/equity/${id}`);
  },

  create: (data: CreateEquityDto) => {
    return api.post<Equity>('/equity', data);
  },

  update: (id: string, data: UpdateEquityDto) => {
    return api.patch<Equity>(`/equity/${id}`, data);
  },

  delete: (id: string) => {
    return api.delete(`/equity/${id}`);
  },

  getSummary: (companyId: string, periodId: string) => {
    return api.get<any[]>(`/equity/summary?companyId=${companyId}&periodId=${periodId}`);
  },
};

export default equityService;
