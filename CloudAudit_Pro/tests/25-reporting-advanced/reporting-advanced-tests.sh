#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../test-helpers.sh"
source "$SCRIPT_DIR/../auth-helper.sh"

echo "╔════════════════════════════════════════════════════════════╗"
echo "║      REPORT TEMPLATES & SCHEDULES TESTS                     ║"
echo "╚════════════════════════════════════════════════════════════╝"

validate_template() { 
    check_field "$1" '.id' && check_field "$1" '.name'
}
validate_schedule() { 
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
echo "━━━ Report Templates Tests ━━━"

echo "" && echo "━━━ Test 1: Create Report Template ━━━"
CREATE_TEMPLATE='{"name":"Test Report Template '$TS'","type":"FINANCIAL","description":"Test template","layout":"standard","isActive":true}'
template_resp=$(test_endpoint "Create Report Template" "POST" "/report-templates" "$CREATE_TEMPLATE" "201" "$TOKEN" "validate_template")
TEMPLATE_ID=$(echo "$template_resp" | jq -r '.id' 2>/dev/null)

if [ -n "$TEMPLATE_ID" ] && [ "$TEMPLATE_ID" != "null" ]; then
    echo "  → Created report template ID: $TEMPLATE_ID"
    
    echo "" && echo "━━━ Test 2: Get Report Template by ID ━━━"
    test_endpoint "Get Report Template" "GET" "/report-templates/$TEMPLATE_ID" "" "200" "$TOKEN" "validate_template" >/dev/null
    
    echo "" && echo "━━━ Test 3: Update Report Template ━━━"
    UPDATE_TEMPLATE='{"description":"Updated template description"}'
    test_endpoint "Update Report Template" "PATCH" "/report-templates/$TEMPLATE_ID" "$UPDATE_TEMPLATE" "200" "$TOKEN" "validate_template" >/dev/null
    
    echo "" && echo "━━━ Test 4: Get All Report Templates ━━━"
    test_endpoint "List Report Templates" "GET" "/report-templates" "" "200" "$TOKEN" "validate_list" >/dev/null
    
    echo "" && echo "━━━ Test 5: Get Standard Report Templates ━━━"
    test_endpoint "Get Standard Templates" "GET" "/report-templates/standard" "" "200" "$TOKEN" "validate_list" >/dev/null
    
    echo "" && echo "━━━ Test 6: Get Templates by Type ━━━"
    test_endpoint "Get Templates by Type" "GET" "/report-templates/by-type/FINANCIAL" "" "200" "$TOKEN" "validate_list" >/dev/null
    
    echo "" && echo "━━━ Test 7: Duplicate Report Template ━━━"
    DUPLICATE_DATA='{"name":"Duplicated Template '$TS'"}'
    test_endpoint "Duplicate Template" "POST" "/report-templates/$TEMPLATE_ID/duplicate" "$DUPLICATE_DATA" "201" "$TOKEN" "" >/dev/null
    
    echo "" && echo "━━━ Test 8: Toggle Template Active Status ━━━"
    test_endpoint "Toggle Active" "POST" "/report-templates/$TEMPLATE_ID/toggle-active" "" "200" "$TOKEN" "" >/dev/null
    
    echo "" && echo "━━━ Test 9: Delete Report Template ━━━"
    test_endpoint "Delete Report Template" "DELETE" "/report-templates/$TEMPLATE_ID" "" "200" "$TOKEN" "" >/dev/null
fi

echo ""
echo "━━━ Report Schedules Tests ━━━"

echo "" && echo "━━━ Test 10: Create Report Schedule ━━━"
CREATE_SCHEDULE='{"name":"Test Schedule '$TS'","reportTemplateId":"test-template-id","frequency":"MONTHLY","recipients":["user@test.com"],"isActive":true}'
schedule_resp=$(test_endpoint "Create Report Schedule" "POST" "/report-schedules" "$CREATE_SCHEDULE" "201" "$TOKEN" "validate_schedule")
SCHEDULE_ID=$(echo "$schedule_resp" | jq -r '.id' 2>/dev/null)

if [ -n "$SCHEDULE_ID" ] && [ "$SCHEDULE_ID" != "null" ]; then
    echo "  → Created report schedule ID: $SCHEDULE_ID"
    
    echo "" && echo "━━━ Test 11: Get Report Schedule by ID ━━━"
    test_endpoint "Get Report Schedule" "GET" "/report-schedules/$SCHEDULE_ID" "" "200" "$TOKEN" "validate_schedule" >/dev/null
    
    echo "" && echo "━━━ Test 12: Update Report Schedule ━━━"
    UPDATE_SCHEDULE='{"frequency":"WEEKLY","isActive":true}'
    test_endpoint "Update Report Schedule" "PATCH" "/report-schedules/$SCHEDULE_ID" "$UPDATE_SCHEDULE" "200" "$TOKEN" "validate_schedule" >/dev/null
    
    echo "" && echo "━━━ Test 13: Get All Report Schedules ━━━"
    test_endpoint "List Report Schedules" "GET" "/report-schedules" "" "200" "$TOKEN" "validate_list" >/dev/null
    
    echo "" && echo "━━━ Test 14: Get Upcoming Scheduled Reports ━━━"
    test_endpoint "Get Upcoming Reports" "GET" "/report-schedules/upcoming" "" "200" "$TOKEN" "validate_list" >/dev/null
    
    echo "" && echo "━━━ Test 15: Get Schedule Execution History ━━━"
    test_endpoint "Get Execution History" "GET" "/report-schedules/history?scheduleId=$SCHEDULE_ID" "" "200" "$TOKEN" "" >/dev/null
    
    echo "" && echo "━━━ Test 16: Run Schedule Immediately ━━━"
    test_endpoint "Run Now" "POST" "/report-schedules/$SCHEDULE_ID/run-now" "" "200" "$TOKEN" "" >/dev/null
    
    echo "" && echo "━━━ Test 17: Toggle Schedule Active Status ━━━"
    test_endpoint "Toggle Schedule Active" "POST" "/report-schedules/$SCHEDULE_ID/toggle-active" "" "200" "$TOKEN" "" >/dev/null
    
    echo "" && echo "━━━ Test 18: Delete Report Schedule ━━━"
    test_endpoint "Delete Report Schedule" "DELETE" "/report-schedules/$SCHEDULE_ID" "" "200" "$TOKEN" "" >/dev/null
fi

echo "" && echo "━━━ Test 19: Unauthorized Access ━━━"
test_endpoint "No Auth" "GET" "/report-templates" "" "401" "" "" >/dev/null

print_summary
