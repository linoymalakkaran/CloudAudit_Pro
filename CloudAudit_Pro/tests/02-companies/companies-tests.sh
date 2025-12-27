#!/bin/bash

# CloudAudit Pro - Companies API Tests
# Tests all company endpoints

set -e

API_BASE_URL="http://localhost:8000/api"
TEST_RESULTS="test-results-companies.txt"
TOKENS_FILE="auth-tokens.json"

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo "╔════════════════════════════════════════════════════════════╗"
echo "║            CLOUDAUDIT PRO - COMPANIES TESTS                 ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""

> "$TEST_RESULTS"
echo "Test Execution Date: $(date)" >> "$TEST_RESULTS"
echo "API Base URL: $API_BASE_URL" >> "$TEST_RESULTS"
echo "" >> "$TEST_RESULTS"

TOTAL_TESTS=0
PASSED_TESTS=0
FAILED_TESTS=0

# Retrieve tokens from auth test
if [ -f "$TOKENS_FILE" ]; then
    ACCESS_TOKEN=$(grep -o '"accessToken":"[^"]*' "$TOKENS_FILE" | cut -d'"' -f4)
else
    echo -e "${RED}✗ Auth tokens not found. Run auth-tests.sh first${NC}"
    exit 1
fi

test_endpoint_with_auth() {
    local test_name=$1
    local method=$2
    local endpoint=$3
    local data=$4
    local expected_status=$5
    
    ((TOTAL_TESTS++))
    echo -n "Test $TOTAL_TESTS: $test_name... "
    
    if [ -z "$data" ]; then
        response=$(curl -s -w "\n%{http_code}" -X $method "$API_BASE_URL$endpoint" \
            -H "Authorization: Bearer $ACCESS_TOKEN")
    else
        response=$(curl -s -w "\n%{http_code}" -X $method "$API_BASE_URL$endpoint" \
            -H "Content-Type: application/json" \
            -H "Authorization: Bearer $ACCESS_TOKEN" \
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
    
    # Return the response body
    echo "$body"
}

echo "▶ 1. CREATE COMPANY"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

COMPANY_PAYLOAD='{
    "name": "Test Company '$(date +%s)'",
    "registrationNumber": "REG-'$(date +%s)'",
    "taxId": "TAX-'$(date +%s)'",
    "address": "123 Business Street",
    "city": "New York",
    "state": "NY",
    "country": "USA",
    "postalCode": "10001",
    "fiscalYearEnd": "12-31",
    "industry": "Consulting",
    "size": "MEDIUM"
}'

COMPANY_RESPONSE=$(test_endpoint_with_auth "Create new company" "POST" "/companies" "$COMPANY_PAYLOAD" "201")
COMPANY_ID=$(echo "$COMPANY_RESPONSE" | grep -o '"id":"[^"]*' | head -1 | cut -d'"' -f4)

if [ ! -z "$COMPANY_ID" ]; then
    echo "Created Company ID: $COMPANY_ID" >> "$TEST_RESULTS"
    echo "COMPANY_ID=$COMPANY_ID" > company-ids.txt
fi

echo ""
echo "▶ 2. GET ALL COMPANIES"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

test_endpoint_with_auth "Get all companies" "GET" "/companies" "" "200" > /dev/null

echo ""
echo "▶ 3. GET COMPANY BY ID"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

if [ ! -z "$COMPANY_ID" ]; then
    test_endpoint_with_auth "Get company by ID" "GET" "/companies/$COMPANY_ID" "" "200" > /dev/null
else
    echo -e "${YELLOW}⚠ SKIP${NC} - No company ID available"
fi

echo ""
echo "▶ 4. UPDATE COMPANY"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

if [ ! -z "$COMPANY_ID" ]; then
    UPDATE_PAYLOAD='{
        "name": "Updated Company Name",
        "address": "456 Corporate Ave",
        "city": "Boston",
        "state": "MA"
    }'
    
    test_endpoint_with_auth "Update company" "PATCH" "/companies/$COMPANY_ID" "$UPDATE_PAYLOAD" "200" > /dev/null
else
    echo -e "${YELLOW}⚠ SKIP${NC} - No company ID available"
fi

echo ""
echo "▶ 5. GET COMPANY STATISTICS"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

test_endpoint_with_auth "Get company statistics" "GET" "/companies/stats" "" "200" > /dev/null

echo ""
echo "▶ 6. SEARCH COMPANIES"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

test_endpoint_with_auth "Search companies" "GET" "/companies/search?q=test" "" "200" > /dev/null

echo ""
echo "▶ 7. DELETE COMPANY"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

if [ ! -z "$COMPANY_ID" ]; then
    test_endpoint_with_auth "Delete company" "DELETE" "/companies/$COMPANY_ID" "" "200" > /dev/null
else
    echo -e "${YELLOW}⚠ SKIP${NC} - No company ID available"
fi

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
