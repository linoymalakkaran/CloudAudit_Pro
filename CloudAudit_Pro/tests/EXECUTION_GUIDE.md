# CloudAudit Pro - API Test Execution Guide

## Quick Start

### 1. Verify Docker Services are Running

```bash
cd CloudAudit_Pro
docker-compose ps
```

Expected output:
```
NAME                STATUS
cloudaudit-postgres Up (healthy)
cloudaudit-redis    Up (healthy)
cloudaudit-backend  Up (running)
```

### 2. Navigate to Tests Directory

```bash
cd tests
```

### 3. Make Test Scripts Executable

```bash
chmod +x *.sh */*.sh
```

### 4. Run All Tests

```bash
bash run-all-tests.sh
```

## Detailed Test Execution

### Step 1: Start Backend Services

```bash
cd CloudAudit_Pro
docker-compose down  # Stop any running containers
docker-compose up -d postgres redis backend
sleep 30  # Wait for services to initialize
docker-compose ps
```

Verify all services show "healthy" or "running" status.

### Step 2: Run Individual Module Tests

#### Authentication Tests (REQUIRED FIRST)
```bash
cd tests/01-authentication
bash auth-tests.sh
```

Output should include:
- User registration test
- User login test with token generation
- Profile retrieval test
- Token refresh test
- Logout test

**Result:** Creates `auth-tokens.json` file used by other tests

#### Company Tests
```bash
cd tests/02-companies
bash companies-tests.sh
```

Tests:
- Create company
- Get all companies
- Get company by ID
- Update company
- Delete company

#### Period Tests
```bash
cd tests/03-periods
bash periods-tests.sh
```

#### Account Tests (Chart of Accounts)
```bash
cd tests/04-accounts
bash accounts-tests.sh
```

#### Audit Procedure Tests
```bash
cd tests/05-audit-procedures
bash procedures-tests.sh
```

#### Workpaper Tests
```bash
cd tests/06-workpapers
bash workpapers-tests.sh
```

#### Findings Tests
```bash
cd tests/07-findings
bash findings-tests.sh
```

#### Journal Entry Tests
```bash
cd tests/08-journal-entries
bash journal-entries-tests.sh
```

#### Financial Statements Tests
```bash
cd tests/09-financial-statements
bash statements-tests.sh
```

#### Document Tests
```bash
cd tests/10-documents
bash documents-tests.sh
```

#### Reports Tests
```bash
cd tests/11-reports
bash reports-tests.sh
```

#### Users Tests
```bash
cd tests/12-users
bash users-tests.sh
```

#### Ledger Tests
```bash
cd tests/13-ledger
bash ledger-tests.sh
```

#### Trial Balance Tests
```bash
cd tests/14-trial-balance
bash trial-balance-tests.sh
```

#### Configuration Tests
```bash
cd tests/15-config
bash config-tests.sh
```

### Step 3: Review Test Results

```bash
# View master results
cat test-results-master.txt

# View specific module results
cat test-results-auth.txt
cat test-results-companies.txt
# etc.
```

## Expected Output Format

### Successful Test
```
Test 1: Register new user... ✓ PASS (Status: 201)
```

### Failed Test
```
Test 2: Login with invalid credentials... ✗ FAIL (Expected: 401, Got: 500)
```

### Test Summary
```
═════════════════════════════════════════════════════════════
Total Tests: 45
Passed: 45
Failed: 0
✓ ALL TESTS PASSED!
```

## Test Metrics

### Full Test Suite Execution

Expected duration: 2-5 minutes for all 90+ tests

Success rate target: 100% (all tests passing)

### By Module

| Module | Tests | Expected Duration | Status |
|--------|-------|-------------------|--------|
| Authentication | 5 | 2s | ✓ REQUIRED |
| Companies | 7 | 3s | ✓ |
| Periods | 5 | 2s | ✓ |
| Accounts | 5 | 2s | ✓ |
| Audit Procedures | 9 | 4s | ✓ |
| Workpapers | 6 | 3s | ✓ |
| Findings | 7 | 3s | ✓ |
| Journal Entries | 9 | 4s | ✓ |
| Financial Statements | 4 | 2s | ✓ |
| Documents | 7 | 3s | ✓ |
| Reports | 8 | 4s | ✓ |
| Users | 7 | 3s | ✓ |
| Ledger | 3 | 2s | ✓ |
| Trial Balance | 3 | 2s | ✓ |
| Configuration | 5 | 2s | ✓ |

**Total: 90+ endpoints**

## Verification Checklist

### Pre-Test
- [ ] Docker is installed and running
- [ ] Backend container is running (`docker ps`)
- [ ] API is accessible (`curl http://localhost:8000/api/health`)
- [ ] Database is initialized (`docker-compose logs postgres`)
- [ ] Test scripts are executable (`ls -la tests/*/*.sh`)

### During Test
- [ ] Authentication generates valid tokens
- [ ] Each endpoint returns expected status code
- [ ] Response bodies are valid JSON
- [ ] No error messages in test output

### Post-Test
- [ ] All 90+ endpoints tested
- [ ] 100% test pass rate achieved
- [ ] Results logged in test-results files
- [ ] No database errors in logs

## Handling Test Failures

### 1. Check Backend Logs
```bash
docker-compose logs backend --tail=100
```

### 2. Check Database Connection
```bash
docker-compose logs postgres
```

### 3. Verify API Connectivity
```bash
curl -v http://localhost:8000/api/health
```

### 4. Check Test Configuration
```bash
cat tests/auth-tokens.json
cat tests/company-ids.txt
```

### 5. Re-run Specific Test
```bash
cd tests/02-companies
bash companies-tests.sh
```

## Continuous Integration

### GitHub Actions Example

```yaml
name: API Tests

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    
    services:
      postgres:
        image: postgres:15-alpine
        env:
          POSTGRES_USER: audit_user
          POSTGRES_PASSWORD: audit_pass
          POSTGRES_DB: cloudaudit_db
        options: >-
          --health-cmd pg_isready
          --health-interval 10s
          --health-timeout 5s
          --health-retries 5
      
      redis:
        image: redis:7-alpine
        options: >-
          --health-cmd "redis-cli ping"
          --health-interval 10s
          --health-timeout 5s
          --health-retries 5
    
    steps:
      - uses: actions/checkout@v2
      
      - name: Start Backend
        run: |
          cd CloudAudit_Pro
          docker-compose up -d backend
          sleep 30
      
      - name: Run Tests
        run: |
          cd tests
          chmod +x *.sh */*.sh
          bash run-all-tests.sh
      
      - name: Upload Results
        if: always()
        uses: actions/upload-artifact@v2
        with:
          name: test-results
          path: tests/test-results-*.txt
```

## Test Data Management

### Sample Payloads Used

**Company:**
```json
{
  "name": "Test Company",
  "registrationNumber": "REG-123",
  "taxId": "TAX-123",
  "address": "123 Business Street",
  "city": "New York",
  "country": "USA"
}
```

**Account:**
```json
{
  "accountNumber": "1000",
  "name": "Cash",
  "type": "ASSET",
  "normalBalance": "DEBIT"
}
```

**Journal Entry:**
```json
{
  "referenceNumber": "JE-001",
  "entries": [
    {"accountId": "acc-1", "debit": 100},
    {"accountId": "acc-2", "credit": 100}
  ]
}
```

## Performance Monitoring

Monitor backend performance during tests:

```bash
# Terminal 1: Watch logs
docker-compose logs -f backend

# Terminal 2: Monitor resources
docker stats cloudaudit-backend

# Terminal 3: Run tests
cd tests && bash run-all-tests.sh
```

## Post-Test Analysis

### Generate Test Report

```bash
bash scripts/generate-test-report.sh
```

### Compare with Previous Runs

```bash
diff test-results-master.txt test-results-master.txt.prev
```

### Archive Results

```bash
mkdir -p test-archives/$(date +%Y-%m-%d)
cp test-results-*.txt test-archives/$(date +%Y-%m-%d)/
```

## Troubleshooting Guide

| Issue | Cause | Solution |
|-------|-------|----------|
| Connection refused | Backend not running | `docker-compose up -d backend` |
| Auth tokens not found | Auth test failed | Run `bash 01-authentication/auth-tests.sh` |
| Invalid response | Endpoint doesn't exist | Check endpoint path in test script |
| Status 500 errors | Backend exception | Check `docker-compose logs backend` |
| Timeout errors | Backend slow | Increase curl timeout, check resources |
| Database errors | Schema not created | Run `docker-compose up -d postgres && npx prisma db push` |

## Success Criteria

✓ **All 90+ API endpoints tested**
✓ **100% test pass rate**
✓ **All CRUD operations functional**
✓ **All workflow transitions working**
✓ **Authentication and authorization verified**
✓ **Error handling validated**
✓ **Integration between modules confirmed**

## Next Steps

After successful test execution:

1. **Performance Testing** - Load test with multiple concurrent requests
2. **Security Testing** - Test authentication, authorization, input validation
3. **Integration Testing** - Test module interactions
4. **Regression Testing** - Include new tests for future changes
5. **Deployment** - Deploy to staging/production with confidence

## References

- [CloudAudit Pro Backend Documentation](../backend/README.md)
- [API Specification](../docs/api-specification.md)
- [Database Schema](../backend/prisma/schema.prisma)
- [Docker Compose Configuration](../docker-compose.yml)

## Support

For test suite issues:
1. Check detailed logs in `test-results-*.txt`
2. Review specific test script
3. Check backend logs: `docker-compose logs backend`
4. Consult API documentation
