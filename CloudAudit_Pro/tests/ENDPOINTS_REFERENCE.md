# CloudAudit Pro - Complete API Endpoint Reference

## All Endpoints by HTTP Method

### POST Endpoints (Create Operations)

1. **POST /auth/login** - User login
2. **POST /auth/register** - User registration
3. **POST /auth/refresh** - Refresh access token
4. **POST /auth/logout** - User logout
5. **POST /companies** - Create company
6. **POST /periods** - Create period
7. **POST /accounts** - Create account
8. **POST /procedures** - Create audit procedure
9. **POST /procedures/:id/start** - Start procedure
10. **POST /procedures/:id/review** - Review procedure
11. **POST /procedures/:id/complete** - Complete procedure
12. **POST /workpapers** - Create workpaper
13. **POST /workpapers/:id/review** - Review workpaper
14. **POST /findings** - Create finding
15. **POST /findings/:id/resolve** - Resolve finding
16. **POST /journal-entries** - Create journal entry
17. **POST /journal-entries/:id/review** - Review journal entry
18. **POST /journal-entries/:id/submit** - Submit journal entry
19. **POST /financial-statements/generate** - Generate financial statement
20. **POST /documents** - Create document
21. **POST /reports** - Create report
22. **POST /reports/generate** - Generate report
23. **POST /reports/:id/execute** - Execute report
24. **POST /users** - Create user
25. **POST /ledger/generate** - Generate ledger entries
26. **POST /ledger/recalculate** - Recalculate balances
27. **POST /trial-balance/generate** - Generate trial balance
28. **POST /config** - Create configuration

**Total POST: 28 endpoints**

### GET Endpoints (Read Operations)

1. **GET /auth/profile** - Get user profile
2. **GET /companies** - Get all companies
3. **GET /companies/:id** - Get company by ID
4. **GET /companies/stats** - Get company statistics
5. **GET /companies/search** - Search companies
6. **GET /periods** - Get all periods
7. **GET /periods/:id** - Get period by ID
8. **GET /accounts** - Get all accounts
9. **GET /accounts/:id** - Get account by ID
10. **GET /procedures** - Get all procedures
11. **GET /procedures/:id** - Get procedure by ID
12. **GET /procedures/statistics** - Get procedure statistics
13. **GET /procedures/templates** - Get procedure templates
14. **GET /workpapers** - Get all workpapers
15. **GET /workpapers/:id** - Get workpaper by ID
16. **GET /findings** - Get all findings
17. **GET /findings/:id** - Get finding by ID
18. **GET /findings/statistics** - Get finding statistics
19. **GET /journal-entries** - Get all journal entries
20. **GET /journal-entries/:id** - Get journal entry by ID
21. **GET /journal-entries/statistics** - Get journal entry statistics
22. **GET /financial-statements** - Get all statements
23. **GET /financial-statements/:id** - Get statement by ID
24. **GET /financial-statements/:id/export** - Export statement
25. **GET /documents** - Get all documents
26. **GET /documents/:id** - Get document by ID
27. **GET /documents/statistics** - Get document statistics
28. **GET /documents/:id/download** - Download document
29. **GET /reports** - Get all reports
30. **GET /reports/:id** - Get report by ID
31. **GET /reports/statistics** - Get report statistics
32. **GET /users** - Get all users
33. **GET /users/:id** - Get user by ID
34. **GET /users/stats** - Get user statistics
35. **GET /users/search** - Search users
36. **GET /ledger** - Get account ledger
37. **GET /trial-balance** - Get trial balance
38. **GET /trial-balance/:id/export** - Export trial balance
39. **GET /config** - Get all configurations
40. **GET /config/:id** - Get configuration by ID

**Total GET: 40 endpoints**

### PUT Endpoints (Update Operations - Full Replace)

1. **PUT /workpapers/:id** - Update workpaper
2. **PUT /findings/:id** - Update finding
3. **PUT /journal-entries/:id** - Update journal entry
4. **PUT /journal-entries/:id/submit** - Submit journal entry
5. **PUT /journal-entries/:id/post** - Post journal entry to ledger

**Total PUT: 5 endpoints**

### PATCH Endpoints (Partial Update Operations)

1. **PATCH /companies/:id** - Update company
2. **PATCH /periods/:id** - Update period
3. **PATCH /accounts/:id** - Update account
4. **PATCH /documents/:id** - Update document
5. **PATCH /reports/:id** - Update report
6. **PATCH /users/:id** - Update user
7. **PATCH /config/:id** - Update configuration

**Total PATCH: 7 endpoints**

### DELETE Endpoints (Delete Operations)

1. **DELETE /companies/:id** - Delete company
2. **DELETE /periods/:id** - Delete period
3. **DELETE /accounts/:id** - Delete account
4. **DELETE /procedures/:id** - Delete procedure
5. **DELETE /workpapers/:id** - Delete workpaper
6. **DELETE /findings/:id** - Delete finding
7. **DELETE /journal-entries/:id** - Delete journal entry
8. **DELETE /documents/:id** - Delete document
9. **DELETE /reports/:id** - Delete report
10. **DELETE /users/:id** - Delete user (optional)
11. **DELETE /config/:id** - Delete configuration

**Total DELETE: 11 endpoints**

---

## Summary Statistics

| Method | Count |
|--------|-------|
| POST | 28 |
| GET | 40 |
| PUT | 5 |
| PATCH | 7 |
| DELETE | 11 |
| **TOTAL** | **91** |

---

## Endpoints by Module

### 1. Authentication (5)
- POST /auth/login
- POST /auth/register
- POST /auth/refresh
- POST /auth/logout
- GET /auth/profile

### 2. Companies (7)
- POST /companies
- GET /companies
- GET /companies/:id
- PATCH /companies/:id
- DELETE /companies/:id
- GET /companies/stats
- GET /companies/search

### 3. Periods (5)
- POST /periods
- GET /periods
- GET /periods/:id
- PATCH /periods/:id
- DELETE /periods/:id

### 4. Accounts (5)
- POST /accounts
- GET /accounts
- GET /accounts/:id
- PATCH /accounts/:id
- DELETE /accounts/:id

### 5. Audit Procedures (9)
- POST /procedures
- GET /procedures
- GET /procedures/:id
- POST /procedures/:id/start
- POST /procedures/:id/review
- POST /procedures/:id/complete
- GET /procedures/statistics
- GET /procedures/templates
- DELETE /procedures/:id

### 6. Workpapers (6)
- POST /workpapers
- GET /workpapers
- GET /workpapers/:id
- PUT /workpapers/:id
- POST /workpapers/:id/review
- DELETE /workpapers/:id

### 7. Findings (7)
- POST /findings
- GET /findings
- GET /findings/:id
- PUT /findings/:id
- DELETE /findings/:id
- GET /findings/statistics
- POST /findings/:id/resolve

### 8. Journal Entries (9)
- POST /journal-entries
- GET /journal-entries
- GET /journal-entries/:id
- PUT /journal-entries/:id
- DELETE /journal-entries/:id
- PUT /journal-entries/:id/submit
- POST /journal-entries/:id/review
- PUT /journal-entries/:id/post
- GET /journal-entries/statistics

### 9. Financial Statements (4)
- POST /financial-statements/generate
- GET /financial-statements
- GET /financial-statements/:id
- GET /financial-statements/:id/export

### 10. Documents (7)
- POST /documents
- GET /documents
- GET /documents/:id
- PATCH /documents/:id
- DELETE /documents/:id
- GET /documents/statistics
- GET /documents/:id/download

### 11. Reports (8)
- POST /reports
- GET /reports
- GET /reports/:id
- PATCH /reports/:id
- DELETE /reports/:id
- GET /reports/statistics
- POST /reports/generate
- POST /reports/:id/execute

### 12. Users (7)
- POST /users
- GET /users
- GET /users/:id
- PATCH /users/:id
- DELETE /users/:id
- GET /users/stats
- GET /users/search

### 13. Ledger (3)
- GET /ledger
- POST /ledger/generate
- POST /ledger/recalculate

### 14. Trial Balance (3)
- POST /trial-balance/generate
- GET /trial-balance
- GET /trial-balance/:id/export

### 15. Configuration (5)
- POST /config
- GET /config
- GET /config/:id
- PATCH /config/:id
- DELETE /config/:id

---

## HTTP Status Codes Used

| Code | Meaning | Used For |
|------|---------|----------|
| 200 | OK | GET, PUT, PATCH, DELETE success |
| 201 | Created | POST success |
| 400 | Bad Request | Invalid input |
| 401 | Unauthorized | Invalid credentials |
| 403 | Forbidden | Insufficient permissions |
| 404 | Not Found | Non-existent resource |
| 409 | Conflict | Resource conflict |
| 500 | Server Error | Backend exception |

---

## Authentication

All endpoints except login, register, and refresh require:

```
Header: Authorization: Bearer <JWT_TOKEN>
```

Token obtained from:
```
POST /auth/login
POST /auth/register
```

Refresh token:
```
POST /auth/refresh
```

---

## Common Request Patterns

### Create (POST)
```json
{
  "field1": "value1",
  "field2": "value2",
  "relatedId": "id"
}
```

### Update (PATCH/PUT)
```json
{
  "field1": "updated_value"
}
```

### List with Filters
```
GET /endpoint?filter=value&skip=0&take=10&sort=field
```

### Search
```
GET /endpoint/search?q=query_string
```

### Export
```
GET /endpoint/:id/export?format=pdf
GET /endpoint/:id/export?format=excel
```

---

## Response Format

### Success Response
```json
{
  "id": "uuid",
  "field1": "value1",
  "field2": "value2",
  "createdAt": "2024-01-01T00:00:00Z",
  "updatedAt": "2024-01-01T00:00:00Z"
}
```

### List Response
```json
{
  "data": [
    { "id": "uuid1", ... },
    { "id": "uuid2", ... }
  ],
  "total": 2,
  "skip": 0,
  "take": 10
}
```

### Error Response
```json
{
  "statusCode": 400,
  "message": "Error message",
  "error": "Bad Request"
}
```

---

## Key Relationships

```
Company
├── Periods
│   ├── Audit Procedures
│   │   ├── Workpapers
│   │   ├── Findings
│   │   └── Comments
│   ├── Journal Entries
│   │   └── Ledger Entries
│   ├── Financial Statements
│   └── Trial Balance
├── Accounts (Chart of Accounts)
│   ├── Journal Entry Details
│   ├── Ledger Entries
│   └── Trial Balance Details
└── Documents
    ├── Linked to Procedures
    └── Linked to Findings

Users
├── Assigned to Companies
├── Assigned to Procedures
└── Assigned to Workpapers

Reports
├── Run against Companies
├── Run against Periods
└── Generate Statements
```

---

## Test Execution Command

```bash
# Run all 91 endpoints
cd tests && bash run-all-tests.sh

# Run specific module
cd tests/01-authentication && bash auth-tests.sh

# Check results
cat test-results-master.txt
```

---

**Total Endpoints: 91**
**Test Status: Ready for Execution**
