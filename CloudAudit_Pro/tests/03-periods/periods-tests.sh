#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../test-helpers.sh"
source "$SCRIPT_DIR/../auth-helper.sh"

echo "╔════════════════════════════════════════════════════════════╗"
echo "║                  PERIODS TESTS                              ║"
echo "╚════════════════════════════════════════════════════════════╝"

validate_period() { 
    check_field "$1" '.id' && check_field "$1" '.name'
}
validate_list() { 
    echo "$1" | jq -e 'type == "array"' >/dev/null 2>&1
}

# Initialize authentication
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
TS=$(date +%s)

# First, create a company (required for period creation)
echo ""
echo "━━━ Setup: Create Company for Period Tests ━━━"
COMPANY_DATA='{"name":"TestCompany'$TS'","industry":"Technology","address":"123 Test Street","city":"Test City","country":"USA"}'
company_resp=$(test_endpoint "Create Company" "POST" "/companies" "$COMPANY_DATA" "201" "$TOKEN" "" 2>/dev/null)
COMPANY_ID=$(echo "$company_resp" | jq -r '.id' 2>/dev/null)

if [ -z "$COMPANY_ID" ] || [ "$COMPANY_ID" == "null" ]; then
    echo "  ⚠️  Could not create company for period tests, skipping period creation"
    
    echo "" && echo "━━━ Test 1: List Periods (fallback) ━━━"
    test_endpoint "List Periods" "GET" "/periods" "" "200" "$TOKEN" "validate_list" >/dev/null
    
    echo "" && echo "━━━ Test 2: Unauthorized Access ━━━"
    test_endpoint "No Auth" "GET" "/periods" "" "401" "" "" >/dev/null
    
    print_summary
    exit 0
fi

echo "  → Created company ID: $COMPANY_ID"

echo ""
echo "━━━ Test 1: Create Period ━━━"
START_DATE=$(date -d "2024-01-01" +%Y-%m-%d 2>/dev/null || date -v 2024y -v 1m -v 1d +%Y-%m-%d)
END_DATE=$(date -d "2024-12-31" +%Y-%m-%d 2>/dev/null || date -v 2024y -v 12m -v 31d +%Y-%m-%d)
CREATE_DATA='{"name":"FY2024-'$TS'","companyId":"'$COMPANY_ID'","startDate":"'$START_DATE'","endDate":"'$END_DATE'","fiscalYear":"2024","periodType":"ANNUAL"}'
create_resp=$(test_endpoint "Create Period" "POST" "/periods" "$CREATE_DATA" "201" "$TOKEN" "validate_period")
PERIOD_ID=$(echo "$create_resp" | jq -r '.id' 2>/dev/null)

if [ -n "$PERIOD_ID" ] && [ "$PERIOD_ID" != "null" ]; then
    echo "  → Created period ID: $PERIOD_ID"
    
    echo "" && echo "━━━ Test 2: Get Period by ID ━━━"
    test_endpoint "Get Period" "GET" "/periods/$PERIOD_ID" "" "200" "$TOKEN" "validate_period" >/dev/null
    
    echo "" && echo "━━━ Test 3: Update Period ━━━"
    UPDATE_DATA='{"name":"FY2024-Updated-'$TS'"}'
    test_endpoint "Update Period" "PATCH" "/periods/$PERIOD_ID" "$UPDATE_DATA" "200" "$TOKEN" "validate_period" >/dev/null
    
    echo "" && echo "━━━ Test 4: List Periods ━━━"
    test_endpoint "List Periods" "GET" "/periods" "" "200" "$TOKEN" "validate_list" >/dev/null
    
    echo "" && echo "━━━ Test 5: Delete Period (soft delete) ━━━"
    # Delete endpoint returns 200 if deleted, 403 if has related data (both are valid)
    delete_resp=$(api_request "DELETE" "/periods/$PERIOD_ID" "" "$TOKEN")
    delete_status=$(echo "$delete_resp" | tail -n 1)
    if [ "$delete_status" = "200" ] || [ "$delete_status" = "403" ]; then
        echo -e "  ${GREEN}✓ Delete test: PASS (status: $delete_status)${NC}" >&2
        PASSED_TESTS=$((PASSED_TESTS + 1))
    else
        echo -e "  ${RED}✗ Delete test: FAIL (expected 200 or 403, got $delete_status)${NC}" >&2
        FAILED_TESTS=$((FAILED_TESTS + 1))
    fi
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
else
    echo "  ⚠️  Could not create period for subsequent tests"
    
    echo "" && echo "━━━ Test 2: List Periods (fallback) ━━━"
    test_endpoint "List Periods" "GET" "/periods" "" "200" "$TOKEN" "validate_list" >/dev/null
fi

echo "" && echo "━━━ Test 6: Unauthorized Access ━━━"
test_endpoint "No Auth" "GET" "/periods" "" "401" "" "" >/dev/null

print_summary
