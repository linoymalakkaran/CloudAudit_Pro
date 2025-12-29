import axios from 'axios';

const API_BASE = process.env.REACT_APP_API_URL || 'http://localhost:3000';

export interface Sampling {
  id: string;
  tenantId: string;
  companyId: string;
  periodId: string;
  procedureId?: string;
  accountId?: string;
  title: string;
  description?: string;
  samplingMethod: SamplingMethod;
  status: SamplingStatus;
  populationSize: number;
  sampleSize: number;
  confidenceLevel?: number;
  tolerableError?: number;
  expectedError?: number;
  samplingInterval?: number;
  randomSeed?: number;
  selectionCriteria?: string;
  stratificationBasis?: string;
  errorsFound?: number;
  itemsTested?: number;
  conclusion?: string;
  requiresProjection?: boolean;
  projectedError?: number;
  createdBy: string;
  updatedBy?: string;
  createdAt: Date;
  updatedAt: Date;
}

export enum SamplingMethod {
  RANDOM = 'RANDOM',
  SYSTEMATIC = 'SYSTEMATIC',
  STRATIFIED = 'STRATIFIED',
  MONETARY_UNIT = 'MONETARY_UNIT',
  JUDGMENTAL = 'JUDGMENTAL',
  HAPHAZARD = 'HAPHAZARD',
}

export enum SamplingStatus {
  PLANNED = 'PLANNED',
  IN_PROGRESS = 'IN_PROGRESS',
  COMPLETED = 'COMPLETED',
  REVIEWED = 'REVIEWED',
}

export interface CreateSamplingDto {
  companyId: string;
  periodId: string;
  procedureId?: string;
  accountId?: string;
  title: string;
  description?: string;
  samplingMethod: SamplingMethod;
  populationSize: number;
  sampleSize: number;
  confidenceLevel?: number;
  tolerableError?: number;
  expectedError?: number;
  selectionCriteria?: string;
  stratificationBasis?: string;
}

export interface SamplingSummary {
  totalSamplingPlans: number;
  byStatus: Record<SamplingStatus, number>;
  byMethod: Record<SamplingMethod, number>;
  totalSampleSize: number;
  totalErrorsFound: number;
  completionRate: number;
}

export interface GenerateSampleRequest {
  populationIds: string[];
}

export interface GenerateSampleResponse {
  selectedIds: string[];
  interval?: number;
  randomSeed?: number;
}

export const samplingService = {
  /**
   * Get all sampling plans with optional filters
   */
  async getAll(
    companyId?: string,
    periodId?: string,
    status?: SamplingStatus,
    samplingMethod?: SamplingMethod
  ): Promise<Sampling[]> {
    const params = new URLSearchParams();
    if (companyId) params.append('companyId', companyId);
    if (periodId) params.append('periodId', periodId);
    if (status) params.append('status', status);
    if (samplingMethod) params.append('samplingMethod', samplingMethod);
    
    const response = await axios.get(`${API_BASE}/api/sampling?${params.toString()}`);
    return response.data;
  },

  /**
   * Get sampling plan by ID
   */
  async getById(id: string): Promise<Sampling> {
    const response = await axios.get(`${API_BASE}/api/sampling/${id}`);
    return response.data;
  },

  /**
   * Create new sampling plan
   */
  async create(data: CreateSamplingDto): Promise<Sampling> {
    const response = await axios.post(`${API_BASE}/api/sampling`, data);
    return response.data;
  },

  /**
   * Update sampling plan
   */
  async update(id: string, data: Partial<CreateSamplingDto>): Promise<Sampling> {
    const response = await axios.patch(`${API_BASE}/api/sampling/${id}`, data);
    return response.data;
  },

  /**
   * Delete sampling plan
   */
  async delete(id: string): Promise<void> {
    await axios.delete(`${API_BASE}/api/sampling/${id}`);
  },

  /**
   * Calculate recommended sample size based on statistical parameters
   */
  async calculateSampleSize(
    populationSize: number,
    confidenceLevel: number,
    tolerableError: number,
    expectedError: number
  ): Promise<number> {
    const response = await axios.get(`${API_BASE}/api/sampling/calculate-sample-size`, {
      params: {
        populationSize,
        confidenceLevel,
        tolerableError,
        expectedError,
      },
    });
    return response.data;
  },

  /**
   * Generate sample selection based on sampling method
   */
  async generateSample(id: string, populationIds: string[]): Promise<GenerateSampleResponse> {
    const response = await axios.post(`${API_BASE}/api/sampling/${id}/generate-sample`, {
      populationIds,
    });
    return response.data;
  },

  /**
   * Get sampling summary for company/period
   */
  async getSummary(companyId: string, periodId: string): Promise<SamplingSummary> {
    const response = await axios.get(`${API_BASE}/api/sampling/summary`, {
      params: { companyId, periodId },
    });
    return response.data;
  },
};

// Helper functions for UI
export const samplingMethodLabels: Record<SamplingMethod, string> = {
  [SamplingMethod.RANDOM]: 'Random Sampling',
  [SamplingMethod.SYSTEMATIC]: 'Systematic Sampling',
  [SamplingMethod.STRATIFIED]: 'Stratified Sampling',
  [SamplingMethod.MONETARY_UNIT]: 'Monetary Unit Sampling',
  [SamplingMethod.JUDGMENTAL]: 'Judgmental Sampling',
  [SamplingMethod.HAPHAZARD]: 'Haphazard Sampling',
};

export const samplingMethodDescriptions: Record<SamplingMethod, string> = {
  [SamplingMethod.RANDOM]: 'Simple random sampling - each item has equal probability of selection',
  [SamplingMethod.SYSTEMATIC]: 'Systematic sampling - selection at fixed intervals',
  [SamplingMethod.STRATIFIED]: 'Stratified sampling - population divided into strata',
  [SamplingMethod.MONETARY_UNIT]: 'Monetary Unit Sampling (MUS) - dollar-weighted selection',
  [SamplingMethod.JUDGMENTAL]: 'Judgmental sampling - based on professional judgment',
  [SamplingMethod.HAPHAZARD]: 'Haphazard sampling - without structured pattern',
};

export const samplingStatusLabels: Record<SamplingStatus, string> = {
  [SamplingStatus.PLANNED]: 'Planned',
  [SamplingStatus.IN_PROGRESS]: 'In Progress',
  [SamplingStatus.COMPLETED]: 'Completed',
  [SamplingStatus.REVIEWED]: 'Reviewed',
};

export const samplingStatusColors: Record<SamplingStatus, string> = {
  [SamplingStatus.PLANNED]: 'default',
  [SamplingStatus.IN_PROGRESS]: 'info',
  [SamplingStatus.COMPLETED]: 'success',
  [SamplingStatus.REVIEWED]: 'primary',
};

export default samplingService;
