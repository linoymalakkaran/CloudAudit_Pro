#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../test-helpers.sh"
source "$SCRIPT_DIR/../auth-helper.sh"

echo "╔════════════════════════════════════════════════════════════╗"
echo "║            PROCEDURE TEMPLATES TESTS                        ║"
echo "╚════════════════════════════════════════════════════════════╝"

validate_template() { 
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
echo "━━━ Test 1: Create Procedure Template ━━━"
CREATE_TEMPLATE='{"name":"Test Procedure Template '$TS'","category":"SUBSTANTIVE","description":"Test template description","steps":[{"stepNumber":1,"description":"Step 1","expectedResult":"Result 1"}]}'
template_resp=$(test_endpoint "Create Procedure Template" "POST" "/procedure-templates" "$CREATE_TEMPLATE" "201" "$TOKEN" "validate_template")
TEMPLATE_ID=$(echo "$template_resp" | jq -r '.id' 2>/dev/null)

if [ -n "$TEMPLATE_ID" ] && [ "$TEMPLATE_ID" != "null" ]; then
    echo "  → Created procedure template ID: $TEMPLATE_ID"
    
    echo "" && echo "━━━ Test 2: Get Procedure Template by ID ━━━"
    test_endpoint "Get Procedure Template" "GET" "/procedure-templates/$TEMPLATE_ID" "" "200" "$TOKEN" "validate_template" >/dev/null
    
    echo "" && echo "━━━ Test 3: Update Procedure Template ━━━"
    UPDATE_TEMPLATE='{"description":"Updated template description"}'
    test_endpoint "Update Procedure Template" "PUT" "/procedure-templates/$TEMPLATE_ID" "$UPDATE_TEMPLATE" "200" "$TOKEN" "validate_template" >/dev/null
    
    echo "" && echo "━━━ Test 4: Get All Procedure Templates ━━━"
    test_endpoint "List Procedure Templates" "GET" "/procedure-templates" "" "200" "$TOKEN" "validate_list" >/dev/null
    
    echo "" && echo "━━━ Test 5: Get Procedure Template Statistics ━━━"
    test_endpoint "Get Template Statistics" "GET" "/procedure-templates/statistics" "" "200" "$TOKEN" "" >/dev/null
    
    echo "" && echo "━━━ Test 6: Delete Procedure Template ━━━"
    test_endpoint "Delete Procedure Template" "DELETE" "/procedure-templates/$TEMPLATE_ID" "" "200" "$TOKEN" "" >/dev/null
fi

echo "" && echo "━━━ Test 7: Unauthorized Access ━━━"
test_endpoint "No Auth" "GET" "/procedure-templates" "" "401" "" "" >/dev/null

print_summary
