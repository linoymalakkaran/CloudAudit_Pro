import api from './api';

export enum DepreciationMethod {
  STRAIGHT_LINE = 'STRAIGHT_LINE',
  DECLINING_BALANCE = 'DECLINING_BALANCE',
  UNITS_OF_PRODUCTION = 'UNITS_OF_PRODUCTION',
}

export enum AssetStatus {
  ACTIVE = 'ACTIVE',
  DISPOSED = 'DISPOSED',
  FULLY_DEPRECIATED = 'FULLY_DEPRECIATED',
}

export interface FixedAsset {
  id: string;
  companyId: string;
  periodId: string;
  category: string;
  description: string;
  referenceNumber?: string;
  purchaseDate: string;
  originalCost: number;
  accumulatedDepreciation: number;
  depreciationExpense: number;
  netBookValue: number;
  depreciationMethod: DepreciationMethod;
  usefulLife: number;
  salvageValue: number;
  location?: string;
  notes?: string;
  status: AssetStatus;
  disposalDate?: string;
  disposalAmount?: number;
  isFinished: boolean;
  company: { name: string };
  period: { name: string };
  createdAt: string;
  updatedAt: string;
}

export interface CreateFixedAssetDto {
  companyId: string;
  periodId: string;
  category: string;
  description: string;
  referenceNumber?: string;
  purchaseDate: string;
  originalCost: number;
  accumulatedDepreciation?: number;
  depreciationMethod: DepreciationMethod;
  usefulLife: number;
  salvageValue?: number;
  location?: string;
  notes?: string;
  status?: AssetStatus;
  disposalDate?: string;
  disposalAmount?: number;
  isFinished?: boolean;
}

export interface UpdateFixedAssetDto extends Partial<CreateFixedAssetDto> {}

const fixedAssetService = {
  getAll: (companyId?: string, periodId?: string, category?: string) => {
    const params = new URLSearchParams();
    if (companyId) params.append('companyId', companyId);
    if (periodId) params.append('periodId', periodId);
    if (category) params.append('category', category);
    const queryString = params.toString();
    return api.get<FixedAsset[]>(`/fixed-assets${queryString ? '?' + queryString : ''}`);
  },

  getById: (id: string) => {
    return api.get<FixedAsset>(`/fixed-assets/${id}`);
  },

  create: (data: CreateFixedAssetDto) => {
    return api.post<FixedAsset>('/fixed-assets', data);
  },

  update: (id: string, data: UpdateFixedAssetDto) => {
    return api.patch<FixedAsset>(`/fixed-assets/${id}`, data);
  },

  delete: (id: string) => {
    return api.delete(`/fixed-assets/${id}`);
  },

  getSummary: (companyId: string, periodId: string) => {
    return api.get<any[]>(`/fixed-assets/summary?companyId=${companyId}&periodId=${periodId}`);
  },
};

export default fixedAssetService;
