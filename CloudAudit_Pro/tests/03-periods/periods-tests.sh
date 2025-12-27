#!/bin/bash

# CloudAudit Pro - Periods API Tests
# Tests all period management endpoints

API_BASE_URL="http://localhost:8000/api"
TEST_RESULTS="test-results-periods.txt"
TOKENS_FILE="auth-tokens.json"

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

echo "╔════════════════════════════════════════════════════════════╗"
echo "║             CLOUDAUDIT PRO - PERIODS TESTS                  ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""

> "$TEST_RESULTS"
TOTAL_TESTS=0
PASSED_TESTS=0
FAILED_TESTS=0

if [ ! -f "$TOKENS_FILE" ]; then
    echo -e "${RED}✗ Auth tokens not found${NC}"
    exit 1
fi

ACCESS_TOKEN=$(grep -o '"accessToken":"[^"]*' "$TOKENS_FILE" | cut -d'"' -f4)

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
        ((PASSED_TESTS++))
        echo "$body"
    else
        echo -e "${RED}FAIL${NC} (Expected: $expected_status, Got: $status_code)"
        ((FAILED_TESTS++))
    fi
    echo "$body"
}

echo "▶ 1. CREATE PERIOD"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

PERIOD_PAYLOAD='{
    "name": "FY 2024",
    "startDate": "2024-01-01",
    "endDate": "2024-12-31",
    "status": "OPEN",
    "description": "Fiscal Year 2024"
}'

PERIOD_RESPONSE=$(test_endpoint_with_auth "Create new period" "POST" "/periods" "$PERIOD_PAYLOAD" "201")
PERIOD_ID=$(echo "$PERIOD_RESPONSE" | grep -o '"id":"[^"]*' | head -1 | cut -d'"' -f4)

echo ""
echo "▶ 2. GET ALL PERIODS"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
test_endpoint_with_auth "Get all periods" "GET" "/periods" "" "200" > /dev/null

echo ""
echo "▶ 3. GET PERIOD BY ID"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
if [ ! -z "$PERIOD_ID" ]; then
    test_endpoint_with_auth "Get period by ID" "GET" "/periods/$PERIOD_ID" "" "200" > /dev/null
fi

echo ""
echo "▶ 4. UPDATE PERIOD"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
if [ ! -z "$PERIOD_ID" ]; then
    UPDATE_PAYLOAD='{"name": "FY 2024 Updated", "status": "CLOSED"}'
    test_endpoint_with_auth "Update period" "PATCH" "/periods/$PERIOD_ID" "$UPDATE_PAYLOAD" "200" > /dev/null
fi

echo ""
echo "▶ 5. DELETE PERIOD"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
if [ ! -z "$PERIOD_ID" ]; then
    test_endpoint_with_auth "Delete period" "DELETE" "/periods/$PERIOD_ID" "" "200" > /dev/null
fi

echo ""
echo "═════════════════════════════════════════════════════════════"
echo "Total Tests: $TOTAL_TESTS | Passed: $PASSED_TESTS | Failed: $FAILED_TESTS"
if [ $FAILED_TESTS -eq 0 ]; then
    echo -e "${GREEN}✓ ALL TESTS PASSED!${NC}"
else
    echo -e "${RED}✗ Some tests failed${NC}"
fi
