#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../test-helpers.sh"
source "$SCRIPT_DIR/../auth-helper.sh"

echo "╔════════════════════════════════════════════════════════════╗"
echo "║      FIXED ASSETS, LIABILITIES & EQUITY TESTS               ║"
echo "╚════════════════════════════════════════════════════════════╝"

validate_asset() { 
    check_field "$1" '.id' && check_field "$1" '.name'
}
validate_liability() { 
    check_field "$1" '.id' && check_field "$1" '.description'
}
validate_equity() { 
    check_field "$1" '.id' && check_field "$1" '.type'
}
validate_list() { 
    echo "$1" | jq -e 'type == "array"' >/dev/null 2>&1
}

# Initialize authentication
if ! init_auth; then
    auth_status=$?
    if [ $auth_status -eq 2 ]; then
        echo "⚠️  Skipping protected endpoint tests (account pending approval)"
        print_summary
        exit 0
    fi
    echo "❌ Failed to authenticate"
    exit 1
fi

TOKEN="$SHARED_AUTH_TOKEN"
TS=$(date +%s)

echo ""
echo "━━━ Fixed Assets Tests ━━━"

echo "" && echo "━━━ Test 1: Create Fixed Asset ━━━"
CREATE_ASSET='{"name":"Test Asset '$TS'","category":"EQUIPMENT","purchaseDate":"2025-01-01","purchaseCost":10000,"usefulLife":5,"depreciationMethod":"STRAIGHT_LINE"}'
asset_resp=$(test_endpoint "Create Fixed Asset" "POST" "/fixed-assets" "$CREATE_ASSET" "201" "$TOKEN" "validate_asset")
ASSET_ID=$(echo "$asset_resp" | jq -r '.id' 2>/dev/null)

if [ -n "$ASSET_ID" ] && [ "$ASSET_ID" != "null" ]; then
    echo "  → Created fixed asset ID: $ASSET_ID"
    
    echo "" && echo "━━━ Test 2: Get Fixed Asset by ID ━━━"
    test_endpoint "Get Fixed Asset" "GET" "/fixed-assets/$ASSET_ID" "" "200" "$TOKEN" "validate_asset" >/dev/null
    
    echo "" && echo "━━━ Test 3: Update Fixed Asset ━━━"
    UPDATE_ASSET='{"name":"Updated Test Asset '$TS'"}'
    test_endpoint "Update Fixed Asset" "PATCH" "/fixed-assets/$ASSET_ID" "$UPDATE_ASSET" "200" "$TOKEN" "validate_asset" >/dev/null
    
    echo "" && echo "━━━ Test 4: Get All Fixed Assets ━━━"
    test_endpoint "List Fixed Assets" "GET" "/fixed-assets" "" "200" "$TOKEN" "validate_list" >/dev/null
    
    echo "" && echo "━━━ Test 5: Get Fixed Assets Summary ━━━"
    test_endpoint "Fixed Assets Summary" "GET" "/fixed-assets/summary" "" "200" "$TOKEN" "" >/dev/null
    
    echo "" && echo "━━━ Test 6: Delete Fixed Asset ━━━"
    test_endpoint "Delete Fixed Asset" "DELETE" "/fixed-assets/$ASSET_ID" "" "200" "$TOKEN" "" >/dev/null
fi

echo ""
echo "━━━ Liabilities Tests ━━━"

echo "" && echo "━━━ Test 7: Create Liability ━━━"
CREATE_LIABILITY='{"description":"Test Liability '$TS'","type":"ACCOUNTS_PAYABLE","amount":5000,"dueDate":"2025-12-31","vendor":"Test Vendor"}'
liability_resp=$(test_endpoint "Create Liability" "POST" "/liabilities" "$CREATE_LIABILITY" "201" "$TOKEN" "validate_liability")
LIABILITY_ID=$(echo "$liability_resp" | jq -r '.id' 2>/dev/null)

if [ -n "$LIABILITY_ID" ] && [ "$LIABILITY_ID" != "null" ]; then
    echo "  → Created liability ID: $LIABILITY_ID"
    
    echo "" && echo "━━━ Test 8: Get Liability by ID ━━━"
    test_endpoint "Get Liability" "GET" "/liabilities/$LIABILITY_ID" "" "200" "$TOKEN" "validate_liability" >/dev/null
    
    echo "" && echo "━━━ Test 9: Update Liability ━━━"
    UPDATE_LIABILITY='{"description":"Updated Test Liability '$TS'","amount":5500}'
    test_endpoint "Update Liability" "PATCH" "/liabilities/$LIABILITY_ID" "$UPDATE_LIABILITY" "200" "$TOKEN" "validate_liability" >/dev/null
    
    echo "" && echo "━━━ Test 10: Get All Liabilities ━━━"
    test_endpoint "List Liabilities" "GET" "/liabilities" "" "200" "$TOKEN" "validate_list" >/dev/null
    
    echo "" && echo "━━━ Test 11: Get Aging Summary ━━━"
    test_endpoint "Aging Summary" "GET" "/liabilities/aging-summary" "" "200" "$TOKEN" "" >/dev/null
    
    echo "" && echo "━━━ Test 12: Delete Liability ━━━"
    test_endpoint "Delete Liability" "DELETE" "/liabilities/$LIABILITY_ID" "" "200" "$TOKEN" "" >/dev/null
fi

echo ""
echo "━━━ Equity Tests ━━━"

echo "" && echo "━━━ Test 13: Create Equity Entry ━━━"
CREATE_EQUITY='{"type":"COMMON_STOCK","description":"Test Equity '$TS'","amount":10000,"date":"2025-01-01"}'
equity_resp=$(test_endpoint "Create Equity Entry" "POST" "/equity" "$CREATE_EQUITY" "201" "$TOKEN" "validate_equity")
EQUITY_ID=$(echo "$equity_resp" | jq -r '.id' 2>/dev/null)

if [ -n "$EQUITY_ID" ] && [ "$EQUITY_ID" != "null" ]; then
    echo "  → Created equity ID: $EQUITY_ID"
    
    echo "" && echo "━━━ Test 14: Get Equity by ID ━━━"
    test_endpoint "Get Equity" "GET" "/equity/$EQUITY_ID" "" "200" "$TOKEN" "validate_equity" >/dev/null
    
    echo "" && echo "━━━ Test 15: Update Equity ━━━"
    UPDATE_EQUITY='{"description":"Updated Test Equity '$TS'","amount":12000}'
    test_endpoint "Update Equity" "PATCH" "/equity/$EQUITY_ID" "$UPDATE_EQUITY" "200" "$TOKEN" "validate_equity" >/dev/null
    
    echo "" && echo "━━━ Test 16: Get All Equity Entries ━━━"
    test_endpoint "List Equity" "GET" "/equity" "" "200" "$TOKEN" "validate_list" >/dev/null
    
    echo "" && echo "━━━ Test 17: Get Equity Summary ━━━"
    test_endpoint "Equity Summary" "GET" "/equity/summary" "" "200" "$TOKEN" "" >/dev/null
    
    echo "" && echo "━━━ Test 18: Delete Equity ━━━"
    test_endpoint "Delete Equity" "DELETE" "/equity/$EQUITY_ID" "" "200" "$TOKEN" "" >/dev/null
fi

echo "" && echo "━━━ Test 19: Unauthorized Access ━━━"
test_endpoint "No Auth" "GET" "/fixed-assets" "" "401" "" "" >/dev/null

print_summary
