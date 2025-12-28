#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../test-helpers.sh"
source "$SCRIPT_DIR/../auth-helper.sh"

echo "╔════════════════════════════════════════════════════════════╗"
echo "║                  ACCOUNTS TESTS                             ║"
echo "╚════════════════════════════════════════════════════════════╝"

validate_account() { check_field "$1" '.id' && check_field "$1" '.code'; }
validate_list() { echo "$1" | jq -e 'type == "array"' >/dev/null 2>&1; }

if ! init_auth; then
    echo "❌ Failed to authenticate"
    exit 1
fi

TOKEN="$SHARED_AUTH_TOKEN"
TS=$(date +%s)

echo ""
echo "━━━ Test 1: List Accounts ━━━"
test_endpoint "List Accounts" "GET" "/accounts" "" "200" "$TOKEN" "validate_list" >/dev/null

echo "" && echo "━━━ Test 2: Get Chart of Accounts ━━━"
test_endpoint "Chart of Accounts" "GET" "/accounts/chart" "" "200" "$TOKEN" "validate_list" >/dev/null

echo "" && echo "━━━ Test 3: Unauthorized Access ━━━"
test_endpoint "No Auth" "GET" "/accounts" "" "401" "" "" >/dev/null

print_summary
