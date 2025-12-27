-- CreateEnum
CREATE TYPE "TenantApprovalStatus" AS ENUM ('PENDING', 'APPROVED', 'REJECTED', 'REQUIRES_CHANGES');

-- CreateEnum
CREATE TYPE "UserApprovalStatus" AS ENUM ('PENDING', 'APPROVED', 'REJECTED', 'REQUIRES_CHANGES');

-- CreateEnum
CREATE TYPE "UserApprovalType" AS ENUM ('REGISTRATION', 'ROLE_CHANGE', 'ACCESS_REQUEST');

-- CreateEnum
CREATE TYPE "UserStatus" AS ENUM ('PENDING', 'ACTIVE', 'SUSPENDED', 'INACTIVE');

-- CreateEnum
CREATE TYPE "TenantStatus" AS ENUM ('PENDING', 'ACTIVE', 'INACTIVE', 'SUSPENDED', 'CANCELLED', 'TRIAL', 'REJECTED');

-- CreateEnum
CREATE TYPE "SubscriptionStatus" AS ENUM ('ACTIVE', 'PAST_DUE', 'CANCELLED', 'UNPAID');

-- CreateEnum
CREATE TYPE "CompanyStatus" AS ENUM ('ACTIVE', 'INACTIVE');

-- CreateEnum
CREATE TYPE "PeriodStatus" AS ENUM ('OPEN', 'PLANNING', 'IN_PROGRESS', 'CLOSED', 'ARCHIVED');

-- CreateEnum
CREATE TYPE "AuditType" AS ENUM ('ANNUAL', 'INTERIM', 'QUARTERLY');

-- CreateEnum
CREATE TYPE "AccountCategory" AS ENUM ('ASSETS', 'LIABILITIES', 'EQUITY', 'REVENUE', 'EXPENSES');

-- CreateEnum
CREATE TYPE "BalanceType" AS ENUM ('DEBIT', 'CREDIT');

-- CreateEnum
CREATE TYPE "AccountStatus" AS ENUM ('ACTIVE', 'INACTIVE');

-- CreateEnum
CREATE TYPE "JournalType" AS ENUM ('ADJUSTMENT', 'RECLASSIFICATION', 'ERROR_CORRECTION');

-- CreateEnum
CREATE TYPE "JournalStatus" AS ENUM ('DRAFT', 'POSTED', 'REVERSED');

-- CreateEnum
CREATE TYPE "ProcedureStatus" AS ENUM ('NOT_STARTED', 'IN_PROGRESS', 'COMPLETED', 'ON_HOLD', 'REVIEW_REQUIRED', 'CANCELLED');

-- CreateEnum
CREATE TYPE "ReviewStatus" AS ENUM ('NOT_REVIEWED', 'IN_REVIEW', 'REVIEWED', 'APPROVED', 'REJECTED', 'REQUIRES_CHANGES');

-- CreateEnum
CREATE TYPE "Classification" AS ENUM ('PUBLIC', 'INTERNAL', 'CONFIDENTIAL', 'RESTRICTED');

-- CreateEnum
CREATE TYPE "AccessLevel" AS ENUM ('PUBLIC', 'INTERNAL', 'RESTRICTED');

-- CreateEnum
CREATE TYPE "UserRole" AS ENUM ('ADMIN', 'MANAGER', 'SENIOR_AUDITOR', 'AUDITOR', 'INTERN', 'USER');

-- CreateEnum
CREATE TYPE "AuditAction" AS ENUM ('INSERT', 'UPDATE', 'DELETE', 'LOGIN', 'LOGOUT', 'ACCESS');

-- CreateEnum
CREATE TYPE "RiskLevel" AS ENUM ('LOW', 'MEDIUM', 'HIGH', 'CRITICAL');

-- CreateEnum
CREATE TYPE "DocumentType" AS ENUM ('FINANCIAL_STATEMENT', 'TRIAL_BALANCE', 'GENERAL_LEDGER', 'BANK_STATEMENT', 'INVOICE', 'RECEIPT', 'CONTRACT', 'CORRESPONDENCE', 'WORKING_PAPER', 'MANAGEMENT_LETTER', 'OTHER');

-- CreateEnum
CREATE TYPE "DocumentStatus" AS ENUM ('PENDING', 'REVIEWED', 'APPROVED', 'REJECTED');

-- CreateEnum
CREATE TYPE "ImportJobStatus" AS ENUM ('PENDING', 'VALIDATING', 'IN_PROGRESS', 'PROCESSING', 'COMPLETED', 'FAILED', 'PARTIAL', 'CANCELLED');

-- CreateEnum
CREATE TYPE "ExportJobStatus" AS ENUM ('PENDING', 'IN_PROGRESS', 'PROCESSING', 'COMPLETED', 'FAILED', 'CANCELLED');

-- CreateEnum
CREATE TYPE "ReportType" AS ENUM ('FINANCIAL_POSITION', 'INCOME_STATEMENT', 'CASH_FLOW', 'TRIAL_BALANCE', 'GENERAL_LEDGER', 'AGED_RECEIVABLES', 'AGED_PAYABLES', 'JOURNAL_REGISTER', 'AUDIT_SUMMARY', 'PROCEDURE_STATUS', 'FINDINGS_REPORT', 'COMPLIANCE_REPORT', 'RISK_ASSESSMENT', 'BALANCE_SHEET', 'AUDIT_REPORT', 'MANAGEMENT_LETTER', 'CUSTOM');

-- CreateEnum
CREATE TYPE "ReportStatus" AS ENUM ('DRAFT', 'GENERATING', 'COMPLETED', 'FAILED');

-- CreateEnum
CREATE TYPE "ReportFormat" AS ENUM ('PDF', 'EXCEL', 'CSV', 'JSON');

-- CreateEnum
CREATE TYPE "AuditSeverity" AS ENUM ('LOW', 'MEDIUM', 'HIGH', 'CRITICAL', 'WARNING', 'INFO', 'ERROR');

-- CreateEnum
CREATE TYPE "ProcedureCategory" AS ENUM ('CASH_AND_BANK', 'ACCOUNTS_RECEIVABLE', 'INVENTORY', 'FIXED_ASSETS', 'ACCOUNTS_PAYABLE', 'REVENUE', 'EXPENSES', 'EQUITY', 'ANALYTICAL_PROCEDURES', 'INTERNAL_CONTROLS', 'COMPLIANCE', 'SUBSTANTIVE_TESTING', 'OTHER');

-- CreateEnum
CREATE TYPE "Priority" AS ENUM ('LOW', 'MEDIUM', 'HIGH', 'URGENT');

-- CreateEnum
CREATE TYPE "Severity" AS ENUM ('MINOR', 'MODERATE', 'SIGNIFICANT', 'MATERIAL', 'CRITICAL');

-- CreateEnum
CREATE TYPE "FindingStatus" AS ENUM ('OPEN', 'IN_PROGRESS', 'RESOLVED', 'CLOSED', 'DEFERRED');

-- CreateTable
CREATE TABLE "super_admins" (
    "id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "passwordHash" TEXT NOT NULL,
    "firstName" TEXT NOT NULL,
    "lastName" TEXT NOT NULL,
    "role" TEXT NOT NULL DEFAULT 'SUPER_ADMIN',
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "lastLoginAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "super_admins_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tenant_approval_requests" (
    "id" TEXT NOT NULL,
    "tenantId" TEXT NOT NULL,
    "requestedBy" TEXT NOT NULL,
    "status" "TenantApprovalStatus" NOT NULL DEFAULT 'PENDING',
    "reviewedBy" TEXT,
    "reviewedAt" TIMESTAMP(3),
    "reviewNotes" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "tenant_approval_requests_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "user_approval_requests" (
    "id" TEXT NOT NULL,
    "tenantId" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "requestedBy" TEXT NOT NULL,
    "approvalType" "UserApprovalType" NOT NULL DEFAULT 'REGISTRATION',
    "status" "UserApprovalStatus" NOT NULL DEFAULT 'PENDING',
    "reviewedBy" TEXT,
    "reviewedAt" TIMESTAMP(3),
    "reviewNotes" TEXT,
    "requestedRole" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "user_approval_requests_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tenants" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "subdomain" TEXT NOT NULL,
    "databaseName" TEXT NOT NULL,
    "subscriptionTier" TEXT NOT NULL DEFAULT 'trial',
    "maxUsers" INTEGER NOT NULL DEFAULT 10,
    "maxCompanies" INTEGER NOT NULL DEFAULT 5,
    "storageLimitGb" INTEGER NOT NULL DEFAULT 10,
    "status" "TenantStatus" NOT NULL DEFAULT 'PENDING',
    "approvalStatus" "TenantApprovalStatus" NOT NULL DEFAULT 'PENDING',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "suspendedAt" TIMESTAMP(3),
    "trialEndsAt" TIMESTAMP(3),
    "approvedBy" TEXT,
    "approvedAt" TIMESTAMP(3),
    "rejectedReason" TEXT,
    "billingEmail" TEXT,
    "billingAddress" JSONB,
    "featureFlags" JSONB NOT NULL DEFAULT '{}',
    "customConfig" JSONB NOT NULL DEFAULT '{}',
    "settings" JSONB NOT NULL DEFAULT '{}',
    "metadata" JSONB NOT NULL DEFAULT '{}',
    "contactInfo" JSONB NOT NULL DEFAULT '{}',
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "tenants_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tenant_users" (
    "id" TEXT NOT NULL,
    "tenantId" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "passwordHash" TEXT NOT NULL,
    "firstName" TEXT,
    "lastName" TEXT,
    "role" TEXT NOT NULL DEFAULT 'USER',
    "status" "UserStatus" NOT NULL DEFAULT 'PENDING',
    "approvalStatus" "UserApprovalStatus" NOT NULL DEFAULT 'PENDING',
    "isActive" BOOLEAN NOT NULL DEFAULT false,
    "invitedBy" TEXT,
    "invitedAt" TIMESTAMP(3),
    "approvedBy" TEXT,
    "approvedAt" TIMESTAMP(3),
    "jobTitle" TEXT,
    "department" TEXT,
    "phoneNumber" TEXT,
    "requirePasswordChange" BOOLEAN NOT NULL DEFAULT false,
    "passwordResetAt" TIMESTAMP(3),
    "passwordResetBy" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "lastLoginAt" TIMESTAMP(3),
    "isDeleted" BOOLEAN NOT NULL DEFAULT false,
    "deletedAt" TIMESTAMP(3),
    "deletedBy" TEXT,

    CONSTRAINT "tenant_users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "subscriptions" (
    "id" TEXT NOT NULL,
    "tenantId" TEXT NOT NULL,
    "planId" TEXT NOT NULL,
    "status" "SubscriptionStatus" NOT NULL,
    "currentPeriodStart" TIMESTAMP(3) NOT NULL,
    "currentPeriodEnd" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "subscriptions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "usage_metrics" (
    "id" TEXT NOT NULL,
    "tenantId" TEXT NOT NULL,
    "metricName" TEXT NOT NULL,
    "metricValue" BIGINT NOT NULL,
    "periodStart" TIMESTAMP(3) NOT NULL,
    "periodEnd" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "usage_metrics_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "companies" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "code" TEXT NOT NULL,
    "shortName" TEXT,
    "address" TEXT,
    "addressLine1" TEXT,
    "addressLine2" TEXT,
    "addressLine3" TEXT,
    "phone" TEXT,
    "fax" TEXT,
    "email" TEXT,
    "website" TEXT,
    "contactPerson" TEXT,
    "contactDesignation" TEXT,
    "contactPhone" TEXT,
    "contactEmail" TEXT,
    "businessType" TEXT,
    "baseCurrency" TEXT,
    "currencyId" INTEGER,
    "industrySector" TEXT,
    "fiscalYearEnd" TIMESTAMP(3),
    "registrationNumber" TEXT,
    "taxId" TEXT,
    "industry" TEXT,
    "tenantId" TEXT,
    "status" "CompanyStatus" NOT NULL DEFAULT 'ACTIVE',
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "createdBy" TEXT,
    "updatedBy" TEXT,
    "version" INTEGER NOT NULL DEFAULT 1,
    "isDeleted" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "companies_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "periods" (
    "id" TEXT NOT NULL,
    "companyId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "startDate" TIMESTAMP(3) NOT NULL,
    "endDate" TIMESTAMP(3) NOT NULL,
    "auditType" "AuditType" NOT NULL,
    "status" "PeriodStatus" NOT NULL DEFAULT 'OPEN',
    "isCurrent" BOOLEAN NOT NULL DEFAULT false,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "closedDate" TIMESTAMP(3),
    "description" TEXT,
    "fiscalYear" TEXT,
    "periodType" TEXT,
    "tenantId" TEXT,
    "materialityAmount" DECIMAL(15,2),
    "materialityPercentage" DECIMAL(5,2),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "createdBy" TEXT,
    "updatedBy" TEXT,

    CONSTRAINT "periods_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "account_types" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "code" TEXT NOT NULL,
    "category" "AccountCategory" NOT NULL,
    "normalBalance" "BalanceType" NOT NULL,
    "displayOrder" INTEGER,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "account_types_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "account_heads" (
    "id" TEXT NOT NULL,
    "companyId" TEXT NOT NULL,
    "periodId" TEXT,
    "tenantId" TEXT,
    "accountTypeId" INTEGER NOT NULL,
    "accountTypeString" TEXT,
    "accountNumber" TEXT,
    "accountName" TEXT,
    "name" TEXT NOT NULL,
    "code" TEXT,
    "subType" TEXT,
    "description" TEXT,
    "parentAccountId" TEXT,
    "level" INTEGER NOT NULL DEFAULT 1,
    "trialBalanceOrder" INTEGER,
    "includeInTrialBalance" BOOLEAN NOT NULL DEFAULT true,
    "openingBalance" DECIMAL(15,2) NOT NULL DEFAULT 0,
    "currentBalance" DECIMAL(15,2) NOT NULL DEFAULT 0,
    "status" "AccountStatus" NOT NULL DEFAULT 'ACTIVE',
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "createdBy" TEXT,
    "updatedBy" TEXT,

    CONSTRAINT "account_heads_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "trial_balance" (
    "id" TEXT NOT NULL,
    "companyId" TEXT NOT NULL,
    "periodId" TEXT NOT NULL,
    "accountId" TEXT NOT NULL,
    "asOfDate" TIMESTAMP(3),
    "openingDebit" DECIMAL(15,2) NOT NULL DEFAULT 0,
    "openingCredit" DECIMAL(15,2) NOT NULL DEFAULT 0,
    "periodDebit" DECIMAL(15,2) NOT NULL DEFAULT 0,
    "periodCredit" DECIMAL(15,2) NOT NULL DEFAULT 0,
    "closingDebit" DECIMAL(15,2) NOT NULL DEFAULT 0,
    "closingCredit" DECIMAL(15,2) NOT NULL DEFAULT 0,
    "adjustmentDebit" DECIMAL(15,2) NOT NULL DEFAULT 0,
    "adjustmentCredit" DECIMAL(15,2) NOT NULL DEFAULT 0,
    "debitBalance" DECIMAL(15,2) NOT NULL DEFAULT 0,
    "creditBalance" DECIMAL(15,2) NOT NULL DEFAULT 0,
    "isBalanced" BOOLEAN NOT NULL DEFAULT true,
    "lastUpdated" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedBy" TEXT,

    CONSTRAINT "trial_balance_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "journal_entries" (
    "id" TEXT NOT NULL,
    "companyId" TEXT NOT NULL,
    "periodId" TEXT NOT NULL,
    "accountId" TEXT,
    "tenantId" TEXT,
    "journalNumber" TEXT NOT NULL,
    "entryNumber" TEXT,
    "entryDate" TIMESTAMP(3) NOT NULL,
    "journalDate" TIMESTAMP(3) NOT NULL,
    "referenceNumber" TEXT,
    "description" TEXT,
    "notes" TEXT,
    "journalType" "JournalType" NOT NULL DEFAULT 'ADJUSTMENT',
    "entryType" TEXT,
    "amount" DECIMAL(15,2),
    "totalDebit" DECIMAL(15,2) NOT NULL DEFAULT 0,
    "totalCredit" DECIMAL(15,2) NOT NULL DEFAULT 0,
    "status" "JournalStatus" NOT NULL DEFAULT 'DRAFT',
    "isPosted" BOOLEAN NOT NULL DEFAULT false,
    "reviewNotes" TEXT,
    "reviewedBy" TEXT,
    "reviewedAt" TIMESTAMP(3),
    "referenceDocumentId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdBy" TEXT,
    "updatedBy" TEXT,
    "postedAt" TIMESTAMP(3),
    "postedBy" TEXT,

    CONSTRAINT "journal_entries_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "journal_line_items" (
    "id" TEXT NOT NULL,
    "journalEntryId" TEXT NOT NULL,
    "accountId" TEXT NOT NULL,
    "lineNumber" INTEGER NOT NULL,
    "description" TEXT,
    "debitAmount" DECIMAL(15,2) NOT NULL DEFAULT 0,
    "creditAmount" DECIMAL(15,2) NOT NULL DEFAULT 0,
    "reference" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdBy" TEXT,
    "updatedBy" TEXT,

    CONSTRAINT "journal_line_items_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ledger" (
    "id" TEXT NOT NULL,
    "companyId" TEXT NOT NULL,
    "periodId" TEXT NOT NULL,
    "accountId" TEXT NOT NULL,
    "journalEntryId" TEXT NOT NULL,
    "lineItemId" TEXT NOT NULL,
    "tenantId" TEXT NOT NULL,
    "transactionDate" TIMESTAMP(3) NOT NULL,
    "journalNumber" TEXT NOT NULL,
    "description" TEXT,
    "reference" TEXT,
    "debitAmount" DECIMAL(15,2) NOT NULL DEFAULT 0,
    "creditAmount" DECIMAL(15,2) NOT NULL DEFAULT 0,
    "runningBalance" DECIMAL(15,2) NOT NULL DEFAULT 0,
    "sequenceNumber" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdBy" TEXT,

    CONSTRAINT "ledger_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "procedure_templates" (
    "id" TEXT NOT NULL,
    "tenantId" TEXT,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "category" TEXT,
    "procedureText" TEXT NOT NULL,
    "isMandatory" BOOLEAN NOT NULL DEFAULT false,
    "estimatedHours" DECIMAL(5,2),
    "requiredSkills" JSONB,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "version" INTEGER NOT NULL DEFAULT 1,
    "createdBy" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "procedure_templates_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "procedures" (
    "id" TEXT NOT NULL,
    "companyId" TEXT NOT NULL,
    "periodId" TEXT NOT NULL,
    "templateId" TEXT,
    "accountId" TEXT,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "procedureType" TEXT,
    "assignedTo" TEXT,
    "assignedDate" TIMESTAMP(3),
    "dueDate" TIMESTAMP(3),
    "estimatedHours" DECIMAL(5,2),
    "actualHours" DECIMAL(5,2),
    "status" "ProcedureStatus" NOT NULL DEFAULT 'NOT_STARTED',
    "completionPercentage" INTEGER NOT NULL DEFAULT 0,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "reviewStatus" "ReviewStatus" NOT NULL DEFAULT 'NOT_REVIEWED',
    "reviewerId" TEXT,
    "reviewedDate" TIMESTAMP(3),
    "reviewNotes" TEXT,
    "signedOffBy" TEXT,
    "signedOffDate" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "createdBy" TEXT,
    "updatedBy" TEXT,

    CONSTRAINT "procedures_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "audit_procedures" (
    "id" TEXT NOT NULL,
    "tenantId" TEXT NOT NULL,
    "companyId" TEXT NOT NULL,
    "periodId" TEXT NOT NULL,
    "templateId" TEXT,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "category" "ProcedureCategory" NOT NULL,
    "riskLevel" "RiskLevel" NOT NULL,
    "status" "ProcedureStatus" NOT NULL DEFAULT 'NOT_STARTED',
    "priority" "Priority" NOT NULL DEFAULT 'MEDIUM',
    "assignedToId" TEXT,
    "assignedBy" TEXT,
    "assignedAt" TIMESTAMP(3),
    "dueDate" TIMESTAMP(3),
    "startedAt" TIMESTAMP(3),
    "completedAt" TIMESTAMP(3),
    "actualHours" DOUBLE PRECISION,
    "reviewStatus" "ReviewStatus" NOT NULL DEFAULT 'NOT_REVIEWED',
    "reviewedBy" TEXT,
    "reviewedAt" TIMESTAMP(3),
    "reviewNotes" TEXT,
    "createdBy" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "audit_procedures_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "workpapers" (
    "id" TEXT NOT NULL,
    "procedureId" TEXT NOT NULL,
    "tenantId" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "content" TEXT NOT NULL,
    "preparedBy" TEXT NOT NULL,
    "preparedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "reviewedBy" TEXT,
    "reviewedAt" TIMESTAMP(3),
    "reviewNotes" TEXT,
    "version" INTEGER NOT NULL DEFAULT 1,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "workpapers_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "findings" (
    "id" TEXT NOT NULL,
    "procedureId" TEXT NOT NULL,
    "tenantId" TEXT NOT NULL,
    "companyId" TEXT NOT NULL,
    "periodId" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "severity" "Severity" NOT NULL,
    "status" "FindingStatus" NOT NULL DEFAULT 'OPEN',
    "recommendation" TEXT,
    "managementResponse" TEXT,
    "identifiedBy" TEXT NOT NULL,
    "identifiedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "resolvedBy" TEXT,
    "resolvedAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "findings_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "procedure_comments" (
    "id" TEXT NOT NULL,
    "procedureId" TEXT NOT NULL,
    "tenantId" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "comment" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "procedure_comments_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "documents" (
    "id" TEXT NOT NULL,
    "tenantId" TEXT NOT NULL,
    "companyId" TEXT NOT NULL,
    "periodId" TEXT,
    "accountId" TEXT,
    "procedureId" TEXT,
    "workpaperId" TEXT,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "originalFilename" TEXT,
    "fileExtension" TEXT,
    "mimeType" TEXT,
    "fileSizeBytes" BIGINT,
    "fileSize" BIGINT,
    "type" "DocumentType" NOT NULL,
    "status" "DocumentStatus" NOT NULL DEFAULT 'PENDING',
    "tags" TEXT[] DEFAULT ARRAY[]::TEXT[],
    "category" TEXT,
    "classification" "Classification" NOT NULL DEFAULT 'CONFIDENTIAL',
    "storageProvider" TEXT NOT NULL DEFAULT 'local',
    "storagePath" TEXT,
    "storageBucket" TEXT,
    "filePath" TEXT,
    "version" INTEGER NOT NULL DEFAULT 1,
    "isCurrentVersion" BOOLEAN NOT NULL DEFAULT true,
    "parentDocumentId" TEXT,
    "reviewNotes" TEXT,
    "reviewedBy" TEXT,
    "reviewedAt" TIMESTAMP(3),
    "approvedBy" TEXT,
    "approvedAt" TIMESTAMP(3),
    "accessLevel" "AccessLevel" NOT NULL DEFAULT 'INTERNAL',
    "passwordProtected" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "uploadedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "uploadedBy" TEXT NOT NULL,
    "lastAccessedAt" TIMESTAMP(3),
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "documents_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "users" (
    "id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "passwordHash" TEXT NOT NULL,
    "password" TEXT,
    "firstName" TEXT NOT NULL,
    "lastName" TEXT NOT NULL,
    "middleName" TEXT,
    "jobTitle" TEXT,
    "department" TEXT,
    "employeeId" TEXT,
    "phone" TEXT,
    "mobile" TEXT,
    "role" "UserRole" NOT NULL DEFAULT 'AUDITOR',
    "permissions" JSONB NOT NULL DEFAULT '[]',
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "tenantId" TEXT,
    "lastLoginAt" TIMESTAMP(3),
    "lastActivityAt" TIMESTAMP(3),
    "loginAttempts" INTEGER NOT NULL DEFAULT 0,
    "lockedUntil" TIMESTAMP(3),
    "timezone" TEXT NOT NULL DEFAULT 'UTC',
    "language" TEXT NOT NULL DEFAULT 'en',
    "theme" TEXT NOT NULL DEFAULT 'light',
    "passwordChangedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "mustChangePassword" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "createdBy" TEXT,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "alerts" (
    "id" TEXT NOT NULL,
    "companyId" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "message" TEXT NOT NULL,
    "alertType" TEXT NOT NULL,
    "category" TEXT,
    "entityId" TEXT,
    "entityType" TEXT,
    "acknowledged" BOOLEAN NOT NULL DEFAULT false,
    "acknowledgedAt" TIMESTAMP(3),
    "actionRequired" BOOLEAN NOT NULL DEFAULT false,
    "severity" "AuditSeverity" NOT NULL,
    "isRead" BOOLEAN NOT NULL DEFAULT false,
    "userId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "createdBy" TEXT NOT NULL,

    CONSTRAINT "alerts_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "import_jobs" (
    "id" TEXT NOT NULL,
    "companyId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "filename" TEXT NOT NULL,
    "filePath" TEXT,
    "format" TEXT,
    "dataType" TEXT,
    "periodId" TEXT,
    "options" JSONB,
    "status" "ImportJobStatus" NOT NULL DEFAULT 'PENDING',
    "progress" INTEGER NOT NULL DEFAULT 0,
    "totalRecords" INTEGER,
    "processedRecords" INTEGER,
    "updatedRecords" INTEGER,
    "errorRecords" INTEGER,
    "invalidRecords" INTEGER,
    "createdRecords" INTEGER,
    "validRecords" INTEGER,
    "skippedRecords" INTEGER,
    "validationErrors" JSONB,
    "startedAt" TIMESTAMP(3),
    "completedAt" TIMESTAMP(3),
    "errorDetails" JSONB,
    "error" TEXT,
    "emailOnComplete" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "createdBy" TEXT NOT NULL,

    CONSTRAINT "import_jobs_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "export_jobs" (
    "id" TEXT NOT NULL,
    "companyId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "filename" TEXT NOT NULL,
    "format" TEXT,
    "dataTypes" JSONB,
    "periodId" TEXT,
    "startDate" TIMESTAMP(3),
    "endDate" TIMESTAMP(3),
    "options" JSONB,
    "scheduledFor" TIMESTAMP(3),
    "status" "ExportJobStatus" NOT NULL DEFAULT 'PENDING',
    "progress" INTEGER NOT NULL DEFAULT 0,
    "totalRecords" INTEGER,
    "processedRecords" INTEGER,
    "startedAt" TIMESTAMP(3),
    "completedAt" TIMESTAMP(3),
    "downloadUrl" TEXT,
    "expiresAt" TIMESTAMP(3),
    "filePath" TEXT,
    "fileSize" BIGINT,
    "error" TEXT,
    "emailOnComplete" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "createdBy" TEXT NOT NULL,

    CONSTRAINT "export_jobs_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "reports" (
    "id" TEXT NOT NULL,
    "companyId" TEXT NOT NULL,
    "periodId" TEXT,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "reportType" "ReportType" NOT NULL,
    "templateId" TEXT,
    "parameters" JSONB NOT NULL DEFAULT '{}',
    "filters" JSONB,
    "configuration" JSONB,
    "recipients" JSONB,
    "format" TEXT,
    "schedule" JSONB,
    "generatedAt" TIMESTAMP(3),
    "status" "ReportStatus" NOT NULL DEFAULT 'DRAFT',
    "fileUrl" TEXT,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "createdBy" TEXT NOT NULL,
    "updatedBy" TEXT,

    CONSTRAINT "reports_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "configurations" (
    "id" TEXT NOT NULL,
    "companyId" TEXT,
    "key" TEXT NOT NULL,
    "value" JSONB NOT NULL,
    "name" TEXT,
    "type" TEXT,
    "settings" JSONB,
    "description" TEXT,
    "category" TEXT,
    "isSystem" BOOLEAN NOT NULL DEFAULT false,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "createdBy" TEXT,
    "updatedBy" TEXT,

    CONSTRAINT "configurations_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "import_templates" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "dataType" TEXT NOT NULL,
    "format" TEXT,
    "fieldMapping" JSONB NOT NULL DEFAULT '{}',
    "fieldMappings" JSONB,
    "defaultOptions" JSONB,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "createdBy" TEXT NOT NULL,

    CONSTRAINT "import_templates_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "audit_logs" (
    "id" TEXT NOT NULL,
    "tableName" TEXT NOT NULL,
    "recordId" TEXT NOT NULL,
    "action" "AuditAction" NOT NULL,
    "eventType" TEXT,
    "entityType" TEXT,
    "entityId" TEXT,
    "oldValues" JSONB,
    "newValues" JSONB,
    "hash" TEXT,
    "previousHash" TEXT,
    "userId" TEXT,
    "userEmail" TEXT,
    "companyId" TEXT,
    "periodId" TEXT,
    "sessionId" TEXT,
    "ipAddress" TEXT,
    "userAgent" TEXT,
    "requestId" TEXT,
    "endpoint" TEXT,
    "httpMethod" TEXT,
    "description" TEXT,
    "tags" TEXT,
    "metadata" TEXT,
    "severity" "AuditSeverity" NOT NULL DEFAULT 'LOW',
    "status" TEXT,
    "timestamp" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "processingTimeMs" INTEGER,
    "riskLevel" "RiskLevel" NOT NULL DEFAULT 'LOW',
    "complianceRelevant" BOOLEAN NOT NULL DEFAULT false,
    "retentionPeriod" TEXT NOT NULL DEFAULT '7 years',
    "archivedAt" TIMESTAMP(3),

    CONSTRAINT "audit_logs_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "super_admins_email_key" ON "super_admins"("email");

-- CreateIndex
CREATE UNIQUE INDEX "tenants_subdomain_key" ON "tenants"("subdomain");

-- CreateIndex
CREATE UNIQUE INDEX "tenants_databaseName_key" ON "tenants"("databaseName");

-- CreateIndex
CREATE UNIQUE INDEX "tenant_users_tenantId_email_key" ON "tenant_users"("tenantId", "email");

-- CreateIndex
CREATE UNIQUE INDEX "usage_metrics_tenantId_metricName_periodStart_key" ON "usage_metrics"("tenantId", "metricName", "periodStart");

-- CreateIndex
CREATE UNIQUE INDEX "companies_code_key" ON "companies"("code");

-- CreateIndex
CREATE UNIQUE INDEX "periods_companyId_name_key" ON "periods"("companyId", "name");

-- CreateIndex
CREATE UNIQUE INDEX "account_types_code_key" ON "account_types"("code");

-- CreateIndex
CREATE UNIQUE INDEX "account_heads_companyId_code_key" ON "account_heads"("companyId", "code");

-- CreateIndex
CREATE UNIQUE INDEX "trial_balance_companyId_periodId_accountId_key" ON "trial_balance"("companyId", "periodId", "accountId");

-- CreateIndex
CREATE UNIQUE INDEX "journal_entries_companyId_journalNumber_key" ON "journal_entries"("companyId", "journalNumber");

-- CreateIndex
CREATE INDEX "ledger_companyId_accountId_periodId_transactionDate_idx" ON "ledger"("companyId", "accountId", "periodId", "transactionDate");

-- CreateIndex
CREATE INDEX "ledger_journalEntryId_idx" ON "ledger"("journalEntryId");

-- CreateIndex
CREATE INDEX "ledger_tenantId_idx" ON "ledger"("tenantId");

-- CreateIndex
CREATE UNIQUE INDEX "ledger_companyId_accountId_periodId_sequenceNumber_key" ON "ledger"("companyId", "accountId", "periodId", "sequenceNumber");

-- CreateIndex
CREATE INDEX "audit_procedures_tenantId_idx" ON "audit_procedures"("tenantId");

-- CreateIndex
CREATE INDEX "audit_procedures_companyId_idx" ON "audit_procedures"("companyId");

-- CreateIndex
CREATE INDEX "audit_procedures_periodId_idx" ON "audit_procedures"("periodId");

-- CreateIndex
CREATE INDEX "audit_procedures_assignedToId_idx" ON "audit_procedures"("assignedToId");

-- CreateIndex
CREATE INDEX "audit_procedures_status_idx" ON "audit_procedures"("status");

-- CreateIndex
CREATE INDEX "workpapers_tenantId_idx" ON "workpapers"("tenantId");

-- CreateIndex
CREATE INDEX "workpapers_procedureId_idx" ON "workpapers"("procedureId");

-- CreateIndex
CREATE INDEX "findings_tenantId_idx" ON "findings"("tenantId");

-- CreateIndex
CREATE INDEX "findings_procedureId_idx" ON "findings"("procedureId");

-- CreateIndex
CREATE INDEX "findings_companyId_idx" ON "findings"("companyId");

-- CreateIndex
CREATE INDEX "findings_status_idx" ON "findings"("status");

-- CreateIndex
CREATE INDEX "findings_severity_idx" ON "findings"("severity");

-- CreateIndex
CREATE INDEX "procedure_comments_tenantId_idx" ON "procedure_comments"("tenantId");

-- CreateIndex
CREATE INDEX "procedure_comments_procedureId_idx" ON "procedure_comments"("procedureId");

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "users"("email");

-- CreateIndex
CREATE UNIQUE INDEX "configurations_companyId_key_key" ON "configurations"("companyId", "key");

-- AddForeignKey
ALTER TABLE "tenant_approval_requests" ADD CONSTRAINT "tenant_approval_requests_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES "tenants"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tenant_approval_requests" ADD CONSTRAINT "tenant_approval_requests_requestedBy_fkey" FOREIGN KEY ("requestedBy") REFERENCES "tenant_users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tenant_approval_requests" ADD CONSTRAINT "tenant_approval_requests_reviewedBy_fkey" FOREIGN KEY ("reviewedBy") REFERENCES "super_admins"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_approval_requests" ADD CONSTRAINT "user_approval_requests_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES "tenants"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_approval_requests" ADD CONSTRAINT "user_approval_requests_userId_fkey" FOREIGN KEY ("userId") REFERENCES "tenant_users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_approval_requests" ADD CONSTRAINT "user_approval_requests_requestedBy_fkey" FOREIGN KEY ("requestedBy") REFERENCES "tenant_users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_approval_requests" ADD CONSTRAINT "user_approval_requests_reviewedBy_fkey" FOREIGN KEY ("reviewedBy") REFERENCES "tenant_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tenant_users" ADD CONSTRAINT "tenant_users_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES "tenants"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "subscriptions" ADD CONSTRAINT "subscriptions_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES "tenants"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "usage_metrics" ADD CONSTRAINT "usage_metrics_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES "tenants"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "periods" ADD CONSTRAINT "periods_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "companies"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "account_heads" ADD CONSTRAINT "account_heads_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "companies"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "account_heads" ADD CONSTRAINT "account_heads_periodId_fkey" FOREIGN KEY ("periodId") REFERENCES "periods"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "account_heads" ADD CONSTRAINT "account_heads_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES "tenants"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "account_heads" ADD CONSTRAINT "account_heads_accountTypeId_fkey" FOREIGN KEY ("accountTypeId") REFERENCES "account_types"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "account_heads" ADD CONSTRAINT "account_heads_parentAccountId_fkey" FOREIGN KEY ("parentAccountId") REFERENCES "account_heads"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "trial_balance" ADD CONSTRAINT "trial_balance_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "companies"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "trial_balance" ADD CONSTRAINT "trial_balance_periodId_fkey" FOREIGN KEY ("periodId") REFERENCES "periods"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "trial_balance" ADD CONSTRAINT "trial_balance_accountId_fkey" FOREIGN KEY ("accountId") REFERENCES "account_heads"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "journal_entries" ADD CONSTRAINT "journal_entries_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "companies"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "journal_entries" ADD CONSTRAINT "journal_entries_periodId_fkey" FOREIGN KEY ("periodId") REFERENCES "periods"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "journal_entries" ADD CONSTRAINT "journal_entries_accountId_fkey" FOREIGN KEY ("accountId") REFERENCES "account_heads"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "journal_entries" ADD CONSTRAINT "journal_entries_referenceDocumentId_fkey" FOREIGN KEY ("referenceDocumentId") REFERENCES "documents"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "journal_line_items" ADD CONSTRAINT "journal_line_items_journalEntryId_fkey" FOREIGN KEY ("journalEntryId") REFERENCES "journal_entries"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "journal_line_items" ADD CONSTRAINT "journal_line_items_accountId_fkey" FOREIGN KEY ("accountId") REFERENCES "account_heads"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ledger" ADD CONSTRAINT "ledger_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "companies"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ledger" ADD CONSTRAINT "ledger_periodId_fkey" FOREIGN KEY ("periodId") REFERENCES "periods"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ledger" ADD CONSTRAINT "ledger_accountId_fkey" FOREIGN KEY ("accountId") REFERENCES "account_heads"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ledger" ADD CONSTRAINT "ledger_journalEntryId_fkey" FOREIGN KEY ("journalEntryId") REFERENCES "journal_entries"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ledger" ADD CONSTRAINT "ledger_lineItemId_fkey" FOREIGN KEY ("lineItemId") REFERENCES "journal_line_items"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "procedure_templates" ADD CONSTRAINT "procedure_templates_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES "tenants"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "procedure_templates" ADD CONSTRAINT "procedure_templates_createdBy_fkey" FOREIGN KEY ("createdBy") REFERENCES "tenant_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "procedures" ADD CONSTRAINT "procedures_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "companies"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "procedures" ADD CONSTRAINT "procedures_periodId_fkey" FOREIGN KEY ("periodId") REFERENCES "periods"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "procedures" ADD CONSTRAINT "procedures_templateId_fkey" FOREIGN KEY ("templateId") REFERENCES "procedure_templates"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "procedures" ADD CONSTRAINT "procedures_accountId_fkey" FOREIGN KEY ("accountId") REFERENCES "account_heads"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "procedures" ADD CONSTRAINT "procedures_assignedTo_fkey" FOREIGN KEY ("assignedTo") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "procedures" ADD CONSTRAINT "procedures_reviewerId_fkey" FOREIGN KEY ("reviewerId") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "procedures" ADD CONSTRAINT "procedures_createdBy_fkey" FOREIGN KEY ("createdBy") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "audit_procedures" ADD CONSTRAINT "audit_procedures_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES "tenants"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "audit_procedures" ADD CONSTRAINT "audit_procedures_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "companies"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "audit_procedures" ADD CONSTRAINT "audit_procedures_periodId_fkey" FOREIGN KEY ("periodId") REFERENCES "periods"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "audit_procedures" ADD CONSTRAINT "audit_procedures_templateId_fkey" FOREIGN KEY ("templateId") REFERENCES "procedure_templates"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "audit_procedures" ADD CONSTRAINT "audit_procedures_assignedToId_fkey" FOREIGN KEY ("assignedToId") REFERENCES "tenant_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "audit_procedures" ADD CONSTRAINT "audit_procedures_assignedBy_fkey" FOREIGN KEY ("assignedBy") REFERENCES "tenant_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "audit_procedures" ADD CONSTRAINT "audit_procedures_reviewedBy_fkey" FOREIGN KEY ("reviewedBy") REFERENCES "tenant_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "audit_procedures" ADD CONSTRAINT "audit_procedures_createdBy_fkey" FOREIGN KEY ("createdBy") REFERENCES "tenant_users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "workpapers" ADD CONSTRAINT "workpapers_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES "tenants"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "workpapers" ADD CONSTRAINT "workpapers_procedureId_fkey" FOREIGN KEY ("procedureId") REFERENCES "audit_procedures"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "workpapers" ADD CONSTRAINT "workpapers_preparedBy_fkey" FOREIGN KEY ("preparedBy") REFERENCES "tenant_users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "workpapers" ADD CONSTRAINT "workpapers_reviewedBy_fkey" FOREIGN KEY ("reviewedBy") REFERENCES "tenant_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "findings" ADD CONSTRAINT "findings_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES "tenants"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "findings" ADD CONSTRAINT "findings_procedureId_fkey" FOREIGN KEY ("procedureId") REFERENCES "audit_procedures"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "findings" ADD CONSTRAINT "findings_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "companies"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "findings" ADD CONSTRAINT "findings_periodId_fkey" FOREIGN KEY ("periodId") REFERENCES "periods"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "findings" ADD CONSTRAINT "findings_identifiedBy_fkey" FOREIGN KEY ("identifiedBy") REFERENCES "tenant_users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "findings" ADD CONSTRAINT "findings_resolvedBy_fkey" FOREIGN KEY ("resolvedBy") REFERENCES "tenant_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "procedure_comments" ADD CONSTRAINT "procedure_comments_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES "tenants"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "procedure_comments" ADD CONSTRAINT "procedure_comments_procedureId_fkey" FOREIGN KEY ("procedureId") REFERENCES "audit_procedures"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "procedure_comments" ADD CONSTRAINT "procedure_comments_userId_fkey" FOREIGN KEY ("userId") REFERENCES "tenant_users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "documents" ADD CONSTRAINT "documents_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES "tenants"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "documents" ADD CONSTRAINT "documents_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "companies"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "documents" ADD CONSTRAINT "documents_periodId_fkey" FOREIGN KEY ("periodId") REFERENCES "periods"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "documents" ADD CONSTRAINT "documents_accountId_fkey" FOREIGN KEY ("accountId") REFERENCES "account_heads"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "documents" ADD CONSTRAINT "documents_procedureId_fkey" FOREIGN KEY ("procedureId") REFERENCES "procedures"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "documents" ADD CONSTRAINT "documents_workpaperId_fkey" FOREIGN KEY ("workpaperId") REFERENCES "workpapers"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "documents" ADD CONSTRAINT "documents_uploadedBy_fkey" FOREIGN KEY ("uploadedBy") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "documents" ADD CONSTRAINT "documents_reviewedBy_fkey" FOREIGN KEY ("reviewedBy") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "documents" ADD CONSTRAINT "documents_approvedBy_fkey" FOREIGN KEY ("approvedBy") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "documents" ADD CONSTRAINT "documents_parentDocumentId_fkey" FOREIGN KEY ("parentDocumentId") REFERENCES "documents"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "users" ADD CONSTRAINT "users_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES "tenants"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "alerts" ADD CONSTRAINT "alerts_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "companies"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "alerts" ADD CONSTRAINT "alerts_createdBy_fkey" FOREIGN KEY ("createdBy") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "import_jobs" ADD CONSTRAINT "import_jobs_createdBy_fkey" FOREIGN KEY ("createdBy") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "import_jobs" ADD CONSTRAINT "import_jobs_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "companies"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "import_jobs" ADD CONSTRAINT "import_jobs_periodId_fkey" FOREIGN KEY ("periodId") REFERENCES "periods"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "export_jobs" ADD CONSTRAINT "export_jobs_createdBy_fkey" FOREIGN KEY ("createdBy") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "export_jobs" ADD CONSTRAINT "export_jobs_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "companies"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "export_jobs" ADD CONSTRAINT "export_jobs_periodId_fkey" FOREIGN KEY ("periodId") REFERENCES "periods"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "reports" ADD CONSTRAINT "reports_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "companies"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "reports" ADD CONSTRAINT "reports_periodId_fkey" FOREIGN KEY ("periodId") REFERENCES "periods"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "reports" ADD CONSTRAINT "reports_createdBy_fkey" FOREIGN KEY ("createdBy") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "configurations" ADD CONSTRAINT "configurations_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "companies"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "configurations" ADD CONSTRAINT "configurations_createdBy_fkey" FOREIGN KEY ("createdBy") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "audit_logs" ADD CONSTRAINT "audit_logs_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "audit_logs" ADD CONSTRAINT "audit_logs_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "companies"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "audit_logs" ADD CONSTRAINT "audit_logs_periodId_fkey" FOREIGN KEY ("periodId") REFERENCES "periods"("id") ON DELETE SET NULL ON UPDATE CASCADE;
