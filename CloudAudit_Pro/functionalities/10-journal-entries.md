# CloudAudit Pro - Journal Entries

## 📒 Overview

Journal Entries are the mechanism for recording financial adjustments, corrections, and transactions in CloudAudit Pro. They provide a structured, auditable way to modify account balances in the trial balance and general ledger.

**Purpose**:
- Record audit adjustments
- Correct accounting errors
- Post accruals and deferrals
- Make reclassification entries
- Process closing entries
- Maintain complete audit trail

**Key Features**:
- Header + line item structure
- Automatic debit/credit validation
- Multi-level approval workflow
- Integration with trial balance
- General ledger posting
- Comprehensive audit trail
- Document attachments
- Batch entry support

---

## 🏗️ Journal Entry Structure

### Header-Level Data

The journal entry header contains metadata about the entire entry:

```typescript
interface JournalEntry {
  id: string;
  companyId: string;          // Company being audited
  periodId: string;           // Audit period
  tenantId: string;           // Multi-tenant isolation
  
  // Entry Identification
  journalNumber: string;      // System-generated (e.g., "JE-1704123456789")
  entryNumber: string;        // User-defined (e.g., "AJE-001")
  
  // Dates
  entryDate: Date;            // Transaction date
  journalDate: Date;          // Journal creation date
  
  // Description
  description: string;        // Entry purpose/reason
  notes?: string;             // Additional explanation
  
  // Classification
  journalType: JournalType;   // ADJUSTMENT, GENERAL, CLOSING, etc.
  entryType: string;          // Type designation
  
  // Reference
  referenceNumber?: string;   // External reference
  referenceDocumentId?: string; // Link to supporting document
  
  // Financial Totals
  totalDebit: Decimal;        // Sum of all debit line items
  totalCredit: Decimal;       // Sum of all credit line items
  
  // Status & Workflow
  status: JournalStatus;      // DRAFT, PENDING, APPROVED, POSTED, REJECTED
  isPosted: boolean;          // Posted to general ledger
  
  // Review
  reviewNotes?: string;       // Reviewer comments
  reviewedBy?: string;        // Reviewer user ID
  reviewedAt?: Date;          // Review timestamp
  
  // Metadata
  createdAt: Date;
  createdBy: string;
  updatedBy?: string;
  postedAt?: Date;
  postedBy?: string;
  
  // Relationships
  company: Company;
  period: Period;
  lineItems: JournalLineItem[];
  account?: AccountHead;
  referenceDocument?: Document;
  ledgerEntries: Ledger[];
}
```

### Line Item Structure

Each journal entry contains one or more line items:

```typescript
interface JournalLineItem {
  id: string;
  journalEntryId: string;     // Parent journal entry
  accountId: string;          // Account affected
  
  // Line Details
  lineNumber: number;         // Sequential (1, 2, 3...)
  description?: string;       // Line-specific description
  
  // Amounts
  debitAmount: Decimal;       // Debit (0 if credit line)
  creditAmount: Decimal;      // Credit (0 if debit line)
  
  // Reference
  reference?: string;         // Line-level reference
  
  // Metadata
  createdAt: Date;
  createdBy?: string;
  updatedBy?: string;
  
  // Relationships
  journalEntry: JournalEntry;
  account: AccountHead;
  ledgerEntries: Ledger[];
}
```

---

## 📝 Journal Entry Types

CloudAudit Pro supports multiple journal entry types for different purposes:

### GENERAL

**Purpose**: Regular business transactions

**Examples**:
- Recording revenue
- Posting expenses
- Asset purchases
- Liability recognition

**Typical Use**: Day-to-day accounting entries

---

### ADJUSTING (Most Common in Audits)

**Purpose**: Audit adjustments to correct misstatements or reclassify accounts

**Examples**:
- Accrued expense adjustments
- Prepaid expense amortization
- Depreciation corrections
- Revenue recognition adjustments
- Allowance for doubtful accounts

**Typical Use**: Year-end audit adjustments (AJE - Adjusting Journal Entry)

**Example Scenario**:
```
Client failed to record December utility expense

Dr. Utilities Expense          $1,250
    Cr. Accrued Liabilities            $1,250

To record December utility expense not recorded by client
```

---

### CLOSING

**Purpose**: Close temporary accounts at period end

**Examples**:
- Transfer revenue to retained earnings
- Transfer expenses to retained earnings
- Close dividend accounts
- Zero out income statement accounts

**Typical Use**: Fiscal year-end closing process

---

### REVERSING

**Purpose**: Reverse previous period accruals at start of new period

**Examples**:
- Reverse accrued payroll
- Reverse accrued expenses
- Reverse deferred revenue

**Typical Use**: First day of new fiscal period

---

### CORRECTING

**Purpose**: Fix errors in previously recorded entries

**Examples**:
- Correct posting to wrong account
- Fix transposed amounts
- Reverse duplicate entries
- Correct classification errors

**Typical Use**: Error correction throughout the year

---

## ⚙️ Entry Status Lifecycle

```typescript
enum JournalStatus {
  DRAFT = 'DRAFT',           // Initial creation, not submitted
  PENDING = 'PENDING',       // Submitted for approval
  APPROVED = 'APPROVED',     // Approved, ready to post
  POSTED = 'POSTED',         // Posted to general ledger
  REJECTED = 'REJECTED'      // Rejected by reviewer
}
```

### Status Flow

```
DRAFT → PENDING → APPROVED → POSTED
           ↓
       REJECTED → DRAFT (if revised)
```

### Status Descriptions

**DRAFT**:
- Entry is being created or edited
- Not visible to reviewers
- Can be freely modified
- Not affecting trial balance

**PENDING**:
- Entry submitted for review
- Visible to reviewers/approvers
- Cannot be edited by creator
- Awaiting approval decision

**APPROVED**:
- Reviewer has approved entry
- Ready for posting to ledger
- Can still be rejected at posting stage
- Not yet affecting account balances

**POSTED**:
- Entry posted to general ledger
- Account balances updated
- Affects trial balance
- Cannot be edited (must reverse instead)

**REJECTED**:
- Reviewer has rejected entry
- Must be revised or cancelled
- Reviewer provides rejection reasons
- Can be resubmitted after revision

---

## 🔄 Journal Entry Workflow

### Step 1: Entry Creation

**User Action**: Create New Journal Entry

**Form Fields**:
```typescript
{
  companyId: "comp_acme",              // Select company
  periodId: "per_fy2024",              // Select period
  entryNumber: "AJE-001",              // Assign entry number
  entryDate: "2024-12-31",             // Entry date
  entryType: "ADJUSTING",              // Entry type
  description: "Accrue December utilities",
  notes: "Per utility invoice dated 1/5/2025",
  referenceNumber: "INV-2024-1234",   // Optional
  lineItems: [
    {
      accountId: "acc_utilities",
      description: "December utilities",
      debitAmount: "1250.00",
      creditAmount: "0.00",
      reference: "Utility bill"
    },
    {
      accountId: "acc_accrued_liab",
      description: "Accrued utility liability",
      debitAmount: "0.00",
      creditAmount: "1250.00",
      reference: "Utility bill"
    }
  ]
}
```

**Validation Rules**:
- ✅ Entry number must be unique within company/period
- ✅ Entry date must be within period range
- ✅ Total debits must equal total credits
- ✅ Each line must have either debit OR credit (not both)
- ✅ All accounts must exist and belong to company
- ✅ At least 2 line items required (debit and credit)

**Backend Processing**:
```typescript
async createJournalEntry(dto: CreateJournalEntryDto, userId: string) {
  // 1. Validate debit/credit balance
  const totalDebits = dto.lineItems.reduce((sum, item) => sum + parseFloat(item.debitAmount), 0);
  const totalCredits = dto.lineItems.reduce((sum, item) => sum + parseFloat(item.creditAmount), 0);
  
  if (totalDebits !== totalCredits) {
    throw new Error('Debits and credits must be equal');
  }
  
  // 2. Verify company and period access
  await verifyCompanyAccess(dto.companyId, userId);
  await verifyPeriodExists(dto.periodId, dto.companyId);
  
  // 3. Check entry number uniqueness
  const existing = await prisma.journalEntry.findFirst({
    where: {
      companyId: dto.companyId,
      periodId: dto.periodId,
      entryNumber: dto.entryNumber
    }
  });
  
  if (existing) {
    throw new Error('Entry number already exists');
  }
  
  // 4. Verify all accounts exist
  for (const line of dto.lineItems) {
    const account = await prisma.accountHead.findFirst({
      where: { id: line.accountId, companyId: dto.companyId }
    });
    
    if (!account) {
      throw new Error(`Account ${line.accountId} not found`);
    }
  }
  
  // 5. Create journal entry with line items
  return await prisma.journalEntry.create({
    data: {
      ...dto,
      journalNumber: `JE-${Date.now()}`,
      status: 'DRAFT',
      createdBy: userId,
      lineItems: {
        create: dto.lineItems.map((item, index) => ({
          ...item,
          lineNumber: index + 1,
          createdBy: userId
        }))
      }
    },
    include: { lineItems: { include: { account: true } } }
  });
}
```

### Step 2: Review and Approval

**Approver Actions**:

1. **View Pending Entries**
   ```http
   GET /api/journal-entries?status=PENDING&companyId=comp_acme
   ```

2. **Review Entry Details**
   - Verify entry date appropriateness
   - Check account selections
   - Validate debit/credit amounts
   - Review supporting documentation
   - Assess adjustment reasonableness

3. **Approval Decision**:

**Option A: Approve**
```http
PATCH /api/journal-entries/:id/approve
{
  "reviewNotes": "Adjustment is reasonable and properly supported. Approved."
}
```

**Option B: Reject**
```http
PATCH /api/journal-entries/:id/reject
{
  "reviewNotes": "Please provide additional support for the amount. Utility invoice not attached."
}
```

### Step 3: Posting to Ledger

**Posting Process**:

Once approved, journal entries can be posted to the general ledger:

```http
POST /api/journal-entries/:id/post
```

**System Actions**:
1. Validates entry is APPROVED status
2. Creates ledger entries for each line item
3. Updates account running balances
4. Updates trial balance
5. Marks entry as POSTED
6. Records posting timestamp and user

**Ledger Entry Creation**:
```typescript
// For each journal line item, create ledger entry
for (const lineItem of journalEntry.lineItems) {
  await prisma.ledger.create({
    data: {
      companyId: journalEntry.companyId,
      periodId: journalEntry.periodId,
      accountId: lineItem.accountId,
      journalEntryId: journalEntry.id,
      lineItemId: lineItem.id,
      tenantId: journalEntry.tenantId,
      transactionDate: journalEntry.entryDate,
      journalNumber: journalEntry.journalNumber,
      description: lineItem.description || journalEntry.description,
      reference: lineItem.reference,
      debitAmount: lineItem.debitAmount,
      creditAmount: lineItem.creditAmount,
      runningBalance: calculateRunningBalance(...),
      sequenceNumber: getNextSequence(...),
      createdBy: userId
    }
  });
  
  // Update trial balance entry
  await updateTrialBalance(lineItem.accountId, lineItem.debitAmount, lineItem.creditAmount);
}
```

**Impact on Financial Statements**:
- Trial balance updated immediately
- Account balances reflect new amounts
- Financial statements regenerate with adjustments
- Comparative analysis includes posted entries

### Step 4: Reversal (if needed)

**When to Reverse**:
- Error discovered after posting
- Need to cancel/correct entry
- Period-end reversal required

**Reversal Process**:
```http
POST /api/journal-entries/:id/reverse
{
  "reversalDate": "2025-01-01",
  "reversalReason": "Reverse December accrual as original invoice was recorded in December"
}
```

**System Actions**:
1. Creates new journal entry with opposite debits/credits
2. Links reversal to original entry
3. Posts reversal automatically (if original was posted)
4. Updates ledger and trial balance
5. Maintains audit trail showing reversal relationship

---

## 🧮 Debit/Credit Validation

### Validation Rules

**Rule 1: Balance Check**
```
Total Debits = Total Credits
```

**Rule 2: Exclusive Debit/Credit**
```
For each line item:
  (debitAmount > 0 AND creditAmount = 0) OR
  (debitAmount = 0 AND creditAmount > 0)
```

**Rule 3: Non-Zero Lines**
```
Each line item must have debitAmount + creditAmount > 0
```

**Rule 4: Precision**
```
All amounts: 2 decimal places (e.g., 100.00, 1250.50)
```

### Validation Examples

**✅ Valid Entry**:
```json
{
  "totalDebit": 1250.00,
  "totalCredit": 1250.00,
  "lineItems": [
    { "accountId": "acc_1", "debitAmount": "1250.00", "creditAmount": "0.00" },
    { "accountId": "acc_2", "debitAmount": "0.00", "creditAmount": "1250.00" }
  ]
}
```

**✅ Valid Multi-Line Entry**:
```json
{
  "totalDebit": 5000.00,
  "totalCredit": 5000.00,
  "lineItems": [
    { "accountId": "acc_1", "debitAmount": "3000.00", "creditAmount": "0.00" },
    { "accountId": "acc_2", "debitAmount": "2000.00", "creditAmount": "0.00" },
    { "accountId": "acc_3", "debitAmount": "0.00", "creditAmount": "5000.00" }
  ]
}
```

**❌ Invalid: Unbalanced**:
```json
{
  "lineItems": [
    { "accountId": "acc_1", "debitAmount": "1000.00", "creditAmount": "0.00" },
    { "accountId": "acc_2", "debitAmount": "0.00", "creditAmount": "500.00" }
  ]
}
// Error: Debits (1000) ≠ Credits (500)
```

**❌ Invalid: Both Debit and Credit**:
```json
{
  "lineItems": [
    { "accountId": "acc_1", "debitAmount": "1000.00", "creditAmount": "500.00" }
  ]
}
// Error: Line item cannot have both debit and credit
```

---

## 📊 API Endpoints

### Create Journal Entry
```http
POST /api/journal-entries
Authorization: Bearer {token}
Content-Type: application/json

{
  "companyId": "comp_acme",
  "periodId": "per_fy2024",
  "entryNumber": "AJE-001",
  "entryDate": "2024-12-31",
  "description": "Accrue December utilities",
  "notes": "Per utility invoice dated 1/5/2025",
  "entryType": "ADJUSTING",
  "referenceNumber": "INV-2024-1234",
  "lineItems": [
    {
      "accountId": "acc_utilities_exp",
      "description": "December utilities expense",
      "debitAmount": "1250.00",
      "creditAmount": "0.00"
    },
    {
      "accountId": "acc_accrued_liab",
      "description": "Accrued liabilities",
      "debitAmount": "0.00",
      "creditAmount": "1250.00"
    }
  ]
}

Response: 201 Created
{
  "id": "je_001",
  "journalNumber": "JE-1704123456789",
  "entryNumber": "AJE-001",
  "companyId": "comp_acme",
  "periodId": "per_fy2024",
  "entryDate": "2024-12-31T00:00:00Z",
  "description": "Accrue December utilities",
  "entryType": "ADJUSTING",
  "status": "DRAFT",
  "totalDebit": "1250.00",
  "totalCredit": "1250.00",
  "isPosted": false,
  "createdBy": "user_123",
  "createdAt": "2025-01-15T10:00:00Z",
  "lineItems": [
    {
      "id": "li_001",
      "lineNumber": 1,
      "accountId": "acc_utilities_exp",
      "description": "December utilities expense",
      "debitAmount": "1250.00",
      "creditAmount": "0.00",
      "account": {
        "id": "acc_utilities_exp",
        "name": "Utilities Expense",
        "code": "6200"
      }
    },
    {
      "id": "li_002",
      "lineNumber": 2,
      "accountId": "acc_accrued_liab",
      "description": "Accrued liabilities",
      "debitAmount": "0.00",
      "creditAmount": "1250.00",
      "account": {
        "id": "acc_accrued_liab",
        "name": "Accrued Liabilities",
        "code": "2400"
      }
    }
  ],
  "company": { "id": "comp_acme", "name": "Acme Corporation" },
  "period": { "id": "per_fy2024", "name": "FY 2024 Audit" }
}
```

### List Journal Entries (with Filters)
```http
GET /api/journal-entries?companyId=comp_acme&periodId=per_fy2024&status=DRAFT&page=1&limit=20
Authorization: Bearer {token}

Response: 200 OK
{
  "data": [
    {
      "id": "je_001",
      "journalNumber": "JE-1704123456789",
      "entryNumber": "AJE-001",
      "entryDate": "2024-12-31T00:00:00Z",
      "description": "Accrue December utilities",
      "status": "DRAFT",
      "totalDebit": "1250.00",
      "totalCredit": "1250.00",
      "isPosted": false,
      "createdAt": "2025-01-15T10:00:00Z",
      "lineItems": [...],
      "company": {...},
      "period": {...}
    }
  ],
  "pagination": {
    "total": 15,
    "page": 1,
    "limit": 20,
    "pages": 1
  },
  "summary": {
    "totalDebits": "25000.00",
    "totalCredits": "25000.00",
    "entryCount": 15
  }
}
```

### Get Single Journal Entry
```http
GET /api/journal-entries/:id
Authorization: Bearer {token}

Response: 200 OK
{
  "id": "je_001",
  "journalNumber": "JE-1704123456789",
  "entryNumber": "AJE-001",
  "companyId": "comp_acme",
  "periodId": "per_fy2024",
  "entryDate": "2024-12-31T00:00:00Z",
  "description": "Accrue December utilities",
  "notes": "Per utility invoice dated 1/5/2025",
  "entryType": "ADJUSTING",
  "referenceNumber": "INV-2024-1234",
  "status": "APPROVED",
  "totalDebit": "1250.00",
  "totalCredit": "1250.00",
  "isPosted": false,
  "reviewNotes": "Adjustment is reasonable. Approved.",
  "reviewedBy": "user_456",
  "reviewedAt": "2025-01-16T14:00:00Z",
  "createdBy": "user_123",
  "createdAt": "2025-01-15T10:00:00Z",
  "updatedAt": "2025-01-16T14:00:00Z",
  "lineItems": [...],
  "company": {...},
  "period": {...},
  "referenceDocument": {...}
}
```

### Update Journal Entry (Draft Only)
```http
PATCH /api/journal-entries/:id
Authorization: Bearer {token}
Content-Type: application/json

{
  "description": "Updated description",
  "notes": "Updated notes"
}

Response: 200 OK
// Updated journal entry object
```

### Submit for Approval
```http
POST /api/journal-entries/:id/submit
Authorization: Bearer {token}

Response: 200 OK
{
  "id": "je_001",
  "status": "PENDING",
  "message": "Journal entry submitted for approval"
}
```

### Approve Journal Entry
```http
POST /api/journal-entries/:id/approve
Authorization: Bearer {token}
Content-Type: application/json

{
  "reviewNotes": "Adjustment is appropriate and well-supported. Approved."
}

Response: 200 OK
{
  "id": "je_001",
  "status": "APPROVED",
  "reviewedBy": "user_456",
  "reviewedAt": "2025-01-16T14:00:00Z",
  "reviewNotes": "Adjustment is appropriate and well-supported. Approved."
}
```

### Reject Journal Entry
```http
POST /api/journal-entries/:id/reject
Authorization: Bearer {token}
Content-Type: application/json

{
  "reviewNotes": "Please provide supporting documentation for the amount."
}

Response: 200 OK
{
  "id": "je_001",
  "status": "REJECTED",
  "reviewedBy": "user_456",
  "reviewedAt": "2025-01-16T14:00:00Z",
  "reviewNotes": "Please provide supporting documentation for the amount."
}
```

### Post to Ledger
```http
POST /api/journal-entries/:id/post
Authorization: Bearer {token}

Response: 200 OK
{
  "id": "je_001",
  "status": "POSTED",
  "isPosted": true,
  "postedBy": "user_456",
  "postedAt": "2025-01-17T09:00:00Z",
  "message": "Journal entry posted to general ledger successfully",
  "ledgerEntriesCreated": 2,
  "trialBalanceUpdated": true
}
```

### Reverse Journal Entry
```http
POST /api/journal-entries/:id/reverse
Authorization: Bearer {token}
Content-Type: application/json

{
  "reversalDate": "2025-01-01",
  "reversalReason": "Reverse December accrual - original invoice recorded"
}

Response: 201 Created
{
  "originalEntry": {
    "id": "je_001",
    "entryNumber": "AJE-001"
  },
  "reversalEntry": {
    "id": "je_002",
    "journalNumber": "JE-1704123500000",
    "entryNumber": "AJE-001-REV",
    "entryDate": "2025-01-01T00:00:00Z",
    "description": "REVERSAL: Accrue December utilities",
    "status": "POSTED",
    "lineItems": [
      // Opposite of original
      { "accountId": "acc_utilities_exp", "debitAmount": "0.00", "creditAmount": "1250.00" },
      { "accountId": "acc_accrued_liab", "debitAmount": "1250.00", "creditAmount": "0.00" }
    ]
  },
  "message": "Journal entry reversed successfully"
}
```

### Delete Journal Entry (Draft Only)
```http
DELETE /api/journal-entries/:id
Authorization: Bearer {token}

Response: 200 OK
{
  "message": "Journal entry deleted successfully"
}
```

---

## 💼 Use Cases

### Use Case 1: Audit Adjustment Entry

**Scenario**: Auditor identifies unrecorded expense

**Steps**:
1. **Identify Issue**: Client failed to record December rent expense ($5,000)

2. **Create Adjustment**:
   - Entry Type: ADJUSTING
   - Entry Number: AJE-015
   - Date: 2024-12-31
   - Description: "Accrue December rent expense"

3. **Enter Line Items**:
   ```
   Dr. Rent Expense              $5,000
       Cr. Accrued Rent Payable          $5,000
   ```

4. **Attach Support**:
   - Lease agreement
   - Payment schedule
   - Landlord invoice

5. **Submit for Approval**: Manager reviews and approves

6. **Post to Ledger**: Entry updates trial balance and financial statements

7. **Impact**:
   - Expenses increased by $5,000
   - Current liabilities increased by $5,000
   - Net income decreased by $5,000

### Use Case 2: Error Correction

**Scenario**: Vendor payment posted to wrong account

**Steps**:
1. **Identify Error**: $10,000 payment to Supplies Expense should be Equipment

2. **Create Correction**:
   - Entry Type: CORRECTING
   - Entry Number: CJE-003
   - Date: 2024-11-15 (original transaction date)
   - Description: "Reclassify payment from supplies to equipment"

3. **Enter Line Items**:
   ```
   Dr. Equipment                 $10,000
       Cr. Supplies Expense              $10,000
   ```

4. **Review and Post**: Manager approves, post to ledger

5. **Result**:
   - Equipment balance increased
   - Supplies expense decreased
   - Net income unaffected (balance sheet reclassification)

### Use Case 3: Period-End Accrual with Reversal

**Scenario**: Accrue payroll at year-end, reverse at start of new year

**December 31, 2024**:
```
Entry Number: AJE-020
Type: ADJUSTING

Dr. Payroll Expense           $15,000
    Cr. Accrued Payroll               $15,000

To record December payroll earned but not yet paid
```

**January 1, 2025**:
```
Entry Number: REV-020
Type: REVERSING

Dr. Accrued Payroll           $15,000
    Cr. Payroll Expense               $15,000

To reverse December payroll accrual
```

**Result**:
- December expense properly recorded
- January reversal clears accrual
- Actual payroll payment in January records correctly

---

## ⚙️ Best Practices

### 1. Entry Numbering

**Recommended Conventions**:
- **AJE-XXX**: Audit Adjusting Entries (AJE-001, AJE-002...)
- **GJE-XXX**: General Journal Entries
- **CJE-XXX**: Correcting Journal Entries
- **RJE-XXX**: Reversing Journal Entries
- **CLO-XXX**: Closing Entries

**Sequential Numbering**: Maintain sequential order within each type

### 2. Clear Descriptions

**❌ Poor Description**:
```
"Adjustment for December"
```

**✅ Good Description**:
```
"Accrue December rent expense per lease agreement dated 1/1/2024. 
Monthly rent $5,000. Payment due 1/5/2025."
```

### 3. Support Documentation

Always attach:
- Source documents (invoices, contracts, statements)
- Calculations or spreadsheets
- Client emails or correspondence
- Supporting workpapers

### 4. Line Item Descriptions

Add line-specific descriptions:
```json
{
  "description": "December rent expense",  // Line-level detail
  "debitAmount": "5000.00"
}
```

### 5. Review Before Submission

Verify:
- ✅ Debits equal credits
- ✅ Accounts are correct
- ✅ Amounts are accurate
- ✅ Description is clear
- ✅ Supporting documents attached
- ✅ Entry date is appropriate

### 6. Approval Workflow

**For Material Adjustments** (> materiality threshold):
- Require manager approval
- Document rationale thoroughly
- Discuss with client before posting
- Obtain client concurrence

**For Immaterial Adjustments**:
- May use streamlined approval
- Still document appropriately

### 7. Posting Timing

- Post adjustments after client review
- Batch-post related entries together
- Post before financial statement generation
- Maintain posting log

---

## ❗ Troubleshooting

### Problem: Entry Won't Save - "Debits and Credits Don't Balance"

**Cause**: Total debits ≠ total credits

**Solution**:
1. Add up all debit amounts
2. Add up all credit amounts
3. Verify they're equal
4. Check for decimal errors (e.g., 1250 vs 1250.00)
5. Ensure no negative amounts

---

### Problem: Cannot Edit Entry

**Cause**: Entry status is not DRAFT

**Solution**:
- PENDING: Request rejection from approver, then edit
- APPROVED: Cannot edit - must reverse and create new entry
- POSTED: Cannot edit - must create reversing entry
- REJECTED: Status should auto-revert to DRAFT for editing

---

### Problem: Account Not Found

**Cause**: Selected account doesn't exist in company's chart of accounts

**Solution**:
1. Verify company selection is correct
2. Check if account exists in Chart of Accounts
3. If account missing, create it first
4. Then return to journal entry

---

### Problem: Entry Number Already Exists

**Cause**: Duplicate entry number for same company/period

**Solution**:
1. Use next sequential number (e.g., AJE-002 instead of AJE-001)
2. Check if previous entry should be deleted
3. Use unique numbering convention

---

### Problem: Cannot Post Entry

**Possible Causes**:
- Status is not APPROVED
- Period is closed
- User lacks posting permission

**Solution**:
1. Check entry status - must be APPROVED
2. Verify period status - must be OPEN
3. Confirm user has posting privileges
4. Contact administrator if needed

---

## 👥 User Roles & Permissions

| Action | Intern | Auditor | Senior | Manager | Admin |
|--------|--------|---------|--------|---------|-------|
| Create entries | ✅ | ✅ | ✅ | ✅ | ✅ |
| Edit DRAFT | ✅ Own | ✅ Own | ✅ All | ✅ All | ✅ All |
| Submit for approval | ✅ | ✅ | ✅ | ✅ | ✅ |
| Approve entries | ❌ | ❌ | ✅ | ✅ | ✅ |
| Reject entries | ❌ | ❌ | ✅ | ✅ | ✅ |
| Post to ledger | ❌ | ❌ | ✅ | ✅ | ✅ |
| Reverse entries | ❌ | ❌ | ✅ | ✅ | ✅ |
| Delete DRAFT | ✅ Own | ✅ Own | ✅ All | ✅ All | ✅ All |
| View all entries | ❌ | ✅ | ✅ | ✅ | ✅ |

---

## 🔐 Security & Audit Trail

### Audit Trail Captured

For each journal entry, system logs:
- Creation: User, timestamp, entry details
- Modifications: Each change with user and timestamp
- Status changes: DRAFT → PENDING → APPROVED → POSTED
- Approval/Rejection: Reviewer, timestamp, notes
- Posting: User, timestamp, ledger entries created
- Reversals: Reason, new entry created, linkage

### Data Validation

- Tenant isolation (multi-tenant security)
- Company access verification
- Period access verification
- Account ownership validation
- Amount precision enforcement
- Status transition rules

### Immutability

- POSTED entries cannot be edited
- Must reverse to correct
- Maintains complete audit trail
- Preserves financial integrity

---

## 📈 Summary

Journal Entries in CloudAudit Pro provide:
- Structured financial adjustment capability
- Rigorous validation and approval workflow
- Seamless integration with trial balance and ledger
- Complete audit trail for compliance
- Error prevention through validation rules
- Role-based access control

**Key Features**:
- Header + line item structure
- Multiple entry types (ADJUSTING, GENERAL, CORRECTING, etc.)
- 5-stage status lifecycle
- Automatic debit/credit validation
- Approval workflow
- General ledger posting
- Reversal capability
- Comprehensive audit trail

---

*For additional support with journal entries, consult your audit manager or system administrator.*
