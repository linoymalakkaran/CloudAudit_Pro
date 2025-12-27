# API Test Suite with jq Validation

## Overview

All test scripts now use **jq** for proper JSON validation and response verification. Each test:
1. **Validates HTTP status codes**
2. **Checks JSON structure is valid**
3. **Verifies required fields exist**
4. **Shows actual PASS/FAIL results**

## Running Tests

### Run All Tests
```bash
cd tests
bash run-all-tests.sh
```

### Run Specific Module
```bash
cd tests/01-authentication
bash auth-tests.sh
```

### Example Test Output
```
▶ Test 1: Register new user
  Method: POST
  Endpoint: /auth/register
  Expected Status: 201
  Actual Status: 201
  ✓ Status Code: PASS
  ✓ Valid JSON: PASS
  ✓ Schema Validation: PASS
  ✓ OVERALL: PASS
```

## Writing New Tests

### 1. Use test-helpers.sh

All tests should source the common helpers:

```bash
#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../test-helpers.sh"
```

### 2. Create Validation Functions

```bash
# Validate response has required fields
validate_user() {
    check_field "$1" '.id' && \
    check_field "$1" '.email' && \
    check_field "$1" '.firstName'
}

validate_list() {
    echo "$1" | jq -e 'type == "array"' >/dev/null 2>&1
}
```

### 3. Use test_endpoint Function

```bash
# Basic test
response=$(test_endpoint \
    "Test name" \
    "HTTP_METHOD" \
    "/endpoint/path" \
    '{"json":"data"}' \
    "200" \
    "" \
    "")

# With authentication
response=$(test_endpoint \
    "Test name" \
    "GET" \
    "/protected/endpoint" \
    "" \
    "200" \
    "$AUTH_TOKEN" \
    "validate_user")
```

### 4. Extract Data from Responses

```bash
# Use jq to extract values
USER_ID=$(echo "$response" | jq -r '.id')
TOKEN=$(echo "$response" | jq -r '.accessToken')
EMAIL=$(echo "$response" | jq -r '.user.email')

# Check if value exists
if [ -n "$TOKEN" ] && [ "$TOKEN" != "null" ]; then
    echo "Token obtained: ${TOKEN:0:20}..."
fi
```

### 5. Print Summary

```bash
# Always call this at the end
print_summary
exit_code=$?
exit $exit_code
```

## Available Helper Functions

### validate_json()
Checks if response is valid JSON
```bash
if validate_json "$response"; then
    echo "Valid JSON"
fi
```

### check_field()
Checks if JSON field exists
```bash
if check_field "$response" '.user.email'; then
    echo "Email field exists"
fi
```

### api_request()
Makes HTTP request and returns response with status
```bash
response=$(api_request "POST" "/endpoint" '{"data":"value"}' "$token")
```

### test_endpoint()
Complete test with validation (recommended)
```bash
response=$(test_endpoint \
    "Test description" \
    "METHOD" \
    "/path" \
    "json_data" \
    "expected_status" \
    "auth_token" \
    "validator_function")
```

## Complete Test Example

```bash
#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../test-helpers.sh"

echo "╔════════════════════════════════════════╗"
echo "║         COMPANY TESTS                   ║"
echo "╚════════════════════════════════════════╝"

# Validation functions
validate_company() {
    check_field "$1" '.id' && \
    check_field "$1" '.name'
}

validate_list() {
    echo "$1" | jq -e 'type == "array"' >/dev/null 2>&1
}

# Login first to get token
LOGIN='{"email":"admin@test.com","password":"Admin@123"}'
login_resp=$(test_endpoint "Login" "POST" "/auth/login" "$LOGIN" "200" "" "")
TOKEN=$(echo "$login_resp" | jq -r '.accessToken')

# Test 1: Create Company
COMPANY_DATA='{"name":"Test Corp","industry":"Technology"}'
create_resp=$(test_endpoint \
    "Create company" \
    "POST" \
    "/companies" \
    "$COMPANY_DATA" \
    "201" \
    "$TOKEN" \
    "validate_company")

COMPANY_ID=$(echo "$create_resp" | jq -r '.id')

# Test 2: Get Company
test_endpoint \
    "Get company by ID" \
    "GET" \
    "/companies/$COMPANY_ID" \
    "" \
    "200" \
    "$TOKEN" \
    "validate_company" >/dev/null

# Test 3: List Companies
test_endpoint \
    "List all companies" \
    "GET" \
    "/companies" \
    "" \
    "200" \
    "$TOKEN" \
    "validate_list" >/dev/null

# Test 4: Update Company
UPDATE_DATA='{"name":"Updated Corp"}'
test_endpoint \
    "Update company" \
    "PATCH" \
    "/companies/$COMPANY_ID" \
    "$UPDATE_DATA" \
    "200" \
    "$TOKEN" \
    "validate_company" >/dev/null

# Test 5: Delete Company
test_endpoint \
    "Delete company" \
    "DELETE" \
    "/companies/$COMPANY_ID" \
    "" \
    "200" \
    "$TOKEN" \
    "" >/dev/null

print_summary
```

## Common Validation Patterns

### Check Array Response
```bash
validate_array() {
    echo "$1" | jq -e 'type == "array"' >/dev/null 2>&1
}
```

### Check Paginated Response
```bash
validate_paginated() {
    check_field "$1" '.data' && \
    check_field "$1" '.total' && \
    check_field "$1" '.page'
}
```

### Check Error Response
```bash
validate_error() {
    check_field "$1" '.message' || \
    check_field "$1" '.error'
}
```

### Check Specific Value
```bash
validate_status() {
    local status=$(echo "$1" | jq -r '.status')
    [ "$status" = "active" ]
}
```

## Best Practices

1. **Always validate JSON structure** - Don't just check status codes
2. **Use unique identifiers** - Use timestamps to avoid conflicts
3. **Test error cases** - Verify 4xx/5xx responses have proper error messages
4. **Clean up after tests** - Delete created resources
5. **Make tests independent** - Each test should work standalone
6. **Use descriptive names** - Test names should clearly indicate what's being tested

## Debugging Failed Tests

When tests fail:

1. Check `test-results.txt` in test directory for full responses
2. Run test manually with curl to see actual API response:
   ```bash
   curl -v http://localhost:8000/api/endpoint
   ```
3. Verify API is running: `curl http://localhost:8000/api/health`
4. Check Docker logs: `docker logs cloudaudit-backend`

## Current Test Coverage

✅ Authentication (8 tests)
- Register user
- Login
- Get profile
- Refresh token
- Logout
- Invalid credentials
- Unauthorized access
- Duplicate registration

🔄 Other modules - Use authentication tests as template
