# CloudAudit Pro - Chart of Accounts

## 📊 Overview

The Chart of Accounts (COA) is the foundation of CloudAudit Pro's financial management system. It provides a structured classification system for all financial transactions, enabling accurate trial balance tracking, financial statement preparation, and comprehensive audit procedures.

---

## 🏗️ Account Structure and Hierarchy

### Account Structure

CloudAudit Pro implements a flexible, hierarchical account structure that supports both standard and custom charts of accounts.

```typescript
interface Account {
  id: string;
  
  // Account Identification
  accountCode: string;        // e.g., "1000", "2100", "4500"
  accountName: string;        // e.g., "Cash", "Accounts Payable"
  accountNumber?: string;     // Alternative numbering system
  
  // Hierarchy
  parentAccountId?: string;   // Parent account (for sub-accounts)
  level: number;              // Hierarchy level (1 = top level)
  sortOrder: number;          // Display order within parent
  
  // Classification
  accountType: AccountType;
  accountCategory: AccountCategory;
  subCategory?: string;
  
  // Financial Properties
  normalBalance: 'DEBIT' | 'CREDIT';
  isBalanceSheet: boolean;    // Balance sheet vs Income statement
  isControlAccount: boolean;  // Has sub-accounts
  isSystemAccount: boolean;   // Cannot be deleted/modified
  
  // Status
  status: AccountStatus;
  isActive: boolean;
  
  // Configuration
  allowDirectEntry: boolean;  // Can post transactions directly
  requiresCostCenter: boolean;
  requiresProject: boolean;
  taxable: boolean;
  
  // Currency
  currency: string;           // ISO 4217 code
  allowMultiCurrency: boolean;
  
  // Metadata
  description?: string;
  notes?: string;
  tags?: string[];
  
  // Balances (read-only, computed)
  openingBalance?: number;
  currentBalance?: number;
  closingBalance?: number;
  
  // Timestamps
  createdAt: Date;
  updatedAt: Date;
  
  // Relationships
  parent?: Account;
  children?: Account[];
  trialBalanceEntries?: TrialBalanceEntry[];
}

enum AccountType {
  ASSET = 'ASSET',
  LIABILITY = 'LIABILITY',
  EQUITY = 'EQUITY',
  INCOME = 'INCOME',
  EXPENSE = 'EXPENSE'
}

enum AccountCategory {
  // Assets
  CURRENT_ASSET = 'CURRENT_ASSET',
  FIXED_ASSET = 'FIXED_ASSET',
  OTHER_ASSET = 'OTHER_ASSET',
  
  // Liabilities
  CURRENT_LIABILITY = 'CURRENT_LIABILITY',
  LONG_TERM_LIABILITY = 'LONG_TERM_LIABILITY',
  OTHER_LIABILITY = 'OTHER_LIABILITY',
  
  // Equity
  CAPITAL = 'CAPITAL',
  RETAINED_EARNINGS = 'RETAINED_EARNINGS',
  DRAWINGS = 'DRAWINGS',
  
  // Income
  REVENUE = 'REVENUE',
  OTHER_INCOME = 'OTHER_INCOME',
  
  // Expense
  COST_OF_SALES = 'COST_OF_SALES',
  OPERATING_EXPENSE = 'OPERATING_EXPENSE',
  ADMINISTRATIVE_EXPENSE = 'ADMINISTRATIVE_EXPENSE',
  FINANCIAL_EXPENSE = 'FINANCIAL_EXPENSE',
  OTHER_EXPENSE = 'OTHER_EXPENSE'
}

enum AccountStatus {
  ACTIVE = 'ACTIVE',           // Available for use
  INACTIVE = 'INACTIVE',       // Not available for new transactions
  ARCHIVED = 'ARCHIVED',       // Historical only
  PENDING = 'PENDING'          // Awaiting approval
}
```

### Account Hierarchy Example

```
1000 - Assets (CONTROL ACCOUNT)
  ├─ 1100 - Current Assets (CONTROL ACCOUNT)
  │   ├─ 1110 - Cash and Cash Equivalents
  │   │   ├─ 1111 - Petty Cash
  │   │   ├─ 1112 - Bank Account - Operating
  │   │   └─ 1113 - Bank Account - Savings
  │   ├─ 1120 - Accounts Receivable
  │   │   ├─ 1121 - Trade Receivables
  │   │   └─ 1122 - Other Receivables
  │   └─ 1130 - Inventory
  │       ├─ 1131 - Raw Materials
  │       ├─ 1132 - Work in Progress
  │       └─ 1133 - Finished Goods
  └─ 1200 - Fixed Assets (CONTROL ACCOUNT)
      ├─ 1210 - Property, Plant & Equipment
      │   ├─ 1211 - Land
      │   ├─ 1212 - Buildings
      │   └─ 1213 - Machinery & Equipment
      └─ 1220 - Accumulated Depreciation
          ├─ 1221 - Buildings Depreciation
          └─ 1222 - Equipment Depreciation

2000 - Liabilities (CONTROL ACCOUNT)
  ├─ 2100 - Current Liabilities (CONTROL ACCOUNT)
  │   ├─ 2110 - Accounts Payable
  │   ├─ 2120 - Accrued Expenses
  │   └─ 2130 - Short-term Loans
  └─ 2200 - Long-term Liabilities (CONTROL ACCOUNT)
      ├─ 2210 - Long-term Debt
      └─ 2220 - Deferred Tax Liability

3000 - Equity (CONTROL ACCOUNT)
  ├─ 3100 - Share Capital
  ├─ 3200 - Retained Earnings
  └─ 3300 - Current Year Earnings

4000 - Income (CONTROL ACCOUNT)
  ├─ 4100 - Operating Revenue
  │   ├─ 4110 - Product Sales
  │   └─ 4120 - Service Revenue
  └─ 4200 - Other Income
      └─ 4210 - Interest Income

5000 - Expenses (CONTROL ACCOUNT)
  ├─ 5100 - Cost of Sales
  ├─ 5200 - Operating Expenses
  │   ├─ 5210 - Salaries & Wages
  │   ├─ 5220 - Rent
  │   └─ 5230 - Utilities
  └─ 5300 - Administrative Expenses
      ├─ 5310 - Office Supplies
      └─ 5320 - Professional Fees
```

---

## 🎨 Account Types

### 1. Asset Accounts

**Characteristics**:
- Normal balance: **Debit**
- Balance sheet accounts
- Represent resources owned by the company

**Categories**:

**Current Assets**:
- Cash and cash equivalents
- Accounts receivable
- Inventory
- Prepaid expenses
- Short-term investments

**Fixed Assets**:
- Property, plant, and equipment
- Land
- Buildings
- Machinery and equipment
- Vehicles
- Accumulated depreciation (contra-asset, credit balance)

**Other Assets**:
- Long-term investments
- Intangible assets (patents, trademarks, goodwill)
- Deferred tax assets

### 2. Liability Accounts

**Characteristics**:
- Normal balance: **Credit**
- Balance sheet accounts
- Represent obligations owed by the company

**Categories**:

**Current Liabilities**:
- Accounts payable
- Accrued expenses
- Short-term loans
- Current portion of long-term debt
- Unearned revenue
- Taxes payable

**Long-term Liabilities**:
- Long-term debt
- Bonds payable
- Deferred tax liabilities
- Pension obligations
- Lease obligations

### 3. Equity Accounts

**Characteristics**:
- Normal balance: **Credit**
- Balance sheet accounts
- Represent owner's interest in the company

**Categories**:

**Capital/Share Capital**:
- Common stock
- Preferred stock
- Additional paid-in capital

**Retained Earnings**:
- Accumulated profits
- Prior period adjustments

**Drawings/Dividends**:
- Owner withdrawals (contra-equity, debit balance)
- Dividend distributions

**Other Equity**:
- Treasury stock (contra-equity)
- Other comprehensive income

### 4. Income/Revenue Accounts

**Characteristics**:
- Normal balance: **Credit**
- Income statement accounts
- Represent earnings from business activities

**Categories**:

**Operating Revenue**:
- Sales revenue
- Service revenue
- Professional fees

**Other Income**:
- Interest income
- Dividend income
- Rental income
- Gain on sale of assets

### 5. Expense Accounts

**Characteristics**:
- Normal balance: **Debit**
- Income statement accounts
- Represent costs of doing business

**Categories**:

**Cost of Sales**:
- Cost of goods sold
- Direct labor
- Direct materials

**Operating Expenses**:
- Salaries and wages
- Rent
- Utilities
- Marketing and advertising
- Insurance
- Depreciation

**Administrative Expenses**:
- Office supplies
- Professional fees
- Bank charges
- Travel and entertainment

**Financial Expenses**:
- Interest expense
- Bank fees
- Foreign exchange losses

---

## 📁 Account Categories

### Detailed Category Structure

```typescript
const ACCOUNT_CATEGORIES = {
  ASSET: {
    CURRENT_ASSET: {
      name: 'Current Assets',
      subcategories: [
        'Cash and Cash Equivalents',
        'Accounts Receivable',
        'Inventory',
        'Prepaid Expenses',
        'Short-term Investments',
        'Other Current Assets'
      ]
    },
    FIXED_ASSET: {
      name: 'Fixed Assets',
      subcategories: [
        'Property, Plant & Equipment',
        'Land',
        'Buildings',
        'Machinery & Equipment',
        'Vehicles',
        'Furniture & Fixtures',
        'Accumulated Depreciation'
      ]
    },
    OTHER_ASSET: {
      name: 'Other Assets',
      subcategories: [
        'Long-term Investments',
        'Intangible Assets',
        'Deferred Tax Assets',
        'Deposits'
      ]
    }
  },
  
  LIABILITY: {
    CURRENT_LIABILITY: {
      name: 'Current Liabilities',
      subcategories: [
        'Accounts Payable',
        'Accrued Expenses',
        'Short-term Loans',
        'Current Portion of Long-term Debt',
        'Unearned Revenue',
        'Taxes Payable'
      ]
    },
    LONG_TERM_LIABILITY: {
      name: 'Long-term Liabilities',
      subcategories: [
        'Long-term Debt',
        'Bonds Payable',
        'Deferred Tax Liabilities',
        'Pension Obligations',
        'Lease Obligations'
      ]
    }
  },
  
  EQUITY: {
    CAPITAL: {
      name: 'Capital',
      subcategories: [
        'Share Capital',
        'Common Stock',
        'Preferred Stock',
        'Additional Paid-in Capital'
      ]
    },
    RETAINED_EARNINGS: {
      name: 'Retained Earnings',
      subcategories: [
        'Retained Earnings - Beginning',
        'Current Year Earnings',
        'Prior Period Adjustments'
      ]
    }
  },
  
  INCOME: {
    REVENUE: {
      name: 'Revenue',
      subcategories: [
        'Product Sales',
        'Service Revenue',
        'Professional Fees',
        'Sales Returns and Allowances'
      ]
    },
    OTHER_INCOME: {
      name: 'Other Income',
      subcategories: [
        'Interest Income',
        'Dividend Income',
        'Rental Income',
        'Gain on Sale of Assets'
      ]
    }
  },
  
  EXPENSE: {
    COST_OF_SALES: {
      name: 'Cost of Sales',
      subcategories: [
        'Cost of Goods Sold',
        'Direct Labor',
        'Direct Materials',
        'Manufacturing Overhead'
      ]
    },
    OPERATING_EXPENSE: {
      name: 'Operating Expenses',
      subcategories: [
        'Salaries & Wages',
        'Rent',
        'Utilities',
        'Marketing & Advertising',
        'Depreciation',
        'Insurance'
      ]
    }
  }
};
```

---

## 🎯 Account Head Management

### Create Account

**Create Account Endpoint**:
```typescript
POST /api/accounts

interface CreateAccountRequest {
  accountCode: string;
  accountName: string;
  accountType: AccountType;
  accountCategory: AccountCategory;
  subCategory?: string;
  parentAccountId?: string;
  description?: string;
  allowDirectEntry?: boolean;
  isControlAccount?: boolean;
  currency?: string;
}

async createAccount(companyId: string, userId: string, data: CreateAccountRequest) {
  // Get tenant database
  const company = await getCompany(companyId);
  const tenantDb = getTenantDatabase(company.databaseName);
  
  // Check permissions
  const user = await prisma.user.findUnique({
    where: { id: userId }
  });
  
  if (!['ADMIN', 'MANAGER'].includes(user.role)) {
    throw new ForbiddenException('Only admins and managers can create accounts');
  }
  
  // Validate account code uniqueness
  const existing = await tenantDb.account.findUnique({
    where: { accountCode: data.accountCode }
  });
  
  if (existing) {
    throw new BadRequestException('Account code already exists');
  }
  
  // Determine hierarchy level
  let level = 1;
  if (data.parentAccountId) {
    const parent = await tenantDb.account.findUnique({
      where: { id: data.parentAccountId }
    });
    level = parent.level + 1;
    
    // Validate parent is a control account
    if (!parent.isControlAccount) {
      throw new BadRequestException('Parent must be a control account');
    }
  }
  
  // Determine normal balance based on account type
  const normalBalance = ['ASSET', 'EXPENSE'].includes(data.accountType) 
    ? 'DEBIT' 
    : 'CREDIT';
  
  // Determine if balance sheet account
  const isBalanceSheet = ['ASSET', 'LIABILITY', 'EQUITY'].includes(data.accountType);
  
  // Create account
  const account = await tenantDb.account.create({
    data: {
      accountCode: data.accountCode,
      accountName: data.accountName,
      accountType: data.accountType,
      accountCategory: data.accountCategory,
      subCategory: data.subCategory,
      parentAccountId: data.parentAccountId,
      level,
      normalBalance,
      isBalanceSheet,
      isControlAccount: data.isControlAccount || false,
      allowDirectEntry: data.allowDirectEntry !== false,
      description: data.description,
      currency: data.currency || company.currency,
      status: 'ACTIVE',
      isActive: true,
      isSystemAccount: false,
      createdBy: userId
    }
  });
  
  // Log creation
  await logAuditEvent({
    userId,
    companyId,
    action: 'ACCOUNT_CREATED',
    resourceType: 'ACCOUNT',
    resourceId: account.id,
    metadata: { accountCode: data.accountCode, accountName: data.accountName }
  });
  
  return account;
}
```

### Update Account

**Update Account Endpoint**:
```typescript
PATCH /api/accounts/:id

interface UpdateAccountRequest {
  accountName?: string;
  accountCategory?: AccountCategory;
  subCategory?: string;
  description?: string;
  allowDirectEntry?: boolean;
  status?: AccountStatus;
  isActive?: boolean;
}

async updateAccount(accountId: string, userId: string, data: UpdateAccountRequest) {
  const user = await prisma.user.findUnique({
    where: { id: userId }
  });
  
  if (!['ADMIN', 'MANAGER'].includes(user.role)) {
    throw new ForbiddenException('Only admins and managers can update accounts');
  }
  
  const company = await getCompany(user.companyId);
  const tenantDb = getTenantDatabase(company.databaseName);
  
  // Get existing account
  const account = await tenantDb.account.findUnique({
    where: { id: accountId }
  });
  
  // Check if system account
  if (account.isSystemAccount) {
    throw new BadRequestException('System accounts cannot be modified');
  }
  
  // Update account
  const updatedAccount = await tenantDb.account.update({
    where: { id: accountId },
    data: {
      accountName: data.accountName,
      accountCategory: data.accountCategory,
      subCategory: data.subCategory,
      description: data.description,
      allowDirectEntry: data.allowDirectEntry,
      status: data.status,
      isActive: data.isActive,
      updatedBy: userId
    }
  });
  
  // Log update
  await logAuditEvent({
    userId,
    companyId: user.companyId,
    action: 'ACCOUNT_UPDATED',
    resourceType: 'ACCOUNT',
    resourceId: accountId,
    metadata: data
  });
  
  return updatedAccount;
}
```

### Delete Account

**Delete Account Endpoint**:
```typescript
DELETE /api/accounts/:id

async deleteAccount(accountId: string, userId: string) {
  const user = await prisma.user.findUnique({
    where: { id: userId }
  });
  
  if (user.role !== 'ADMIN') {
    throw new ForbiddenException('Only admins can delete accounts');
  }
  
  const company = await getCompany(user.companyId);
  const tenantDb = getTenantDatabase(company.databaseName);
  
  // Get account
  const account = await tenantDb.account.findUnique({
    where: { id: accountId },
    include: {
      children: true,
      trialBalanceEntries: true
    }
  });
  
  // Validation checks
  if (account.isSystemAccount) {
    throw new BadRequestException('System accounts cannot be deleted');
  }
  
  if (account.children.length > 0) {
    throw new BadRequestException('Cannot delete account with sub-accounts');
  }
  
  if (account.trialBalanceEntries.length > 0) {
    throw new BadRequestException('Cannot delete account with trial balance entries. Archive instead.');
  }
  
  // Soft delete (archive)
  const deletedAccount = await tenantDb.account.update({
    where: { id: accountId },
    data: {
      status: 'ARCHIVED',
      isActive: false,
      deletedBy: userId,
      deletedAt: new Date()
    }
  });
  
  // Log deletion
  await logAuditEvent({
    userId,
    companyId: user.companyId,
    action: 'ACCOUNT_DELETED',
    resourceType: 'ACCOUNT',
    resourceId: accountId
  });
  
  return { success: true };
}
```

### List Accounts

**List Accounts Endpoint**:
```typescript
GET /api/accounts

interface ListAccountsQuery {
  accountType?: AccountType;
  accountCategory?: AccountCategory;
  status?: AccountStatus;
  isActive?: boolean;
  isControlAccount?: boolean;
  parentAccountId?: string;
  search?: string;
  includeBalances?: boolean;
}

async listAccounts(companyId: string, query: ListAccountsQuery) {
  const company = await getCompany(companyId);
  const tenantDb = getTenantDatabase(company.databaseName);
  
  const accounts = await tenantDb.account.findMany({
    where: {
      ...(query.accountType && { accountType: query.accountType }),
      ...(query.accountCategory && { accountCategory: query.accountCategory }),
      ...(query.status && { status: query.status }),
      ...(query.isActive !== undefined && { isActive: query.isActive }),
      ...(query.isControlAccount !== undefined && { isControlAccount: query.isControlAccount }),
      ...(query.parentAccountId && { parentAccountId: query.parentAccountId }),
      ...(query.search && {
        OR: [
          { accountCode: { contains: query.search, mode: 'insensitive' } },
          { accountName: { contains: query.search, mode: 'insensitive' } }
        ]
      })
    },
    include: {
      parent: {
        select: {
          id: true,
          accountCode: true,
          accountName: true
        }
      },
      children: {
        select: {
          id: true,
          accountCode: true,
          accountName: true
        }
      }
    },
    orderBy: [
      { accountCode: 'asc' }
    ]
  });
  
  // Include balances if requested
  if (query.includeBalances) {
    const activePeriod = await tenantDb.period.findFirst({
      where: { isActive: true }
    });
    
    if (activePeriod) {
      for (const account of accounts) {
        const balance = await calculateAccountBalance(tenantDb, account.id, activePeriod.id);
        account.currentBalance = balance;
      }
    }
  }
  
  return accounts;
}
```

---

## 📋 Standard Chart Templates

### Predefined Templates

CloudAudit Pro includes several standard chart of accounts templates:

```typescript
const CHART_TEMPLATES = {
  US_GAAP_STANDARD: {
    id: 'us-gaap-standard',
    name: 'US GAAP Standard Chart of Accounts',
    description: 'Standard chart following US GAAP principles',
    country: 'US',
    accountingStandard: 'US GAAP',
    accountCount: 150
  },
  
  IFRS_STANDARD: {
    id: 'ifrs-standard',
    name: 'IFRS Standard Chart of Accounts',
    description: 'Standard chart following IFRS principles',
    country: 'International',
    accountingStandard: 'IFRS',
    accountCount: 145
  },
  
  SMALL_BUSINESS: {
    id: 'small-business',
    name: 'Small Business Chart of Accounts',
    description: 'Simplified chart for small businesses',
    country: 'US',
    accountingStandard: 'US GAAP',
    accountCount: 80
  },
  
  NONPROFIT: {
    id: 'nonprofit',
    name: 'Non-Profit Organization Chart',
    description: 'Chart designed for non-profit organizations',
    country: 'US',
    accountingStandard: 'US GAAP',
    accountCount: 100
  },
  
  MANUFACTURING: {
    id: 'manufacturing',
    name: 'Manufacturing Company Chart',
    description: 'Chart optimized for manufacturing businesses',
    country: 'US',
    accountingStandard: 'US GAAP',
    accountCount: 200
  }
};
```

### Load Template

**Load Chart Template Endpoint**:
```typescript
POST /api/accounts/load-template

interface LoadTemplateRequest {
  templateId: string;
  clearExisting?: boolean;  // Clear existing accounts first
  prefix?: string;          // Add prefix to account codes
}

async loadChartTemplate(companyId: string, userId: string, data: LoadTemplateRequest) {
  const user = await prisma.user.findUnique({
    where: { id: userId }
  });
  
  if (user.role !== 'ADMIN') {
    throw new ForbiddenException('Only admins can load chart templates');
  }
  
  const company = await getCompany(companyId);
  const tenantDb = getTenantDatabase(company.databaseName);
  
  // Check if accounts already exist
  const existingCount = await tenantDb.account.count();
  
  if (existingCount > 0 && !data.clearExisting) {
    throw new BadRequestException('Accounts already exist. Set clearExisting to true to replace.');
  }
  
  // Get template from master database
  const template = await prisma.chartTemplate.findUnique({
    where: { id: data.templateId },
    include: {
      accounts: {
        orderBy: { sortOrder: 'asc' }
      }
    }
  });
  
  if (!template) {
    throw new NotFoundException('Template not found');
  }
  
  // Clear existing if requested
  if (data.clearExisting) {
    await tenantDb.account.deleteMany({
      where: { isSystemAccount: false }
    });
  }
  
  // Copy accounts to tenant database
  const accountMap = new Map(); // Map old IDs to new IDs
  
  // First pass: Create all accounts without parent relationships
  for (const templateAccount of template.accounts) {
    const accountCode = data.prefix 
      ? `${data.prefix}${templateAccount.accountCode}`
      : templateAccount.accountCode;
    
    const newAccount = await tenantDb.account.create({
      data: {
        accountCode,
        accountName: templateAccount.accountName,
        accountType: templateAccount.accountType,
        accountCategory: templateAccount.accountCategory,
        subCategory: templateAccount.subCategory,
        normalBalance: templateAccount.normalBalance,
        isBalanceSheet: templateAccount.isBalanceSheet,
        isControlAccount: templateAccount.isControlAccount,
        allowDirectEntry: templateAccount.allowDirectEntry,
        level: templateAccount.level,
        sortOrder: templateAccount.sortOrder,
        description: templateAccount.description,
        status: 'ACTIVE',
        isActive: true,
        currency: company.currency,
        createdBy: userId
      }
    });
    
    accountMap.set(templateAccount.id, newAccount.id);
  }
  
  // Second pass: Update parent relationships
  for (const templateAccount of template.accounts) {
    if (templateAccount.parentAccountId) {
      const newAccountId = accountMap.get(templateAccount.id);
      const newParentId = accountMap.get(templateAccount.parentAccountId);
      
      await tenantDb.account.update({
        where: { id: newAccountId },
        data: { parentAccountId: newParentId }
      });
    }
  }
  
  // Log template loading
  await logAuditEvent({
    userId,
    companyId,
    action: 'CHART_TEMPLATE_LOADED',
    resourceType: 'CHART_OF_ACCOUNTS',
    metadata: { templateId: data.templateId, accountCount: template.accounts.length }
  });
  
  return {
    success: true,
    accountsLoaded: template.accounts.length
  };
}
```

---

## ✏️ Custom Account Creation

### Import Custom Chart

**Import Chart Endpoint**:
```typescript
POST /api/accounts/import

interface ImportChartRequest {
  format: 'CSV' | 'EXCEL' | 'JSON';
  file: File;
  mapping?: FieldMapping;
  clearExisting?: boolean;
}

interface FieldMapping {
  accountCode: string;
  accountName: string;
  accountType: string;
  accountCategory: string;
  parentAccountCode?: string;
  description?: string;
}

async importChart(companyId: string, userId: string, data: ImportChartRequest) {
  const user = await prisma.user.findUnique({
    where: { id: userId }
  });
  
  if (user.role !== 'ADMIN') {
    throw new ForbiddenException('Only admins can import chart of accounts');
  }
  
  const company = await getCompany(companyId);
  const tenantDb = getTenantDatabase(company.databaseName);
  
  // Parse file based on format
  let accounts;
  switch (data.format) {
    case 'CSV':
      accounts = await parseCSV(data.file, data.mapping);
      break;
    case 'EXCEL':
      accounts = await parseExcel(data.file, data.mapping);
      break;
    case 'JSON':
      accounts = await parseJSON(data.file);
      break;
  }
  
  // Validate all accounts
  const validationErrors = validateAccounts(accounts);
  if (validationErrors.length > 0) {
    throw new BadRequestException('Validation errors', validationErrors);
  }
  
  // Clear existing if requested
  if (data.clearExisting) {
    await tenantDb.account.deleteMany({
      where: { isSystemAccount: false }
    });
  }
  
  // Import accounts in hierarchical order
  const imported = await importAccountsHierarchically(tenantDb, accounts, userId);
  
  // Log import
  await logAuditEvent({
    userId,
    companyId,
    action: 'CHART_IMPORTED',
    resourceType: 'CHART_OF_ACCOUNTS',
    metadata: { accountCount: imported.length, format: data.format }
  });
  
  return {
    success: true,
    accountsImported: imported.length,
    errors: []
  };
}
```

### Export Chart

**Export Chart Endpoint**:
```typescript
GET /api/accounts/export

interface ExportChartQuery {
  format: 'CSV' | 'EXCEL' | 'JSON' | 'PDF';
  includeBalances?: boolean;
  includeInactive?: boolean;
}

async exportChart(companyId: string, query: ExportChartQuery) {
  const company = await getCompany(companyId);
  const tenantDb = getTenantDatabase(company.databaseName);
  
  // Get accounts
  const accounts = await tenantDb.account.findMany({
    where: {
      ...(query.includeInactive === false && { isActive: true })
    },
    include: {
      parent: {
        select: {
          accountCode: true,
          accountName: true
        }
      }
    },
    orderBy: { accountCode: 'asc' }
  });
  
  // Include balances if requested
  if (query.includeBalances) {
    const activePeriod = await tenantDb.period.findFirst({
      where: { isActive: true }
    });
    
    if (activePeriod) {
      for (const account of accounts) {
        const balance = await calculateAccountBalance(tenantDb, account.id, activePeriod.id);
        account.currentBalance = balance;
      }
    }
  }
  
  // Generate file based on format
  let file;
  switch (query.format) {
    case 'CSV':
      file = await generateCSV(accounts);
      break;
    case 'EXCEL':
      file = await generateExcel(accounts);
      break;
    case 'JSON':
      file = await generateJSON(accounts);
      break;
    case 'PDF':
      file = await generatePDF(accounts);
      break;
  }
  
  return file;
}
```

---

## ⚙️ Account Configuration

### Account Settings

**Update Account Settings**:
```typescript
PATCH /api/accounts/:id/settings

interface AccountSettings {
  // Entry Control
  allowDirectEntry: boolean;
  requiresCostCenter: boolean;
  requiresProject: boolean;
  requiresNarration: boolean;
  
  // Validation
  validateBalance: boolean;
  maxDebitAmount?: number;
  maxCreditAmount?: number;
  
  // Currency
  allowMultiCurrency: boolean;
  defaultCurrency: string;
  
  // Tax
  taxable: boolean;
  defaultTaxCode?: string;
  
  // Reporting
  excludeFromFinancials: boolean;
  reportingCategory?: string;
  
  // Audit
  requiresApproval: boolean;
  approverRole?: string;
}

async updateAccountSettings(accountId: string, userId: string, settings: AccountSettings) {
  const user = await prisma.user.findUnique({
    where: { id: userId }
  });
  
  if (!['ADMIN', 'MANAGER'].includes(user.role)) {
    throw new ForbiddenException('Insufficient permissions');
  }
  
  const company = await getCompany(user.companyId);
  const tenantDb = getTenantDatabase(company.databaseName);
  
  const account = await tenantDb.account.update({
    where: { id: accountId },
    data: {
      settings: settings
    }
  });
  
  return account;
}
```

---

## 🔍 Best Practices

### Chart of Accounts Design

1. **Numbering System**:
   - Use consistent numbering (e.g., 1000-1999 for Assets)
   - Leave gaps for future accounts (e.g., 1010, 1020, 1030)
   - Use meaningful codes that indicate account type

2. **Hierarchy**:
   - Keep hierarchy to 4-5 levels maximum
   - Use control accounts for grouping
   - Balance detail vs. simplicity

3. **Naming**:
   - Use clear, descriptive names
   - Be consistent with naming conventions
   - Avoid abbreviations unless standard

4. **Account Types**:
   - Correctly classify all accounts
   - Use appropriate normal balances
   - Set proper balance sheet/income statement flags

### Account Management

1. **Creation**:
   - Plan chart structure before creating accounts
   - Use templates when appropriate
   - Test with sample data before going live

2. **Modification**:
   - Avoid modifying system accounts
   - Document all changes
   - Consider impact on existing data

3. **Deletion**:
   - Never delete accounts with history
   - Use archive status instead
   - Transfer balances before archiving

4. **Maintenance**:
   - Review inactive accounts annually
   - Consolidate redundant accounts
   - Update descriptions and categories

---

## 🛠️ Common Use Cases

### Use Case 1: Setup New Company Chart

**Workflow**:
1. Choose appropriate template (US GAAP, IFRS, etc.)
2. Load template into company
3. Review and customize accounts
4. Add company-specific accounts
5. Set account settings and permissions
6. Test with trial balance import

### Use Case 2: Migrate from Legacy System

**Workflow**:
1. Export chart from legacy system
2. Map legacy accounts to standard categories
3. Clean and validate data
4. Import to CloudAudit Pro
5. Verify hierarchy and relationships
6. Test balances and reports

### Use Case 3: Multi-Company Consolidation

**Workflow**:
1. Create standard parent chart
2. Map each subsidiary chart to parent
3. Set up consolidation accounts
4. Define elimination entries
5. Configure currency translation
6. Test consolidated reports

---

## 🚨 Troubleshooting

### Common Issues

**Issue: "Account code already exists"**
- **Cause**: Duplicate account code in chart
- **Solution**: Use unique account codes or add prefix

**Issue: "Cannot delete account with sub-accounts"**
- **Cause**: Control account has child accounts
- **Solution**: Delete or move child accounts first

**Issue: "Parent must be a control account"**
- **Cause**: Trying to add sub-account to non-control account
- **Solution**: Set parent as control account first

**Issue: "Chart template not loading"**
- **Cause**: Accounts already exist in database
- **Solution**: Set clearExisting flag or manually clear accounts

---

## 📚 API Reference Summary

### Account Endpoints
- `GET /api/accounts` - List all accounts
- `GET /api/accounts/:id` - Get account details
- `POST /api/accounts` - Create new account
- `PATCH /api/accounts/:id` - Update account
- `DELETE /api/accounts/:id` - Delete/archive account
- `GET /api/accounts/:id/balance` - Get account balance
- `GET /api/accounts/:id/transactions` - Get account transactions
- `PATCH /api/accounts/:id/settings` - Update account settings

### Template Endpoints
- `GET /api/accounts/templates` - List available templates
- `GET /api/accounts/templates/:id` - Get template details
- `POST /api/accounts/load-template` - Load chart template

### Import/Export Endpoints
- `POST /api/accounts/import` - Import chart of accounts
- `GET /api/accounts/export` - Export chart of accounts
- `POST /api/accounts/validate-import` - Validate import file

---

*This documentation is maintained by the CloudAudit Pro development team. Last updated: December 2025.*
