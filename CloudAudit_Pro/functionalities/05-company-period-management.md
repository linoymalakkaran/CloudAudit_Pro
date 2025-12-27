# CloudAudit Pro - Company & Period Management

## 🏢 Overview

Company and Period Management is a core module of CloudAudit Pro that handles multi-tenant company organization and fiscal period tracking. This module enables audit firms to manage multiple client companies, each with their own fiscal periods, ensuring proper data isolation and audit cycle management.

---

## 🏛️ Company Management

### Company Structure

CloudAudit Pro uses a **database-per-tenant** architecture where each company gets its own isolated database instance for maximum security and data segregation.

```typescript
interface Company {
  id: string;                    // UUID
  name: string;                  // Legal company name
  displayName: string;           // Public display name
  slug: string;                  // URL-friendly identifier
  
  // Business Information
  businessType: BusinessType;
  registrationNumber?: string;   // Business registration number
  taxId?: string;                // Tax identification number
  industry?: string;
  
  // Contact Information
  email: string;
  phone: string;
  website?: string;
  
  // Address
  address: {
    street: string;
    city: string;
    state: string;
    postalCode: string;
    country: string;
  };
  
  // Database Configuration
  databaseName: string;          // Tenant database name
  
  // Status & Lifecycle
  status: CompanyStatus;
  
  // Audit Configuration
  fiscalYearEnd: string;         // MM-DD format (e.g., "12-31")
  currency: string;              // ISO 4217 code (e.g., "USD")
  timezone: string;              // IANA timezone (e.g., "America/New_York")
  
  // Subscription (future)
  subscriptionTier?: 'FREE' | 'BASIC' | 'PROFESSIONAL' | 'ENTERPRISE';
  subscriptionStatus?: 'TRIAL' | 'ACTIVE' | 'PAST_DUE' | 'CANCELLED';
  
  // Timestamps
  createdAt: Date;
  approvedAt?: Date;
  approvedBy?: string;           // Super admin ID
  
  // Relationships
  users: User[];
  periods: Period[];
}

enum BusinessType {
  AUDIT_FIRM = 'AUDIT_FIRM',
  INTERNAL_AUDIT = 'INTERNAL_AUDIT',
  ACCOUNTING_FIRM = 'ACCOUNTING_FIRM',
  CORPORATION = 'CORPORATION',
  NON_PROFIT = 'NON_PROFIT',
  GOVERNMENT = 'GOVERNMENT',
  OTHER = 'OTHER'
}

enum CompanyStatus {
  PENDING = 'PENDING',           // Awaiting super admin approval
  UNDER_REVIEW = 'UNDER_REVIEW', // Being reviewed
  ACTIVE = 'ACTIVE',             // Approved and operational
  SUSPENDED = 'SUSPENDED',       // Temporarily disabled
  REJECTED = 'REJECTED',         // Registration denied
  CANCELLED = 'CANCELLED'        // Subscription cancelled
}
```

### Company Setup and Configuration

#### Initial Setup (Post-Approval)

After super admin approval, the company admin must complete the initial setup:

**Setup Wizard Steps**:
```typescript
interface CompanySetupWizard {
  steps: [
    'company_details',    // Verify and complete company information
    'fiscal_configuration', // Set fiscal year end, currency, timezone
    'chart_of_accounts',  // Choose or customize chart of accounts
    'first_period',       // Create first audit period
    'team_invitation'     // Invite team members (optional)
  ];
  
  currentStep: number;
  completedSteps: string[];
  isComplete: boolean;
}
```

**Step 1: Company Details**:
```typescript
POST /api/companies/setup/details

interface CompanyDetailsSetup {
  displayName: string;
  logo?: File;              // Company logo upload
  industry: string;
  fiscalYearEnd: string;    // MM-DD format
  currency: string;         // ISO 4217 code
  timezone: string;         // IANA timezone
  
  // Additional settings
  enableMultiCurrency: boolean;
  decimalPlaces: number;    // 2 or 3
  dateFormat: 'MM/DD/YYYY' | 'DD/MM/YYYY' | 'YYYY-MM-DD';
  numberFormat: 'US' | 'EU' | 'OTHER';
}

async completeCompanyDetails(companyId: string, data: CompanyDetailsSetup) {
  // Validate fiscal year end
  if (!isValidDate(data.fiscalYearEnd, 'MM-DD')) {
    throw new BadRequestException('Invalid fiscal year end format');
  }
  
  // Validate currency code
  if (!VALID_CURRENCIES.includes(data.currency)) {
    throw new BadRequestException('Invalid currency code');
  }
  
  // Upload logo if provided
  let logoUrl;
  if (data.logo) {
    logoUrl = await uploadCompanyLogo(companyId, data.logo);
  }
  
  // Update company
  const company = await prisma.company.update({
    where: { id: companyId },
    data: {
      displayName: data.displayName,
      logo: logoUrl,
      industry: data.industry,
      fiscalYearEnd: data.fiscalYearEnd,
      currency: data.currency,
      timezone: data.timezone,
      settings: {
        enableMultiCurrency: data.enableMultiCurrency,
        decimalPlaces: data.decimalPlaces,
        dateFormat: data.dateFormat,
        numberFormat: data.numberFormat
      }
    }
  });
  
  // Log setup step completion
  await logAuditEvent({
    companyId,
    action: 'COMPANY_DETAILS_COMPLETED',
    resourceType: 'COMPANY',
    resourceId: companyId
  });
  
  return company;
}
```

**Step 2: Chart of Accounts Selection**:
```typescript
POST /api/companies/setup/chart-of-accounts

interface ChartOfAccountsSetup {
  templateId?: string;     // Use predefined template
  customChart?: object;    // Or provide custom chart
}

async setupChartOfAccounts(companyId: string, data: ChartOfAccountsSetup) {
  const company = await getCompany(companyId);
  
  // Get tenant database connection
  const tenantDb = getTenantDatabase(company.databaseName);
  
  if (data.templateId) {
    // Load template from master database
    const template = await prisma.chartTemplate.findUnique({
      where: { id: data.templateId },
      include: { accounts: true }
    });
    
    // Copy template to tenant database
    await copyChartTemplate(tenantDb, template);
  } else if (data.customChart) {
    // Import custom chart
    await importCustomChart(tenantDb, data.customChart);
  }
  
  return { success: true };
}
```

**Step 3: First Period Creation**:
```typescript
POST /api/companies/setup/first-period

interface FirstPeriodSetup {
  name: string;              // e.g., "FY 2024"
  startDate: Date;
  endDate: Date;
  status: 'OPEN' | 'IN_PROGRESS';
}

async createFirstPeriod(companyId: string, data: FirstPeriodSetup) {
  const company = await getCompany(companyId);
  const tenantDb = getTenantDatabase(company.databaseName);
  
  // Validate dates
  if (data.startDate >= data.endDate) {
    throw new BadRequestException('Start date must be before end date');
  }
  
  // Create period in tenant database
  const period = await tenantDb.period.create({
    data: {
      name: data.name,
      startDate: data.startDate,
      endDate: data.endDate,
      status: data.status,
      isActive: true
    }
  });
  
  // Mark setup as complete
  await prisma.company.update({
    where: { id: companyId },
    data: {
      setupCompleted: true,
      setupCompletedAt: new Date()
    }
  });
  
  return period;
}
```

### Company Administration

#### View Company Information

**Get Company Details**:
```typescript
GET /api/companies/:id

async getCompanyDetails(companyId: string, userId: string) {
  // Check permissions
  const user = await prisma.user.findUnique({
    where: { id: userId }
  });
  
  if (user.companyId !== companyId && user.role !== 'SUPER_ADMIN') {
    throw new ForbiddenException('Access denied');
  }
  
  const company = await prisma.company.findUnique({
    where: { id: companyId },
    include: {
      users: {
        select: {
          id: true,
          firstName: true,
          lastName: true,
          email: true,
          role: true,
          status: true
        }
      },
      _count: {
        select: {
          users: true
        }
      }
    }
  });
  
  // Get period count from tenant database
  if (company.databaseName) {
    const tenantDb = getTenantDatabase(company.databaseName);
    const periodCount = await tenantDb.period.count();
    company.periodCount = periodCount;
  }
  
  return company;
}
```

#### Update Company Settings

**Update Company Information**:
```typescript
PATCH /api/companies/:id

interface UpdateCompanyRequest {
  displayName?: string;
  email?: string;
  phone?: string;
  website?: string;
  address?: Address;
  industry?: string;
  fiscalYearEnd?: string;
  timezone?: string;
  logo?: File;
}

async updateCompany(companyId: string, userId: string, data: UpdateCompanyRequest) {
  // Check admin permissions
  const user = await prisma.user.findUnique({
    where: { id: userId }
  });
  
  if (user.companyId !== companyId || !['ADMIN', 'MANAGER'].includes(user.role)) {
    throw new ForbiddenException('Only admins can update company details');
  }
  
  // Upload new logo if provided
  if (data.logo) {
    const logoUrl = await uploadCompanyLogo(companyId, data.logo);
    data.logo = logoUrl;
  }
  
  const company = await prisma.company.update({
    where: { id: companyId },
    data: {
      displayName: data.displayName,
      email: data.email,
      phone: data.phone,
      website: data.website,
      address: data.address,
      industry: data.industry,
      fiscalYearEnd: data.fiscalYearEnd,
      timezone: data.timezone,
      logo: data.logo
    }
  });
  
  // Log update
  await logAuditEvent({
    userId,
    action: 'COMPANY_UPDATED',
    resourceType: 'COMPANY',
    resourceId: companyId,
    metadata: data
  });
  
  return company;
}
```

### Multi-Company Support

#### Company Switching (for Super Admins)

Super admins can access multiple companies for support purposes:

```typescript
POST /api/super-admin/switch-company

interface SwitchCompanyRequest {
  companyId: string;
  reason: string;  // Reason for accessing company data
}

async switchCompany(superAdminId: string, data: SwitchCompanyRequest) {
  // Verify super admin
  const admin = await prisma.user.findUnique({
    where: { id: superAdminId }
  });
  
  if (admin.role !== 'SUPER_ADMIN') {
    throw new ForbiddenException('Only super admins can switch companies');
  }
  
  // Get target company
  const company = await prisma.company.findUnique({
    where: { id: data.companyId }
  });
  
  if (!company) {
    throw new NotFoundException('Company not found');
  }
  
  // Log access for audit trail
  await logAuditEvent({
    userId: superAdminId,
    action: 'SUPER_ADMIN_COMPANY_ACCESS',
    resourceType: 'COMPANY',
    resourceId: data.companyId,
    metadata: { reason: data.reason }
  });
  
  // Generate special access token
  const accessToken = jwt.sign(
    {
      userId: superAdminId,
      role: 'SUPER_ADMIN',
      companyId: data.companyId,
      databaseName: company.databaseName,
      isSuperAdminAccess: true
    },
    process.env.JWT_SECRET,
    { expiresIn: '1h' } // Shorter expiry for security
  );
  
  return {
    accessToken,
    company: {
      id: company.id,
      name: company.name,
      databaseName: company.databaseName
    }
  };
}
```

#### Company Isolation

Each company's data is completely isolated in its own database:

```typescript
// Tenant database connection manager
class TenantDatabaseManager {
  private connections: Map<string, PrismaClient> = new Map();
  
  getTenantDatabase(databaseName: string): PrismaClient {
    // Check if connection exists
    if (this.connections.has(databaseName)) {
      return this.connections.get(databaseName);
    }
    
    // Create new connection
    const connectionString = `postgresql://user:pass@localhost:5432/${databaseName}`;
    const client = new PrismaClient({
      datasources: {
        db: { url: connectionString }
      }
    });
    
    // Cache connection
    this.connections.set(databaseName, client);
    
    return client;
  }
  
  // Middleware to automatically select tenant database
  async selectTenantDatabase(req: Request, res: Response, next: NextFunction) {
    // Get user from JWT
    const user = req.user;
    
    if (!user) {
      return next();
    }
    
    // Get company database name
    const company = await prisma.company.findUnique({
      where: { id: user.companyId },
      select: { databaseName: true }
    });
    
    // Attach tenant database to request
    req.tenantDb = this.getTenantDatabase(company.databaseName);
    
    next();
  }
}
```

---

## 📅 Period Management

### Period Structure

Periods represent fiscal years or audit cycles in CloudAudit Pro. Each company can have multiple periods, but only one is typically active at a time.

```typescript
interface Period {
  id: string;
  name: string;              // e.g., "FY 2024", "Q1 2024"
  description?: string;
  
  // Date Range
  startDate: Date;           // Period start date
  endDate: Date;             // Period end date
  
  // Status
  status: PeriodStatus;
  
  // Settings
  isActive: boolean;         // Currently active period
  lockDate?: Date;           // Date after which no changes allowed
  
  // Financial Configuration
  openingBalances?: object;  // Opening trial balance
  closingBalances?: object;  // Closing trial balance
  
  // Audit Information
  auditType?: 'FULL' | 'REVIEW' | 'COMPILATION';
  auditorInCharge?: string;  // User ID
  reviewPartner?: string;    // User ID
  
  // Timestamps
  createdAt: Date;
  openedAt?: Date;
  closedAt?: Date;
  lockedAt?: Date;
  
  // Relationships
  trialBalances: TrialBalance[];
  workpapers: Workpaper[];
  financialStatements: FinancialStatement[];
  adjustments: Adjustment[];
}

enum PeriodStatus {
  DRAFT = 'DRAFT',               // Being created
  OPEN = 'OPEN',                 // Ready for audit work
  IN_PROGRESS = 'IN_PROGRESS',   // Audit work ongoing
  UNDER_REVIEW = 'UNDER_REVIEW', // Review phase
  COMPLETED = 'COMPLETED',       // Audit completed
  CLOSED = 'CLOSED',             // Permanently closed
  ARCHIVED = 'ARCHIVED'          // Archived for long-term storage
}
```

### Period Lifecycle

```
DRAFT → OPEN → IN_PROGRESS → UNDER_REVIEW → COMPLETED → CLOSED → ARCHIVED
          ↓                                                ↓
        (can be                                    (can be reopened
         closed                                     for adjustments)
         early)
```

### Create New Period

**Create Period Endpoint**:
```typescript
POST /api/periods

interface CreatePeriodRequest {
  name: string;
  description?: string;
  startDate: string;         // ISO date
  endDate: string;           // ISO date
  auditType?: 'FULL' | 'REVIEW' | 'COMPILATION';
  copyFromPeriodId?: string; // Copy settings from previous period
}

async createPeriod(companyId: string, userId: string, data: CreatePeriodRequest) {
  // Get tenant database
  const company = await getCompany(companyId);
  const tenantDb = getTenantDatabase(company.databaseName);
  
  // Validate dates
  const startDate = new Date(data.startDate);
  const endDate = new Date(data.endDate);
  
  if (startDate >= endDate) {
    throw new BadRequestException('Start date must be before end date');
  }
  
  // Check for overlapping periods
  const overlapping = await tenantDb.period.findFirst({
    where: {
      OR: [
        {
          startDate: { lte: endDate },
          endDate: { gte: startDate }
        }
      ]
    }
  });
  
  if (overlapping) {
    throw new BadRequestException('Period dates overlap with existing period');
  }
  
  // Check permissions
  const user = await prisma.user.findUnique({
    where: { id: userId }
  });
  
  if (!['ADMIN', 'MANAGER'].includes(user.role)) {
    throw new ForbiddenException('Only admins and managers can create periods');
  }
  
  // Create period
  const period = await tenantDb.period.create({
    data: {
      name: data.name,
      description: data.description,
      startDate,
      endDate,
      status: 'DRAFT',
      auditType: data.auditType,
      createdBy: userId
    }
  });
  
  // Copy settings from previous period if specified
  if (data.copyFromPeriodId) {
    await copyPeriodSettings(tenantDb, data.copyFromPeriodId, period.id);
  }
  
  // Log creation
  await logAuditEvent({
    userId,
    companyId,
    action: 'PERIOD_CREATED',
    resourceType: 'PERIOD',
    resourceId: period.id,
    metadata: { periodName: data.name }
  });
  
  return period;
}
```

### Period Status Transitions

#### Open Period (DRAFT → OPEN)

**Open Period Endpoint**:
```typescript
POST /api/periods/:id/open

async openPeriod(periodId: string, userId: string) {
  const user = await prisma.user.findUnique({
    where: { id: userId }
  });
  
  if (!['ADMIN', 'MANAGER'].includes(user.role)) {
    throw new ForbiddenException('Only admins and managers can open periods');
  }
  
  const company = await getCompany(user.companyId);
  const tenantDb = getTenantDatabase(company.databaseName);
  
  // Get period
  const period = await tenantDb.period.findUnique({
    where: { id: periodId }
  });
  
  if (!period) {
    throw new NotFoundException('Period not found');
  }
  
  if (period.status !== 'DRAFT') {
    throw new BadRequestException('Only draft periods can be opened');
  }
  
  // Deactivate other active periods
  await tenantDb.period.updateMany({
    where: { isActive: true },
    data: { isActive: false }
  });
  
  // Open period
  const updatedPeriod = await tenantDb.period.update({
    where: { id: periodId },
    data: {
      status: 'OPEN',
      isActive: true,
      openedAt: new Date()
    }
  });
  
  // Log event
  await logAuditEvent({
    userId,
    companyId: user.companyId,
    action: 'PERIOD_OPENED',
    resourceType: 'PERIOD',
    resourceId: periodId
  });
  
  return updatedPeriod;
}
```

#### Start Audit Work (OPEN → IN_PROGRESS)

**Start Audit Endpoint**:
```typescript
POST /api/periods/:id/start-audit

async startAudit(periodId: string, userId: string) {
  const user = await prisma.user.findUnique({
    where: { id: userId }
  });
  
  const company = await getCompany(user.companyId);
  const tenantDb = getTenantDatabase(company.databaseName);
  
  // Get period
  const period = await tenantDb.period.findUnique({
    where: { id: periodId }
  });
  
  if (period.status !== 'OPEN') {
    throw new BadRequestException('Period must be open to start audit');
  }
  
  // Check if trial balance exists
  const trialBalance = await tenantDb.trialBalance.findFirst({
    where: { periodId }
  });
  
  if (!trialBalance) {
    throw new BadRequestException('Trial balance must be imported before starting audit');
  }
  
  // Update status
  const updatedPeriod = await tenantDb.period.update({
    where: { id: periodId },
    data: {
      status: 'IN_PROGRESS',
      auditStartedAt: new Date(),
      auditStartedBy: userId
    }
  });
  
  // Log event
  await logAuditEvent({
    userId,
    companyId: user.companyId,
    action: 'AUDIT_STARTED',
    resourceType: 'PERIOD',
    resourceId: periodId
  });
  
  return updatedPeriod;
}
```

#### Submit for Review (IN_PROGRESS → UNDER_REVIEW)

**Submit for Review Endpoint**:
```typescript
POST /api/periods/:id/submit-review

interface SubmitReviewRequest {
  reviewerId: string;  // User ID of reviewer
  notes?: string;
}

async submitForReview(periodId: string, userId: string, data: SubmitReviewRequest) {
  const user = await prisma.user.findUnique({
    where: { id: userId }
  });
  
  const company = await getCompany(user.companyId);
  const tenantDb = getTenantDatabase(company.databaseName);
  
  // Get period
  const period = await tenantDb.period.findUnique({
    where: { id: periodId }
  });
  
  if (period.status !== 'IN_PROGRESS') {
    throw new BadRequestException('Period must be in progress to submit for review');
  }
  
  // Validate reviewer
  const reviewer = await prisma.user.findUnique({
    where: { id: data.reviewerId }
  });
  
  if (!reviewer || !['ADMIN', 'MANAGER', 'SENIOR_AUDITOR'].includes(reviewer.role)) {
    throw new BadRequestException('Invalid reviewer');
  }
  
  // Check completion status
  const incompleteTasks = await tenantDb.auditTask.count({
    where: {
      periodId,
      status: { not: 'COMPLETED' }
    }
  });
  
  if (incompleteTasks > 0) {
    throw new BadRequestException(`${incompleteTasks} audit tasks are not completed`);
  }
  
  // Update status
  const updatedPeriod = await tenantDb.period.update({
    where: { id: periodId },
    data: {
      status: 'UNDER_REVIEW',
      reviewPartner: data.reviewerId,
      submittedForReviewAt: new Date(),
      submittedForReviewBy: userId,
      reviewNotes: data.notes
    }
  });
  
  // Notify reviewer
  await sendNotification({
    userId: data.reviewerId,
    type: 'PERIOD_REVIEW_REQUEST',
    title: 'Period Submitted for Review',
    message: `${period.name} has been submitted for your review`,
    link: `/periods/${periodId}/review`
  });
  
  // Log event
  await logAuditEvent({
    userId,
    companyId: user.companyId,
    action: 'PERIOD_SUBMITTED_FOR_REVIEW',
    resourceType: 'PERIOD',
    resourceId: periodId,
    metadata: { reviewerId: data.reviewerId }
  });
  
  return updatedPeriod;
}
```

#### Complete Period (UNDER_REVIEW → COMPLETED)

**Complete Period Endpoint**:
```typescript
POST /api/periods/:id/complete

interface CompletePeriodRequest {
  finalReviewNotes?: string;
  generateFinalReports: boolean;
}

async completePeriod(periodId: string, userId: string, data: CompletePeriodRequest) {
  const user = await prisma.user.findUnique({
    where: { id: userId }
  });
  
  if (!['ADMIN', 'MANAGER'].includes(user.role)) {
    throw new ForbiddenException('Only admins and managers can complete periods');
  }
  
  const company = await getCompany(user.companyId);
  const tenantDb = getTenantDatabase(company.databaseName);
  
  // Get period
  const period = await tenantDb.period.findUnique({
    where: { id: periodId }
  });
  
  if (period.status !== 'UNDER_REVIEW') {
    throw new BadRequestException('Period must be under review to complete');
  }
  
  // Generate final reports if requested
  if (data.generateFinalReports) {
    await generateFinalAuditReports(tenantDb, periodId);
  }
  
  // Update status
  const updatedPeriod = await tenantDb.period.update({
    where: { id: periodId },
    data: {
      status: 'COMPLETED',
      completedAt: new Date(),
      completedBy: userId,
      finalReviewNotes: data.finalReviewNotes
    }
  });
  
  // Log event
  await logAuditEvent({
    userId,
    companyId: user.companyId,
    action: 'PERIOD_COMPLETED',
    resourceType: 'PERIOD',
    resourceId: periodId
  });
  
  return updatedPeriod;
}
```

#### Close Period (COMPLETED → CLOSED)

**Close Period Endpoint**:
```typescript
POST /api/periods/:id/close

interface ClosePeriodRequest {
  lockPeriod: boolean;     // Prevent any future changes
  archiveData: boolean;    // Move to long-term storage
}

async closePeriod(periodId: string, userId: string, data: ClosePeriodRequest) {
  const user = await prisma.user.findUnique({
    where: { id: userId }
  });
  
  if (user.role !== 'ADMIN') {
    throw new ForbiddenException('Only admins can close periods');
  }
  
  const company = await getCompany(user.companyId);
  const tenantDb = getTenantDatabase(company.databaseName);
  
  // Get period
  const period = await tenantDb.period.findUnique({
    where: { id: periodId }
  });
  
  if (!['COMPLETED', 'OPEN'].includes(period.status)) {
    throw new BadRequestException('Only completed or open periods can be closed');
  }
  
  // Close period
  const updatedPeriod = await tenantDb.period.update({
    where: { id: periodId },
    data: {
      status: 'CLOSED',
      closedAt: new Date(),
      closedBy: userId,
      isActive: false,
      lockDate: data.lockPeriod ? new Date() : null
    }
  });
  
  // Archive if requested
  if (data.archiveData) {
    await archivePeriodData(tenantDb, periodId);
  }
  
  // Log event
  await logAuditEvent({
    userId,
    companyId: user.companyId,
    action: 'PERIOD_CLOSED',
    resourceType: 'PERIOD',
    resourceId: periodId
  });
  
  return updatedPeriod;
}
```

### Period Locking and Unlocking

#### Lock Period

Locking a period prevents any modifications to its data:

```typescript
POST /api/periods/:id/lock

interface LockPeriodRequest {
  reason: string;
  lockDate?: Date;  // Effective date of lock (default: now)
}

async lockPeriod(periodId: string, userId: string, data: LockPeriodRequest) {
  const user = await prisma.user.findUnique({
    where: { id: userId }
  });
  
  if (user.role !== 'ADMIN') {
    throw new ForbiddenException('Only admins can lock periods');
  }
  
  const company = await getCompany(user.companyId);
  const tenantDb = getTenantDatabase(company.databaseName);
  
  // Lock period
  const updatedPeriod = await tenantDb.period.update({
    where: { id: periodId },
    data: {
      lockDate: data.lockDate || new Date(),
      lockReason: data.reason,
      lockedBy: userId,
      lockedAt: new Date()
    }
  });
  
  // Log event
  await logAuditEvent({
    userId,
    companyId: user.companyId,
    action: 'PERIOD_LOCKED',
    resourceType: 'PERIOD',
    resourceId: periodId,
    metadata: { reason: data.reason }
  });
  
  return updatedPeriod;
}
```

#### Unlock Period

```typescript
POST /api/periods/:id/unlock

interface UnlockPeriodRequest {
  reason: string;
}

async unlockPeriod(periodId: string, userId: string, data: UnlockPeriodRequest) {
  const user = await prisma.user.findUnique({
    where: { id: userId }
  });
  
  if (user.role !== 'ADMIN') {
    throw new ForbiddenException('Only admins can unlock periods');
  }
  
  const company = await getCompany(user.companyId);
  const tenantDb = getTenantDatabase(company.databaseName);
  
  // Unlock period
  const updatedPeriod = await tenantDb.period.update({
    where: { id: periodId },
    data: {
      lockDate: null,
      unlockReason: data.reason,
      unlockedBy: userId,
      unlockedAt: new Date()
    }
  });
  
  // Log event
  await logAuditEvent({
    userId,
    companyId: user.companyId,
    action: 'PERIOD_UNLOCKED',
    resourceType: 'PERIOD',
    resourceId: periodId,
    metadata: { reason: data.reason }
  });
  
  return updatedPeriod;
}
```

### Company-Period Relationships

#### Active Period Management

Only one period should be active at a time:

```typescript
POST /api/periods/:id/set-active

async setActivePeriod(periodId: string, userId: string) {
  const user = await prisma.user.findUnique({
    where: { id: userId }
  });
  
  const company = await getCompany(user.companyId);
  const tenantDb = getTenantDatabase(company.databaseName);
  
  // Deactivate all periods
  await tenantDb.period.updateMany({
    where: { isActive: true },
    data: { isActive: false }
  });
  
  // Activate selected period
  const period = await tenantDb.period.update({
    where: { id: periodId },
    data: { isActive: true }
  });
  
  return period;
}
```

#### List Periods

```typescript
GET /api/periods

interface ListPeriodsQuery {
  status?: PeriodStatus;
  year?: number;
  isActive?: boolean;
  sortBy?: 'startDate' | 'endDate' | 'createdAt';
  sortOrder?: 'asc' | 'desc';
}

async listPeriods(companyId: string, query: ListPeriodsQuery) {
  const company = await getCompany(companyId);
  const tenantDb = getTenantDatabase(company.databaseName);
  
  const periods = await tenantDb.period.findMany({
    where: {
      ...(query.status && { status: query.status }),
      ...(query.isActive !== undefined && { isActive: query.isActive }),
      ...(query.year && {
        startDate: {
          gte: new Date(`${query.year}-01-01`),
          lte: new Date(`${query.year}-12-31`)
        }
      })
    },
    orderBy: {
      [query.sortBy || 'startDate']: query.sortOrder || 'desc'
    },
    include: {
      _count: {
        select: {
          trialBalances: true,
          workpapers: true,
          adjustments: true
        }
      }
    }
  });
  
  return periods;
}
```

---

## 🔍 Best Practices

### Company Management Best Practices

1. **Setup Completion**:
   - Complete all setup wizard steps before inviting users
   - Choose appropriate fiscal year end date
   - Select or customize chart of accounts carefully
   - Set correct timezone and currency

2. **Data Security**:
   - Each company has isolated database
   - No cross-tenant data access (except super admins)
   - Regular backups of tenant databases
   - Audit all super admin access

3. **Company Settings**:
   - Keep company information up to date
   - Use meaningful display names
   - Upload company logo for branding
   - Configure regional settings appropriately

### Period Management Best Practices

1. **Period Planning**:
   - Create periods in advance
   - Avoid overlapping period dates
   - Use consistent naming convention (e.g., "FY 2024")
   - Plan audit timeline before opening period

2. **Status Transitions**:
   - Follow proper workflow (Draft → Open → In Progress → Under Review → Completed → Closed)
   - Don't skip status transitions
   - Complete all audit tasks before submitting for review
   - Have proper approval before completing

3. **Period Locking**:
   - Lock periods after completion to prevent changes
   - Document reason for locking/unlocking
   - Only unlock when absolutely necessary
   - Maintain audit trail of all lock/unlock actions

4. **Active Period**:
   - Keep only one period active at a time
   - Switch active period when starting new audit cycle
   - Archive old periods to maintain performance

---

## 🛠️ Common Use Cases

### Use Case 1: New Company Onboarding

**Workflow**:
1. User registers company
2. Super admin approves registration
3. Tenant database created automatically
4. Admin receives welcome email
5. Admin completes setup wizard:
   - Configure company details
   - Select chart of accounts template
   - Create first audit period
   - Invite team members
6. Company ready for audit work

### Use Case 2: Annual Audit Cycle

**Workflow**:
1. Manager creates new period for fiscal year
2. Admin reviews and opens period
3. Import trial balance
4. Manager starts audit (status → IN_PROGRESS)
5. Team completes audit procedures
6. Manager submits for partner review
7. Partner reviews and completes period
8. Admin closes period after finalization
9. Archive period data

### Use Case 3: Multi-Period Management

**Scenario**: Working on multiple periods simultaneously

**Workflow**:
1. Keep current year as active period
2. Create draft period for next year planning
3. Keep previous year completed but not closed (for adjustments)
4. Archive periods older than 2 years
5. Switch active period when starting new audit

### Use Case 4: Period Reopening

**Scenario**: Need to make adjustments to closed period

**Workflow**:
1. Admin unlocks period with documented reason
2. Make necessary adjustments
3. Update affected reports
4. Re-complete review process if significant
5. Re-close and lock period
6. Document all changes in audit trail

---

## 🚨 Troubleshooting

### Common Issues

**Issue: "Period dates overlap with existing period"**
- **Cause**: Trying to create period with overlapping dates
- **Solution**: Check existing periods, adjust dates, or use different period structure

**Issue: "Cannot start audit - no trial balance"**
- **Cause**: Trial balance not imported before starting audit
- **Solution**: Import trial balance before changing status to IN_PROGRESS

**Issue: "Cannot complete period - incomplete tasks"**
- **Cause**: Some audit tasks not marked as completed
- **Solution**: Review and complete all pending audit tasks

**Issue: "Period is locked - cannot make changes"**
- **Cause**: Period has been locked by admin
- **Solution**: Request admin to unlock period with valid reason

**Issue: "Cannot switch company - access denied"**
- **Cause**: Not a super admin or wrong permissions
- **Solution**: Only super admins can access multiple companies

### Error Codes

```typescript
enum CompanyPeriodErrorCode {
  // Company errors
  COMPANY_NOT_FOUND = 'COMP_001',
  COMPANY_NOT_ACTIVE = 'COMP_002',
  COMPANY_SETUP_INCOMPLETE = 'COMP_003',
  DUPLICATE_COMPANY_NAME = 'COMP_004',
  
  // Period errors
  PERIOD_NOT_FOUND = 'PER_001',
  PERIOD_LOCKED = 'PER_002',
  PERIOD_OVERLAP = 'PER_003',
  INVALID_STATUS_TRANSITION = 'PER_004',
  TRIAL_BALANCE_MISSING = 'PER_005',
  INCOMPLETE_AUDIT_TASKS = 'PER_006',
  PERIOD_CLOSED = 'PER_007',
  
  // Permission errors
  INSUFFICIENT_PERMISSIONS = 'PERM_001',
  TENANT_ACCESS_DENIED = 'PERM_002'
}
```

---

## 📊 Monitoring & Metrics

### Company Metrics

- Total active companies
- New registrations (daily/monthly)
- Company setup completion rate
- Average time to complete setup
- Companies by business type
- Companies by subscription tier

### Period Metrics

- Total periods by status
- Average period duration
- Periods by audit type
- Active periods count
- Locked periods count
- Period status transition times

---

## 📚 API Reference Summary

### Company Endpoints
- `GET /api/companies/:id` - Get company details
- `PATCH /api/companies/:id` - Update company
- `POST /api/companies/setup/details` - Complete company details setup
- `POST /api/companies/setup/chart-of-accounts` - Setup chart of accounts
- `POST /api/companies/setup/first-period` - Create first period
- `POST /api/companies/:id/logo` - Upload company logo

### Period Endpoints
- `GET /api/periods` - List all periods
- `GET /api/periods/:id` - Get period details
- `POST /api/periods` - Create new period
- `PATCH /api/periods/:id` - Update period
- `DELETE /api/periods/:id` - Delete period (draft only)
- `POST /api/periods/:id/open` - Open period
- `POST /api/periods/:id/start-audit` - Start audit work
- `POST /api/periods/:id/submit-review` - Submit for review
- `POST /api/periods/:id/complete` - Complete period
- `POST /api/periods/:id/close` - Close period
- `POST /api/periods/:id/lock` - Lock period
- `POST /api/periods/:id/unlock` - Unlock period
- `POST /api/periods/:id/set-active` - Set as active period

### Super Admin Endpoints
- `GET /api/super-admin/companies` - List all companies
- `POST /api/super-admin/switch-company` - Switch company context
- `GET /api/super-admin/tenants/:id/health` - Check tenant database health

---

*This documentation is maintained by the CloudAudit Pro development team. Last updated: December 2025.*
