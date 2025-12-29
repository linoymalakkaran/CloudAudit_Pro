#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../test-helpers.sh"
source "$SCRIPT_DIR/../auth-helper.sh"

echo "╔════════════════════════════════════════════════════════════╗"
echo "║          DATA IMPORT & EXPORT TESTS                         ║"
echo "╚════════════════════════════════════════════════════════════╝"

validate_import() { 
    check_field "$1" '.id' && check_field "$1" '.status'
}
validate_export() { 
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
echo "━━━ Data Import Tests ━━━"

echo "" && echo "━━━ Test 1: Upload File for Import ━━━"
# Note: This would typically be a file upload, simulated here
UPLOAD_DATA='{"type":"ACCOUNTS","fileName":"test_import.csv","companyId":"test-company"}'
import_resp=$(test_endpoint "Upload Import File" "POST" "/data-import" "$UPLOAD_DATA" "201" "$TOKEN" "validate_import")
IMPORT_ID=$(echo "$import_resp" | jq -r '.id' 2>/dev/null)

if [ -n "$IMPORT_ID" ] && [ "$IMPORT_ID" != "null" ]; then
    echo "  → Created import ID: $IMPORT_ID"
    
    echo "" && echo "━━━ Test 2: Get Import by ID ━━━"
    test_endpoint "Get Import" "GET" "/data-import/$IMPORT_ID" "" "200" "$TOKEN" "validate_import" >/dev/null
    
    echo "" && echo "━━━ Test 3: Update Import ━━━"
    UPDATE_IMPORT='{"notes":"Updated import notes"}'
    test_endpoint "Update Import" "PATCH" "/data-import/$IMPORT_ID" "$UPDATE_IMPORT" "200" "$TOKEN" "validate_import" >/dev/null
    
    echo "" && echo "━━━ Test 4: Get All Imports ━━━"
    test_endpoint "List Imports" "GET" "/data-import" "" "200" "$TOKEN" "validate_list" >/dev/null
    
    echo "" && echo "━━━ Test 5: Get Import Summary ━━━"
    test_endpoint "Get Import Summary" "GET" "/data-import/summary" "" "200" "$TOKEN" "" >/dev/null
    
    echo "" && echo "━━━ Test 6: Get Import Template ━━━"
    test_endpoint "Get Import Template" "GET" "/data-import/templates/ACCOUNTS" "" "200" "$TOKEN" "" >/dev/null
    
    echo "" && echo "━━━ Test 7: Validate Import Data ━━━"
    test_endpoint "Validate Import" "POST" "/data-import/$IMPORT_ID/validate" "" "200" "$TOKEN" "" >/dev/null
    
    echo "" && echo "━━━ Test 8: Process Import ━━━"
    test_endpoint "Process Import" "POST" "/data-import/$IMPORT_ID/process" "" "200" "$TOKEN" "" >/dev/null
    
    echo "" && echo "━━━ Test 9: Get Import Errors ━━━"
    test_endpoint "Get Import Errors" "GET" "/data-import/$IMPORT_ID/errors" "" "200" "$TOKEN" "" >/dev/null
    
    echo "" && echo "━━━ Test 10: Download Error CSV ━━━"
    test_endpoint "Download Errors CSV" "GET" "/data-import/$IMPORT_ID/download-errors" "" "200" "$TOKEN" "" >/dev/null
    
    echo "" && echo "━━━ Test 11: Rollback Import ━━━"
    test_endpoint "Rollback Import" "POST" "/data-import/$IMPORT_ID/rollback" "" "200" "$TOKEN" "" >/dev/null
    
    echo "" && echo "━━━ Test 12: Delete Import ━━━"
    test_endpoint "Delete Import" "DELETE" "/data-import/$IMPORT_ID" "" "200" "$TOKEN" "" >/dev/null
fi

echo ""
echo "━━━ Data Export Tests ━━━"

echo "" && echo "━━━ Test 13: Create Export ━━━"
CREATE_EXPORT='{"type":"ACCOUNTS","format":"CSV","filters":{"companyId":"test-company"}}'
export_resp=$(test_endpoint "Create Export" "POST" "/data-export" "$CREATE_EXPORT" "201" "$TOKEN" "validate_export")
EXPORT_ID=$(echo "$export_resp" | jq -r '.id' 2>/dev/null)

if [ -n "$EXPORT_ID" ] && [ "$EXPORT_ID" != "null" ]; then
    echo "  → Created export ID: $EXPORT_ID"
    
    echo "" && echo "━━━ Test 14: Get Export by ID ━━━"
    test_endpoint "Get Export" "GET" "/data-export/$EXPORT_ID" "" "200" "$TOKEN" "validate_export" >/dev/null
    
    echo "" && echo "━━━ Test 15: Update Export ━━━"
    UPDATE_EXPORT='{"notes":"Updated export notes"}'
    test_endpoint "Update Export" "PATCH" "/data-export/$EXPORT_ID" "$UPDATE_EXPORT" "200" "$TOKEN" "validate_export" >/dev/null
    
    echo "" && echo "━━━ Test 16: Get All Exports ━━━"
    test_endpoint "List Exports" "GET" "/data-export" "" "200" "$TOKEN" "validate_list" >/dev/null
    
    echo "" && echo "━━━ Test 17: Get Export Summary ━━━"
    test_endpoint "Get Export Summary" "GET" "/data-export/summary" "" "200" "$TOKEN" "" >/dev/null
    
    echo "" && echo "━━━ Test 18: Get Export Types ━━━"
    test_endpoint "Get Export Types" "GET" "/data-export/types" "" "200" "$TOKEN" "" >/dev/null
    
    echo "" && echo "━━━ Test 19: Process Export ━━━"
    test_endpoint "Process Export" "POST" "/data-export/$EXPORT_ID/process" "" "200" "$TOKEN" "" >/dev/null
    
    echo "" && echo "━━━ Test 20: Download Export File ━━━"
    test_endpoint "Download Export" "GET" "/data-export/$EXPORT_ID/download" "" "200" "$TOKEN" "" >/dev/null
    
    echo "" && echo "━━━ Test 21: Delete Export ━━━"
    test_endpoint "Delete Export" "DELETE" "/data-export/$EXPORT_ID" "" "200" "$TOKEN" "" >/dev/null
fi

echo "" && echo "━━━ Test 22: Quick Export ━━━"
QUICK_EXPORT='{"type":"TRIAL_BALANCE","format":"EXCEL","filters":{"periodId":"test-period"}}'
test_endpoint "Quick Export" "POST" "/data-export/quick" "$QUICK_EXPORT" "200" "$TOKEN" "" >/dev/null

echo "" && echo "━━━ Test 23: Schedule Export ━━━"
SCHEDULE_EXPORT='{"type":"ACCOUNTS","format":"CSV","frequency":"MONTHLY","recipients":["user@test.com"]}'
test_endpoint "Schedule Export" "POST" "/data-export/schedule" "$SCHEDULE_EXPORT" "201" "$TOKEN" "" >/dev/null

echo "" && echo "━━━ Test 24: Unauthorized Access ━━━"
test_endpoint "No Auth" "GET" "/data-import" "" "401" "" "" >/dev/null

print_summary
