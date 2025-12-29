import axios from 'axios';

const API_BASE = process.env.REACT_APP_API_URL || 'http://localhost:3000';

export interface InternalControl {
  id: string;
  tenantId: string;
  companyId: string;
  periodId: string;
  processArea: string;
  controlId: string;
  title: string;
  description: string;
  controlObjective?: string;
  controlType: ControlType;
  controlNature: ControlNature;
  controlFrequency: ControlFrequency;
  riskAddressed?: string;
  riskLevel?: RiskLevel;
  controlOwner?: string;
  isKeyControl: boolean;
  testProcedures?: string;
  testResult?: string;
  controlEffectiveness: ControlEffectiveness;
  deficiencyIdentified: boolean;
  deficiencyDescription?: string;
  remediationPlan?: string;
  remediationDeadline?: Date;
  managementResponse?: string;
  testPerformedBy?: string;
  testDate?: Date;
  reviewedBy?: string;
  reviewDate?: Date;
  evidence?: string;
  conclusion?: string;
  createdBy: string;
  updatedBy?: string;
  createdAt: Date;
  updatedAt: Date;
}

export enum ControlType {
  PREVENTIVE = 'PREVENTIVE',
  DETECTIVE = 'DETECTIVE',
  CORRECTIVE = 'CORRECTIVE',
  DIRECTIVE = 'DIRECTIVE',
}

export enum ControlNature {
  MANUAL = 'MANUAL',
  AUTOMATED = 'AUTOMATED',
  IT_DEPENDENT_MANUAL = 'IT_DEPENDENT_MANUAL',
}

export enum ControlFrequency {
  CONTINUOUS = 'CONTINUOUS',
  DAILY = 'DAILY',
  WEEKLY = 'WEEKLY',
  MONTHLY = 'MONTHLY',
  QUARTERLY = 'QUARTERLY',
  ANNUALLY = 'ANNUALLY',
  AD_HOC = 'AD_HOC',
}

export enum ControlEffectiveness {
  EFFECTIVE = 'EFFECTIVE',
  PARTIALLY_EFFECTIVE = 'PARTIALLY_EFFECTIVE',
  INEFFECTIVE = 'INEFFECTIVE',
  NOT_TESTED = 'NOT_TESTED',
}

export enum RiskLevel {
  LOW = 'LOW',
  MEDIUM = 'MEDIUM',
  HIGH = 'HIGH',
  CRITICAL = 'CRITICAL',
}

export interface CreateInternalControlDto {
  companyId: string;
  periodId: string;
  processArea: string;
  controlId: string;
  title: string;
  description: string;
  controlObjective?: string;
  controlType: ControlType;
  controlNature: ControlNature;
  controlFrequency: ControlFrequency;
  riskAddressed?: string;
  riskLevel?: RiskLevel;
  controlOwner?: string;
  isKeyControl?: boolean;
  testProcedures?: string;
  testResult?: string;
  evidence?: string;
}

export interface InternalControlSummary {
  totalControls: number;
  keyControls: number;
  byProcessArea: Record<string, number>;
  byControlType: Record<ControlType, number>;
  byEffectiveness: Record<ControlEffectiveness, number>;
  totalDeficiencies: number;
  effectiveControlsPercentage: number;
  partiallyEffectiveControlsPercentage: number;
  ineffectiveControlsPercentage: number;
  notTestedControlsPercentage: number;
}

export const internalControlsService = {
  /**
   * Get all internal controls with optional filters
   */
  async getAll(
    companyId?: string,
    periodId?: string,
    processArea?: string,
    controlType?: ControlType,
    controlEffectiveness?: ControlEffectiveness,
    isKeyControl?: boolean,
    deficiencyIdentified?: boolean
  ): Promise<InternalControl[]> {
    const params = new URLSearchParams();
    if (companyId) params.append('companyId', companyId);
    if (periodId) params.append('periodId', periodId);
    if (processArea) params.append('processArea', processArea);
    if (controlType) params.append('controlType', controlType);
    if (controlEffectiveness) params.append('controlEffectiveness', controlEffectiveness);
    if (isKeyControl !== undefined) params.append('isKeyControl', String(isKeyControl));
    if (deficiencyIdentified !== undefined) params.append('deficiencyIdentified', String(deficiencyIdentified));
    
    const response = await axios.get(`${API_BASE}/api/internal-controls?${params.toString()}`);
    return response.data;
  },

  /**
   * Get internal control by ID
   */
  async getById(id: string): Promise<InternalControl> {
    const response = await axios.get(`${API_BASE}/api/internal-controls/${id}`);
    return response.data;
  },

  /**
   * Create new internal control
   */
  async create(data: CreateInternalControlDto): Promise<InternalControl> {
    const response = await axios.post(`${API_BASE}/api/internal-controls`, data);
    return response.data;
  },

  /**
   * Update internal control
   */
  async update(id: string, data: Partial<CreateInternalControlDto>): Promise<InternalControl> {
    const response = await axios.patch(`${API_BASE}/api/internal-controls/${id}`, data);
    return response.data;
  },

  /**
   * Delete internal control
   */
  async delete(id: string): Promise<void> {
    await axios.delete(`${API_BASE}/api/internal-controls/${id}`);
  },

  /**
   * Test control and assess effectiveness
   */
  async test(
    id: string,
    testProcedures: string,
    testResult: string,
    controlEffectiveness: ControlEffectiveness
  ): Promise<InternalControl> {
    const response = await axios.post(`${API_BASE}/api/internal-controls/${id}/test`, {
      testProcedures,
      testResult,
      controlEffectiveness,
    });
    return response.data;
  },

  /**
   * Identify control deficiency
   */
  async identifyDeficiency(
    id: string,
    deficiencyDescription: string,
    remediationPlan: string,
    remediationDeadline: Date
  ): Promise<InternalControl> {
    const response = await axios.post(`${API_BASE}/api/internal-controls/${id}/deficiency`, {
      deficiencyDescription,
      remediationPlan,
      remediationDeadline,
    });
    return response.data;
  },

  /**
   * Review control with conclusion
   */
  async review(id: string, conclusion: string): Promise<InternalControl> {
    const response = await axios.post(`${API_BASE}/api/internal-controls/${id}/review`, {
      conclusion,
    });
    return response.data;
  },

  /**
   * Get internal controls summary
   */
  async getSummary(companyId: string, periodId: string): Promise<InternalControlSummary> {
    const response = await axios.get(`${API_BASE}/api/internal-controls/summary`, {
      params: { companyId, periodId },
    });
    return response.data;
  },
};

// Helper functions for UI
export const controlTypeLabels: Record<ControlType, string> = {
  [ControlType.PREVENTIVE]: 'Preventive',
  [ControlType.DETECTIVE]: 'Detective',
  [ControlType.CORRECTIVE]: 'Corrective',
  [ControlType.DIRECTIVE]: 'Directive',
};

export const controlTypeDescriptions: Record<ControlType, string> = {
  [ControlType.PREVENTIVE]: 'Prevents errors or irregularities from occurring',
  [ControlType.DETECTIVE]: 'Detects errors or irregularities that have occurred',
  [ControlType.CORRECTIVE]: 'Corrects errors or irregularities that have been detected',
  [ControlType.DIRECTIVE]: 'Directs actions to achieve desired outcomes',
};

export const controlNatureLabels: Record<ControlNature, string> = {
  [ControlNature.MANUAL]: 'Manual',
  [ControlNature.AUTOMATED]: 'Automated',
  [ControlNature.IT_DEPENDENT_MANUAL]: 'IT-Dependent Manual',
};

export const controlFrequencyLabels: Record<ControlFrequency, string> = {
  [ControlFrequency.CONTINUOUS]: 'Continuous',
  [ControlFrequency.DAILY]: 'Daily',
  [ControlFrequency.WEEKLY]: 'Weekly',
  [ControlFrequency.MONTHLY]: 'Monthly',
  [ControlFrequency.QUARTERLY]: 'Quarterly',
  [ControlFrequency.ANNUALLY]: 'Annually',
  [ControlFrequency.AD_HOC]: 'Ad-hoc',
};

export const controlEffectivenessLabels: Record<ControlEffectiveness, string> = {
  [ControlEffectiveness.EFFECTIVE]: 'Effective',
  [ControlEffectiveness.PARTIALLY_EFFECTIVE]: 'Partially Effective',
  [ControlEffectiveness.INEFFECTIVE]: 'Ineffective',
  [ControlEffectiveness.NOT_TESTED]: 'Not Tested',
};

export const controlEffectivenessColors: Record<ControlEffectiveness, string> = {
  [ControlEffectiveness.EFFECTIVE]: 'success',
  [ControlEffectiveness.PARTIALLY_EFFECTIVE]: 'warning',
  [ControlEffectiveness.INEFFECTIVE]: 'error',
  [ControlEffectiveness.NOT_TESTED]: 'default',
};

export const riskLevelLabels: Record<RiskLevel, string> = {
  [RiskLevel.LOW]: 'Low',
  [RiskLevel.MEDIUM]: 'Medium',
  [RiskLevel.HIGH]: 'High',
  [RiskLevel.CRITICAL]: 'Critical',
};

export const riskLevelColors: Record<RiskLevel, string> = {
  [RiskLevel.LOW]: 'success',
  [RiskLevel.MEDIUM]: 'info',
  [RiskLevel.HIGH]: 'warning',
  [RiskLevel.CRITICAL]: 'error',
};

export default internalControlsService;
