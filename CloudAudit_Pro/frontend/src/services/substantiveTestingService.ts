import axios from 'axios';

const API_BASE = process.env.REACT_APP_API_URL || 'http://localhost:3000';

export interface SubstantiveTest {
  id: string;
  tenantId: string;
  companyId: string;
  periodId: string;
  procedureId?: string;
  accountId?: string;
  samplingId?: string;
  title: string;
  description?: string;
  testType: TestType;
  status: TestStatus;
  transactionReference?: string;
  transactionDate?: Date;
  transactionAmount?: number;
  sourceDocument?: string;
  expectedResult?: string;
  actualResult?: string;
  proceduresPerformed?: string;
  hasException: boolean;
  exceptionDescription?: string;
  exceptionSeverity?: ExceptionSeverity;
  exceptionAmount?: number;
  managementResponse?: string;
  conclusion?: string;
  performedBy?: string;
  testDate?: Date;
  reviewedBy?: string;
  reviewDate?: Date;
  createdBy: string;
  updatedBy?: string;
  createdAt: Date;
  updatedAt: Date;
}

export enum TestType {
  VOUCHING = 'VOUCHING',
  TRACING = 'TRACING',
  RECALCULATION = 'RECALCULATION',
  CONFIRMATION = 'CONFIRMATION',
  OBSERVATION = 'OBSERVATION',
  INSPECTION = 'INSPECTION',
  ANALYTICAL_PROCEDURE = 'ANALYTICAL_PROCEDURE',
  REPERFORMANCE = 'REPERFORMANCE',
}

export enum TestStatus {
  PLANNED = 'PLANNED',
  IN_PROGRESS = 'IN_PROGRESS',
  COMPLETED = 'COMPLETED',
  REVIEWED = 'REVIEWED',
  EXCEPTION_NOTED = 'EXCEPTION_NOTED',
}

export enum ExceptionSeverity {
  LOW = 'LOW',
  MEDIUM = 'MEDIUM',
  HIGH = 'HIGH',
  CRITICAL = 'CRITICAL',
}

export interface CreateSubstantiveTestDto {
  companyId: string;
  periodId: string;
  procedureId?: string;
  accountId?: string;
  samplingId?: string;
  title: string;
  description?: string;
  testType: TestType;
  transactionReference?: string;
  transactionDate?: Date;
  transactionAmount?: number;
  sourceDocument?: string;
  expectedResult?: string;
  actualResult?: string;
  proceduresPerformed?: string;
  hasException?: boolean;
  exceptionDescription?: string;
  exceptionSeverity?: ExceptionSeverity;
  exceptionAmount?: number;
  managementResponse?: string;
  conclusion?: string;
}

export interface SubstantiveTestSummary {
  totalTests: number;
  byTestType: Record<TestType, number>;
  byStatus: Record<TestStatus, number>;
  totalExceptions: number;
  bySeverity: Record<ExceptionSeverity, number>;
  totalTransactionAmount: number;
  totalExceptionAmount: number;
  exceptionRate: number;
}

export const substantiveTestingService = {
  /**
   * Get all substantive tests with optional filters
   */
  async getAll(
    companyId?: string,
    periodId?: string,
    status?: TestStatus,
    testType?: TestType,
    hasException?: boolean
  ): Promise<SubstantiveTest[]> {
    const params = new URLSearchParams();
    if (companyId) params.append('companyId', companyId);
    if (periodId) params.append('periodId', periodId);
    if (status) params.append('status', status);
    if (testType) params.append('testType', testType);
    if (hasException !== undefined) params.append('hasException', String(hasException));
    
    const response = await axios.get(`${API_BASE}/api/substantive-testing?${params.toString()}`);
    return response.data;
  },

  /**
   * Get substantive test by ID
   */
  async getById(id: string): Promise<SubstantiveTest> {
    const response = await axios.get(`${API_BASE}/api/substantive-testing/${id}`);
    return response.data;
  },

  /**
   * Create new substantive test
   */
  async create(data: CreateSubstantiveTestDto): Promise<SubstantiveTest> {
    const response = await axios.post(`${API_BASE}/api/substantive-testing`, data);
    return response.data;
  },

  /**
   * Update substantive test
   */
  async update(id: string, data: Partial<CreateSubstantiveTestDto>): Promise<SubstantiveTest> {
    const response = await axios.patch(`${API_BASE}/api/substantive-testing/${id}`, data);
    return response.data;
  },

  /**
   * Delete substantive test
   */
  async delete(id: string): Promise<void> {
    await axios.delete(`${API_BASE}/api/substantive-testing/${id}`);
  },

  /**
   * Complete test with conclusion
   */
  async complete(id: string, conclusion: string): Promise<SubstantiveTest> {
    const response = await axios.post(`${API_BASE}/api/substantive-testing/${id}/complete`, {
      conclusion,
    });
    return response.data;
  },

  /**
   * Review test with comments
   */
  async review(id: string, reviewComments: string): Promise<SubstantiveTest> {
    const response = await axios.post(`${API_BASE}/api/substantive-testing/${id}/review`, {
      reviewComments,
    });
    return response.data;
  },

  /**
   * Get substantive testing summary
   */
  async getSummary(companyId: string, periodId: string): Promise<SubstantiveTestSummary> {
    const response = await axios.get(`${API_BASE}/api/substantive-testing/summary`, {
      params: { companyId, periodId },
    });
    return response.data;
  },
};

// Helper functions for UI
export const testTypeLabels: Record<TestType, string> = {
  [TestType.VOUCHING]: 'Vouching',
  [TestType.TRACING]: 'Tracing',
  [TestType.RECALCULATION]: 'Recalculation',
  [TestType.CONFIRMATION]: 'Confirmation',
  [TestType.OBSERVATION]: 'Observation',
  [TestType.INSPECTION]: 'Inspection',
  [TestType.ANALYTICAL_PROCEDURE]: 'Analytical Procedure',
  [TestType.REPERFORMANCE]: 'Reperformance',
};

export const testTypeDescriptions: Record<TestType, string> = {
  [TestType.VOUCHING]: 'Trace transaction back to source documents',
  [TestType.TRACING]: 'Trace forward from source documents to records',
  [TestType.RECALCULATION]: 'Recalculate mathematical computations',
  [TestType.CONFIRMATION]: 'Obtain third-party confirmation',
  [TestType.OBSERVATION]: 'Direct observation of process or procedure',
  [TestType.INSPECTION]: 'Examine documents or physical assets',
  [TestType.ANALYTICAL_PROCEDURE]: 'Analytical review and reasonableness test',
  [TestType.REPERFORMANCE]: 'Reperform client procedures',
};

export const testStatusLabels: Record<TestStatus, string> = {
  [TestStatus.PLANNED]: 'Planned',
  [TestStatus.IN_PROGRESS]: 'In Progress',
  [TestStatus.COMPLETED]: 'Completed',
  [TestStatus.REVIEWED]: 'Reviewed',
  [TestStatus.EXCEPTION_NOTED]: 'Exception Noted',
};

export const testStatusColors: Record<TestStatus, string> = {
  [TestStatus.PLANNED]: 'default',
  [TestStatus.IN_PROGRESS]: 'info',
  [TestStatus.COMPLETED]: 'success',
  [TestStatus.REVIEWED]: 'primary',
  [TestStatus.EXCEPTION_NOTED]: 'error',
};

export const exceptionSeverityLabels: Record<ExceptionSeverity, string> = {
  [ExceptionSeverity.LOW]: 'Low',
  [ExceptionSeverity.MEDIUM]: 'Medium',
  [ExceptionSeverity.HIGH]: 'High',
  [ExceptionSeverity.CRITICAL]: 'Critical',
};

export const exceptionSeverityColors: Record<ExceptionSeverity, string> = {
  [ExceptionSeverity.LOW]: 'info',
  [ExceptionSeverity.MEDIUM]: 'warning',
  [ExceptionSeverity.HIGH]: 'error',
  [ExceptionSeverity.CRITICAL]: 'error',
};

export default substantiveTestingService;
