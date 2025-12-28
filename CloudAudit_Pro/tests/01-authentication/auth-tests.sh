#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../test-helpers.sh"

echo "╔════════════════════════════════════════════════════════════╗"
echo "║              AUTHENTICATION TESTS                           ║"
echo "╚════════════════════════════════════════════════════════════╝"

validate_register() { check_field "$1" '.user.id' && check_field "$1" '.tenant' && check_field "$1" '.status'; }
validate_pending_status() { echo "$1" | jq -e '.status == "PENDING_APPROVAL"' >/dev/null 2>&1; }
validate_approved_status() { echo "$1" | jq -e '.status == "APPROVED"' >/dev/null 2>&1; }

TS=$(date +%s)
EMAIL="user${TS}@test.com"
TENANT="t${TS}"

echo "━━━ Test 1: Register (Auto-Approval Enabled) ━━━"
REG='{"email":"'$EMAIL'","password":"Test@12345","firstName":"Test","lastName":"User","companyName":"Co'$TS'","tenantSubdomain":"'$TENANT'"}'
reg=$(test_endpoint "Register" "POST" "/auth/register" "$REG" "201" "" "validate_register")

# Check status (can be APPROVED or PENDING_APPROVAL depending on environment)
reg_status=$(echo "$reg" | jq -r '.status' 2>/dev/null)
if [ "$reg_status" = "APPROVED" ]; then
    echo "  ✅ Registration auto-approved (AUTO_APPROVE_TENANTS=true)"
    # Extract token for subsequent tests
    TOKEN=$(echo "$reg" | jq -r '.access_token' 2>/dev/null)
elif [ "$reg_status" = "PENDING_APPROVAL" ]; then
    echo "  ℹ️  Registration pending approval (manual approval required)"
    TOKEN=""
else
    echo "  ℹ️  Registration status: $reg_status"
    TOKEN=""
fi

echo "" && echo "━━━ Test 2: Login with Registered Account ━━━"
# If auto-approved, login should work. If pending, it should fail with 401.
LOGIN='{"email":"'$EMAIL'","password":"Test@12345","tenantSubdomain":"'$TENANT'"}'
if [ "$reg_status" = "APPROVED" ]; then
    test_endpoint "Login Approved" "POST" "/auth/login" "$LOGIN" "200" "" ""
else
    test_endpoint "Login Pending" "POST" "/auth/login" "$LOGIN" "401" "" ""
fi

echo "" && echo "━━━ Test 3: Unauthorized Access ━━━"
test_endpoint "No Auth" "GET" "/auth/profile" "" "401" "" ""

echo "" && echo "━━━ Test 4: Invalid Credentials ━━━"
test_endpoint "Bad Creds" "POST" "/auth/login" '{"email":"bad@test.com","password":"WrongPass123"}' "401" "" ""

echo "" && echo "━━━ Test 5: Login Without Tenant (Should Succeed) ━━━"
test_endpoint "No Tenant" "POST" "/auth/login" '{"email":"'$EMAIL'","password":"Test@12345"}' "200" "" ""

print_summary
