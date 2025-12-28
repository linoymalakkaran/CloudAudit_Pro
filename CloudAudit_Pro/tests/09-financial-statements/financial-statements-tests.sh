#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../test-helpers.sh"
source "$SCRIPT_DIR/../auth-helper.sh"

echo "╔════════════════════════════════════════════════════════════╗"
echo "║            FINANCIAL STATEMENTS TESTS                      ║"
echo "╚════════════════════════════════════════════════════════════╝"

validate_statement() { check_field "$1" '.id' && check_field "$1" '.type'; }
validate_list() { echo "$1" | jq -e 'type == "array"' >/dev/null 2>&1; }

if ! init_auth; then
    auth_status=$?
    if [ $auth_status -eq 2 ]; then
        echo "26a0Fe0f  Skipping protected endpoint tests (account pending approval)"
        echo "" && echo "250125012501 Test 1: Health Check (Public) 250125012501"
        test_endpoint "API Health" "GET" "/health" "" "200" "" "" >/dev/null
        print_summary
        exit 0
    fi
    echo "❌ Failed to authenticate"
    exit 1
fi

TOKEN="$SHARED_AUTH_TOKEN"

echo ""
echo "━━━ Test 1: List Statements ━━━"
test_endpoint "List Statements" "GET" "/financial-statements" "" "200" "$TOKEN" "validate_list" >/dev/null

echo "" && echo "━━━ Test 2: Unauthorized Access ━━━"
test_endpoint "No Auth" "GET" "/financial-statements" "" "401" "" "" >/dev/null

echo "" && echo "━━━ Test 3: Health Check ━━━"
test_endpoint "API Health" "GET" "/health" "" "200" "" "" >/dev/null

print_summary
