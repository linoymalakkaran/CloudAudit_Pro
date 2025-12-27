#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../test-helpers.sh"

echo "╔════════════════════════════════════════════════════════════╗"
MODULE_NAME="users"
echo "║              ${MODULE_NAME^^} TESTS                              ║"
echo "╚════════════════════════════════════════════════════════════╝"

validate_item() { check_field "$1" '.id'; }
validate_list() { echo "$1" | jq -e 'type == "array"' >/dev/null 2>&1; }

echo "━━━ Test 1: Health Check ━━━"
test_endpoint "API Health" "GET" "/health" "" "200" "" "" >/dev/null

echo "" && echo "━━━ Test 2: API Status ━━━"
test_endpoint "API Status" "GET" "/health" "" "200" "" "" >/dev/null

print_summary
