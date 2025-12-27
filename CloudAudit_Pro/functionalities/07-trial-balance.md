# CloudAudit Pro - Trial Balance Management

## ⚖️ Overview

The Trial Balance is a fundamental accounting report that lists all accounts with their debit and credit balances for a specific period. CloudAudit Pro provides comprehensive trial balance management with import capabilities, manual entry, validation, adjustments, and export functionality. The trial balance serves as the foundation for financial statement preparation and audit procedures.

---

## 📋 Trial Balance Structure

### Trial Balance Data Model

```typescript
interface TrialBalance {
  id: string;
  periodId: string;          // Link to accounting period
  
  // Metadata
  name: string;              // e.g., "Unadjusted Trial Balance 2024"
  type: TrialBalanceType;
  description?: string;
  
  // Import Information
  importDate: Date;
  importedBy: string;        // User ID
  importSource?: string;     // e.g., "QuickBooks", "Manual Entry"
  importFileName?: string;
  
  // Status
  status: TrialBalanceStatus;
  validationStatus: ValidationStatus;
  
  // Balance Summary
  totalDebits: number;
  totalCredits: number;
  difference: number;        // Should be 0
  isBalanced: boolean;       // totalDebits === totalCredits
  
  // Counts
  entryCount: number;
  adjustmentCount: number;
  
  // Dates
  asOfDate: Date;           // Balance sheet date
  createdAt: Date;
  updatedAt: Date;
  approvedAt?: Date;
  approvedBy?: string;
  
  // Relationships
  period: Period;
  entries: TrialBalanceEntry[];
  adjustments: TrialBalanceAdjustment[];
  workpapers: Workpaper[];
}

interface TrialBalanceEntry {
  id: string;
  trialBalanceId: string;
  accountId: string;
  
  // Account Reference
  accountCode: string;
  accountName: string;
  accountType: AccountType;
  
  // Balances
  debitBalance: number;
  creditBalance: number;
  netBalance: number;        // Debit - Credit (with proper sign)
  
  // Opening/Closing
  openingBalance?: number;
  closingBalance?: number;
  
  // Flags
  isAdjusted: boolean;
  hasAttachments: boolean;
  requiresReview: boolean;
  
  // Notes
  notes?: string;
  tags?: string[];
  
  // Audit Trail
  createdAt: Date;
  updatedAt: Date;
  updatedBy?: string;
  
  // Relationships
  account: Account;
  adjustments: TrialBalanceAdjustment[];
  auditProcedures: AuditProcedure[];
}

interface TrialBalanceAdjustment {
  id: string;
  trialBalanceId: string;
  entryId: string;
  
  // Adjustment Details
  type: AdjustmentType;
  description: string;
  reference?: string;        // e.g., "AJE-001"
  
  // Amounts
  debitAdjustment: number;
  creditAdjustment: number;
  
  // Impact
  originalDebit: number;
  originalCredit: number;
  adjustedDebit: number;
  adjustedCredit: number;
  
  // Approval
  status: AdjustmentStatus;
  reason: string;
  
  // Audit Trail
  createdBy: string;
  createdAt: Date;
  approvedBy?: string;
  approvedAt?: Date;
  
  // Relationships
  entry: TrialBalanceEntry;
  supportingDocuments: Document[];
}

enum TrialBalanceType {
  UNADJUSTED = 'UNADJUSTED',           // Initial import
  ADJUSTED = 'ADJUSTED',                // After adjustments
  POST_CLOSING = 'POST_CLOSING',       // After closing entries
  COMPARATIVE = 'COMPARATIVE'           // Multi-period comparison
}

enum TrialBalanceStatus {
  DRAFT = 'DRAFT',
  IN_REVIEW = 'IN_REVIEW',
  APPROVED = 'APPROVED',
  FINALIZED = 'FINALIZED'
}

enum ValidationStatus {
  PENDING = 'PENDING',
  VALID = 'VALID',
  WARNING = 'WARNING',
  ERROR = 'ERROR'
}

enum AdjustmentType {
  RECLASSIFICATION = 'RECLASSIFICATION',
  ACCRUAL = 'ACCRUAL',
  DEFERRAL = 'DEFERRAL',
  DEPRECIATION = 'DEPRECIATION',
  VALUATION = 'VALUATION',
  CORRECTION = 'CORRECTION',
  OTHER = 'OTHER'
}

enum AdjustmentStatus {
  DRAFT = 'DRAFT',
  PENDING_APPROVAL = 'PENDING_APPROVAL',
  APPROVED = 'APPROVED',
  REJECTED = 'REJECTED',
  POSTED = 'POSTED'
}
```

---

## 📥 Trial Balance Import

### Supported Import Formats

CloudAudit Pro supports multiple import formats:

```typescript
const SUPPORTED_IMPORT_FORMATS = {
  CSV: {
    extensions: ['.csv'],
    mimeTypes: ['text/csv', 'application/csv'],
    maxSize: 10 * 1024 * 1024, // 10MB
    encoding: 'UTF-8'
  },
  EXCEL: {
    extensions: ['.xlsx', '.xls'],
    mimeTypes: [
      'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
      'application/vnd.ms-excel'
    ],
    maxSize: 20 * 1024 * 1024, // 20MB
  },
  JSON: {
    extensions: ['.json'],
    mimeTypes: ['application/json'],
    maxSize: 5 * 1024 * 1024, // 5MB
  }
};
```

### CSV Import Format

**Standard CSV Format**:
```csv
Account Code,Account Name,Debit Balance,Credit Balance,Notes
1000,Cash,50000.00,0.00,
1100,Accounts Receivable,75000.00,0.00,
1500,Inventory,100000.00,0.00,
2000,Accounts Payable,0.00,45000.00,
2100,Accrued Expenses,0.00,12000.00,
3000,Share Capital,0.00,100000.00,
4000,Sales Revenue,0.00,500000.00,
5000,Cost of Goods Sold,300000.00,0.00,
5100,Salaries Expense,85000.00,0.00,
5200,Rent Expense,24000.00,0.00,
```

**Alternative CSV Format (with Account Type)**:
```csv
Account Code,Account Name,Account Type,Opening Balance,Debit,Credit,Closing Balance
1000,Cash,ASSET,45000.00,25000.00,20000.00,50000.00
1100,Accounts Receivable,ASSET,65000.00,20000.00,10000.00,75000.00
```

### Import Trial Balance Endpoint

```typescript
POST /api/trial-balances/import

interface ImportTrialBalanceRequest {
  periodId: string;
  name: string;
  type: TrialBalanceType;
  file: File;
  format: 'CSV' | 'EXCEL' | 'JSON';
  mapping?: FieldMapping;
  asOfDate: string;
  createMissingAccounts?: boolean;
}

interface FieldMapping {
  accountCode: string | number;    // Column name or index
  accountName: string | number;
  debitBalance: string | number;
  creditBalance: string | number;
  openingBalance?: string | number;
  closingBalance?: string | number;
  notes?: string | number;
}

async importTrialBalance(
  companyId: string, 
  userId: string, 
  data: ImportTrialBalanceRequest
) {
  // Get tenant database
  const company = await getCompany(companyId);
  const tenantDb = getTenantDatabase(company.databaseName);
  
  // Check permissions
  const user = await prisma.user.findUnique({
    where: { id: userId }
  });
  
  if (!['ADMIN', 'MANAGER', 'SENIOR_AUDITOR'].includes(user.role)) {
    throw new ForbiddenException('Insufficient permissions to import trial balance');
  }
  
  // Verify period exists
  const period = await tenantDb.period.findUnique({
    where: { id: data.periodId }
  });
  
  if (!period) {
    throw new NotFoundException('Period not found');
  }
  
  // Check if trial balance already exists for this period
  const existing = await tenantDb.trialBalance.findFirst({
    where: {
      periodId: data.periodId,
      type: data.type
    }
  });
  
  if (existing) {
    throw new BadRequestException(
      'Trial balance already exists for this period and type'
    );
  }
  
  // Parse file based on format
  let parsedData;
  switch (data.format) {
    case 'CSV':
      parsedData = await parseCSVFile(data.file, data.mapping);
      break;
    case 'EXCEL':
      parsedData = await parseExcelFile(data.file, data.mapping);
      break;
    case 'JSON':
      parsedData = await parseJSONFile(data.file);
      break;
    default:
      throw new BadRequestException('Unsupported format');
  }
  
  // Validate parsed data
  const validationResults = await validateImportData(parsedData);
  
  if (validationResults.errors.length > 0) {
    throw new BadRequestException('Validation failed', validationResults.errors);
  }
  
  // Match accounts with chart of accounts
  const matchedAccounts = await matchAccountsToChart(
    tenantDb, 
    parsedData,
    data.createMissingAccounts,
    userId
  );
  
  // Calculate totals
  let totalDebits = 0;
  let totalCredits = 0;
  
  for (const entry of matchedAccounts) {
    totalDebits += entry.debitBalance || 0;
    totalCredits += entry.creditBalance || 0;
  }
  
  const difference = Math.abs(totalDebits - totalCredits);
  const isBalanced = difference < 0.01; // Allow for rounding
  
  // Create trial balance
  const trialBalance = await tenantDb.trialBalance.create({
    data: {
      periodId: data.periodId,
      name: data.name,
      type: data.type,
      asOfDate: new Date(data.asOfDate),
      importDate: new Date(),
      importedBy: userId,
      importFileName: data.file.originalname,
      status: 'DRAFT',
      validationStatus: isBalanced ? 'VALID' : 'ERROR',
      totalDebits,
      totalCredits,
      difference,
      isBalanced,
      entryCount: matchedAccounts.length,
      adjustmentCount: 0
    }
  });
  
  // Create trial balance entries
  const entries = await tenantDb.trialBalanceEntry.createMany({
    data: matchedAccounts.map(entry => ({
      trialBalanceId: trialBalance.id,
      accountId: entry.accountId,
      accountCode: entry.accountCode,
      accountName: entry.accountName,
      accountType: entry.accountType,
      debitBalance: entry.debitBalance || 0,
      creditBalance: entry.creditBalance || 0,
      netBalance: (entry.debitBalance || 0) - (entry.creditBalance || 0),
      openingBalance: entry.openingBalance,
      closingBalance: entry.closingBalance,
      notes: entry.notes,
      isAdjusted: false,
      hasAttachments: false,
      requiresReview: false
    }))
  });
  
  // Log import
  await logAuditEvent({
    userId,
    companyId,
    action: 'TRIAL_BALANCE_IMPORTED',
    resourceType: 'TRIAL_BALANCE',
    resourceId: trialBalance.id,
    metadata: {
      periodId: data.periodId,
      entryCount: matchedAccounts.length,
      totalDebits,
      totalCredits,
      isBalanced
    }
  });
  
  // Send notification if not balanced
  if (!isBalanced) {
    await sendNotification({
      userId,
      type: 'TRIAL_BALANCE_IMBALANCE',
      title: 'Trial Balance Import Warning',
      message: `Trial balance is out of balance by ${difference.toFixed(2)}`,
      severity: 'WARNING'
    });
  }
  
  return {
    success: true,
    trialBalance: {
      id: trialBalance.id,
      name: trialBalance.name,
      entryCount: matchedAccounts.length,
      totalDebits,
      totalCredits,
      difference,
      isBalanced
    },
    warnings: validationResults.warnings,
    unmatchedAccounts: matchedAccounts.filter(a => !a.accountId).length
  };
}
```

### Import Validation

**Validation Rules**:
```typescript
interface ValidationResult {
  valid: boolean;
  errors: ValidationError[];
  warnings: ValidationWarning[];
}

interface ValidationError {
  row: number;
  field: string;
  message: string;
  value?: any;
}

interface ValidationWarning {
  row: number;
  field: string;
  message: string;
  value?: any;
}

async function validateImportData(data: any[]): Promise<ValidationResult> {
  const errors: ValidationError[] = [];
  const warnings: ValidationWarning[] = [];
  
  for (let i = 0; i < data.length; i++) {
    const row = i + 2; // Account for header row
    const entry = data[i];
    
    // Required field validation
    if (!entry.accountCode) {
      errors.push({
        row,
        field: 'accountCode',
        message: 'Account code is required'
      });
    }
    
    if (!entry.accountName) {
      errors.push({
        row,
        field: 'accountName',
        message: 'Account name is required'
      });
    }
    
    // Balance validation
    const debit = parseFloat(entry.debitBalance) || 0;
    const credit = parseFloat(entry.creditBalance) || 0;
    
    if (debit < 0) {
      errors.push({
        row,
        field: 'debitBalance',
        message: 'Debit balance cannot be negative',
        value: debit
      });
    }
    
    if (credit < 0) {
      errors.push({
        row,
        field: 'creditBalance',
        message: 'Credit balance cannot be negative',
        value: credit
      });
    }
    
    // Both debit and credit have values (unusual but not error)
    if (debit > 0 && credit > 0) {
      warnings.push({
        row,
        field: 'balances',
        message: 'Both debit and credit balances are present',
        value: { debit, credit }
      });
    }
    
    // Zero balance (might want to exclude)
    if (debit === 0 && credit === 0) {
      warnings.push({
        row,
        field: 'balances',
        message: 'Account has zero balance',
        value: entry.accountCode
      });
    }
    
    // Large amounts (potential data entry error)
    const threshold = 10000000; // 10 million
    if (debit > threshold || credit > threshold) {
      warnings.push({
        row,
        field: 'balances',
        message: 'Unusually large balance detected',
        value: Math.max(debit, credit)
      });
    }
  }
  
  return {
    valid: errors.length === 0,
    errors,
    warnings
  };
}
```

### Account Matching

**Match Imported Accounts to Chart**:
```typescript
async function matchAccountsToChart(
  tenantDb: PrismaClient,
  importData: any[],
  createMissing: boolean,
  userId: string
) {
  const matched = [];
  
  for (const entry of importData) {
    // Try to find account by code
    let account = await tenantDb.account.findFirst({
      where: {
        OR: [
          { accountCode: entry.accountCode },
          { accountCode: entry.accountCode.toString().padStart(4, '0') }
        ]
      }
    });
    
    // Try to find by name if code doesn't match
    if (!account) {
      account = await tenantDb.account.findFirst({
        where: {
          accountName: {
            equals: entry.accountName,
            mode: 'insensitive'
          }
        }
      });
    }
    
    // Create account if requested and not found
    if (!account && createMissing) {
      account = await createAccountFromImport(tenantDb, entry, userId);
    }
    
    matched.push({
      ...entry,
      accountId: account?.id,
      accountType: account?.accountType,
      matched: !!account
    });
  }
  
  return matched;
}

async function createAccountFromImport(
  tenantDb: PrismaClient,
  entry: any,
  userId: string
) {
  // Infer account type from balance or code
  const accountType = inferAccountType(entry);
  const accountCategory = inferAccountCategory(entry, accountType);
  
  const account = await tenantDb.account.create({
    data: {
      accountCode: entry.accountCode,
      accountName: entry.accountName,
      accountType,
      accountCategory,
      normalBalance: ['ASSET', 'EXPENSE'].includes(accountType) ? 'DEBIT' : 'CREDIT',
      isBalanceSheet: ['ASSET', 'LIABILITY', 'EQUITY'].includes(accountType),
      status: 'ACTIVE',
      isActive: true,
      allowDirectEntry: true,
      level: 1,
      createdBy: userId
    }
  });
  
  return account;
}

function inferAccountType(entry: any): AccountType {
  const code = entry.accountCode.toString();
  const firstDigit = code[0];
  
  // Standard numbering convention
  switch (firstDigit) {
    case '1':
      return 'ASSET';
    case '2':
      return 'LIABILITY';
    case '3':
      return 'EQUITY';
    case '4':
      return 'INCOME';
    case '5':
    case '6':
      return 'EXPENSE';
    default:
      // Fallback to balance analysis
      const debit = parseFloat(entry.debitBalance) || 0;
      const credit = parseFloat(entry.creditBalance) || 0;
      return debit > credit ? 'ASSET' : 'LIABILITY';
  }
}
```

---

## ✏️ Manual Entry and Editing

### Create Manual Entry

**Manual Entry Endpoint**:
```typescript
POST /api/trial-balances/:id/entries

interface CreateEntryRequest {
  accountId: string;
  debitBalance?: number;
  creditBalance?: number;
  openingBalance?: number;
  closingBalance?: number;
  notes?: string;
}

async createTrialBalanceEntry(
  trialBalanceId: string,
  userId: string,
  data: CreateEntryRequest
) {
  const user = await prisma.user.findUnique({
    where: { id: userId }
  });
  
  const company = await getCompany(user.companyId);
  const tenantDb = getTenantDatabase(company.databaseName);
  
  // Get trial balance
  const trialBalance = await tenantDb.trialBalance.findUnique({
    where: { id: trialBalanceId }
  });
  
  if (!trialBalance) {
    throw new NotFoundException('Trial balance not found');
  }
  
  if (trialBalance.status === 'FINALIZED') {
    throw new BadRequestException('Cannot modify finalized trial balance');
  }
  
  // Get account
  const account = await tenantDb.account.findUnique({
    where: { id: data.accountId }
  });
  
  if (!account) {
    throw new NotFoundException('Account not found');
  }
  
  // Check if entry already exists
  const existing = await tenantDb.trialBalanceEntry.findFirst({
    where: {
      trialBalanceId,
      accountId: data.accountId
    }
  });
  
  if (existing) {
    throw new BadRequestException('Entry already exists for this account');
  }
  
  // Validate balances
  if (data.debitBalance && data.debitBalance < 0) {
    throw new BadRequestException('Debit balance cannot be negative');
  }
  
  if (data.creditBalance && data.creditBalance < 0) {
    throw new BadRequestException('Credit balance cannot be negative');
  }
  
  // Create entry
  const entry = await tenantDb.trialBalanceEntry.create({
    data: {
      trialBalanceId,
      accountId: data.accountId,
      accountCode: account.accountCode,
      accountName: account.accountName,
      accountType: account.accountType,
      debitBalance: data.debitBalance || 0,
      creditBalance: data.creditBalance || 0,
      netBalance: (data.debitBalance || 0) - (data.creditBalance || 0),
      openingBalance: data.openingBalance,
      closingBalance: data.closingBalance,
      notes: data.notes,
      isAdjusted: false,
      hasAttachments: false,
      requiresReview: false
    }
  });
  
  // Update trial balance totals
  await updateTrialBalanceTotals(tenantDb, trialBalanceId);
  
  // Log creation
  await logAuditEvent({
    userId,
    companyId: user.companyId,
    action: 'TRIAL_BALANCE_ENTRY_CREATED',
    resourceType: 'TRIAL_BALANCE_ENTRY',
    resourceId: entry.id,
    metadata: { trialBalanceId, accountCode: account.accountCode }
  });
  
  return entry;
}
```

### Update Entry

**Update Entry Endpoint**:
```typescript
PATCH /api/trial-balances/entries/:id

interface UpdateEntryRequest {
  debitBalance?: number;
  creditBalance?: number;
  openingBalance?: number;
  closingBalance?: number;
  notes?: string;
  requiresReview?: boolean;
}

async updateTrialBalanceEntry(
  entryId: string,
  userId: string,
  data: UpdateEntryRequest
) {
  const user = await prisma.user.findUnique({
    where: { id: userId }
  });
  
  const company = await getCompany(user.companyId);
  const tenantDb = getTenantDatabase(company.databaseName);
  
  // Get entry with trial balance
  const entry = await tenantDb.trialBalanceEntry.findUnique({
    where: { id: entryId },
    include: { trialBalance: true }
  });
  
  if (!entry) {
    throw new NotFoundException('Entry not found');
  }
  
  if (entry.trialBalance.status === 'FINALIZED') {
    throw new BadRequestException('Cannot modify finalized trial balance');
  }
  
  // Validate new balances
  if (data.debitBalance !== undefined && data.debitBalance < 0) {
    throw new BadRequestException('Debit balance cannot be negative');
  }
  
  if (data.creditBalance !== undefined && data.creditBalance < 0) {
    throw new BadRequestException('Credit balance cannot be negative');
  }
  
  // Update entry
  const updatedEntry = await tenantDb.trialBalanceEntry.update({
    where: { id: entryId },
    data: {
      debitBalance: data.debitBalance,
      creditBalance: data.creditBalance,
      netBalance: data.debitBalance !== undefined || data.creditBalance !== undefined
        ? (data.debitBalance || entry.debitBalance) - (data.creditBalance || entry.creditBalance)
        : undefined,
      openingBalance: data.openingBalance,
      closingBalance: data.closingBalance,
      notes: data.notes,
      requiresReview: data.requiresReview,
      updatedBy: userId,
      updatedAt: new Date()
    }
  });
  
  // Update trial balance totals
  await updateTrialBalanceTotals(tenantDb, entry.trialBalanceId);
  
  // Log update
  await logAuditEvent({
    userId,
    companyId: user.companyId,
    action: 'TRIAL_BALANCE_ENTRY_UPDATED',
    resourceType: 'TRIAL_BALANCE_ENTRY',
    resourceId: entryId,
    metadata: { changes: data }
  });
  
  return updatedEntry;
}
```

### Delete Entry

**Delete Entry Endpoint**:
```typescript
DELETE /api/trial-balances/entries/:id

async deleteTrialBalanceEntry(entryId: string, userId: string) {
  const user = await prisma.user.findUnique({
    where: { id: userId }
  });
  
  if (!['ADMIN', 'MANAGER'].includes(user.role)) {
    throw new ForbiddenException('Only admins and managers can delete entries');
  }
  
  const company = await getCompany(user.companyId);
  const tenantDb = getTenantDatabase(company.databaseName);
  
  // Get entry
  const entry = await tenantDb.trialBalanceEntry.findUnique({
    where: { id: entryId },
    include: { trialBalance: true }
  });
  
  if (!entry) {
    throw new NotFoundException('Entry not found');
  }
  
  if (entry.trialBalance.status === 'FINALIZED') {
    throw new BadRequestException('Cannot delete entry from finalized trial balance');
  }
  
  // Delete entry
  await tenantDb.trialBalanceEntry.delete({
    where: { id: entryId }
  });
  
  // Update trial balance totals
  await updateTrialBalanceTotals(tenantDb, entry.trialBalanceId);
  
  // Log deletion
  await logAuditEvent({
    userId,
    companyId: user.companyId,
    action: 'TRIAL_BALANCE_ENTRY_DELETED',
    resourceType: 'TRIAL_BALANCE_ENTRY',
    resourceId: entryId
  });
  
  return { success: true };
}
```

---

## ✅ Balance Validation

### Automatic Validation

**Validation Function**:
```typescript
async function validateTrialBalance(
  tenantDb: PrismaClient,
  trialBalanceId: string
): Promise<ValidationResult> {
  const trialBalance = await tenantDb.trialBalance.findUnique({
    where: { id: trialBalanceId },
    include: {
      entries: {
        include: { account: true }
      }
    }
  });
  
  const issues: ValidationIssue[] = [];
  
  // 1. Check if debits equal credits
  let totalDebits = 0;
  let totalCredits = 0;
  
  for (const entry of trialBalance.entries) {
    totalDebits += entry.debitBalance;
    totalCredits += entry.creditBalance;
  }
  
  const difference = Math.abs(totalDebits - totalCredits);
  
  if (difference >= 0.01) {
    issues.push({
      severity: 'ERROR',
      code: 'IMBALANCE',
      message: `Trial balance is out of balance by ${difference.toFixed(2)}`,
      affectedEntries: []
    });
  }
  
  // 2. Check for negative balances
  for (const entry of trialBalance.entries) {
    if (entry.debitBalance < 0) {
      issues.push({
        severity: 'ERROR',
        code: 'NEGATIVE_DEBIT',
        message: `Negative debit balance for account ${entry.accountCode}`,
        affectedEntries: [entry.id]
      });
    }
    
    if (entry.creditBalance < 0) {
      issues.push({
        severity: 'ERROR',
        code: 'NEGATIVE_CREDIT',
        message: `Negative credit balance for account ${entry.accountCode}`,
        affectedEntries: [entry.id]
      });
    }
  }
  
  // 3. Check for unusual account balances
  for (const entry of trialBalance.entries) {
    const account = entry.account;
    const hasDebit = entry.debitBalance > 0;
    const hasCredit = entry.creditBalance > 0;
    
    // Asset or Expense should typically have debit balance
    if (['ASSET', 'EXPENSE'].includes(account.accountType) && hasCredit && !hasDebit) {
      issues.push({
        severity: 'WARNING',
        code: 'UNUSUAL_BALANCE',
        message: `${account.accountType} account has credit balance: ${entry.accountCode}`,
        affectedEntries: [entry.id]
      });
    }
    
    // Liability, Equity, or Income should typically have credit balance
    if (['LIABILITY', 'EQUITY', 'INCOME'].includes(account.accountType) && hasDebit && !hasCredit) {
      issues.push({
        severity: 'WARNING',
        code: 'UNUSUAL_BALANCE',
        message: `${account.accountType} account has debit balance: ${entry.accountCode}`,
        affectedEntries: [entry.id]
      });
    }
  }
  
  // 4. Check for zero balances
  const zeroBalanceCount = trialBalance.entries.filter(
    e => e.debitBalance === 0 && e.creditBalance === 0
  ).length;
  
  if (zeroBalanceCount > 0) {
    issues.push({
      severity: 'INFO',
      code: 'ZERO_BALANCES',
      message: `${zeroBalanceCount} accounts have zero balance`,
      affectedEntries: []
    });
  }
  
  // 5. Check for duplicate accounts
  const accountCodes = trialBalance.entries.map(e => e.accountCode);
  const duplicates = accountCodes.filter(
    (code, index) => accountCodes.indexOf(code) !== index
  );
  
  if (duplicates.length > 0) {
    issues.push({
      severity: 'ERROR',
      code: 'DUPLICATE_ACCOUNTS',
      message: `Duplicate account codes found: ${duplicates.join(', ')}`,
      affectedEntries: []
    });
  }
  
  // Update validation status
  const hasErrors = issues.some(i => i.severity === 'ERROR');
  const hasWarnings = issues.some(i => i.severity === 'WARNING');
  
  await tenantDb.trialBalance.update({
    where: { id: trialBalanceId },
    data: {
      validationStatus: hasErrors ? 'ERROR' : hasWarnings ? 'WARNING' : 'VALID',
      totalDebits,
      totalCredits,
      difference,
      isBalanced: difference < 0.01
    }
  });
  
  return {
    valid: !hasErrors,
    isBalanced: difference < 0.01,
    totalDebits,
    totalCredits,
    difference,
    issues
  };
}
```

### Manual Validation Trigger

**Validate Endpoint**:
```typescript
POST /api/trial-balances/:id/validate

async validateTrialBalanceEndpoint(trialBalanceId: string, userId: string) {
  const user = await prisma.user.findUnique({
    where: { id: userId }
  });
  
  const company = await getCompany(user.companyId);
  const tenantDb = getTenantDatabase(company.databaseName);
  
  const result = await validateTrialBalance(tenantDb, trialBalanceId);
  
  // Log validation
  await logAuditEvent({
    userId,
    companyId: user.companyId,
    action: 'TRIAL_BALANCE_VALIDATED',
    resourceType: 'TRIAL_BALANCE',
    resourceId: trialBalanceId,
    metadata: {
      valid: result.valid,
      isBalanced: result.isBalanced,
      issueCount: result.issues.length
    }
  });
  
  return result;
}
```

---

## 🔧 Adjustments and Corrections

### Create Adjustment

**Create Adjustment Endpoint**:
```typescript
POST /api/trial-balances/entries/:id/adjustments

interface CreateAdjustmentRequest {
  type: AdjustmentType;
  description: string;
  reference?: string;
  debitAdjustment: number;
  creditAdjustment: number;
  reason: string;
  supportingDocuments?: string[];  // Document IDs
}

async createAdjustment(
  entryId: string,
  userId: string,
  data: CreateAdjustmentRequest
) {
  const user = await prisma.user.findUnique({
    where: { id: userId }
  });
  
  if (!['ADMIN', 'MANAGER', 'SENIOR_AUDITOR'].includes(user.role)) {
    throw new ForbiddenException('Insufficient permissions');
  }
  
  const company = await getCompany(user.companyId);
  const tenantDb = getTenantDatabase(company.databaseName);
  
  // Get entry
  const entry = await tenantDb.trialBalanceEntry.findUnique({
    where: { id: entryId },
    include: { trialBalance: true }
  });
  
  if (!entry) {
    throw new NotFoundException('Entry not found');
  }
  
  if (entry.trialBalance.status === 'FINALIZED') {
    throw new BadRequestException('Cannot adjust finalized trial balance');
  }
  
  // Calculate adjusted balances
  const adjustedDebit = entry.debitBalance + (data.debitAdjustment || 0);
  const adjustedCredit = entry.creditBalance + (data.creditAdjustment || 0);
  
  // Validate adjusted balances
  if (adjustedDebit < 0 || adjustedCredit < 0) {
    throw new BadRequestException('Adjusted balance cannot be negative');
  }
  
  // Create adjustment
  const adjustment = await tenantDb.trialBalanceAdjustment.create({
    data: {
      trialBalanceId: entry.trialBalanceId,
      entryId,
      type: data.type,
      description: data.description,
      reference: data.reference,
      debitAdjustment: data.debitAdjustment || 0,
      creditAdjustment: data.creditAdjustment || 0,
      originalDebit: entry.debitBalance,
      originalCredit: entry.creditBalance,
      adjustedDebit,
      adjustedCredit,
      reason: data.reason,
      status: 'PENDING_APPROVAL',
      createdBy: userId
    }
  });
  
  // Mark entry as adjusted
  await tenantDb.trialBalanceEntry.update({
    where: { id: entryId },
    data: { isAdjusted: true }
  });
  
  // Update adjustment count
  await tenantDb.trialBalance.update({
    where: { id: entry.trialBalanceId },
    data: {
      adjustmentCount: { increment: 1 }
    }
  });
  
  // Log adjustment
  await logAuditEvent({
    userId,
    companyId: user.companyId,
    action: 'ADJUSTMENT_CREATED',
    resourceType: 'TRIAL_BALANCE_ADJUSTMENT',
    resourceId: adjustment.id,
    metadata: {
      entryId,
      type: data.type,
      debitAdjustment: data.debitAdjustment,
      creditAdjustment: data.creditAdjustment
    }
  });
  
  return adjustment;
}
```

### Approve Adjustment

**Approve Adjustment Endpoint**:
```typescript
POST /api/trial-balances/adjustments/:id/approve

async approveAdjustment(adjustmentId: string, userId: string) {
  const user = await prisma.user.findUnique({
    where: { id: userId }
  });
  
  if (!['ADMIN', 'MANAGER'].includes(user.role)) {
    throw new ForbiddenException('Only admins and managers can approve adjustments');
  }
  
  const company = await getCompany(user.companyId);
  const tenantDb = getTenantDatabase(company.databaseName);
  
  // Get adjustment
  const adjustment = await tenantDb.trialBalanceAdjustment.findUnique({
    where: { id: adjustmentId },
    include: { entry: true }
  });
  
  if (!adjustment) {
    throw new NotFoundException('Adjustment not found');
  }
  
  if (adjustment.status !== 'PENDING_APPROVAL') {
    throw new BadRequestException('Adjustment is not pending approval');
  }
  
  // Approve and post adjustment
  await tenantDb.trialBalanceAdjustment.update({
    where: { id: adjustmentId },
    data: {
      status: 'APPROVED',
      approvedBy: userId,
      approvedAt: new Date()
    }
  });
  
  // Apply adjustment to entry
  await tenantDb.trialBalanceEntry.update({
    where: { id: adjustment.entryId },
    data: {
      debitBalance: adjustment.adjustedDebit,
      creditBalance: adjustment.adjustedCredit,
      netBalance: adjustment.adjustedDebit - adjustment.adjustedCredit
    }
  });
  
  // Update trial balance totals
  await updateTrialBalanceTotals(tenantDb, adjustment.trialBalanceId);
  
  // Log approval
  await logAuditEvent({
    userId,
    companyId: user.companyId,
    action: 'ADJUSTMENT_APPROVED',
    resourceType: 'TRIAL_BALANCE_ADJUSTMENT',
    resourceId: adjustmentId
  });
  
  return { success: true };
}
```

---

## 📊 Trial Balance Reports

### Generate Trial Balance Report

**Report Generation Endpoint**:
```typescript
GET /api/trial-balances/:id/report

interface TrialBalanceReportQuery {
  format: 'PDF' | 'EXCEL' | 'CSV';
  includeZeroBalances?: boolean;
  groupBy?: 'ACCOUNT_TYPE' | 'ACCOUNT_CATEGORY';
  showAdjustments?: boolean;
}

async generateTrialBalanceReport(
  trialBalanceId: string,
  query: TrialBalanceReportQuery
) {
  const company = await getCompany(companyId);
  const tenantDb = getTenantDatabase(company.databaseName);
  
  // Get trial balance with entries
  const trialBalance = await tenantDb.trialBalance.findUnique({
    where: { id: trialBalanceId },
    include: {
      period: true,
      entries: {
        include: {
          account: true,
          adjustments: query.showAdjustments ? true : false
        },
        orderBy: { accountCode: 'asc' }
      }
    }
  });
  
  // Filter zero balances if requested
  let entries = trialBalance.entries;
  if (!query.includeZeroBalances) {
    entries = entries.filter(
      e => e.debitBalance !== 0 || e.creditBalance !== 0
    );
  }
  
  // Group entries if requested
  const groupedEntries = query.groupBy
    ? groupEntriesBy(entries, query.groupBy)
    : { 'All Accounts': entries };
  
  // Generate report based on format
  let report;
  switch (query.format) {
    case 'PDF':
      report = await generatePDFReport(trialBalance, groupedEntries);
      break;
    case 'EXCEL':
      report = await generateExcelReport(trialBalance, groupedEntries);
      break;
    case 'CSV':
      report = await generateCSVReport(trialBalance, entries);
      break;
  }
  
  return report;
}
```

---

## 📤 Export Functionality

### Export Trial Balance

**Export Endpoint**:
```typescript
GET /api/trial-balances/:id/export

interface ExportQuery {
  format: 'CSV' | 'EXCEL' | 'PDF' | 'JSON';
  includeAdjustments?: boolean;
  includeNotes?: boolean;
}

async exportTrialBalance(
  trialBalanceId: string,
  query: ExportQuery
) {
  // Implementation similar to report generation
  // Returns downloadable file in specified format
}
```

---

## 🔗 Linking to Audit Procedures

### Link Entry to Procedure

**Link Endpoint**:
```typescript
POST /api/trial-balances/entries/:id/link-procedure

interface LinkProcedureRequest {
  procedureId: string;
  notes?: string;
}

async linkEntryToProcedure(
  entryId: string,
  userId: string,
  data: LinkProcedureRequest
) {
  // Create link between trial balance entry and audit procedure
  // Enables tracking of audit work performed on specific accounts
}
```

---

## 🔍 Best Practices

1. **Import Validation**: Always validate imported data before posting
2. **Regular Backups**: Backup trial balance data before major changes
3. **Adjustment Documentation**: Document all adjustments with clear reasons
4. **Balance Checks**: Verify debits equal credits before finalizing
5. **Audit Trail**: Maintain complete audit trail of all changes

---

## 📚 API Reference Summary

### Trial Balance Endpoints
- `GET /api/trial-balances` - List trial balances
- `GET /api/trial-balances/:id` - Get trial balance details
- `POST /api/trial-balances/import` - Import trial balance
- `POST /api/trial-balances/:id/validate` - Validate trial balance
- `POST /api/trial-balances/:id/finalize` - Finalize trial balance
- `DELETE /api/trial-balances/:id` - Delete trial balance

### Entry Endpoints
- `GET /api/trial-balances/:id/entries` - List entries
- `POST /api/trial-balances/:id/entries` - Create entry
- `PATCH /api/trial-balances/entries/:id` - Update entry
- `DELETE /api/trial-balances/entries/:id` - Delete entry

### Adjustment Endpoints
- `POST /api/trial-balances/entries/:id/adjustments` - Create adjustment
- `POST /api/trial-balances/adjustments/:id/approve` - Approve adjustment
- `DELETE /api/trial-balances/adjustments/:id` - Delete adjustment

### Report/Export Endpoints
- `GET /api/trial-balances/:id/report` - Generate report
- `GET /api/trial-balances/:id/export` - Export trial balance

---

*This documentation is maintained by the CloudAudit Pro development team. Last updated: December 2025.*
