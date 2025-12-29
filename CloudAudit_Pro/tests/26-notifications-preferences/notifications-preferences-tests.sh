#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../test-helpers.sh"
source "$SCRIPT_DIR/../auth-helper.sh"

echo "╔════════════════════════════════════════════════════════════╗"
echo "║      NOTIFICATIONS & USER PREFERENCES TESTS                 ║"
echo "╚════════════════════════════════════════════════════════════╝"

validate_notification() { 
    check_field "$1" '.id' && check_field "$1" '.message'
}
validate_template() { 
    check_field "$1" '.key' && check_field "$1" '.subject'
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
echo "━━━ Notifications Tests ━━━"

echo "" && echo "━━━ Test 1: Create Notification ━━━"
CREATE_NOTIF='{"message":"Test notification message","type":"INFO","priority":"NORMAL"}'
notif_resp=$(test_endpoint "Create Notification" "POST" "/notifications" "$CREATE_NOTIF" "201" "$TOKEN" "validate_notification")
NOTIF_ID=$(echo "$notif_resp" | jq -r '.id' 2>/dev/null)

if [ -n "$NOTIF_ID" ] && [ "$NOTIF_ID" != "null" ]; then
    echo "  → Created notification ID: $NOTIF_ID"
    
    echo "" && echo "━━━ Test 2: Get Notification by ID ━━━"
    test_endpoint "Get Notification" "GET" "/notifications/$NOTIF_ID" "" "200" "$TOKEN" "validate_notification" >/dev/null
    
    echo "" && echo "━━━ Test 3: Get All Notifications ━━━"
    test_endpoint "List Notifications" "GET" "/notifications" "" "200" "$TOKEN" "validate_list" >/dev/null
    
    echo "" && echo "━━━ Test 4: Get Unread Count ━━━"
    test_endpoint "Get Unread Count" "GET" "/notifications/unread-count" "" "200" "$TOKEN" "" >/dev/null
    
    echo "" && echo "━━━ Test 5: Mark Notification as Read ━━━"
    test_endpoint "Mark as Read" "PATCH" "/notifications/$NOTIF_ID/read" "" "200" "$TOKEN" "" >/dev/null
    
    echo "" && echo "━━━ Test 6: Dismiss Notification ━━━"
    test_endpoint "Dismiss Notification" "PATCH" "/notifications/$NOTIF_ID/dismiss" "" "200" "$TOKEN" "" >/dev/null
    
    echo "" && echo "━━━ Test 7: Delete Notification ━━━"
    test_endpoint "Delete Notification" "DELETE" "/notifications/$NOTIF_ID" "" "200" "$TOKEN" "" >/dev/null
fi

echo "" && echo "━━━ Test 8: Mark All as Read ━━━"
test_endpoint "Mark All Read" "POST" "/notifications/mark-all-read" "" "200" "$TOKEN" "" >/dev/null

echo "" && echo "━━━ Test 9: Clear Read Notifications ━━━"
test_endpoint "Clear Read" "POST" "/notifications/clear-read" "" "200" "$TOKEN" "" >/dev/null

echo "" && echo "━━━ Test 10: Bulk Send Notifications ━━━"
BULK_DATA='{"userIds":["user1","user2"],"message":"Bulk notification","type":"SYSTEM"}'
test_endpoint "Bulk Send" "POST" "/notifications/bulk-send" "$BULK_DATA" "201" "$TOKEN" "" >/dev/null

echo ""
echo "━━━ Notification Templates Tests ━━━"

echo "" && echo "━━━ Test 11: Get All Templates ━━━"
test_endpoint "List Templates" "GET" "/notifications/templates" "" "200" "$TOKEN" "" >/dev/null

echo "" && echo "━━━ Test 12: Create Notification Template ━━━"
CREATE_TPL='{"key":"test_template_'$TS'","subject":"Test Subject","body":"Test body {{variable}}","type":"EMAIL"}'
tpl_resp=$(test_endpoint "Create Template" "POST" "/notifications/templates" "$CREATE_TPL" "201" "$TOKEN" "validate_template")
TPL_KEY=$(echo "$tpl_resp" | jq -r '.key' 2>/dev/null)

if [ -n "$TPL_KEY" ] && [ "$TPL_KEY" != "null" ]; then
    echo "  → Created template key: $TPL_KEY"
    
    echo "" && echo "━━━ Test 13: Get Template by Key ━━━"
    test_endpoint "Get Template" "GET" "/notifications/templates/$TPL_KEY" "" "200" "$TOKEN" "validate_template" >/dev/null
    
    echo "" && echo "━━━ Test 14: Update Template ━━━"
    UPDATE_TPL='{"subject":"Updated Subject"}'
    test_endpoint "Update Template" "PATCH" "/notifications/templates/$TPL_KEY" "$UPDATE_TPL" "200" "$TOKEN" "validate_template" >/dev/null
    
    echo "" && echo "━━━ Test 15: Send from Template ━━━"
    SEND_DATA='{"recipients":["user@test.com"],"variables":{"variable":"test value"}}'
    test_endpoint "Send from Template" "POST" "/notifications/templates/$TPL_KEY/send" "$SEND_DATA" "200" "$TOKEN" "" >/dev/null
    
    echo "" && echo "━━━ Test 16: Delete Template ━━━"
    test_endpoint "Delete Template" "DELETE" "/notifications/templates/$TPL_KEY" "" "200" "$TOKEN" "" >/dev/null
fi

echo ""
echo "━━━ User Preferences Tests ━━━"

echo "" && echo "━━━ Test 17: Get All Preferences ━━━"
test_endpoint "Get All Preferences" "GET" "/user-preferences" "" "200" "$TOKEN" "" >/dev/null

echo "" && echo "━━━ Test 18: Set User Preference ━━━"
PREF_DATA='{"key":"theme","value":"dark"}'
test_endpoint "Set Preference" "POST" "/user-preferences" "$PREF_DATA" "200" "$TOKEN" "" >/dev/null

echo "" && echo "━━━ Test 19: Get Specific Preference ━━━"
test_endpoint "Get Preference" "GET" "/user-preferences/theme" "" "200" "$TOKEN" "" >/dev/null

echo "" && echo "━━━ Test 20: Update Preference ━━━"
UPDATE_PREF='{"value":"light"}'
test_endpoint "Update Preference" "PATCH" "/user-preferences/theme" "$UPDATE_PREF" "200" "$TOKEN" "" >/dev/null

echo "" && echo "━━━ Test 21: Bulk Set Preferences ━━━"
BULK_PREF='{"preferences":[{"key":"language","value":"en"},{"key":"dateFormat","value":"MM/DD/YYYY"}]}'
test_endpoint "Bulk Set Preferences" "POST" "/user-preferences/bulk" "$BULK_PREF" "200" "$TOKEN" "" >/dev/null

echo "" && echo "━━━ Test 22: Get Preferences by Category ━━━"
test_endpoint "Get by Category" "GET" "/user-preferences/category/appearance" "" "200" "$TOKEN" "" >/dev/null

echo "" && echo "━━━ Test 23: Export Preferences ━━━"
test_endpoint "Export Preferences" "GET" "/user-preferences/export" "" "200" "$TOKEN" "" >/dev/null

echo "" && echo "━━━ Test 24: Import Preferences ━━━"
IMPORT_DATA='{"preferences":{"theme":"dark","language":"en"}}'
test_endpoint "Import Preferences" "POST" "/user-preferences/import" "$IMPORT_DATA" "200" "$TOKEN" "" >/dev/null

echo "" && echo "━━━ Test 25: Reset Preferences ━━━"
test_endpoint "Reset Preferences" "POST" "/user-preferences/reset" "" "200" "$TOKEN" "" >/dev/null

echo "" && echo "━━━ Test 26: Delete Specific Preference ━━━"
test_endpoint "Delete Preference" "DELETE" "/user-preferences/theme" "" "200" "$TOKEN" "" >/dev/null

echo "" && echo "━━━ Test 27: Delete All Preferences ━━━"
test_endpoint "Delete All Preferences" "DELETE" "/user-preferences/all" "" "200" "$TOKEN" "" >/dev/null

echo "" && echo "━━━ Test 28: Unauthorized Access ━━━"
test_endpoint "No Auth" "GET" "/notifications" "" "401" "" "" >/dev/null

print_summary
