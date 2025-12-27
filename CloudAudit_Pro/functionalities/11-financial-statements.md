# CloudAudit Pro - Financial Statements

## 📊 Overview

CloudAudit Pro provides automated financial statement generation from trial balance data. The system produces professional, formatted financial statements that comply with accounting standards and can be exported in multiple formats.

**Supported Statements**:
- Balance Sheet (Statement of Financial Position)
- Income Statement (Profit & Loss)
- Cash Flow Statement
- Statement of Changes in Equity

**Key Features**:
- Automated generation from trial balance
- Multiple format support (Standard, Detailed, Summary)
- Comparative statements (current vs prior period)
- Export to PDF, Excel, CSV, HTML
- Customizable account groupings
- Vertical and horizontal analysis
- Financial ratios calculation
- Professional formatting with company branding

---

## 📋 Statement Types

### 1. Balance Sheet

**Purpose**: Shows financial position at a specific point in time

**Structure**:
```
ASSETS
  Current Assets
    Cash and Cash Equivalents
    Accounts Receivable
    Inventory
    Prepaid Expenses
  Total Current Assets

  Non-Current Assets
    Property, Plant & Equipment
    Less: Accumulated Depreciation
    Intangible Assets
    Long-term Investments
  Total Non-Current Assets

TOTAL ASSETS

LIABILITIES
  Current Liabilities
    Accounts Payable
    Accrued Liabilities
    Short-term Debt
    Current Portion of Long-term Debt
  Total Current Liabilities

  Non-Current Liabilities
    Long-term Debt
    Deferred Tax Liabilities
    Other Long-term Liabilities
  Total Non-Current Liabilities

TOTAL LIABILITIES

EQUITY
  Share Capital
  Retained Earnings
  Other Comprehensive Income
TOTAL EQUITY

TOTAL LIABILITIES AND EQUITY
```

**Data Model**:
```typescript
interface BalanceSheet {
  companyName: string;
  asOfDate: Date;
  currency: string;
  assets: {
    currentAssets: AccountLine[];
    nonCurrentAssets: AccountLine[];
    totalAssets: number;
  };
  liabilities: {
    currentLiabilities: AccountLine[];
    nonCurrentLiabilities: AccountLine[];
    totalLiabilities: number;
  };
  equity: {
    shareCapital: number;
    retainedEarnings: number;
    otherEquity: AccountLine[];
    totalEquity: number;
  };
  totalLiabilitiesAndEquity: number;
}
```

### 2. Income Statement

**Purpose**: Shows financial performance over a period

**Structure**:
```
REVENUE
  Product Sales
  Service Revenue
  Other Income
TOTAL REVENUE

COST OF GOODS SOLD
  Direct Materials
  Direct Labor
  Manufacturing Overhead
TOTAL COST OF GOODS SOLD

GROSS PROFIT

OPERATING EXPENSES
  Selling Expenses
  Administrative Expenses
  Depreciation & Amortization
TOTAL OPERATING EXPENSES

OPERATING INCOME

OTHER INCOME/(EXPENSE)
  Interest Income
  Interest Expense
  Gain/Loss on Asset Disposal
TOTAL OTHER INCOME/(EXPENSE)

INCOME BEFORE TAX

INCOME TAX EXPENSE

NET INCOME
```

**Data Model**:
```typescript
interface IncomeStatement {
  companyName: string;
  periodStart: Date;
  periodEnd: Date;
  currency: string;
  revenue: {
    operatingRevenue: AccountLine[];
    totalRevenue: number;
  };
  costOfSales: {
    costs: AccountLine[];
    totalCostOfSales: number;
  };
  grossProfit: number;
  operatingExpenses: {
    expenses: AccountLine[];
    totalOperatingExpenses: number;
  };
  operatingIncome: number;
  otherIncome: AccountLine[];
  otherExpenses: AccountLine[];
  incomeBeforeTax: number;
  incomeTaxExpense: number;
  netIncome: number;
  earningsPerShare?: number;
}
```

### 3. Cash Flow Statement

**Purpose**: Shows cash inflows and outflows

**Structure**:
```
OPERATING ACTIVITIES
  Net Income
  Adjustments:
    Depreciation & Amortization
    Changes in Working Capital
      (Increase)/Decrease in Receivables
      (Increase)/Decrease in Inventory
      Increase/(Decrease) in Payables
NET CASH FROM OPERATING ACTIVITIES

INVESTING ACTIVITIES
  Purchase of Property, Plant & Equipment
  Proceeds from Sale of Assets
  Purchase/Sale of Investments
NET CASH FROM INVESTING ACTIVITIES

FINANCING ACTIVITIES
  Proceeds from Borrowings
  Repayment of Borrowings
  Dividends Paid
  Issuance/Repurchase of Shares
NET CASH FROM FINANCING ACTIVITIES

NET INCREASE/(DECREASE) IN CASH

CASH AT BEGINNING OF PERIOD
CASH AT END OF PERIOD
```

### 4. Statement of Changes in Equity

**Purpose**: Shows changes in equity components

**Structure**:
```
                Share      Retained    Other        Total
                Capital    Earnings    Equity       Equity

Opening Balance
Net Income
Dividends
Other Changes
Closing Balance
```

---

## 🔧 Statement Generation

### Generation Request

```http
POST /api/financial-statements/generate
Authorization: Bearer {token}
Content-Type: application/json

{
  "companyId": "comp_acme",
  "periodId": "per_fy2024",
  "statementType": "BALANCE_SHEET",
  "format": "STANDARD",
  "asOfDate": "2024-12-31",
  "includeZeroBalances": false,
  "includePriorPeriod": true,
  "roundingFactor": 1
}
```

**Request Parameters**:
```typescript
interface GenerateStatementDto {
  companyId: string;
  periodId: string;
  statementType: 'BALANCE_SHEET' | 'INCOME_STATEMENT' | 'CASH_FLOW' | 'STATEMENT_OF_EQUITY';
  format: 'STANDARD' | 'DETAILED' | 'SUMMARY';
  asOfDate?: string;           // For Balance Sheet
  startDate?: string;          // For Income Statement, Cash Flow
  endDate?: string;            // For Income Statement, Cash Flow
  includeZeroBalances: boolean;
  includePriorPeriod: boolean;
  roundingFactor: number;      // 1, 1000, 1000000 (for thousands/millions)
}
```

### Generation Process

**Step 1: Validate Inputs**
- Verify company and period exist
- Check user access permissions
- Validate date ranges

**Step 2: Retrieve Trial Balance Data**
- Query trial balance for specified period
- Get account balances
- Apply any adjustments from journal entries

**Step 3: Group Accounts**
- Group by account type and category
- Calculate subtotals
- Apply formatting rules

**Step 4: Calculate Totals**
- Sum account groups
- Verify balance sheet balances (Assets = Liabilities + Equity)
- Calculate derived values (Gross Profit, Operating Income, etc.)

**Step 5: Format Statement**
- Apply formatting rules
- Add headers and footers
- Include company branding
- Generate line items with proper indentation

**Step 6: Return Response**
```json
{
  "id": "stmt_001",
  "companyId": "comp_acme",
  "companyName": "Acme Corporation",
  "periodId": "per_fy2024",
  "periodName": "FY 2024 Audit",
  "statementType": "BALANCE_SHEET",
  "format": "STANDARD",
  "asOfDate": "2024-12-31T00:00:00Z",
  "currency": "USD",
  "generatedAt": "2025-01-15T10:00:00Z",
  "generatedBy": "user_123",
  "lineItems": [
    {
      "id": "line_1",
      "accountName": "ASSETS",
      "accountType": "HEADER",
      "amount": "",
      "level": 1,
      "isSubtotal": false,
      "isTotal": false,
      "sortOrder": 1
    },
    {
      "id": "line_2",
      "accountName": "Current Assets",
      "accountType": "HEADER",
      "amount": "",
      "level": 2,
      "isSubtotal": false,
      "isTotal": false,
      "sortOrder": 2
    },
    {
      "id": "acc_cash",
      "accountId": "acc_001",
      "accountCode": "1000",
      "accountName": "Cash and Cash Equivalents",
      "accountType": "ASSET",
      "amount": "125000.00",
      "percentage": "8.5",
      "level": 3,
      "isSubtotal": false,
      "isTotal": false,
      "sortOrder": 3
    }
    // ... more line items
  ],
  "totals": {
    "totalAssets": "1500000.00",
    "totalLiabilities": "900000.00",
    "totalEquity": "600000.00",
    "totalLiabilitiesAndEquity": "1500000.00"
  },
  "metadata": {
    "currency": "USD",
    "roundingFactor": 1,
    "includeZeroBalances": false,
    "includePriorPeriod": true
  }
}
```

---

## 📤 Export Capabilities

### Export Formats

**1. PDF Export**
```http
POST /api/financial-statements/:id/export
Content-Type: application/json

{
  "format": "PDF",
  "includeHeader": true,
  "includeFooter": true,
  "pageSize": "A4",
  "orientation": "PORTRAIT"
}

Response: PDF file (application/pdf)
```

**Features**:
- Professional formatting
- Company letterhead
- Page numbers
- Date stamps
- Digital signatures (optional)

**2. Excel Export**
```http
POST /api/financial-statements/:id/export
Content-Type: application/json

{
  "format": "EXCEL",
  "includeFormulas": true,
  "includeFormatting": true,
  "sheetName": "Balance Sheet"
}

Response: Excel file (application/vnd.openxmlformats-officedocument.spreadsheetml.sheet)
```

**Features**:
- Formatted cells
- Formula preservation
- Multiple worksheets (comparative periods)
- Charts and graphs

**3. CSV Export**
```http
POST /api/financial-statements/:id/export
Content-Type: application/json

{
  "format": "CSV",
  "delimiter": ",",
  "includeHeaders": true
}

Response: CSV file (text/csv)
```

**4. HTML Export**
```http
POST /api/financial-statements/:id/export
Content-Type: application/json

{
  "format": "HTML",
  "includeStyles": true,
  "standalone": true
}

Response: HTML file (text/html)
```

---

## 📊 Comparative Statements

### Side-by-Side Comparison

**Request**:
```http
POST /api/financial-statements/generate-comparative
Content-Type: application/json

{
  "companyId": "comp_acme",
  "currentPeriodId": "per_2024",
  "priorPeriodId": "per_2023",
  "statementType": "INCOME_STATEMENT",
  "showVariance": true,
  "showPercentageChange": true
}
```

**Response Structure**:
```typescript
interface ComparativeStatement {
  statementType: string;
  columns: [
    { period: "FY 2024", periodId: "per_2024" },
    { period: "FY 2023", periodId: "per_2023" },
    { period: "Change", type: "variance" },
    { period: "Change %", type: "percentage" }
  ];
  lineItems: [
    {
      accountName: "Revenue",
      fy2024: "1000000.00",
      fy2023: "850000.00",
      variance: "150000.00",
      percentageChange: "17.6%",
      trend: "UP"
    }
    // ... more lines
  ];
}
```

---

## 💼 Use Cases

### Use Case 1: Year-End Balance Sheet

**Scenario**: Generate balance sheet for audit report

**Steps**:
1. Navigate to Financial Statements
2. Click "Generate Statement"
3. Select:
   - Company: Acme Corporation
   - Period: FY 2024
   - Type: Balance Sheet
   - As of Date: December 31, 2024
   - Include Prior Period: Yes
4. Click "Generate"
5. Review generated statement
6. Export to PDF for audit report
7. Export to Excel for analysis

### Use Case 2: Monthly Income Statement

**Scenario**: Generate monthly P&L for management review

**Steps**:
1. Generate Income Statement
2. Period: January 1-31, 2024
3. Format: Standard
4. Compare to: January 2023
5. Export to Excel
6. Email to management

### Use Case 3: Cash Flow Analysis

**Scenario**: Analyze cash flow trends

**Steps**:
1. Generate Cash Flow Statement
2. Period: Q1 2024 (Jan-Mar)
3. Method: Indirect
4. Include: Operating, Investing, Financing activities
5. Compare to Q1 2023
6. Analyze variances
7. Generate commentary

---

## ⚙️ Best Practices

1. **Verify Trial Balance First**: Ensure trial balance is balanced and complete
2. **Review Adjustments**: Post all audit adjustments before generating
3. **Check Account Mapping**: Verify accounts are properly categorized
4. **Comparative Analysis**: Always generate comparative statements
5. **Multiple Formats**: Export in both PDF (presentation) and Excel (analysis)
6. **Version Control**: Save statement versions for audit trail
7. **Review Calculations**: Verify key calculations (gross profit, operating income, etc.)
8. **Professional Formatting**: Use consistent formatting for external distribution

---

## ❗ Troubleshooting

**Problem**: Balance Sheet Doesn't Balance  
**Solution**: Verify trial balance totals, check for missing accounts, review journal entry postings

**Problem**: Negative Values in Unexpected Places  
**Solution**: Check account type configuration, review debit/credit normal balances

**Problem**: Zero Balances Showing  
**Solution**: Disable "Include Zero Balances" option in generation settings

**Problem**: Export Fails  
**Solution**: Check file permissions, verify export format support, review file size limits

---

## 🔐 Security

- Tenant-level data isolation
- Company access verification
- Role-based export permissions
- Audit trail for all generations
- Secure file storage for exports

---

*For detailed financial statement generation support, consult your audit manager or system administrator.*
