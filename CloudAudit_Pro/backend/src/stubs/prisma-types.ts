// Temporary type definitions until Prisma client is generated

export enum UserRole {
  ADMIN = 'ADMIN',
  MANAGER = 'MANAGER',
  SENIOR_AUDITOR = 'SENIOR_AUDITOR',
  AUDITOR = 'AUDITOR',
  INTERN = 'INTERN',
}

export enum TenantStatus {
  ACTIVE = 'ACTIVE',
  SUSPENDED = 'SUSPENDED',
  CANCELLED = 'CANCELLED',
  TRIAL = 'TRIAL',
}

export enum JournalEntryStatus {
  DRAFT = 'DRAFT',
  POSTED = 'POSTED',
  REVERSED = 'REVERSED',
}

export interface User {
  id: string;
  email: string;
  passwordHash: string;
  firstName: string;
  lastName: string;
  role: UserRole;
  isActive: boolean;
  createdAt: Date;
  updatedAt: Date;
}

export interface Tenant {
  id: string;
  name: string;
  subdomain: string;
  status: TenantStatus;
  createdAt: Date;
  updatedAt: Date;
}

export namespace Prisma {
  export type JsonValue = any;
}