#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../test-helpers.sh"
source "$SCRIPT_DIR/../auth-helper.sh"

echo "╔════════════════════════════════════════════════════════════╗"
echo "║   SAMPLING, SUBSTANTIVE & INTERNAL CONTROLS TESTS           ║"
echo "╚════════════════════════════════════════════════════════════╝"

validate_sampling() { 
    check_field "$1" '.id' && check_field "$1" '.populationSize'
}
validate_substantive() { 
    check_field "$1" '.id' && check_field "$1" '.testType'
}
validate_control() { 
    check_field "$1" '.id' && check_field "$1" '.controlName'
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
echo "━━━ Sampling Tests ━━━"

echo "" && echo "━━━ Test 1: Calculate Sample Size ━━━"
CALC_DATA='{"populationSize":1000,"confidenceLevel":95,"expectedError":2,"tolerableError":5}'
test_endpoint "Calculate Sample Size" "GET" "/sampling/calculate-sample-size?populationSize=1000&confidenceLevel=95" "" "200" "$TOKEN" "" >/dev/null

echo "" && echo "━━━ Test 2: Create Sampling Plan ━━━"
CREATE_SAMPLING='{"name":"Test Sampling Plan '$TS'","populationSize":1000,"sampleSize":100,"samplingMethod":"RANDOM","objective":"Test objective"}'
sampling_resp=$(test_endpoint "Create Sampling Plan" "POST" "/sampling" "$CREATE_SAMPLING" "201" "$TOKEN" "validate_sampling")
SAMPLING_ID=$(echo "$sampling_resp" | jq -r '.id' 2>/dev/null)

if [ -n "$SAMPLING_ID" ] && [ "$SAMPLING_ID" != "null" ]; then
    echo "  → Created sampling plan ID: $SAMPLING_ID"
    
    echo "" && echo "━━━ Test 3: Get Sampling Plan by ID ━━━"
    test_endpoint "Get Sampling Plan" "GET" "/sampling/$SAMPLING_ID" "" "200" "$TOKEN" "validate_sampling" >/dev/null
    
    echo "" && echo "━━━ Test 4: Update Sampling Plan ━━━"
    UPDATE_SAMPLING='{"sampleSize":120}'
    test_endpoint "Update Sampling Plan" "PATCH" "/sampling/$SAMPLING_ID" "$UPDATE_SAMPLING" "200" "$TOKEN" "validate_sampling" >/dev/null
    
    echo "" && echo "━━━ Test 5: Get All Sampling Plans ━━━"
    test_endpoint "List Sampling Plans" "GET" "/sampling" "" "200" "$TOKEN" "validate_list" >/dev/null
    
    echo "" && echo "━━━ Test 6: Get Sampling Summary ━━━"
    test_endpoint "Sampling Summary" "GET" "/sampling/summary" "" "200" "$TOKEN" "" >/dev/null
    
    echo "" && echo "━━━ Test 7: Generate Sample Selection ━━━"
    GENERATE_DATA='{"seed":12345}'
    test_endpoint "Generate Sample" "POST" "/sampling/$SAMPLING_ID/generate-sample" "$GENERATE_DATA" "200" "$TOKEN" "" >/dev/null
    
    echo "" && echo "━━━ Test 8: Delete Sampling Plan ━━━"
    test_endpoint "Delete Sampling Plan" "DELETE" "/sampling/$SAMPLING_ID" "" "200" "$TOKEN" "" >/dev/null
fi

echo ""
echo "━━━ Substantive Testing Tests ━━━"

echo "" && echo "━━━ Test 9: Create Substantive Test ━━━"
CREATE_SUB='{"testType":"DETAIL_TEST","accountId":"test-account","objective":"Verify account balance","procedures":"Test procedures","expectedResult":"Balance verified"}'
sub_resp=$(test_endpoint "Create Substantive Test" "POST" "/substantive-testing" "$CREATE_SUB" "201" "$TOKEN" "validate_substantive")
SUB_ID=$(echo "$sub_resp" | jq -r '.id' 2>/dev/null)

if [ -n "$SUB_ID" ] && [ "$SUB_ID" != "null" ]; then
    echo "  → Created substantive test ID: $SUB_ID"
    
    echo "" && echo "━━━ Test 10: Get Substantive Test by ID ━━━"
    test_endpoint "Get Substantive Test" "GET" "/substantive-testing/$SUB_ID" "" "200" "$TOKEN" "validate_substantive" >/dev/null
    
    echo "" && echo "━━━ Test 11: Update Substantive Test ━━━"
    UPDATE_SUB='{"status":"IN_PROGRESS","actualResult":"Testing in progress"}'
    test_endpoint "Update Substantive Test" "PATCH" "/substantive-testing/$SUB_ID" "$UPDATE_SUB" "200" "$TOKEN" "validate_substantive" >/dev/null
    
    echo "" && echo "━━━ Test 12: Get All Substantive Tests ━━━"
    test_endpoint "List Substantive Tests" "GET" "/substantive-testing" "" "200" "$TOKEN" "validate_list" >/dev/null
    
    echo "" && echo "━━━ Test 13: Get Substantive Testing Summary ━━━"
    test_endpoint "Substantive Testing Summary" "GET" "/substantive-testing/summary" "" "200" "$TOKEN" "" >/dev/null
    
    echo "" && echo "━━━ Test 14: Complete Substantive Test ━━━"
    COMPLETE_DATA='{"actualResult":"Test completed successfully","conclusion":"No exceptions noted"}'
    test_endpoint "Complete Substantive Test" "POST" "/substantive-testing/$SUB_ID/complete" "$COMPLETE_DATA" "200" "$TOKEN" "" >/dev/null
    
    echo "" && echo "━━━ Test 15: Review Substantive Test ━━━"
    REVIEW_DATA='{"reviewComments":"Reviewed and approved","reviewedBy":"Test Reviewer"}'
    test_endpoint "Review Substantive Test" "POST" "/substantive-testing/$SUB_ID/review" "$REVIEW_DATA" "200" "$TOKEN" "" >/dev/null
    
    echo "" && echo "━━━ Test 16: Delete Substantive Test ━━━"
    test_endpoint "Delete Substantive Test" "DELETE" "/substantive-testing/$SUB_ID" "" "200" "$TOKEN" "" >/dev/null
fi

echo ""
echo "━━━ Internal Controls Tests ━━━"

echo "" && echo "━━━ Test 17: Create Internal Control ━━━"
CREATE_CONTROL='{"controlName":"Test Control '$TS'","controlType":"PREVENTIVE","description":"Test control description","frequency":"MONTHLY","owner":"Test Owner"}'
control_resp=$(test_endpoint "Create Internal Control" "POST" "/internal-controls" "$CREATE_CONTROL" "201" "$TOKEN" "validate_control")
CONTROL_ID=$(echo "$control_resp" | jq -r '.id' 2>/dev/null)

if [ -n "$CONTROL_ID" ] && [ "$CONTROL_ID" != "null" ]; then
    echo "  → Created internal control ID: $CONTROL_ID"
    
    echo "" && echo "━━━ Test 18: Get Internal Control by ID ━━━"
    test_endpoint "Get Internal Control" "GET" "/internal-controls/$CONTROL_ID" "" "200" "$TOKEN" "validate_control" >/dev/null
    
    echo "" && echo "━━━ Test 19: Update Internal Control ━━━"
    UPDATE_CONTROL='{"frequency":"QUARTERLY","description":"Updated control description"}'
    test_endpoint "Update Internal Control" "PATCH" "/internal-controls/$CONTROL_ID" "$UPDATE_CONTROL" "200" "$TOKEN" "validate_control" >/dev/null
    
    echo "" && echo "━━━ Test 20: Get All Internal Controls ━━━"
    test_endpoint "List Internal Controls" "GET" "/internal-controls" "" "200" "$TOKEN" "validate_list" >/dev/null
    
    echo "" && echo "━━━ Test 21: Get Internal Controls Summary ━━━"
    test_endpoint "Internal Controls Summary" "GET" "/internal-controls/summary" "" "200" "$TOKEN" "" >/dev/null
    
    echo "" && echo "━━━ Test 22: Test Internal Control ━━━"
    TEST_DATA='{"testDate":"2025-01-15","testResult":"EFFECTIVE","testNotes":"Control is operating effectively"}'
    test_endpoint "Test Internal Control" "POST" "/internal-controls/$CONTROL_ID/test" "$TEST_DATA" "200" "$TOKEN" "" >/dev/null
    
    echo "" && echo "━━━ Test 23: Identify Control Deficiency ━━━"
    DEFICIENCY_DATA='{"severity":"MINOR","description":"Minor control gap identified","remediationPlan":"Will address in next quarter"}'
    test_endpoint "Identify Deficiency" "POST" "/internal-controls/$CONTROL_ID/deficiency" "$DEFICIENCY_DATA" "200" "$TOKEN" "" >/dev/null
    
    echo "" && echo "━━━ Test 24: Review Internal Control ━━━"
    CONTROL_REVIEW='{"reviewComments":"Control reviewed and approved","reviewedBy":"Test Reviewer"}'
    test_endpoint "Review Internal Control" "POST" "/internal-controls/$CONTROL_ID/review" "$CONTROL_REVIEW" "200" "$TOKEN" "" >/dev/null
    
    echo "" && echo "━━━ Test 25: Delete Internal Control ━━━"
    test_endpoint "Delete Internal Control" "DELETE" "/internal-controls/$CONTROL_ID" "" "200" "$TOKEN" "" >/dev/null
fi

echo "" && echo "━━━ Test 26: Unauthorized Access ━━━"
test_endpoint "No Auth" "GET" "/sampling" "" "401" "" "" >/dev/null

print_summary
