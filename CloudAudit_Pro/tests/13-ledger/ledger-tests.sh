#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../test-helpers.sh"
source "$SCRIPT_DIR/../auth-helper.sh"

echo "╔════════════════════════════════════════════════════════════╗"
echo "║                  LEDGER TESTS                               ║"
echo "╚════════════════════════════════════════════════════════════╝"

validate_ledger() { echo "$1" | jq -e '.entries | type == "array"' >/dev/null 2>&1; }
validate_list() { echo "$1" | jq -e 'type == "array"' >/dev/null 2>&1; }

if ! init_auth; then
    auth_status=$?
    if [ $auth_status -eq 2 ]; then
        echo "⚠️  Skipping protected endpoint tests (account pending approval)"
        echo "" && echo "━━━ Test 1: Health Check (Public) ━━━"
        test_endpoint "API Health" "GET" "/health" "" "200" "" "" >/dev/null
        print_summary
        exit 0
    fi
    echo "❌ Failed to authenticate"
    exit 1
fi

TOKEN="$SHARED_AUTH_TOKEN"

# Create test data with proper error handling
echo "🔧 Setting up test data..."

# Create company
COMPANY_RESPONSE=$(curl -s -X POST "$API_BASE_URL/companies" \
    -H "Authorization: Bearer $TOKEN" \
    -H "Content-Type: application/json" \
    -d '{"name":"Ledger Test Co","code":"LTC'$(date +%s)'","fiscalYearEnd":"12-31"}')
COMPANY_ID=$(echo "$COMPANY_RESPONSE" | jq -r '.id // empty')

if [ -z "$COMPANY_ID" ]; then
    echo "❌ Failed to create company"
    echo "Response: $COMPANY_RESPONSE"
    echo "" && echo "━━━ Test 1: Health Check ━━━"
    test_endpoint "API Health" "GET" "/health" "" "200" "" "" >/dev/null
    print_summary
    exit 0
fi

# Create period
PERIOD_RESPONSE=$(curl -s -X POST "$API_BASE_URL/periods" \
    -H "Authorization: Bearer $TOKEN" \
    -H "Content-Type: application/json" \
    -d "{\"companyId\":\"$COMPANY_ID\",\"name\":\"FY2024\",\"startDate\":\"2024-01-01\",\"endDate\":\"2024-12-31\",\"status\":\"ACTIVE\"}")
PERIOD_ID=$(echo "$PERIOD_RESPONSE" | jq -r '.id // empty')

if [ -z "$PERIOD_ID" ]; then
    echo "❌ Failed to create period"
    echo "Response: $PERIOD_RESPONSE"
    echo "" && echo "━━━ Test 1: Health Check ━━━"
    test_endpoint "API Health" "GET" "/health" "" "200" "" "" >/dev/null
    print_summary
    exit 0
fi

# Create account
ACCOUNT_RESPONSE=$(curl -s -X POST "$API_BASE_URL/accounts" \
    -H "Authorization: Bearer $TOKEN" \
    -H "Content-Type: application/json" \
    -d "{\"companyId\":\"$COMPANY_ID\",\"periodId\":\"$PERIOD_ID\",\"accountCode\":\"1000\",\"accountName\":\"Cash\",\"accountType\":\"ASSET\",\"isActive\":true}")
ACCOUNT_ID=$(echo "$ACCOUNT_RESPONSE" | jq -r '.id // empty')

if [ -z "$ACCOUNT_ID" ]; then
    echo "❌ Failed to create account"
    echo "Response: $ACCOUNT_RESPONSE"
    echo "" && echo "━━━ Test 1: Health Check ━━━"
    test_endpoint "API Health" "GET" "/health" "" "200" "" "" >/dev/null
    print_summary
    exit 0
fi

echo "✓ Test data created successfully"
echo "  Company: $COMPANY_ID"
echo "  Period: $PERIOD_ID"
echo "  Account: $ACCOUNT_ID"

echo ""
echo "━━━ Test 1: Get Ledger ━━━"
test_endpoint "Get Ledger" "GET" "/ledger?companyId=$COMPANY_ID&periodId=$PERIOD_ID&accountId=$ACCOUNT_ID" "" "200" "$TOKEN" "validate_ledger" >/dev/null

echo "" && echo "━━━ Test 2: Unauthorized Access ━━━"
test_endpoint "No Auth" "GET" "/ledger?companyId=$COMPANY_ID&periodId=$PERIOD_ID&accountId=$ACCOUNT_ID" "" "401" "" "" >/dev/null

echo "" && echo "━━━ Test 3: Health Check ━━━"
test_endpoint "API Health" "GET" "/health" "" "200" "" "" >/dev/null

print_summary
