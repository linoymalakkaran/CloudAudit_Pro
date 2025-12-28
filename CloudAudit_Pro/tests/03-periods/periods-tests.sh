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
    echo "❌ Failed to authenticate"
    exit 1
fi

TOKEN="$SHARED_AUTH_TOKEN"
TS=$(date +%s)

echo ""
echo "━━━ Test 1: Create Period ━━━"
START_DATE=$(date -d "2024-01-01" +%Y-%m-%d 2>/dev/null || date -v 2024y -v 1m -v 1d +%Y-%m-%d)
END_DATE=$(date -d "2024-12-31" +%Y-%m-%d 2>/dev/null || date -v 2024y -v 12m -v 31d +%Y-%m-%d)
CREATE_DATA='{"name":"FY2024-'$TS'","startDate":"'$START_DATE'","endDate":"'$END_DATE'","status":"ACTIVE"}'
create_resp=$(test_endpoint "Create Period" "POST" "/periods" "$CREATE_DATA" "201" "$TOKEN" "validate_period")
PERIOD_ID=$(echo "$create_resp" | jq -r '.id' 2>/dev/null)

if [ -n "$PERIOD_ID" ] && [ "$PERIOD_ID" != "null" ]; then
    echo "  → Created period ID: $PERIOD_ID"
    
    echo "" && echo "━━━ Test 2: Get Period by ID ━━━"
    test_endpoint "Get Period" "GET" "/periods/$PERIOD_ID" "" "200" "$TOKEN" "validate_period" >/dev/null
    
    echo "" && echo "━━━ Test 3: Update Period ━━━"
    UPDATE_DATA='{"name":"FY2024-Updated-'$TS'","status":"CLOSED"}'
    test_endpoint "Update Period" "PATCH" "/periods/$PERIOD_ID" "$UPDATE_DATA" "200" "$TOKEN" "validate_period" >/dev/null
    
    echo "" && echo "━━━ Test 4: List Periods ━━━"
    test_endpoint "List Periods" "GET" "/periods" "" "200" "$TOKEN" "validate_list" >/dev/null
    
    echo "" && echo "━━━ Test 5: Delete Period ━━━"
    test_endpoint "Delete Period" "DELETE" "/periods/$PERIOD_ID" "" "200" "$TOKEN" "" >/dev/null
else
    echo "  ⚠️  Could not create period for subsequent tests"
    
    echo "" && echo "━━━ Test 2: List Periods (fallback) ━━━"
    test_endpoint "List Periods" "GET" "/periods" "" "200" "$TOKEN" "validate_list" >/dev/null
fi

echo "" && echo "━━━ Test 6: Unauthorized Access ━━━"
test_endpoint "No Auth" "GET" "/periods" "" "401" "" "" >/dev/null

print_summary
