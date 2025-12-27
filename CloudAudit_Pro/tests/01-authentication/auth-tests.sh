#!/bin/bash

# CloudAudit Pro - Authentication Tests
# Tests all authentication endpoints

set -e

API_BASE_URL="http://localhost:8000/api"
TEST_RESULTS="test-results.txt"
TOKENS_FILE="auth-tokens.json"

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "╔════════════════════════════════════════════════════════════╗"
echo "║         CLOUDAUDIT PRO - AUTHENTICATION TESTS               ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""

# Initialize results file
> "$TEST_RESULTS"
echo "Test Execution Date: $(date)" >> "$TEST_RESULTS"
echo "API Base URL: $API_BASE_URL" >> "$TEST_RESULTS"
echo "" >> "$TEST_RESULTS"

# Test Counter
TOTAL_TESTS=0
PASSED_TESTS=0
FAILED_TESTS=0

# Helper function to run a test
test_endpoint() {
    local test_name=$1
    local method=$2
    local endpoint=$3
    local data=$4
    local expected_status=$5
    
    ((TOTAL_TESTS++))
    echo -n "Test $TOTAL_TESTS: $test_name... "
    
    if [ -z "$data" ]; then
        response=$(curl -s -w "\n%{http_code}" -X $method "$API_BASE_URL$endpoint")
    else
        response=$(curl -s -w "\n%{http_code}" -X $method "$API_BASE_URL$endpoint" \
            -H "Content-Type: application/json" \
            -d "$data")
    fi
    
    status_code=$(echo "$response" | tail -n 1)
    body=$(echo "$response" | sed '$d')
    
    if [ "$status_code" = "$expected_status" ]; then
        echo -e "${GREEN}PASS${NC} (Status: $status_code)"
        echo "✓ Test $TOTAL_TESTS: $test_name - PASS (Status: $status_code)" >> "$TEST_RESULTS"
        ((PASSED_TESTS++))
        echo "$body" >> "$TEST_RESULTS"
    else
        echo -e "${RED}FAIL${NC} (Expected: $expected_status, Got: $status_code)"
        echo "✗ Test $TOTAL_TESTS: $test_name - FAIL (Expected: $expected_status, Got: $status_code)" >> "$TEST_RESULTS"
        ((FAILED_TESTS++))
        echo "Response: $body" >> "$TEST_RESULTS"
    fi
    echo "" >> "$TEST_RESULTS"
}

# Test with auth header
test_endpoint_with_auth() {
    local test_name=$1
    local method=$2
    local endpoint=$3
    local data=$4
    local expected_status=$5
    local token=$6
    
    ((TOTAL_TESTS++))
    echo -n "Test $TOTAL_TESTS: $test_name... "
    
    if [ -z "$data" ]; then
        response=$(curl -s -w "\n%{http_code}" -X $method "$API_BASE_URL$endpoint" \
            -H "Authorization: Bearer $token")
    else
        response=$(curl -s -w "\n%{http_code}" -X $method "$API_BASE_URL$endpoint" \
            -H "Content-Type: application/json" \
            -H "Authorization: Bearer $token" \
            -d "$data")
    fi
    
    status_code=$(echo "$response" | tail -n 1)
    body=$(echo "$response" | sed '$d')
    
    if [ "$status_code" = "$expected_status" ]; then
        echo -e "${GREEN}PASS${NC} (Status: $status_code)"
        echo "✓ Test $TOTAL_TESTS: $test_name - PASS (Status: $status_code)" >> "$TEST_RESULTS"
        ((PASSED_TESTS++))
        echo "$body" >> "$TEST_RESULTS"
    else
        echo -e "${RED}FAIL${NC} (Expected: $expected_status, Got: $status_code)"
        echo "✗ Test $TOTAL_TESTS: $test_name - FAIL (Expected: $expected_status, Got: $status_code)" >> "$TEST_RESULTS"
        ((FAILED_TESTS++))
        echo "Response: $body" >> "$TEST_RESULTS"
    fi
    echo "" >> "$TEST_RESULTS"
}

echo "▶ 1. REGISTER NEW USER"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

REGISTER_PAYLOAD='{
    "email": "testuser@cloudauditpro.com",
    "password": "Test@12345",
    "firstName": "Test",
    "lastName": "User",
    "companyName": "Test Audit Firm",
    "tenantName": "test-tenant-'$(date +%s)'"
}'

test_endpoint "Register new user" "POST" "/auth/register" "$REGISTER_PAYLOAD" "201"

echo ""
echo "▶ 2. LOGIN WITH REGISTERED USER"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

LOGIN_PAYLOAD='{
    "email": "testuser@cloudauditpro.com",
    "password": "Test@12345"
}'

# Run login and capture tokens
response=$(curl -s -X POST "$API_BASE_URL/auth/login" \
    -H "Content-Type: application/json" \
    -d "$LOGIN_PAYLOAD")

# Extract tokens using grep/awk if jq is not available
ACCESS_TOKEN=$(echo "$response" | grep -o '"accessToken":"[^"]*' | cut -d'"' -f4 | head -1)
REFRESH_TOKEN=$(echo "$response" | grep -o '"refreshToken":"[^"]*' | cut -d'"' -f4 | head -1)

if [ ! -z "$ACCESS_TOKEN" ]; then
    echo -e "${GREEN}✓ PASS${NC} - Login successful, tokens obtained"
    echo "Access Token: ${ACCESS_TOKEN:0:20}..." >> "$TEST_RESULTS"
    echo "Refresh Token: ${REFRESH_TOKEN:0:20}..." >> "$TEST_RESULTS"
    ((PASSED_TESTS++))
else
    echo -e "${RED}✗ FAIL${NC} - Could not extract tokens from login response"
    ((FAILED_TESTS++))
fi
((TOTAL_TESTS++))

# Save tokens for other tests
echo "{\"accessToken\":\"$ACCESS_TOKEN\",\"refreshToken\":\"$REFRESH_TOKEN\"}" > "$TOKENS_FILE"

echo ""
echo "▶ 3. GET USER PROFILE (Authenticated)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

test_endpoint_with_auth "Get user profile" "GET" "/auth/profile" "" "200" "$ACCESS_TOKEN"

echo ""
echo "▶ 4. REFRESH ACCESS TOKEN"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

REFRESH_PAYLOAD='{
    "refreshToken": "'$REFRESH_TOKEN'"
}'

test_endpoint "Refresh access token" "POST" "/auth/refresh" "$REFRESH_PAYLOAD" "200"

echo ""
echo "▶ 5. LOGIN WITH INVALID CREDENTIALS"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

INVALID_LOGIN='{
    "email": "invalid@test.com",
    "password": "wrongpassword"
}'

test_endpoint "Login with invalid credentials" "POST" "/auth/login" "$INVALID_LOGIN" "401"

echo ""
echo "▶ 6. LOGOUT (Authenticated)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

test_endpoint_with_auth "Logout" "POST" "/auth/logout" "" "200" "$ACCESS_TOKEN"

echo ""
echo "╔════════════════════════════════════════════════════════════╗"
echo "║                    TEST SUMMARY                             ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo "Total Tests: $TOTAL_TESTS"
echo -e "Passed: ${GREEN}$PASSED_TESTS${NC}"
echo -e "Failed: ${RED}$FAILED_TESTS${NC}"
echo ""
echo "Results saved to: $TEST_RESULTS"

if [ $FAILED_TESTS -eq 0 ]; then
    echo -e "${GREEN}✓ ALL TESTS PASSED!${NC}"
    exit 0
else
    echo -e "${RED}✗ Some tests failed. Check $TEST_RESULTS for details${NC}"
    exit 1
fi
