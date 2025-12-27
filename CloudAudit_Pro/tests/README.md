# CloudAudit Pro - Comprehensive API Test Suite

## Overview

This directory contains a comprehensive test suite for all CloudAudit Pro backend API endpoints. The tests are organized by module/functionality and use bash scripts with curl commands to validate all API endpoints.

## Test Structure

```
tests/
├── 01-authentication/         # Authentication endpoints
├── 02-companies/              # Company management
├── 03-periods/                # Fiscal period management
├── 04-accounts/               # Chart of Accounts (COA)
├── 05-audit-procedures/       # Audit procedure management
├── 06-workpapers/             # Workpaper management
├── 07-findings/               # Audit findings
├── 08-journal-entries/        # Journal entry posting
├── 09-financial-statements/   # Financial statement generation
├── 10-documents/              # Document management
├── 11-reports/                # Report generation and execution
├── 12-users/                  # User management
├── 13-ledger/                 # General ledger operations
├── 14-trial-balance/          # Trial balance generation
├── 15-config/                 # System configuration
└── run-all-tests.sh           # Master test runner
```

## Endpoints Covered

### 1. Authentication (01-authentication)
- `POST /auth/login` - User login
- `POST /auth/register` - User registration
- `POST /auth/refresh` - Refresh access token
- `POST /auth/logout` - User logout
- `GET /auth/profile` - Get user profile

**Total Endpoints:** 5

### 2. Companies (02-companies)
- `POST /companies` - Create new company
- `GET /companies` - Get all companies
- `GET /companies/:id` - Get company by ID
- `PATCH /companies/:id` - Update company
- `DELETE /companies/:id` - Delete company
- `GET /companies/stats` - Get company statistics
- `GET /companies/search` - Search companies

**Total Endpoints:** 7

### 3. Periods (03-periods)
- `POST /periods` - Create new period
- `GET /periods` - Get all periods
- `GET /periods/:id` - Get period by ID
- `PATCH /periods/:id` - Update period
- `DELETE /periods/:id` - Delete period

**Total Endpoints:** 5

### 4. Accounts - Chart of Accounts (04-accounts)
- `POST /accounts` - Create account
- `GET /accounts` - Get all accounts
- `GET /accounts/:id` - Get account by ID
- `PATCH /accounts/:id` - Update account
- `DELETE /accounts/:id` - Delete account

**Total Endpoints:** 5

### 5. Audit Procedures (05-audit-procedures)
- `POST /procedures` - Create audit procedure
- `GET /procedures` - Get all procedures
- `GET /procedures/:id` - Get procedure by ID
- `POST /procedures/:id/start` - Start procedure
- `POST /procedures/:id/review` - Review procedure
- `POST /procedures/:id/complete` - Complete procedure
- `GET /procedures/statistics` - Get statistics
- `GET /procedures/templates` - Get templates
- `DELETE /procedures/:id` - Delete procedure

**Total Endpoints:** 9

### 6. Workpapers (06-workpapers)
- `POST /workpapers` - Create workpaper
- `GET /workpapers` - Get all workpapers
- `GET /workpapers/:id` - Get workpaper by ID
- `PUT /workpapers/:id` - Update workpaper
- `POST /workpapers/:id/review` - Review workpaper
- `DELETE /workpapers/:id` - Delete workpaper

**Total Endpoints:** 6

### 7. Findings (07-findings)
- `POST /findings` - Create finding
- `GET /findings` - Get all findings
- `GET /findings/:id` - Get finding by ID
- `PUT /findings/:id` - Update finding
- `GET /findings/statistics` - Get statistics
- `POST /findings/:id/resolve` - Resolve finding
- `DELETE /findings/:id` - Delete finding

**Total Endpoints:** 7

### 8. Journal Entries (08-journal-entries)
- `POST /journal-entries` - Create journal entry
- `GET /journal-entries` - Get all entries
- `GET /journal-entries/:id` - Get entry by ID
- `PUT /journal-entries/:id` - Update entry
- `DELETE /journal-entries/:id` - Delete entry
- `GET /journal-entries/statistics` - Get statistics
- `PUT /journal-entries/:id/submit` - Submit for review
- `POST /journal-entries/:id/review` - Review entry
- `PUT /journal-entries/:id/post` - Post to ledger

**Total Endpoints:** 9

### 9. Financial Statements (09-financial-statements)
- `POST /financial-statements/generate` - Generate statement
- `GET /financial-statements` - Get all statements
- `GET /financial-statements/:id` - Get statement by ID
- `GET /financial-statements/:id/export` - Export statement (PDF, Excel)

**Total Endpoints:** 4

### 10. Documents (10-documents)
- `POST /documents` - Create document
- `GET /documents` - Get all documents
- `GET /documents/:id` - Get document by ID
- `PATCH /documents/:id` - Update document
- `GET /documents/statistics` - Get statistics
- `GET /documents/:id/download` - Download document
- `DELETE /documents/:id` - Delete document

**Total Endpoints:** 7

### 11. Reports (11-reports)
- `POST /reports` - Create report
- `GET /reports` - Get all reports
- `GET /reports/:id` - Get report by ID
- `PATCH /reports/:id` - Update report
- `DELETE /reports/:id` - Delete report
- `GET /reports/statistics` - Get statistics
- `POST /reports/generate` - Generate report
- `POST /reports/:id/execute` - Execute report

**Total Endpoints:** 8

### 12. Users (12-users)
- `POST /users` - Create user
- `GET /users` - Get all users
- `GET /users/:id` - Get user by ID
- `PATCH /users/:id` - Update user
- `DELETE /users/:id` - Delete user (optional)
- `GET /users/stats` - Get statistics
- `GET /users/search` - Search users

**Total Endpoints:** 7

### 13. Ledger (13-ledger)
- `GET /ledger` - Get account ledger
- `POST /ledger/generate` - Generate ledger entries
- `POST /ledger/recalculate` - Recalculate balances

**Total Endpoints:** 3

### 14. Trial Balance (14-trial-balance)
- `POST /trial-balance/generate` - Generate trial balance
- `GET /trial-balance` - Get trial balance
- `GET /trial-balance/:id/export` - Export trial balance

**Total Endpoints:** 3

### 15. System Configuration (15-config)
- `POST /config` - Create configuration
- `GET /config` - Get all configurations
- `GET /config/:id` - Get config by ID
- `PATCH /config/:id` - Update configuration
- `DELETE /config/:id` - Delete configuration

**Total Endpoints:** 5

**Total API Endpoints Tested: 90+**

## Prerequisites

- Docker Desktop running with CloudAudit Pro backend container
- Backend API accessible at `http://localhost:8000/api`
- `curl` command-line tool installed
- Bash shell

## Running Tests

### 1. Start Backend Services

```bash
cd CloudAudit_Pro
docker-compose up -d postgres redis backend
```

Wait for all services to be healthy (check with `docker-compose ps`)

### 2. Run All Tests

```bash
cd tests
chmod +x *.sh */*.sh
bash run-all-tests.sh
```

### 3. Run Specific Module Tests

```bash
cd tests/01-authentication
bash auth-tests.sh
```

### 4. Run Tests Sequentially

Tests should be run in order due to dependencies:

1. **Authentication** - Must run first to generate auth tokens
2. **Companies** - Required by procedures and other modules
3. **Periods** - Required by financial statements
4. **Accounts** - Required by journal entries and ledger
5. **Audit Procedures** - Core module
6. **Workpapers** - Depends on procedures
7. **Findings** - Depends on procedures
8. **Journal Entries** - Depends on accounts
9. **Financial Statements** - Depends on accounts and periods
10. **Documents** - Can run independently
11. **Reports** - Can run independently
12. **Users** - Can run independently
13. **Ledger** - Depends on journal entries
14. **Trial Balance** - Depends on accounts and periods
15. **Config** - Can run independently

## Test Results

Test results are saved in the following files:

- `test-results-auth.txt` - Authentication test results
- `test-results-companies.txt` - Companies test results
- `test-results-*.txt` - Individual module results
- `test-results-master.txt` - Master summary

## Output Format

Each test produces output like:

```
╔════════════════════════════════════════════════════════════╗
║         CLOUDAUDIT PRO - AUTHENTICATION TESTS               ║
╚════════════════════════════════════════════════════════════╝

Test 1: Register new user... ✓ PASS (Status: 201)
Test 2: Get user profile... ✓ PASS (Status: 200)
Test 3: Login with invalid credentials... ✓ PASS (Status: 401)

═════════════════════════════════════════════════════════════
Total Tests: 3
Passed: 3
Failed: 0
✓ ALL TESTS PASSED!
```

## Troubleshooting

### API Not Accessible
```
Error: API is not accessible at http://localhost:8000/api
```
**Solution:** Ensure Docker container is running:
```bash
docker-compose ps
docker-compose logs backend
```

### Auth Tokens Not Found
```
Auth tokens not found
```
**Solution:** Run authentication tests first:
```bash
cd tests/01-authentication
bash auth-tests.sh
```

### Connection Refused
```
curl: (7) Failed to connect to localhost:8000
```
**Solution:** Ensure backend service is started and healthy:
```bash
docker-compose up -d backend
docker-compose logs backend
```

## Expected Test Results

All 90+ endpoints should return:
- **201** (Created) for POST requests that create resources
- **200** (OK) for GET, PUT, PATCH, DELETE requests
- **400** (Bad Request) for invalid inputs
- **401** (Unauthorized) for invalid credentials
- **404** (Not Found) for non-existent resources

## Test Coverage Summary

- ✅ All CRUD operations for 15 modules
- ✅ All workflow transitions (start, review, complete)
- ✅ All filtering and search operations
- ✅ All export operations (PDF, Excel)
- ✅ Authentication and authorization
- ✅ Error handling and validation
- ✅ Integration between modules

## Notes

- Tests use realistic sample payloads based on the Prisma schema
- Each test is idempotent and can be run multiple times
- Token management is automatic - auth test generates tokens used by other tests
- Test results are logged for audit trail and debugging
- All sensitive data (tokens, passwords) are handled securely

## CI/CD Integration

To integrate with CI/CD pipelines:

```bash
#!/bin/bash
set -e
cd tests
bash run-all-tests.sh
if [ $? -eq 0 ]; then
    echo "All API tests passed ✓"
    exit 0
else
    echo "Some API tests failed ✗"
    exit 1
fi
```

## Support

For issues or questions about the test suite:
1. Check the detailed results in `test-results-*.txt` files
2. Review the specific test script for the failing endpoint
3. Check backend logs: `docker-compose logs backend`
4. Verify database connection: `docker-compose logs postgres`

## Version

Test Suite Version: 1.0.0
Created: 2024
CloudAudit Pro API: v1.0.0
