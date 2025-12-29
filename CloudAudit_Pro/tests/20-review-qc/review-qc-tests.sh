#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../test-helpers.sh"
source "$SCRIPT_DIR/../auth-helper.sh"

echo "╔════════════════════════════════════════════════════════════╗"
echo "║         REVIEW POINTS & MANAGER REVIEW TESTS                ║"
echo "╚════════════════════════════════════════════════════════════╝"

validate_review_point() { 
    check_field "$1" '.id' && check_field "$1" '.description'
}
validate_manager_review() { 
    check_field "$1" '.id' && check_field "$1" '.reviewType'
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
echo "━━━ Review Points Tests ━━━"

echo "" && echo "━━━ Test 1: Create Review Point ━━━"
CREATE_RP='{"description":"Test Review Point '$TS'","category":"ACCOUNTING","priority":"HIGH","status":"OPEN","raisedBy":"Test User"}'
rp_resp=$(test_endpoint "Create Review Point" "POST" "/review-points" "$CREATE_RP" "201" "$TOKEN" "validate_review_point")
RP_ID=$(echo "$rp_resp" | jq -r '.id' 2>/dev/null)

if [ -n "$RP_ID" ] && [ "$RP_ID" != "null" ]; then
    echo "  → Created review point ID: $RP_ID"
    
    echo "" && echo "━━━ Test 2: Get Review Point by ID ━━━"
    test_endpoint "Get Review Point" "GET" "/review-points/$RP_ID" "" "200" "$TOKEN" "validate_review_point" >/dev/null
    
    echo "" && echo "━━━ Test 3: Update Review Point ━━━"
    UPDATE_RP='{"description":"Updated Review Point '$TS'","priority":"MEDIUM"}'
    test_endpoint "Update Review Point" "PATCH" "/review-points/$RP_ID" "$UPDATE_RP" "200" "$TOKEN" "validate_review_point" >/dev/null
    
    echo "" && echo "━━━ Test 4: Get All Review Points ━━━"
    test_endpoint "List Review Points" "GET" "/review-points" "" "200" "$TOKEN" "validate_list" >/dev/null
    
    echo "" && echo "━━━ Test 5: Get Review Points Summary ━━━"
    test_endpoint "Review Points Summary" "GET" "/review-points/summary" "" "200" "$TOKEN" "" >/dev/null
    
    echo "" && echo "━━━ Test 6: Clear Review Point ━━━"
    CLEAR_DATA='{"resolution":"Test resolution","clearedBy":"Test Manager"}'
    test_endpoint "Clear Review Point" "POST" "/review-points/$RP_ID/clear" "$CLEAR_DATA" "200" "$TOKEN" "" >/dev/null
    
    echo "" && echo "━━━ Test 7: Delete Review Point ━━━"
    test_endpoint "Delete Review Point" "DELETE" "/review-points/$RP_ID" "" "200" "$TOKEN" "" >/dev/null
fi

echo ""
echo "━━━ Manager Review Tests ━━━"

echo "" && echo "━━━ Test 8: Create Manager Review ━━━"
CREATE_MR='{"reviewType":"WORKPAPER","entityId":"test-entity-id","reviewer":"Test Manager","status":"IN_PROGRESS","comments":"Initial review"}'
mr_resp=$(test_endpoint "Create Manager Review" "POST" "/manager-reviews" "$CREATE_MR" "201" "$TOKEN" "validate_manager_review")
MR_ID=$(echo "$mr_resp" | jq -r '.id' 2>/dev/null)

if [ -n "$MR_ID" ] && [ "$MR_ID" != "null" ]; then
    echo "  → Created manager review ID: $MR_ID"
    
    echo "" && echo "━━━ Test 9: Get Manager Review by ID ━━━"
    test_endpoint "Get Manager Review" "GET" "/manager-reviews/$MR_ID" "" "200" "$TOKEN" "validate_manager_review" >/dev/null
    
    echo "" && echo "━━━ Test 10: Update Manager Review ━━━"
    UPDATE_MR='{"comments":"Updated review comments","status":"COMPLETED"}'
    test_endpoint "Update Manager Review" "PATCH" "/manager-reviews/$MR_ID" "$UPDATE_MR" "200" "$TOKEN" "validate_manager_review" >/dev/null
    
    echo "" && echo "━━━ Test 11: Get All Manager Reviews ━━━"
    test_endpoint "List Manager Reviews" "GET" "/manager-reviews" "" "200" "$TOKEN" "validate_list" >/dev/null
    
    echo "" && echo "━━━ Test 12: Get Manager Reviews Summary ━━━"
    test_endpoint "Manager Reviews Summary" "GET" "/manager-reviews/summary" "" "200" "$TOKEN" "" >/dev/null
    
    echo "" && echo "━━━ Test 13: Approve Manager Review ━━━"
    APPROVE_DATA='{"approvalComments":"Approved by manager"}'
    test_endpoint "Approve Manager Review" "POST" "/manager-reviews/$MR_ID/approve" "$APPROVE_DATA" "200" "$TOKEN" "" >/dev/null
    
    echo "" && echo "━━━ Test 14: Reject Manager Review ━━━"
    # Create another review for rejection test
    CREATE_MR2='{"reviewType":"FINDING","entityId":"test-entity-2","reviewer":"Test Manager","status":"IN_PROGRESS"}'
    mr_resp2=$(test_endpoint "Create Another Review" "POST" "/manager-reviews" "$CREATE_MR2" "201" "$TOKEN" "validate_manager_review")
    MR_ID2=$(echo "$mr_resp2" | jq -r '.id' 2>/dev/null)
    
    if [ -n "$MR_ID2" ] && [ "$MR_ID2" != "null" ]; then
        REJECT_DATA='{"rejectionReason":"Needs more work"}'
        test_endpoint "Reject Manager Review" "POST" "/manager-reviews/$MR_ID2/reject" "$REJECT_DATA" "200" "$TOKEN" "" >/dev/null
        
        echo "" && echo "━━━ Test 15: Delete Second Manager Review ━━━"
        test_endpoint "Delete Manager Review 2" "DELETE" "/manager-reviews/$MR_ID2" "" "200" "$TOKEN" "" >/dev/null
    fi
    
    echo "" && echo "━━━ Test 16: Delete Manager Review ━━━"
    test_endpoint "Delete Manager Review" "DELETE" "/manager-reviews/$MR_ID" "" "200" "$TOKEN" "" >/dev/null
fi

echo "" && echo "━━━ Test 17: Unauthorized Access ━━━"
test_endpoint "No Auth" "GET" "/review-points" "" "401" "" "" >/dev/null

print_summary
