import axios from 'axios';

const API_URL = import.meta.env.VITE_API_URL || 'http://localhost:3000';

export enum AnalyticsMetric {
  REVENUE = 'REVENUE',
  EXPENSES = 'EXPENSES',
  PROFIT_MARGIN = 'PROFIT_MARGIN',
  LIQUIDITY_RATIO = 'LIQUIDITY_RATIO',
  DEBT_RATIO = 'DEBT_RATIO',
  ROA = 'ROA',
  ROE = 'ROE',
  CASH_FLOW = 'CASH_FLOW',
  AUDIT_COMPLETION = 'AUDIT_COMPLETION',
  DOCUMENT_COUNT = 'DOCUMENT_COUNT',
  FINDING_SEVERITY = 'FINDING_SEVERITY',
}

export enum AnalyticsTimeframe {
  DAY = 'DAY',
  WEEK = 'WEEK',
  MONTH = 'MONTH',
  QUARTER = 'QUARTER',
  YEAR = 'YEAR',
  CUSTOM = 'CUSTOM',
}

export interface AnalyticsOverview {
  summary: {
    totalTransactions: number;
    totalDocuments: number;
    totalFindings: number;
    auditCompletion: number;
  };
  financial: {
    totalRevenue: number;
    totalExpenses: number;
    netIncome: number;
    profitMargin: number;
  };
  auditProgress: {
    total: number;
    completed: number;
    completionPercentage: number;
  };
  timestamp: Date;
}

export interface FinancialRatios {
  liquidityRatios: {
    currentRatio: number;
    quickRatio: number;
  };
  profitabilityRatios: {
    grossProfitMargin: number;
    netProfitMargin: number;
    returnOnAssets: number;
    returnOnEquity: number;
  };
  leverageRatios: {
    debtToAssets: number;
    debtToEquity: number;
    equityRatio: number;
  };
  amounts: {
    totalAssets: number;
    totalLiabilities: number;
    totalEquity: number;
    totalRevenue: number;
    totalExpenses: number;
    netIncome: number;
  };
}

export interface TrendAnalysis {
  metric: AnalyticsMetric;
  periods: Array<{
    periodId: string;
    periodName: string;
    startDate: Date;
    endDate: Date;
    value: number;
  }>;
  summary: {
    latestValue: number;
    averageChange: number;
    trendDirection: 'INCREASING' | 'DECREASING' | 'STABLE';
    percentageChange: number;
  };
}

export interface Snapshot {
  id: string;
  tenantId: string;
  companyId: string;
  periodId: string;
  snapshotDate: Date;
  snapshotType: 'DAILY' | 'WEEKLY' | 'MONTHLY' | 'QUARTERLY' | 'ANNUAL';
  metrics: any;
  trends: any;
  alerts: any[];
  createdAt: Date;
  company?: { name: string };
  period?: { name: string };
}

class AnalyticsService {
  private getAuthHeaders() {
    const token = localStorage.getItem('accessToken');
    return {
      headers: {
        Authorization: `Bearer ${token}`,
        'Content-Type': 'application/json',
      },
    };
  }

  async getOverview(companyId: string, periodId?: string): Promise<AnalyticsOverview> {
    const params = new URLSearchParams({ companyId });
    if (periodId) params.append('periodId', periodId);

    const response = await axios.get(
      `${API_URL}/analytics/overview?${params.toString()}`,
      this.getAuthHeaders()
    );
    return response.data;
  }

  async customQuery(data: {
    companyId: string;
    periodId?: string;
    metrics?: AnalyticsMetric[];
    timeframe?: AnalyticsTimeframe;
    startDate?: Date;
    endDate?: Date;
    filters?: any;
  }): Promise<any> {
    const response = await axios.post(`${API_URL}/analytics/query`, data, this.getAuthHeaders());
    return response.data;
  }

  async getFinancialRatios(companyId: string, periodId?: string): Promise<FinancialRatios> {
    const params = new URLSearchParams({ companyId });
    if (periodId) params.append('periodId', periodId);

    const response = await axios.get(
      `${API_URL}/analytics/financial-ratios?${params.toString()}`,
      this.getAuthHeaders()
    );
    return response.data;
  }

  async getTrendAnalysis(
    metric: AnalyticsMetric,
    companyId: string,
    periods?: number
  ): Promise<TrendAnalysis> {
    const params = new URLSearchParams({ companyId });
    if (periods) params.append('periods', periods.toString());

    const response = await axios.get(
      `${API_URL}/analytics/trends/${metric}?${params.toString()}`,
      this.getAuthHeaders()
    );
    return response.data;
  }

  async getVarianceAnalysis(
    companyId: string,
    periodId: string,
    comparisonPeriodId: string
  ): Promise<any> {
    const params = new URLSearchParams({ companyId, periodId, comparisonPeriodId });

    const response = await axios.get(
      `${API_URL}/analytics/variance?${params.toString()}`,
      this.getAuthHeaders()
    );
    return response.data;
  }

  async getAgingAnalysis(companyId: string): Promise<any> {
    const response = await axios.get(
      `${API_URL}/analytics/aging?companyId=${companyId}`,
      this.getAuthHeaders()
    );
    return response.data;
  }

  async getMateriality(companyId: string, periodId?: string): Promise<any> {
    const params = new URLSearchParams({ companyId });
    if (periodId) params.append('periodId', periodId);

    const response = await axios.get(
      `${API_URL}/analytics/materiality?${params.toString()}`,
      this.getAuthHeaders()
    );
    return response.data;
  }

  async createSnapshot(data: {
    companyId: string;
    periodId: string;
    snapshotType?: string;
    snapshotDate?: Date;
  }): Promise<Snapshot> {
    const response = await axios.post(
      `${API_URL}/analytics/snapshots`,
      data,
      this.getAuthHeaders()
    );
    return response.data;
  }

  async getSnapshots(companyId?: string, periodId?: string, limit?: number): Promise<Snapshot[]> {
    const params = new URLSearchParams();
    if (companyId) params.append('companyId', companyId);
    if (periodId) params.append('periodId', periodId);
    if (limit) params.append('limit', limit.toString());

    const response = await axios.get(
      `${API_URL}/analytics/snapshots?${params.toString()}`,
      this.getAuthHeaders()
    );
    return response.data;
  }
}

export default new AnalyticsService();
