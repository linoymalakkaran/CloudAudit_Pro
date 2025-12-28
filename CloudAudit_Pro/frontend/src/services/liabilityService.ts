import api from './api';

export interface Liability {
  id: string;
  companyId: string;
  periodId: string;
  type: string;
  creditorName: string;
  description: string;
  referenceNumber?: string;
  originalAmount: number;
  outstandingBalance: number;
  dueDate: string;
  daysOverdue: number;
  agingCategory: string;
  interestRate?: number;
  paymentTerms?: string;
  collateral?: string;
  notes?: string;
  isCurrent: boolean;
  isFinished: boolean;
  company: { name: string };
  period: { name: string };
  createdAt: string;
  updatedAt: string;
}

export interface CreateLiabilityDto {
  companyId: string;
  periodId: string;
  type: string;
  creditorName: string;
  description: string;
  referenceNumber?: string;
  originalAmount: number;
  outstandingBalance: number;
  dueDate: string;
  interestRate?: number;
  paymentTerms?: string;
  collateral?: string;
  notes?: string;
  isCurrent?: boolean;
  isFinished?: boolean;
}

export interface UpdateLiabilityDto extends Partial<CreateLiabilityDto> {}

const liabilityService = {
  getAll: (companyId?: string, periodId?: string, type?: string, isCurrent?: boolean) => {
    const params = new URLSearchParams();
    if (companyId) params.append('companyId', companyId);
    if (periodId) params.append('periodId', periodId);
    if (type) params.append('type', type);
    if (isCurrent !== undefined) params.append('isCurrent', String(isCurrent));
    const queryString = params.toString();
    return api.get<Liability[]>(`/liabilities${queryString ? '?' + queryString : ''}`);
  },

  getById: (id: string) => {
    return api.get<Liability>(`/liabilities/${id}`);
  },

  create: (data: CreateLiabilityDto) => {
    return api.post<Liability>('/liabilities', data);
  },

  update: (id: string, data: UpdateLiabilityDto) => {
    return api.patch<Liability>(`/liabilities/${id}`, data);
  },

  delete: (id: string) => {
    return api.delete(`/liabilities/${id}`);
  },

  getAgingSummary: (companyId: string, periodId: string) => {
    return api.get<any>(`/liabilities/aging-summary?companyId=${companyId}&periodId=${periodId}`);
  },
};

export default liabilityService;
