#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../test-helpers.sh"
source "$SCRIPT_DIR/../auth-helper.sh"

echo "╔════════════════════════════════════════════════════════════╗"
echo "║              AUDIT PROCEDURES TESTS                         ║"
echo "╚════════════════════════════════════════════════════════════╝"

validate_procedure() { check_field "$1" '.id' && check_field "$1" '.title'; }
validate_list() { echo "$1" | jq -e 'type == "array"' >/dev/null 2>&1; }

if ! init_auth; then
    echo "❌ Failed to authenticate"
    exit 1
fi

TOKEN="$SHARED_AUTH_TOKEN"

echo ""
echo "━━━ Test 1: List Procedures ━━━"
test_endpoint "List Procedures" "GET" "/procedures" "" "200" "$TOKEN" "validate_list" >/dev/null

echo "" && echo "━━━ Test 2: Get Procedure Statistics ━━━"
test_endpoint "Procedure Stats" "GET" "/procedures/statistics" "" "200" "$TOKEN" "" >/dev/null

echo "" && echo "━━━ Test 3: Unauthorized Access ━━━"
test_endpoint "No Auth" "GET" "/procedures" "" "401" "" "" >/dev/null

print_summary
