# CloudAudit Pro - Comprehensive API Test Coverage

This document provides a complete mapping of all API endpoints documented in the backend and their corresponding test coverage.

## Test Execution Date
Generated: December 29, 2025

## API Base URL
`http://localhost:3000/api`

---

## Test Coverage Summary

### Module 1: Authentication (01-authentication/)
**Test File:** `01-authentication/auth-tests.sh`

| Method | Endpoint | Status | Test Case |
|--------|----------|--------|-----------|
| POST | /auth/register | ✅ | User registration |
| POST | /auth/login | ✅ | User login |
| POST | /auth/refresh | ✅ | Refresh access token |
| POST | /auth/logout | ✅ | User logout |
| GET | /auth/profile | ✅ | Get user profile |

**Total Endpoints:** 5/5 ✅

---

### Module 2: Tenants (16-tenants/)
**Test File:** `16-tenants/tenants-tests.sh`

| Method | Endpoint | Status | Test Case |
|--------|----------|--------|-----------|
| GET | /tenants/subdomain/:subdomain | ✅ | Get tenant by subdomain |
| GET | /tenants/:id/stats | ✅ | Get tenant statistics |
| PATCH | /tenants/:id/settings | ✅ | Update tenant settings |
| POST | /tenants/:id/suspend | ⚠️ | Suspend tenant (admin only) |
| POST | /tenants/:id/activate | ⚠️ | Activate tenant (admin only) |

**Total Endpoints:** 3/5 ✅ (2 admin endpoints)

---

### Module 3: Companies (02-companies/)
**Test File:** `02-companies/companies-tests.sh`

| Method | Endpoint | Status | Test Case |
|--------|----------|--------|-----------|
| POST | /companies | ✅ | Create new company |
| GET | /companies | ✅ | Get all companies |
| GET | /companies/:id | ✅ | Get company by ID |
| PATCH | /companies/:id | ✅ | Update company |
| DELETE | /companies/:id | ✅ | Delete company |
| GET | /companies/stats | ✅ | Get company statistics |
| GET | /companies/search | ✅ | Search companies |

**Total Endpoints:** 7/7 ✅

---

### Module 4: Periods (03-periods/)
**Test File:** `03-periods/periods-tests.sh`

| Method | Endpoint | Status | Test Case |
|--------|----------|--------|-----------|
| POST | /periods | ✅ | Create new period |
| GET | /periods | ✅ | Get all periods |
| GET | /periods/:id | ✅ | Get period by ID |
| PATCH | /periods/:id | ✅ | Update period |
| DELETE | /periods/:id | ✅ | Delete period |
| GET | /periods/company/:companyId | ✅ | Get periods by company |
| GET | /periods/stats | ✅ | Get period statistics |
| GET | /periods/search | ✅ | Search periods |
| POST | /periods/:id/close | ⚠️ | Close period (needs testing) |
| POST | /periods/:id/reopen | ⚠️ | Reopen period (needs testing) |

**Total Endpoints:** 8/10 ✅

---

### Module 5: Accounts - Chart of Accounts (04-accounts/)
**Test File:** `04-accounts/accounts-tests.sh`

| Method | Endpoint | Status | Test Case |
|--------|----------|--------|-----------|
| POST | /accounts | ✅ | Create account |
| GET | /accounts/period/:periodId | ✅ | Get accounts for period |
| GET | /accounts/:id | ✅ | Get account by ID |
| PATCH | /accounts/:id | ✅ | Update account |
| DELETE | /accounts/:id | ✅ | Delete account |
| GET | /accounts/chart/:periodId | ✅ | Get chart of accounts |
| GET | /accounts/trial-balance/:periodId | ✅ | Get trial balance |
| POST | /accounts/import/:periodId | ✅ | Import chart of accounts |
| GET | /accounts/stats | ✅ | Get account statistics |

**Total Endpoints:** 9/9 ✅

---

### Module 6: Audit Procedures (05-audit-procedures/)
**Test File:** `05-audit-procedures/audit-procedures-tests.sh`

| Method | Endpoint | Status | Test Case |
|--------|----------|--------|-----------|
| POST | /procedures | ✅ | Create audit procedure |
| GET | /procedures | ✅ | Get audit procedures |
| GET | /procedures/:id | ✅ | Get audit procedure |
| PATCH | /procedures/:id | ✅ | Update audit procedure |
| DELETE | /procedures/:id | ✅ | Delete audit procedure |
| POST | /procedures/:id/start | ✅ | Start procedure |
| POST | /procedures/:id/complete | ✅ | Complete procedure |
| POST | /procedures/:id/hold | ✅ | Put on hold |
| POST | /procedures/:id/review | ✅ | Review procedure |
| POST | /procedures/bulk-assign | ✅ | Bulk assign procedures |
| GET | /procedures/statistics | ✅ | Get statistics |
| GET | /procedures/templates | ✅ | Get templates |
| GET | /procedures/company/:companyId/workload | ⚠️ | Get workload distribution |
| GET | /procedures/dashboard/:companyId | ⚠️ | Get dashboard data |
| GET | /procedures/:id/comments | ⚠️ | Get comments |
| POST | /procedures/:id/comments | ⚠️ | Add comment |

**Total Endpoints:** 12/16 ✅

---

### Module 7: Workpapers (06-workpapers/)
**Test File:** `06-workpapers/workpapers-tests.sh`

| Method | Endpoint | Status | Test Case |
|--------|----------|--------|-----------|
| POST | /workpapers | ✅ | Create workpaper |
| GET | /workpapers | ✅ | Get all workpapers |
| GET | /workpapers/:id | ✅ | Get workpaper |
| PUT | /workpapers/:id | ✅ | Update workpaper |
| DELETE | /workpapers/:id | ✅ | Delete workpaper |
| POST | /workpapers/:id/review | ✅ | Review workpaper |

**Total Endpoints:** 6/6 ✅

---

### Module 8: Findings (07-findings/)
**Test File:** `07-findings/findings-tests.sh`

| Method | Endpoint | Status | Test Case |
|--------|----------|--------|-----------|
| POST | /findings | ✅ | Create finding |
| GET | /findings | ✅ | Get all findings |
| GET | /findings/:id | ✅ | Get finding |
| PUT | /findings/:id | ✅ | Update finding |
| DELETE | /findings/:id | ✅ | Delete finding |
| GET | /findings/statistics | ✅ | Get statistics |
| POST | /findings/:id/resolve | ✅ | Resolve finding |

**Total Endpoints:** 7/7 ✅

---

### Module 9: Journal Entries (08-journal-entries/)
**Test File:** `08-journal-entries/journal-entries-tests.sh`

| Method | Endpoint | Status | Test Case |
|--------|----------|--------|-----------|
| POST | /journal-entries | ✅ | Create journal entry |
| GET | /journal-entries | ✅ | Get all entries |
| GET | /journal-entries/:id | ✅ | Get entry by ID |
| PUT | /journal-entries/:id | ✅ | Update entry |
| DELETE | /journal-entries/:id | ✅ | Delete entry |
| GET | /journal-entries/statistics | ✅ | Get statistics |
| PUT | /journal-entries/:id/submit | ✅ | Submit for review |
| PUT | /journal-entries/:id/review | ✅ | Review entry |
| PUT | /journal-entries/:id/post | ✅ | Post to ledger |

**Total Endpoints:** 9/9 ✅

---

### Module 10: Ledger (13-ledger/)
**Test File:** `13-ledger/ledger-tests.sh`

| Method | Endpoint | Status | Test Case |
|--------|----------|--------|-----------|
| GET | /ledger | ✅ | Get ledger entries |
| POST | /ledger/generate | ✅ | Generate ledger entries |
| POST | /ledger/recalculate | ✅ | Recalculate balances |
| GET | /ledger/export | ✅ | Export ledger |

**Total Endpoints:** 4/4 ✅

---

### Module 11: Trial Balance (14-trial-balance/)
**Test File:** `14-trial-balance/trial-balance-tests.sh`

| Method | Endpoint | Status | Test Case |
|--------|----------|--------|-----------|
| POST | /trial-balance/generate | ✅ | Generate trial balance |
| GET | /trial-balance | ✅ | Get all reports |
| GET | /trial-balance/:id | ✅ | Get report by ID |
| POST | /trial-balance/validate | ✅ | Validate trial balance |
| POST | /trial-balance/:id/export | ✅ | Export trial balance |
| GET | /trial-balance/company/:companyId/quick-balance | ✅ | Get quick balance |
| GET | /trial-balance/company/:companyId/balance-trends | ✅ | Get balance trends |

**Total Endpoints:** 7/7 ✅

---

### Module 12: Financial Statements (09-financial-statements/)
**Test File:** `09-financial-statements/financial-statements-tests.sh`

| Method | Endpoint | Status | Test Case |
|--------|----------|--------|-----------|
| POST | /financial-statements/generate | ✅ | Generate statement |
| POST | /financial-statements | ✅ | Create statement |
| GET | /financial-statements | ✅ | Get all statements |
| GET | /financial-statements/:id | ✅ | Get statement |
| PATCH | /financial-statements/:id | ✅ | Update statement |
| DELETE | /financial-statements/:id | ✅ | Delete statement |
| GET | /financial-statements/comparative | ✅ | Get comparative statements |
| POST | /financial-statements/:id/approve | ✅ | Approve statement |
| POST | /financial-statements/:id/issue | ✅ | Issue statement |
| POST | /financial-statements/:id/notes | ✅ | Add notes |
| POST | /financial-statements/:id/export | ✅ | Export statement |
| GET | /financial-statements/company/:companyId/income-statement | ✅ | Quick income statement |
| GET | /financial-statements/company/:companyId/balance-sheet | ✅ | Quick balance sheet |
| GET | /financial-statements/company/:companyId/cash-flow | ✅ | Cash flow statement |
| GET | /financial-statements/company/:companyId/dashboard | ✅ | Financial dashboard |

**Total Endpoints:** 15/15 ✅

---

### Module 13: Documents (10-documents/)
**Test File:** `10-documents/documents-tests.sh`

| Method | Endpoint | Status | Test Case |
|--------|----------|--------|-----------|
| POST | /documents | ✅ | Create document |
| GET | /documents | ✅ | Get all documents |
| GET | /documents/:id | ✅ | Get document |
| PATCH | /documents/:id | ✅ | Update document |
| DELETE | /documents/:id | ✅ | Delete document |
| GET | /documents/statistics | ✅ | Get statistics |
| GET | /documents/:id/download | ✅ | Download document |
| GET | /documents/:id/versions | ✅ | Get versions |
| POST | /documents/:id/versions | ✅ | Create version |
| POST | /documents/:id/checkout | ✅ | Checkout document |
| POST | /documents/:id/checkin | ✅ | Checkin document |
| POST | /documents/:id/unlock | ✅ | Force unlock |
| POST | /documents/:id/duplicate | ✅ | Duplicate document |
| POST | /documents/:id/archive | ✅ | Archive document |
| GET | /documents/search | ✅ | Advanced search |
| GET | /documents/recent | ✅ | Get recent documents |

**Total Endpoints:** 16/16 ✅

---

### Module 14: Document Advanced (23-document-advanced/)
**Test File:** `23-document-advanced/document-advanced-tests.sh`

| Method | Endpoint | Status | Test Case |
|--------|----------|--------|-----------|
| POST | /document-links | ✅ | Create document link |
| GET | /document-links | ✅ | Get all links |
| GET | /document-links/:id | ✅ | Get link |
| PATCH | /document-links/:id | ✅ | Update link |
| DELETE | /document-links/:id | ✅ | Delete link |
| POST | /document-links/bulk | ✅ | Create bulk links |
| GET | /document-links/document/:documentId | ✅ | Get links for document |
| GET | /document-links/entity/:entityType/:entityId | ✅ | Get links for entity |
| POST | /document-templates | ✅ | Create template |
| GET | /document-templates | ✅ | Get all templates |
| GET | /document-templates/:id | ✅ | Get template |
| PATCH | /document-templates/:id | ✅ | Update template |
| DELETE | /document-templates/:id | ✅ | Delete template |
| GET | /document-templates/category/:category | ✅ | Get templates by category |
| POST | /document-templates/:id/activate | ✅ | Toggle active status |
| POST | /document-templates/:id/generate | ✅ | Generate document |
| POST | /document-collections | ✅ | Create collection |
| GET | /document-collections | ✅ | Get all collections |
| GET | /document-collections/:id | ✅ | Get collection |
| PATCH | /document-collections/:id | ✅ | Update collection |
| DELETE | /document-collections/:id | ✅ | Delete collection |
| POST | /document-collections/:id/status | ✅ | Update status |
| GET | /document-collections/:id/progress | ✅ | Get progress |
| POST | /document-collections/:id/items | ✅ | Add item |
| PATCH | /document-collections/items/:itemId | ✅ | Update item |
| DELETE | /document-collections/items/:itemId | ✅ | Remove item |
| POST | /document-collections/items/:itemId/upload | ✅ | Upload for item |

**Total Endpoints:** 27/27 ✅

---

### Module 15: Reports (11-reports/)
**Test File:** `11-reports/reports-tests.sh`

| Method | Endpoint | Status | Test Case |
|--------|----------|--------|-----------|
| POST | /reports | ✅ | Create report template |
| GET | /reports | ✅ | Get report templates |
| GET | /reports/:id | ✅ | Get report template |
| PATCH | /reports/:id | ✅ | Update report template |
| DELETE | /reports/:id | ✅ | Delete report template |
| GET | /reports/statistics | ✅ | Get statistics |
| GET | /reports/templates | ✅ | Get templates |
| POST | /reports/generate | ✅ | Generate adhoc report |
| POST | /reports/bulk-generate | ✅ | Generate bulk reports |
| POST | /reports/:id/execute | ✅ | Execute report |
| GET | /reports/financial/:companyId/:periodId/balance-sheet | ✅ | Balance sheet |
| GET | /reports/financial/:companyId/:periodId/income-statement | ✅ | Income statement |
| GET | /reports/financial/:companyId/:periodId/cash-flow | ✅ | Cash flow |
| GET | /reports/audit/:companyId/:periodId/summary | ✅ | Audit summary |
| GET | /reports/dashboard/:companyId | ✅ | Dashboard data |

**Total Endpoints:** 15/15 ✅

---

### Module 16: Reporting Advanced (25-reporting-advanced/)
**Test File:** `25-reporting-advanced/reporting-advanced-tests.sh`

| Method | Endpoint | Status | Test Case |
|--------|----------|--------|-----------|
| POST | /report-templates | ✅ | Create template |
| GET | /report-templates | ✅ | Get all templates |
| GET | /report-templates/:id | ✅ | Get template |
| PATCH | /report-templates/:id | ✅ | Update template |
| DELETE | /report-templates/:id | ✅ | Delete template |
| GET | /report-templates/standard | ✅ | Get standard templates |
| GET | /report-templates/by-type/:type | ✅ | Get by type |
| POST | /report-templates/:id/duplicate | ✅ | Duplicate template |
| POST | /report-templates/:id/toggle-active | ✅ | Toggle active |
| POST | /report-schedules | ✅ | Create schedule |
| GET | /report-schedules | ✅ | Get all schedules |
| GET | /report-schedules/:id | ✅ | Get schedule |
| PATCH | /report-schedules/:id | ✅ | Update schedule |
| DELETE | /report-schedules/:id | ✅ | Delete schedule |
| GET | /report-schedules/upcoming | ✅ | Get upcoming |
| GET | /report-schedules/history | ✅ | Get history |
| POST | /report-schedules/:id/run-now | ✅ | Run now |
| POST | /report-schedules/:id/toggle-active | ✅ | Toggle active |

**Total Endpoints:** 18/18 ✅

---

### Module 17: Users (12-users/)
**Test File:** `12-users/users-tests.sh`

| Method | Endpoint | Status | Test Case |
|--------|----------|--------|-----------|
| POST | /users | ✅ | Create user |
| GET | /users | ✅ | Get all users |
| GET | /users/:id | ✅ | Get user |
| PATCH | /users/:id | ✅ | Update user |
| DELETE | /users/:id | ✅ | Deactivate user |
| GET | /users/me | ✅ | Get current user |
| GET | /users/stats | ✅ | Get statistics |
| GET | /users/search | ✅ | Search users |
| PATCH | /users/:id/password | ✅ | Update password |

**Total Endpoints:** 9/9 ✅

---

### Module 18: User Management (12-users/ - Extended)
**Test File:** Part of `12-users/users-tests.sh`

| Method | Endpoint | Status | Test Case |
|--------|----------|--------|-----------|
| POST | /user-management/invite | ⚠️ | Invite user |
| GET | /user-management/users | ⚠️ | Get all users |
| GET | /user-management/users/pending | ⚠️ | Get pending approvals |
| GET | /user-management/users/stats | ⚠️ | Get statistics |
| PATCH | /user-management/users/:userId/approve | ⚠️ | Approve/reject user |
| PUT | /user-management/users/:userId | ⚠️ | Update user |
| PATCH | /user-management/users/:userId/reset-password | ⚠️ | Reset password |
| PATCH | /user-management/users/:userId/activate | ⚠️ | Activate user |
| PATCH | /user-management/users/:userId/deactivate | ⚠️ | Deactivate user |
| POST | /user-management/users/bulk-action | ⚠️ | Bulk actions |
| GET | /user-management/roles | ⚠️ | Get roles |
| GET | /user-management/permissions/:role | ⚠️ | Get permissions |

**Total Endpoints:** 0/12 ⚠️ (Needs dedicated test module)

---

### Module 19: Currency & Exchange Rates (17-currency-exchange/)
**Test File:** `17-currency-exchange/currency-exchange-tests.sh`

| Method | Endpoint | Status | Test Case |
|--------|----------|--------|-----------|
| POST | /currencies | ✅ | Create currency |
| GET | /currencies | ✅ | Get all currencies |
| GET | /currencies/:id | ✅ | Get currency |
| PATCH | /currencies/:id | ✅ | Update currency |
| DELETE | /currencies/:id | ✅ | Delete currency |
| GET | /currencies/base | ✅ | Get base currency |
| GET | /currencies/code/:code | ✅ | Get by code |
| PATCH | /currencies/:id/status | ✅ | Update status |
| POST | /exchange-rates | ✅ | Create exchange rate |
| GET | /exchange-rates | ✅ | Get all rates |
| GET | /exchange-rates/:id | ✅ | Get rate |
| PATCH | /exchange-rates/:id | ✅ | Update rate |
| DELETE | /exchange-rates/:id | ✅ | Delete rate |
| GET | /exchange-rates/latest | ✅ | Get latest rate |
| GET | /exchange-rates/convert | ✅ | Convert currency |

**Total Endpoints:** 15/15 ✅

---

### Module 20: Bank & Country (18-bank-country/)
**Test File:** `18-bank-country/bank-country-tests.sh`

| Method | Endpoint | Status | Test Case |
|--------|----------|--------|-----------|
| POST | /bank | ✅ | Create bank |
| GET | /bank | ✅ | Get all banks |
| GET | /bank/:id | ✅ | Get bank |
| PATCH | /bank/:id | ✅ | Update bank |
| DELETE | /bank/:id | ✅ | Delete bank |
| POST | /bank/account | ✅ | Create bank account |
| GET | /bank/account | ✅ | Get all accounts |
| GET | /bank/account/:id | ✅ | Get account |
| PATCH | /bank/account/:id | ✅ | Update account |
| DELETE | /bank/account/:id | ✅ | Delete account |
| POST | /country | ✅ | Create country |
| GET | /country | ✅ | Get all countries |
| GET | /country/:id | ✅ | Get country |
| PATCH | /country/:id | ✅ | Update country |
| DELETE | /country/:id | ✅ | Delete country |
| GET | /country/code/:code | ✅ | Get by code |
| GET | /country/seed | ✅ | Seed countries |

**Total Endpoints:** 17/17 ✅

---

### Module 21: Financial Schedules (19-financial-schedules/)
**Test File:** `19-financial-schedules/financial-schedules-tests.sh`

| Method | Endpoint | Status | Test Case |
|--------|----------|--------|-----------|
| POST | /fixed-assets | ✅ | Create fixed asset |
| GET | /fixed-assets | ✅ | Get all assets |
| GET | /fixed-assets/:id | ✅ | Get asset |
| PATCH | /fixed-assets/:id | ✅ | Update asset |
| DELETE | /fixed-assets/:id | ✅ | Delete asset |
| GET | /fixed-assets/summary | ✅ | Get summary |
| POST | /liabilities | ✅ | Create liability |
| GET | /liabilities | ✅ | Get all liabilities |
| GET | /liabilities/:id | ✅ | Get liability |
| PATCH | /liabilities/:id | ✅ | Update liability |
| DELETE | /liabilities/:id | ✅ | Delete liability |
| GET | /liabilities/aging-summary | ✅ | Aging summary |
| POST | /equity | ✅ | Create equity |
| GET | /equity | ✅ | Get all equity |
| GET | /equity/:id | ✅ | Get equity |
| PATCH | /equity/:id | ✅ | Update equity |
| DELETE | /equity/:id | ✅ | Delete equity |
| GET | /equity/summary | ✅ | Get summary |

**Total Endpoints:** 18/18 ✅

---

### Module 22: Review & QC (20-review-qc/)
**Test File:** `20-review-qc/review-qc-tests.sh`

| Method | Endpoint | Status | Test Case |
|--------|----------|--------|-----------|
| POST | /review-points | ✅ | Create review point |
| GET | /review-points | ✅ | Get all review points |
| GET | /review-points/:id | ✅ | Get review point |
| PATCH | /review-points/:id | ✅ | Update review point |
| DELETE | /review-points/:id | ✅ | Delete review point |
| GET | /review-points/summary | ✅ | Get summary |
| POST | /review-points/:id/clear | ✅ | Clear review point |
| POST | /manager-reviews | ✅ | Create manager review |
| GET | /manager-reviews | ✅ | Get all reviews |
| GET | /manager-reviews/:id | ✅ | Get review |
| PATCH | /manager-reviews/:id | ✅ | Update review |
| DELETE | /manager-reviews/:id | ✅ | Delete review |
| GET | /manager-reviews/summary | ✅ | Get summary |
| POST | /manager-reviews/:id/approve | ✅ | Approve review |
| POST | /manager-reviews/:id/reject | ✅ | Reject review |

**Total Endpoints:** 15/15 ✅

---

### Module 23: Audit Finalization (21-audit-finalization/)
**Test File:** `21-audit-finalization/audit-finalization-tests.sh`

| Method | Endpoint | Status | Test Case |
|--------|----------|--------|-----------|
| POST | /audit-finalization | ✅ | Create finalization |
| GET | /audit-finalization | ✅ | Get all finalizations |
| GET | /audit-finalization/:id | ✅ | Get finalization |
| PATCH | /audit-finalization/:id | ✅ | Update finalization |
| DELETE | /audit-finalization/:id | ✅ | Delete finalization |
| GET | /audit-finalization/summary | ✅ | Get summary |
| GET | /audit-finalization/by-company-period | ✅ | Get by company/period |
| POST | /audit-finalization/:id/finalize | ✅ | Finalize audit |
| POST | /audit-finalization/:id/issue | ✅ | Issue audit report |

**Total Endpoints:** 9/9 ✅

---

### Module 24: Advanced Testing (22-advanced-testing/)
**Test File:** `22-advanced-testing/advanced-testing-tests.sh`

| Method | Endpoint | Status | Test Case |
|--------|----------|--------|-----------|
| POST | /sampling | ✅ | Create sampling plan |
| GET | /sampling | ✅ | Get all plans |
| GET | /sampling/:id | ✅ | Get plan |
| PATCH | /sampling/:id | ✅ | Update plan |
| DELETE | /sampling/:id | ✅ | Delete plan |
| GET | /sampling/summary | ✅ | Get summary |
| GET | /sampling/calculate-sample-size | ✅ | Calculate sample size |
| POST | /sampling/:id/generate-sample | ✅ | Generate sample |
| POST | /substantive-testing | ✅ | Create test |
| GET | /substantive-testing | ✅ | Get all tests |
| GET | /substantive-testing/:id | ✅ | Get test |
| PATCH | /substantive-testing/:id | ✅ | Update test |
| DELETE | /substantive-testing/:id | ✅ | Delete test |
| GET | /substantive-testing/summary | ✅ | Get summary |
| POST | /substantive-testing/:id/complete | ✅ | Complete test |
| POST | /substantive-testing/:id/review | ✅ | Review test |
| POST | /internal-controls | ✅ | Create control |
| GET | /internal-controls | ✅ | Get all controls |
| GET | /internal-controls/:id | ✅ | Get control |
| PATCH | /internal-controls/:id | ✅ | Update control |
| DELETE | /internal-controls/:id | ✅ | Delete control |
| GET | /internal-controls/summary | ✅ | Get summary |
| POST | /internal-controls/:id/test | ✅ | Test control |
| POST | /internal-controls/:id/deficiency | ✅ | Identify deficiency |
| POST | /internal-controls/:id/review | ✅ | Review control |

**Total Endpoints:** 25/25 ✅

---

### Module 25: Dashboard & Analytics (24-dashboard-analytics/)
**Test File:** `24-dashboard-analytics/dashboard-analytics-tests.sh`

| Method | Endpoint | Status | Test Case |
|--------|----------|--------|-----------|
| GET | /dashboard/executive | ✅ | Executive dashboard |
| GET | /dashboard/financial | ✅ | Financial dashboard |
| GET | /dashboard/audit | ✅ | Audit dashboard |
| GET | /dashboard/operational | ✅ | Operational dashboard |
| POST | /dashboard/custom | ✅ | Custom dashboard |
| GET | /dashboard/realtime | ✅ | Realtime metrics |
| GET | /dashboard/company/:companyId/financial | ✅ | Company financial |
| GET | /dashboard/company/:companyId/audit | ✅ | Company audit |
| GET | /dashboard/kpis/:companyId | ✅ | Company KPIs |
| GET | /dashboard/alerts | ✅ | Get alerts |
| POST | /dashboard/alerts | ✅ | Create alert |
| PATCH | /dashboard/alerts/:id/acknowledge | ✅ | Acknowledge alert |
| GET | /dashboard/trends/:companyId | ✅ | Trend analysis |
| GET | /dashboard/performance/:companyId | ✅ | Performance metrics |
| GET | /dashboard/analytics/:companyId/summary | ✅ | Analytics summary |
| GET | /dashboard/health | ✅ | System health |
| POST | /dashboards | ✅ | Create dashboard |
| GET | /dashboards | ✅ | Get all dashboards |
| GET | /dashboards/:id | ✅ | Get dashboard |
| PATCH | /dashboards/:id | ✅ | Update dashboard |
| DELETE | /dashboards/:id | ✅ | Delete dashboard |
| GET | /dashboards/default | ✅ | Get default |
| POST | /dashboards/:id/duplicate | ✅ | Duplicate |
| POST | /dashboards/:id/set-default | ✅ | Set default |
| POST | /dashboards/:id/share | ✅ | Share |
| POST | /dashboards/:id/unshare | ✅ | Unshare |
| POST | /dashboards/widget-data | ✅ | Get widget data |
| GET | /analytics/overview | ✅ | Analytics overview |
| POST | /analytics/query | ✅ | Custom query |
| GET | /analytics/financial-ratios | ✅ | Financial ratios |
| GET | /analytics/trends/:metric | ✅ | Metric trends |
| GET | /analytics/variance | ✅ | Variance analysis |
| GET | /analytics/aging | ✅ | Aging analysis |
| GET | /analytics/materiality | ✅ | Materiality |
| POST | /analytics/snapshots | ✅ | Create snapshot |
| GET | /analytics/snapshots | ✅ | Get snapshots |

**Total Endpoints:** 36/36 ✅

---

### Module 26: Notifications & Preferences (26-notifications-preferences/)
**Test File:** `26-notifications-preferences/notifications-preferences-tests.sh`

| Method | Endpoint | Status | Test Case |
|--------|----------|--------|-----------|
| POST | /notifications | ✅ | Create notification |
| GET | /notifications | ✅ | Get all notifications |
| GET | /notifications/:id | ✅ | Get notification |
| DELETE | /notifications/:id | ✅ | Delete notification |
| GET | /notifications/unread-count | ✅ | Get unread count |
| POST | /notifications/mark-all-read | ✅ | Mark all read |
| POST | /notifications/clear-read | ✅ | Clear read |
| POST | /notifications/bulk-send | ✅ | Bulk send |
| PATCH | /notifications/:id/read | ✅ | Mark as read |
| PATCH | /notifications/:id/dismiss | ✅ | Dismiss |
| GET | /notifications/templates | ✅ | Get templates |
| POST | /notifications/templates | ✅ | Create template |
| GET | /notifications/templates/:key | ✅ | Get template |
| PATCH | /notifications/templates/:key | ✅ | Update template |
| DELETE | /notifications/templates/:key | ✅ | Delete template |
| POST | /notifications/templates/:key/send | ✅ | Send from template |
| GET | /user-preferences | ✅ | Get all preferences |
| POST | /user-preferences | ✅ | Set preference |
| GET | /user-preferences/:key | ✅ | Get preference |
| PATCH | /user-preferences/:key | ✅ | Update preference |
| DELETE | /user-preferences/:key | ✅ | Delete preference |
| POST | /user-preferences/bulk | ✅ | Bulk set |
| GET | /user-preferences/category/:category | ✅ | Get by category |
| GET | /user-preferences/export | ✅ | Export |
| POST | /user-preferences/import | ✅ | Import |
| POST | /user-preferences/reset | ✅ | Reset |
| DELETE | /user-preferences/all | ✅ | Delete all |

**Total Endpoints:** 27/27 ✅

---

### Module 27: Data Management (27-data-management/)
**Test File:** `27-data-management/data-management-tests.sh`

| Method | Endpoint | Status | Test Case |
|--------|----------|--------|-----------|
| POST | /data-import | ✅ | Upload import file |
| GET | /data-import | ✅ | Get all imports |
| GET | /data-import/:id | ✅ | Get import |
| PATCH | /data-import/:id | ✅ | Update import |
| DELETE | /data-import/:id | ✅ | Delete import |
| GET | /data-import/summary | ✅ | Get summary |
| GET | /data-import/templates/:type | ✅ | Get template |
| POST | /data-import/:id/validate | ✅ | Validate |
| POST | /data-import/:id/process | ✅ | Process |
| POST | /data-import/:id/rollback | ✅ | Rollback |
| GET | /data-import/:id/errors | ✅ | Get errors |
| GET | /data-import/:id/download-errors | ✅ | Download errors |
| POST | /data-export | ✅ | Create export |
| GET | /data-export | ✅ | Get all exports |
| GET | /data-export/:id | ✅ | Get export |
| PATCH | /data-export/:id | ✅ | Update export |
| DELETE | /data-export/:id | ✅ | Delete export |
| GET | /data-export/summary | ✅ | Get summary |
| GET | /data-export/types | ✅ | Get types |
| POST | /data-export/:id/process | ✅ | Process |
| GET | /data-export/:id/download | ✅ | Download |
| POST | /data-export/quick | ✅ | Quick export |
| POST | /data-export/schedule | ✅ | Schedule export |

**Total Endpoints:** 23/23 ✅

---

### Module 28: Integrations (28-integrations/)
**Test File:** `28-integrations/integrations-tests.sh`

| Method | Endpoint | Status | Test Case |
|--------|----------|--------|-----------|
| POST | /integrations | ✅ | Create integration |
| GET | /integrations | ✅ | Get all integrations |
| GET | /integrations/:id | ✅ | Get integration |
| PATCH | /integrations/:id | ✅ | Update integration |
| DELETE | /integrations/:id | ✅ | Delete integration |
| GET | /integrations/active | ✅ | Get active |
| POST | /integrations/:id/test | ✅ | Test connection |
| POST | /integrations/:id/sync | ✅ | Sync |
| POST | /integrations/:id/enable | ✅ | Enable |
| POST | /integrations/:id/disable | ✅ | Disable |
| GET | /integrations/:id/logs | ✅ | Get logs |
| GET | /integrations/:id/stats | ✅ | Get statistics |

**Total Endpoints:** 12/12 ✅

---

### Module 29: Procedure Templates (29-procedure-templates/)
**Test File:** `29-procedure-templates/procedure-templates-tests.sh`

| Method | Endpoint | Status | Test Case |
|--------|----------|--------|-----------|
| POST | /procedure-templates | ✅ | Create template |
| GET | /procedure-templates | ✅ | Get all templates |
| GET | /procedure-templates/:id | ✅ | Get template |
| PUT | /procedure-templates/:id | ✅ | Update template |
| DELETE | /procedure-templates/:id | ✅ | Delete template |
| GET | /procedure-templates/statistics | ✅ | Get statistics |

**Total Endpoints:** 6/6 ✅

---

### Module 30: System Configuration (30-system-config/)
**Test File:** `30-system-config/system-config-tests.sh`

| Method | Endpoint | Status | Test Case |
|--------|----------|--------|-----------|
| POST | /system-config | ✅ | Create config |
| GET | /system-config | ✅ | Get all configs |
| GET | /system-config/:key | ✅ | Get config |
| PATCH | /system-config/:key | ✅ | Update config |
| DELETE | /system-config/:key | ✅ | Delete config |
| GET | /system-config/category/:category | ✅ | Get by category |
| GET | /system-config/export | ✅ | Export |
| POST | /system-config/import | ✅ | Import |
| POST | /system-config/bulk-update | ✅ | Bulk update |
| POST | /system-config/reset | ✅ | Reset |
| POST | /config | ✅ | Create configuration |
| GET | /config | ✅ | Get configurations |
| GET | /config/templates | ✅ | Get templates |
| GET | /config/system | ✅ | System config |
| GET | /config/security | ✅ | Security config |
| GET | /config/audit | ✅ | Audit config |
| GET | /config/financial | ✅ | Financial config |
| GET | /config/reporting | ✅ | Reporting config |
| GET | /config/notifications | ✅ | Notification config |
| GET | /config/integrations | ✅ | Integration config |
| GET | /config/appearance | ✅ | Appearance config |
| GET | /config/health | ✅ | System health |
| GET | /config/export | ✅ | Export |
| GET | /config/type/:type | ✅ | Get by type |
| GET | /config/company/:companyId/audit | ✅ | Company audit config |

**Total Endpoints:** 25/25 ✅

---

## Overall Test Coverage Summary

| Category | Total Endpoints | Tested | Coverage |
|----------|----------------|--------|----------|
| Authentication | 5 | 5 | 100% |
| Tenants | 5 | 3 | 60% |
| Companies | 7 | 7 | 100% |
| Periods | 10 | 8 | 80% |
| Accounts | 9 | 9 | 100% |
| Audit Procedures | 16 | 12 | 75% |
| Workpapers | 6 | 6 | 100% |
| Findings | 7 | 7 | 100% |
| Journal Entries | 9 | 9 | 100% |
| Ledger | 4 | 4 | 100% |
| Trial Balance | 7 | 7 | 100% |
| Financial Statements | 15 | 15 | 100% |
| Documents | 16 | 16 | 100% |
| Document Advanced | 27 | 27 | 100% |
| Reports | 15 | 15 | 100% |
| Reporting Advanced | 18 | 18 | 100% |
| Users | 9 | 9 | 100% |
| User Management | 12 | 0 | 0% |
| Currency & Exchange | 15 | 15 | 100% |
| Bank & Country | 17 | 17 | 100% |
| Financial Schedules | 18 | 18 | 100% |
| Review & QC | 15 | 15 | 100% |
| Audit Finalization | 9 | 9 | 100% |
| Advanced Testing | 25 | 25 | 100% |
| Dashboard & Analytics | 36 | 36 | 100% |
| Notifications | 27 | 27 | 100% |
| Data Management | 23 | 23 | 100% |
| Integrations | 12 | 12 | 100% |
| Procedure Templates | 6 | 6 | 100% |
| System Configuration | 25 | 25 | 100% |
| **TOTAL** | **423** | **405** | **95.7%** |

---

## Running the Tests

### Prerequisites
1. Backend must be running: `docker-compose up -d backend`
2. Database must be initialized and migrated
3. API should be accessible at `http://localhost:3000/api`

### Run All Tests
```bash
cd CloudAudit_Pro/tests
bash run-all-tests.sh
```

### Run Individual Module
```bash
cd CloudAudit_Pro/tests/01-authentication
bash auth-tests.sh
```

### Run Specific Test Groups
```bash
# Run all document-related tests
cd CloudAudit_Pro/tests
bash 10-documents/documents-tests.sh
bash 23-document-advanced/document-advanced-tests.sh

# Run all financial tests
bash 09-financial-statements/financial-statements-tests.sh
bash 19-financial-schedules/financial-schedules-tests.sh
```

---

## Test Results Location
- Master results: `tests/results/test-results-master.txt`
- Detailed JSON: `tests/results/test-results-detailed.json`

---

## Notes
- ✅ = Fully tested with comprehensive coverage
- ⚠️ = Partial coverage or needs additional testing
- ❌ = Not yet tested

## Recommendations
1. **User Management Module**: Create dedicated test file for `/user-management/*` endpoints
2. **Periods Module**: Add tests for close/reopen endpoints
3. **Tenants Module**: Add tests for suspend/activate (requires admin privileges)
4. **Audit Procedures**: Add tests for workload, dashboard, and comments endpoints
