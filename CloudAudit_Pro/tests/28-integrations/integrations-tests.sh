#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../test-helpers.sh"
source "$SCRIPT_DIR/../auth-helper.sh"

echo "╔════════════════════════════════════════════════════════════╗"
echo "║                 INTEGRATIONS TESTS                          ║"
echo "╚════════════════════════════════════════════════════════════╝"

validate_integration() { 
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
        print_summary
        exit 0
    fi
    echo "❌ Failed to authenticate"
    exit 1
fi

TOKEN="$SHARED_AUTH_TOKEN"
TS=$(date +%s)

echo ""
echo "━━━ Test 1: Create Integration ━━━"
CREATE_INT='{"name":"Test Integration '$TS'","type":"API","provider":"QuickBooks","config":{"apiKey":"test-key","apiSecret":"test-secret"},"isActive":true}'
int_resp=$(test_endpoint "Create Integration" "POST" "/integrations" "$CREATE_INT" "201" "$TOKEN" "validate_integration")
INT_ID=$(echo "$int_resp" | jq -r '.id' 2>/dev/null)

if [ -n "$INT_ID" ] && [ "$INT_ID" != "null" ]; then
    echo "  → Created integration ID: $INT_ID"
    
    echo "" && echo "━━━ Test 2: Get Integration by ID ━━━"
    test_endpoint "Get Integration" "GET" "/integrations/$INT_ID" "" "200" "$TOKEN" "validate_integration" >/dev/null
    
    echo "" && echo "━━━ Test 3: Update Integration ━━━"
    UPDATE_INT='{"config":{"apiKey":"updated-key"}}'
    test_endpoint "Update Integration" "PATCH" "/integrations/$INT_ID" "$UPDATE_INT" "200" "$TOKEN" "validate_integration" >/dev/null
    
    echo "" && echo "━━━ Test 4: Get All Integrations ━━━"
    test_endpoint "List Integrations" "GET" "/integrations" "" "200" "$TOKEN" "validate_list" >/dev/null
    
    echo "" && echo "━━━ Test 5: Get Active Integrations ━━━"
    test_endpoint "Get Active Integrations" "GET" "/integrations/active" "" "200" "$TOKEN" "validate_list" >/dev/null
    
    echo "" && echo "━━━ Test 6: Test Integration Connection ━━━"
    test_endpoint "Test Connection" "POST" "/integrations/$INT_ID/test" "" "200" "$TOKEN" "" >/dev/null
    
    echo "" && echo "━━━ Test 7: Sync Integration ━━━"
    SYNC_DATA='{"syncType":"FULL","entities":["accounts","transactions"]}'
    test_endpoint "Sync Integration" "POST" "/integrations/$INT_ID/sync" "$SYNC_DATA" "200" "$TOKEN" "" >/dev/null
    
    echo "" && echo "━━━ Test 8: Enable Integration ━━━"
    test_endpoint "Enable Integration" "POST" "/integrations/$INT_ID/enable" "" "200" "$TOKEN" "" >/dev/null
    
    echo "" && echo "━━━ Test 9: Disable Integration ━━━"
    test_endpoint "Disable Integration" "POST" "/integrations/$INT_ID/disable" "" "200" "$TOKEN" "" >/dev/null
    
    echo "" && echo "━━━ Test 10: Get Integration Logs ━━━"
    test_endpoint "Get Integration Logs" "GET" "/integrations/$INT_ID/logs" "" "200" "$TOKEN" "" >/dev/null
    
    echo "" && echo "━━━ Test 11: Get Integration Statistics ━━━"
    test_endpoint "Get Integration Stats" "GET" "/integrations/$INT_ID/stats" "" "200" "$TOKEN" "" >/dev/null
    
    echo "" && echo "━━━ Test 12: Delete Integration ━━━"
    test_endpoint "Delete Integration" "DELETE" "/integrations/$INT_ID" "" "200" "$TOKEN" "" >/dev/null
fi

echo "" && echo "━━━ Test 13: Unauthorized Access ━━━"
test_endpoint "No Auth" "GET" "/integrations" "" "401" "" "" >/dev/null

print_summary
