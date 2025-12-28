#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../test-helpers.sh"
source "$SCRIPT_DIR/../auth-helper.sh"

echo "╔════════════════════════════════════════════════════════════╗"
echo "║                 COMPANIES TESTS                             ║"
echo "╚════════════════════════════════════════════════════════════╝"

validate_company() { 
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
echo "━━━ Test 1: Create Company ━━━"
CREATE_DATA='{"name":"TestCompany'$TS'","industry":"Technology","address":"123 Test Street","city":"Test City","country":"USA"}'
create_resp=$(test_endpoint "Create Company" "POST" "/companies" "$CREATE_DATA" "201" "$TOKEN" "validate_company")
COMPANY_ID=$(echo "$create_resp" | jq -r '.id' 2>/dev/null)

if [ -n "$COMPANY_ID" ] && [ "$COMPANY_ID" != "null" ]; then
    echo "  → Created company ID: $COMPANY_ID"
    
    echo "" && echo "━━━ Test 2: Get Company by ID ━━━"
    test_endpoint "Get Company" "GET" "/companies/$COMPANY_ID" "" "200" "$TOKEN" "validate_company" >/dev/null
    
    echo "" && echo "━━━ Test 3: Update Company ━━━"
    UPDATE_DATA='{"name":"UpdatedCompany'$TS'","industry":"Finance"}'
    test_endpoint "Update Company" "PATCH" "/companies/$COMPANY_ID" "$UPDATE_DATA" "200" "$TOKEN" "validate_company" >/dev/null
    
    echo "" && echo "━━━ Test 4: List Companies ━━━"
    test_endpoint "List Companies" "GET" "/companies" "" "200" "$TOKEN" "validate_list" >/dev/null
    
    echo "" && echo "━━━ Test 5: Delete Company ━━━"
    test_endpoint "Delete Company" "DELETE" "/companies/$COMPANY_ID" "" "200" "$TOKEN" "" >/dev/null
else
    echo "  ⚠️  Could not create company for subsequent tests"
    
    echo "" && echo "━━━ Test 2: List Companies (fallback) ━━━"
    test_endpoint "List Companies" "GET" "/companies" "" "200" "$TOKEN" "validate_list" >/dev/null
fi

echo "" && echo "━━━ Test 6: Unauthorized Access ━━━"
test_endpoint "No Auth" "GET" "/companies" "" "401" "" "" >/dev/null

print_summary
