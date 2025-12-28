#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../test-helpers.sh"
source "$SCRIPT_DIR/../auth-helper.sh"

echo "╔════════════════════════════════════════════════════════════╗"
echo "║                  USERS TESTS                                ║"
echo "╚════════════════════════════════════════════════════════════╝"

validate_user() { check_field "$1" '.id' && check_field "$1" '.email'; }
validate_list() { echo "$1" | jq -e 'type == "array"' >/dev/null 2>&1; }

if ! init_auth; then
    echo "❌ Failed to authenticate"
    exit 1
fi

TOKEN="$SHARED_AUTH_TOKEN"

echo ""
echo "━━━ Test 1: List Users ━━━"
test_endpoint "List Users" "GET" "/users" "" "200" "$TOKEN" "validate_list" >/dev/null

echo "" && echo "━━━ Test 2: Get Current User ━━━"
test_endpoint "Get Me" "GET" "/users/me" "" "200" "$TOKEN" "validate_user" >/dev/null

echo "" && echo "━━━ Test 3: Unauthorized Access ━━━"
test_endpoint "No Auth" "GET" "/users" "" "401" "" "" >/dev/null

print_summary
