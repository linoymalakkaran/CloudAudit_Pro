#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../test-helpers.sh"
source "$SCRIPT_DIR/../auth-helper.sh"

echo "╔════════════════════════════════════════════════════════════╗"
echo "║                  TENANT TESTS                               ║"
echo "╚════════════════════════════════════════════════════════════╝"

validate_tenant() { 
    check_field "$1" '.id' && check_field "$1" '.subdomain'
}
validate_stats() { 
    check_field "$1" '.totalUsers' || check_field "$1" '.totalCompanies' || check_field "$1" '.activeUsers'
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

echo ""
echo "━━━ Test 1: Get Tenant by Subdomain ━━━"
# Extract subdomain from auth info
SUBDOMAIN=$(echo "$AUTH_INFO" | jq -r '.tenant.subdomain // "test"' 2>/dev/null)
test_endpoint "Get Tenant by Subdomain" "GET" "/tenants/subdomain/$SUBDOMAIN" "" "200" "$TOKEN" "validate_tenant" >/dev/null

echo "" && echo "━━━ Test 2: Get Tenant Statistics ━━━"
TENANT_ID=$(echo "$AUTH_INFO" | jq -r '.tenant.id' 2>/dev/null)
if [ -n "$TENANT_ID" ] && [ "$TENANT_ID" != "null" ]; then
    test_endpoint "Get Tenant Stats" "GET" "/tenants/$TENANT_ID/stats" "" "200" "$TOKEN" "validate_stats" >/dev/null
fi

echo "" && echo "━━━ Test 3: Update Tenant Settings ━━━"
if [ -n "$TENANT_ID" ] && [ "$TENANT_ID" != "null" ]; then
    UPDATE_DATA='{"settings":{"theme":"dark","language":"en"}}'
    test_endpoint "Update Tenant Settings" "PATCH" "/tenants/$TENANT_ID/settings" "$UPDATE_DATA" "200" "$TOKEN" "" >/dev/null
fi

echo "" && echo "━━━ Test 4: Unauthorized Access ━━━"
test_endpoint "No Auth" "GET" "/tenants/$TENANT_ID/stats" "" "401" "" "" >/dev/null

print_summary
