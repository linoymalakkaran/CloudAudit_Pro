#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../test-helpers.sh"
source "$SCRIPT_DIR/../auth-helper.sh"

echo "╔════════════════════════════════════════════════════════════╗"
echo "║                  ACCOUNTS TESTS                             ║"
echo "╚════════════════════════════════════════════════════════════╝"

validate_account() { check_field "$1" '.id' && check_field "$1" '.code'; }
validate_list() { echo "$1" | jq -e 'type == "array"' >/dev/null 2>&1; }
validate_chart() { echo "$1" | jq -e 'type == "object"' >/dev/null 2>&1; }

if ! init_auth; then
    auth_status=$?
    if [ $auth_status -eq 2 ]; then
        echo "26a0Fe0f  Skipping protected endpoint tests (account pending approval)"
        echo "" && echo "250125012501 Test 1: Health Check (Public) 250125012501"
        test_endpoint "API Health" "GET" "/health" "" "200" "" "" >/dev/null
        print_summary
        exit 0
    fi
    echo "❌ Failed to authenticate"
    exit 1
fi

TOKEN="$SHARED_AUTH_TOKEN"
TS=$(date +%s)

# First, create a company and period (required for account operations)
echo ""
echo "━━━ Setup: Create Company and Period for Account Tests ━━━"
COMPANY_DATA='{"name":"TestCompany'$TS'","industry":"Technology","address":"123 Test Street"}'
company_resp=$(test_endpoint "Create Company" "POST" "/companies" "$COMPANY_DATA" "201" "$TOKEN" "" 2>/dev/null)
COMPANY_ID=$(echo "$company_resp" | jq -r '.id' 2>/dev/null)

if [ -z "$COMPANY_ID" ] || [ "$COMPANY_ID" == "null" ]; then
    echo "  ⚠️  Could not create company for account tests"
    print_summary
    exit 0
fi

echo "  → Created company ID: $COMPANY_ID"

START_DATE=$(date -d "2024-01-01" +%Y-%m-%d 2>/dev/null || date -v 2024y -v 1m -v 1d +%Y-%m-%d)
END_DATE=$(date -d "2024-12-31" +%Y-%m-%d 2>/dev/null || date -v 2024y -v 12m -v 31d +%Y-%m-%d)
PERIOD_DATA='{"name":"FY2024-'$TS'","companyId":"'$COMPANY_ID'","startDate":"'$START_DATE'","endDate":"'$END_DATE'","fiscalYear":"2024","periodType":"ANNUAL"}'
period_resp=$(test_endpoint "Create Period" "POST" "/periods" "$PERIOD_DATA" "201" "$TOKEN" "" 2>/dev/null)
PERIOD_ID=$(echo "$period_resp" | jq -r '.id' 2>/dev/null)

if [ -z "$PERIOD_ID" ] || [ "$PERIOD_ID" == "null" ]; then
    echo "  ⚠️  Could not create period for account tests"
    print_summary
    exit 0
fi

echo "  → Created period ID: $PERIOD_ID"

echo ""
echo "━━━ Test 1: List Accounts for Period ━━━"
test_endpoint "List Accounts" "GET" "/accounts/period/$PERIOD_ID" "" "200" "$TOKEN" "validate_list" >/dev/null

echo "" && echo "━━━ Test 2: Get Chart of Accounts ━━━"
test_endpoint "Chart of Accounts" "GET" "/accounts/chart/$PERIOD_ID" "" "200" "$TOKEN" "validate_chart" >/dev/null

echo "" && echo "━━━ Test 3: Unauthorized Access ━━━"
test_endpoint "No Auth" "GET" "/accounts/period/$PERIOD_ID" "" "401" "" "" >/dev/null

print_summary
