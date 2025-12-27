#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../test-helpers.sh"

echo "╔════════════════════════════════════════════════════════════╗"
echo "║              AUTHENTICATION TESTS                           ║"
echo "╚════════════════════════════════════════════════════════════╝"

validate_register() { check_field "$1" '.user.id' && check_field "$1" '.tenant'; }
validate_login() { check_field "$1" '.accessToken' && check_field "$1" '.user'; }
validate_profile() { check_field "$1" '.email'; }

TS=$(date +%s)
EMAIL="user${TS}@test.com"
TENANT="t${TS}"

echo "━━━ Test 1: Register ━━━"
REG='{"email":"'$EMAIL'","password":"Test@12345","firstName":"Test","lastName":"User","companyName":"Co'$TS'","tenantSubdomain":"'$TENANT'"}'
reg=$(test_endpoint "Register" "POST" "/auth/register" "$REG" "201" "" "validate_register")

echo "" && echo "━━━ Test 2: Login ━━━"
LOGIN='{"email":"'$EMAIL'","password":"Test@12345","tenantSubdomain":"'$TENANT'"}'
login=$(test_endpoint "Login" "POST" "/auth/login" "$LOGIN" "200" "" "validate_login")
TOKEN=$(echo "$login" | jq -r '.accessToken' 2>/dev/null)

echo "" && echo "━━━ Test 3: Get Profile ━━━"
test_endpoint "Get Profile" "GET" "/auth/profile" "" "200" "$TOKEN" "validate_profile" >/dev/null

echo "" && echo "━━━ Test 4: Unauthorized ━━━"
test_endpoint "No Auth" "GET" "/auth/profile" "" "401" "" "" >/dev/null

echo "" && echo "━━━ Test 5: Invalid Login ━━━"
test_endpoint "Bad Creds" "POST" "/auth/login" '{"email":"bad@test.com","password":"wrong"}' "401" "" "" >/dev/null

print_summary
