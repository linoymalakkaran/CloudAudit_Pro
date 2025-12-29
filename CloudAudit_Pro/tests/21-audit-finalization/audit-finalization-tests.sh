#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../test-helpers.sh"
source "$SCRIPT_DIR/../auth-helper.sh"

echo "╔════════════════════════════════════════════════════════════╗"
echo "║            AUDIT FINALIZATION TESTS                         ║"
echo "╚════════════════════════════════════════════════════════════╝"

validate_finalization() { 
    check_field "$1" '.id' && check_field "$1" '.status'
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
echo "━━━ Test 1: Create Audit Finalization ━━━"
CREATE_FIN='{"companyId":"test-company-id","periodId":"test-period-id","status":"IN_PROGRESS","opinionType":"UNQUALIFIED","completedBy":"Test Auditor"}'
fin_resp=$(test_endpoint "Create Audit Finalization" "POST" "/audit-finalization" "$CREATE_FIN" "201" "$TOKEN" "validate_finalization")
FIN_ID=$(echo "$fin_resp" | jq -r '.id' 2>/dev/null)

if [ -n "$FIN_ID" ] && [ "$FIN_ID" != "null" ]; then
    echo "  → Created audit finalization ID: $FIN_ID"
    
    echo "" && echo "━━━ Test 2: Get Audit Finalization by ID ━━━"
    test_endpoint "Get Audit Finalization" "GET" "/audit-finalization/$FIN_ID" "" "200" "$TOKEN" "validate_finalization" >/dev/null
    
    echo "" && echo "━━━ Test 3: Update Audit Finalization ━━━"
    UPDATE_FIN='{"status":"REVIEW","opinionType":"QUALIFIED"}'
    test_endpoint "Update Audit Finalization" "PATCH" "/audit-finalization/$FIN_ID" "$UPDATE_FIN" "200" "$TOKEN" "validate_finalization" >/dev/null
    
    echo "" && echo "━━━ Test 4: Get All Audit Finalizations ━━━"
    test_endpoint "List Audit Finalizations" "GET" "/audit-finalization" "" "200" "$TOKEN" "validate_list" >/dev/null
    
    echo "" && echo "━━━ Test 5: Get Audit Summary ━━━"
    test_endpoint "Get Audit Summary" "GET" "/audit-finalization/summary?companyId=test-company-id&periodId=test-period-id" "" "200" "$TOKEN" "" >/dev/null
    
    echo "" && echo "━━━ Test 6: Get Audit Finalization by Company and Period ━━━"
    test_endpoint "Get by Company/Period" "GET" "/audit-finalization/by-company-period?companyId=test-company-id&periodId=test-period-id" "" "200" "$TOKEN" "" >/dev/null
    
    echo "" && echo "━━━ Test 7: Finalize Audit ━━━"
    FINALIZE_DATA='{"finalizedBy":"Test Partner","finalizedDate":"2025-12-31","notes":"Audit completed successfully"}'
    test_endpoint "Finalize Audit" "POST" "/audit-finalization/$FIN_ID/finalize" "$FINALIZE_DATA" "200" "$TOKEN" "" >/dev/null
    
    echo "" && echo "━━━ Test 8: Issue Audit Report ━━━"
    ISSUE_DATA='{"issuedBy":"Test Partner","issuedDate":"2025-12-31","reportFormat":"PDF"}'
    test_endpoint "Issue Audit Report" "POST" "/audit-finalization/$FIN_ID/issue" "$ISSUE_DATA" "200" "$TOKEN" "" >/dev/null
    
    echo "" && echo "━━━ Test 9: Delete Audit Finalization ━━━"
    test_endpoint "Delete Audit Finalization" "DELETE" "/audit-finalization/$FIN_ID" "" "200" "$TOKEN" "" >/dev/null
fi

echo "" && echo "━━━ Test 10: Unauthorized Access ━━━"
test_endpoint "No Auth" "GET" "/audit-finalization" "" "401" "" "" >/dev/null

print_summary
