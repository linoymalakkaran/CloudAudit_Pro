export interface EmailTemplate {
  subject: string;
  html: string;
  text: string;
}

export interface EmailConfig {
  host: string;
  port: number;
  secure: boolean;
  auth: {
    user: string;
    pass: string;
  };
}

export interface BaseEmailData {
  to: string;
  supportEmail: string;
  loginUrl: string;
}

export interface TenantApprovalEmailData extends BaseEmailData {
  tenantName: string;
  adminName: string;
  status: 'APPROVED' | 'REJECTED' | 'PENDING';
  reviewNotes?: string;
}

export interface UserApprovalEmailData extends BaseEmailData {
  userName: string;
  tenantName: string;
  role: string;
  status: 'APPROVED' | 'REJECTED' | 'PENDING';
  reviewNotes?: string;
}

export interface WelcomeEmailData extends BaseEmailData {
  userName: string;
  tenantName: string;
  role?: string;
  temporaryPassword?: string;
}