# CloudAudit Pro - Postman Collection Quick Start Guide

## 🚀 Quick Start (5 Minutes)

### Step 1: Import All Collections

1. Open **Postman**
2. Click **Import** button (top left)
3. Select **Folder** tab
4. Browse to `CloudAudit_Pro/postman-collections`
5. Click **Import** - All 30 collections + environment will be imported

### Step 2: Configure Environment

1. Click the **Environment** dropdown (top right)
2. Select **CloudAudit Pro Environment**
3. Click the **👁 Eye icon** to view variables
4. Click **Edit** and update:
   - `base_url`: Your API URL (default: `http://localhost:8000/api`)
   - `email`: Your test email (will be auto-generated for new users)
   - `password`: Your test password

### Step 3: First Test - Register & Login

1. Open **01 - Authentication** collection
2. Run **Register** request
   - This creates a new user and tenant
   - Token is automatically saved to environment
3. Or run **Login** if you already have an account
   - Token is automatically saved

✅ **You're ready!** All subsequent requests will use this token automatically.

## 📋 Recommended Testing Sequence

For a complete test of the system, run collections in this order:

### Core Setup (Required)
```
1. 01 - Authentication       → Get auth token
2. 02 - Companies            → Create test company
3. 03 - Periods              → Create audit period
4. 04 - Accounts             → Setup chart of accounts
5. 14 - Trial Balance        → Import financial data
```

### Audit Workflow
```
6. 05 - Audit Procedures     → Create audit procedures
7. 06 - Workpapers           → Create workpapers
8. 07 - Findings             → Record audit findings
9. 08 - Journal Entries      → Post adjustments
10. 09 - Financial Statements → Generate reports
```

### Document & Reporting
```
11. 10 - Documents           → Upload documents
12. 11 - Reports             → Generate audit reports
13. 13 - Ledger              → View ledger details
```

### Advanced Features (Optional)
```
14. 15-30                    → Test other modules as needed
```

## 🎯 Common Use Cases

### Use Case 1: Create New Audit Engagement

**Collections to Run:**
1. `01 - Authentication` → Login
2. `02 - Companies` → Create Company
3. `03 - Periods` → Create Period
4. `14 - Trial Balance` → Import Trial Balance
5. `05 - Audit Procedures` → Create Procedures

### Use Case 2: Document Upload & Management

**Collections to Run:**
1. `01 - Authentication` → Login
2. `10 - Documents` → Upload Document
3. `23 - Document Advanced` → Link to Procedure
4. `10 - Documents` → Search Documents

### Use Case 3: Generate Financial Statements

**Collections to Run:**
1. `01 - Authentication` → Login
2. `09 - Financial Statements` → Generate Balance Sheet
3. `09 - Financial Statements` → Generate Income Statement
4. `09 - Financial Statements` → Generate Cash Flow
5. `09 - Financial Statements` → Export to PDF

### Use Case 4: User & Team Management

**Collections to Run:**
1. `01 - Authentication` → Login (as admin)
2. `12 - Users` → Create Invitation
3. `12 - Users` → List Invitations
4. `12 - Users` → List Users
5. `24 - Dashboard & Analytics` → Team Performance

## 🔧 Environment Variables Reference

### Auto-Generated Variables
These are automatically set when you run requests:

| Variable | Set By | Description |
|----------|--------|-------------|
| `auth_token` | Login/Register | JWT authentication token |
| `user_id` | Login/Register | Current user ID |
| `tenant_id` | Login/Register | Current tenant ID |
| `company_id` | Create Company | Last created company ID |
| `period_id` | Create Period | Last created period ID |
| `account_id` | List Accounts | First account ID from list |
| `procedure_id` | Create Procedure | Last created procedure ID |
| `workpaper_id` | Create Workpaper | Last created workpaper ID |
| `finding_id` | Create Finding | Last created finding ID |
| `journal_entry_id` | Create Journal Entry | Last created entry ID |
| `document_id` | Upload Document | Last uploaded document ID |
| `report_id` | Generate Report | Last generated report ID |

### Manual Configuration Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `base_url` | `http://localhost:8000/api` | API base URL |
| `email` | `test@cloudauditpro.com` | User email |
| `password` | `Test@12345` | User password |
| `tenant_subdomain` | `testaudit` | Tenant subdomain |

## 📊 Sample Data Reference

### Sample Company Data
```json
{
  "name": "Acme Corporation",
  "industry": "Technology",
  "taxId": "12-3456789",
  "address": "123 Main Street",
  "city": "San Francisco",
  "country": "USA",
  "fiscalYearEnd": "12-31",
  "currency": "USD"
}
```

### Sample Period Data
```json
{
  "name": "FY2024 Annual Audit",
  "startDate": "2024-01-01",
  "endDate": "2024-12-31",
  "fiscalYear": "2024",
  "periodType": "ANNUAL"
}
```

### Sample Trial Balance Import
```json
{
  "periodId": "{{period_id}}",
  "accounts": [
    {
      "code": "1000",
      "name": "Cash",
      "accountType": "ASSETS",
      "debit": 50000.00,
      "credit": 0
    },
    {
      "code": "2000",
      "name": "Accounts Payable",
      "accountType": "LIABILITIES",
      "debit": 0,
      "credit": 25000.00
    }
  ]
}
```

### Sample Journal Entry
```json
{
  "reference": "AJE-001",
  "periodId": "{{period_id}}",
  "date": "2024-12-31",
  "description": "Audit adjustment",
  "type": "ADJUSTMENT",
  "lines": [
    {
      "accountId": "{{account_id}}",
      "debit": 10000.00,
      "credit": 0,
      "description": "Accrued expenses"
    },
    {
      "accountId": "{{account_id}}",
      "debit": 0,
      "credit": 10000.00,
      "description": "Accounts payable"
    }
  ]
}
```

## 🎨 Collection Features

### Pre-request Scripts
All collections include pre-request scripts that:
- Generate unique timestamps for testing
- Create unique emails and tenant names
- Set dynamic variables

### Test Scripts  
All collections include test scripts that:
- Validate response status codes
- Extract IDs from responses
- Save variables to environment
- Verify response structure

### Example Test Script:
```javascript
// Validate status
pm.test('Status code is 201', function() {
    pm.response.to.have.status(201);
});

// Extract and save ID
const jsonData = pm.response.json();
if (jsonData.id) {
    pm.environment.set('company_id', jsonData.id);
}
```

## 🔄 Running Multiple Collections

### Using Collection Runner

1. Click **Runner** button (top left)
2. Select collections to run
3. Choose environment
4. Set delay between requests (100-500ms recommended)
5. Click **Run CloudAudit Pro**

### Using Newman (CLI)

```bash
# Install Newman
npm install -g newman

# Run single collection
newman run 01-authentication.postman_collection.json \
  -e CloudAuditPro-Environment.postman_environment.json

# Run all collections in sequence
for i in {01..30}; do
  newman run "${i}-*.postman_collection.json" \
    -e CloudAuditPro-Environment.postman_environment.json \
    --delay-request 100
done
```

### Automated Testing Script

Create `run-all-collections.sh`:
```bash
#!/bin/bash
cd postman-collections

# Collections to run in order
collections=(
  "01-authentication"
  "02-companies"
  "03-periods"
  "04-accounts"
  "14-trial-balance"
  "05-audit-procedures"
  "06-workpapers"
  "07-findings"
  "08-journal-entries"
  "09-financial-statements"
)

for collection in "${collections[@]}"; do
  echo "Running $collection..."
  newman run "${collection}.postman_collection.json" \
    -e CloudAuditPro-Environment.postman_environment.json \
    --delay-request 200
done
```

## 🐛 Troubleshooting

### Problem: 401 Unauthorized

**Solution:**
1. Run `01 - Authentication → Login`
2. Check that `auth_token` is set in environment
3. Verify token hasn't expired (24 hour default)

### Problem: 404 Not Found (Company/Period)

**Solution:**
1. Run `02 - Companies → Create Company`
2. Run `03 - Periods → Create Period`
3. Verify `company_id` and `period_id` are set in environment

### Problem: 400 Bad Request

**Solution:**
1. Check request body has all required fields
2. Verify data types (dates, numbers, etc.)
3. Check API documentation in collection description

### Problem: Connection Refused

**Solution:**
1. Verify backend is running: `docker ps`
2. Check `base_url` in environment
3. Test with: `curl http://localhost:8000/api/health`

## 📖 Collection Details

### Module Organization

| # | Module | Endpoints | Description |
|---|--------|-----------|-------------|
| 01 | Authentication | 8 | Login, register, logout, profile |
| 02 | Companies | 8 | Company CRUD operations |
| 03 | Periods | 7 | Fiscal period management |
| 04 | Accounts | 5 | Chart of accounts |
| 05 | Audit Procedures | 5 | Procedure management |
| 06 | Workpapers | 4 | Workpaper operations |
| 07 | Findings | 5 | Audit findings |
| 08 | Journal Entries | 6 | Journal entry posting |
| 09 | Financial Statements | 5 | Statement generation |
| 10 | Documents | 7 | Document management |
| 11 | Reports | 4 | Report generation |
| 12 | Users | 6 | User management |
| 13 | Ledger | 2 | Ledger operations |
| 14 | Trial Balance | 3 | Trial balance import/export |
| 15 | Config | 2 | System configuration |
| 16 | Tenants | 2 | Tenant management |
| 17 | Currency Exchange | 3 | Currency & exchange rates |
| 18 | Bank & Country | 3 | Master data |
| 19 | Financial Schedules | 4 | Asset/liability schedules |
| 20 | Review & QC | 3 | Review points |
| 21 | Audit Finalization | 3 | Finalization process |
| 22 | Advanced Testing | 3 | Sampling & controls |
| 23 | Document Advanced | 3 | Document links & templates |
| 24 | Dashboard & Analytics | 4 | Dashboard data |
| 25 | Reporting Advanced | 3 | Report templates |
| 26 | Notifications | 4 | Notifications & preferences |
| 27 | Data Management | 3 | Import/export |
| 28 | Integrations | 3 | Third-party integrations |
| 29 | Procedure Templates | 3 | Template management |
| 30 | System Config | 5 | System administration |

## 🎓 Best Practices

### 1. Always Start with Authentication
```
01 - Authentication → Login/Register (FIRST)
```

### 2. Create Test Data in Order
```
Company → Period → Accounts → Procedures → Workpapers
```

### 3. Use Environment Variables
```
Don't hardcode IDs - let the test scripts save them automatically
```

### 4. Check Response Status
```
Green = Success (200, 201)
Orange = Redirect (300s)
Red = Error (400s, 500s)
```

### 5. Review Test Results
```
Click "Test Results" tab to see validation results
```

## 💡 Pro Tips

1. **Duplicate Collections**: Make copies for different environments (dev, staging, prod)

2. **Use Folders**: Organize collections into folders by workflow

3. **Monitor Requests**: Use Postman Console (View → Show Postman Console) to debug

4. **Share Collections**: Export and share with team members

5. **Version Control**: Keep collections in Git for tracking changes

6. **Documentation**: Use collection descriptions to document your API

7. **Mock Servers**: Create mock servers from collections for frontend development

## 📞 Support & Resources

- **API Documentation**: `docs/11_API_Reference.md`
- **Test Scripts**: `tests/` folder
- **Backend Code**: `CloudAudit_Pro/backend/src/`
- **Issues**: Check backend logs with `docker logs cloudaudit-backend`

## 🎉 Success!

You now have complete Postman collections for all CloudAudit Pro API endpoints with:

✅ 30 comprehensive collections
✅ 100+ API endpoints covered  
✅ Sample data for all requests
✅ Auto-generated test data
✅ Automatic variable management
✅ Pre-request and test scripts
✅ Full environment configuration

**Happy Testing! 🚀**
