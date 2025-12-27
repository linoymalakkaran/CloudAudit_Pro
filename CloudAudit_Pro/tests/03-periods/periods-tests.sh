#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../test-helpers.sh"

echo "╔════════════════════════════════════════════════════════════╗"
echo "║                  PERIODS TESTS                              ║"
echo "╚════════════════════════════════════════════════════════════╝"

validate_list() { echo "$1" | jq -e 'type == "array"' >/dev/null 2>&1; }

# Get auth token
TS=$(date +%s)
EMAIL="testadmin${TS}@test.com"
TENANT="tenant${TS}"

REG='{"email":"'$EMAIL'","password":"Test@12345","firstName":"Admin","lastName":"User","companyName":"AdminCo'$TS'","tenantSubdomain":"'$TENANT'"}'
reg=$(curl -s -X POST "http://localhost:8000/api/auth/register" -H "Content-Type: application/json" -d "$REG")

LOGIN='{"email":"'$EMAIL'","password":"Test@12345","tenantSubdomain":"'$TENANT'"}'
login=$(curl -s -X POST "http://localhost:8000/api/auth/login" -H "Content-Type: application/json" -d "$LOGIN")
TOKEN=$(echo "$login" | jq -r '.accessToken' 2>/dev/null)

if [ -z "$TOKEN" ] || [ "$TOKEN" = "null" ]; then
    echo "❌ Failed to get auth token"
    exit 1
fi

echo "━━━ Test 1: List Periods ━━━"
test_endpoint "List Periods" "GET" "/periods" "" "200" "$TOKEN" "validate_list" >/dev/null

echo "" && echo "━━━ Test 2: Health Check ━━━"
test_endpoint "API Health" "GET" "/health" "" "200" "" "" >/dev/null

print_summary
