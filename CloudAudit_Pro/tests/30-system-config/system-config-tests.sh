#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../test-helpers.sh"
source "$SCRIPT_DIR/../auth-helper.sh"

echo "╔════════════════════════════════════════════════════════════╗"
echo "║           SYSTEM CONFIGURATION TESTS                        ║"
echo "╚════════════════════════════════════════════════════════════╝"

validate_config() { 
    check_field "$1" '.key' && check_field "$1" '.value'
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
echo "━━━ System Config Tests ━━━"

echo "" && echo "━━━ Test 1: Create System Configuration ━━━"
CREATE_CONFIG='{"key":"test_config_'$TS'","value":"test value","category":"GENERAL","description":"Test configuration"}'
config_resp=$(test_endpoint "Create Config" "POST" "/system-config" "$CREATE_CONFIG" "201" "$TOKEN" "validate_config")
CONFIG_KEY=$(echo "$config_resp" | jq -r '.key' 2>/dev/null)

if [ -n "$CONFIG_KEY" ] && [ "$CONFIG_KEY" != "null" ]; then
    echo "  → Created config key: $CONFIG_KEY"
    
    echo "" && echo "━━━ Test 2: Get Configuration by Key ━━━"
    test_endpoint "Get Config" "GET" "/system-config/$CONFIG_KEY" "" "200" "$TOKEN" "validate_config" >/dev/null
    
    echo "" && echo "━━━ Test 3: Update Configuration ━━━"
    UPDATE_CONFIG='{"value":"updated value"}'
    test_endpoint "Update Config" "PATCH" "/system-config/$CONFIG_KEY" "$UPDATE_CONFIG" "200" "$TOKEN" "validate_config" >/dev/null
    
    echo "" && echo "━━━ Test 4: Get All Configurations ━━━"
    test_endpoint "List Configs" "GET" "/system-config" "" "200" "$TOKEN" "validate_list" >/dev/null
    
    echo "" && echo "━━━ Test 5: Get Configurations by Category ━━━"
    test_endpoint "Get by Category" "GET" "/system-config/category/GENERAL" "" "200" "$TOKEN" "validate_list" >/dev/null
    
    echo "" && echo "━━━ Test 6: Delete Configuration ━━━"
    test_endpoint "Delete Config" "DELETE" "/system-config/$CONFIG_KEY" "" "200" "$TOKEN" "" >/dev/null
fi

echo "" && echo "━━━ Test 7: Export Configurations ━━━"
test_endpoint "Export Configs" "GET" "/system-config/export" "" "200" "$TOKEN" "" >/dev/null

echo "" && echo "━━━ Test 8: Import Configurations ━━━"
IMPORT_DATA='{"configurations":[{"key":"imported_config","value":"imported value","category":"GENERAL"}]}'
test_endpoint "Import Configs" "POST" "/system-config/import" "$IMPORT_DATA" "200" "$TOKEN" "" >/dev/null

echo "" && echo "━━━ Test 9: Bulk Update Configurations ━━━"
BULK_UPDATE='{"updates":[{"key":"config1","value":"value1"},{"key":"config2","value":"value2"}]}'
test_endpoint "Bulk Update" "POST" "/system-config/bulk-update" "$BULK_UPDATE" "200" "$TOKEN" "" >/dev/null

echo "" && echo "━━━ Test 10: Reset Configurations to Defaults ━━━"
test_endpoint "Reset to Defaults" "POST" "/system-config/reset" "" "200" "$TOKEN" "" >/dev/null

echo ""
echo "━━━ Config Module Tests ━━━"

echo "" && echo "━━━ Test 11: Create Configuration ━━━"
CREATE_CFG='{"type":"SYSTEM","category":"GENERAL","key":"test_cfg_'$TS'","value":"test","isActive":true}'
test_endpoint "Create Configuration" "POST" "/config" "$CREATE_CFG" "201" "$TOKEN" "" >/dev/null

echo "" && echo "━━━ Test 12: Get All Configurations ━━━"
test_endpoint "Get Configurations" "GET" "/config" "" "200" "$TOKEN" "" >/dev/null

echo "" && echo "━━━ Test 13: Get Configuration Templates ━━━"
test_endpoint "Get Templates" "GET" "/config/templates" "" "200" "$TOKEN" "" >/dev/null

echo "" && echo "━━━ Test 14: Get System Configuration ━━━"
test_endpoint "Get System Config" "GET" "/config/system" "" "200" "$TOKEN" "" >/dev/null

echo "" && echo "━━━ Test 15: Get Security Configuration ━━━"
test_endpoint "Get Security Config" "GET" "/config/security" "" "200" "$TOKEN" "" >/dev/null

echo "" && echo "━━━ Test 16: Get Audit Configuration ━━━"
test_endpoint "Get Audit Config" "GET" "/config/audit" "" "200" "$TOKEN" "" >/dev/null

echo "" && echo "━━━ Test 17: Get Financial Configuration ━━━"
test_endpoint "Get Financial Config" "GET" "/config/financial" "" "200" "$TOKEN" "" >/dev/null

echo "" && echo "━━━ Test 18: Get Reporting Configuration ━━━"
test_endpoint "Get Reporting Config" "GET" "/config/reporting" "" "200" "$TOKEN" "" >/dev/null

echo "" && echo "━━━ Test 19: Get Notification Configuration ━━━"
test_endpoint "Get Notification Config" "GET" "/config/notifications" "" "200" "$TOKEN" "" >/dev/null

echo "" && echo "━━━ Test 20: Get Integration Configuration ━━━"
test_endpoint "Get Integration Config" "GET" "/config/integrations" "" "200" "$TOKEN" "" >/dev/null

echo "" && echo "━━━ Test 21: Get Appearance Configuration ━━━"
test_endpoint "Get Appearance Config" "GET" "/config/appearance" "" "200" "$TOKEN" "" >/dev/null

echo "" && echo "━━━ Test 22: Get System Health ━━━"
test_endpoint "Get System Health" "GET" "/config/health" "" "200" "$TOKEN" "" >/dev/null

echo "" && echo "━━━ Test 23: Export Configurations ━━━"
test_endpoint "Export Configurations" "GET" "/config/export" "" "200" "$TOKEN" "" >/dev/null

echo "" && echo "━━━ Test 24: Get Configurations by Type ━━━"
test_endpoint "Get by Type" "GET" "/config/type/SYSTEM" "" "200" "$TOKEN" "" >/dev/null

echo "" && echo "━━━ Test 25: Get Company Audit Config ━━━"
test_endpoint "Get Company Audit Config" "GET" "/config/company/test-company/audit" "" "200" "$TOKEN" "" >/dev/null

echo "" && echo "━━━ Test 26: Unauthorized Access ━━━"
test_endpoint "No Auth" "GET" "/system-config" "" "401" "" "" >/dev/null

print_summary
