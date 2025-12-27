#!/bin/bash

# CloudAudit Pro - Accounts (Chart of Accounts) API Tests

API_BASE_URL="http://localhost:8000/api"
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

echo "╔════════════════════════════════════════════════════════════╗"
echo "║          CLOUDAUDIT PRO - ACCOUNTS (COA) TESTS              ║"
echo "╚════════════════════════════════════════════════════════════╝"

TOKENS_FILE="../../auth-tokens.json"
[ ! -f "$TOKENS_FILE" ] && echo "Auth tokens not found" && exit 1
ACCESS_TOKEN=$(grep -o '"accessToken":"[^"]*' "$TOKENS_FILE" | cut -d'"' -f4)

TOTAL=0; PASSED=0; FAILED=0

test_api() {
    ((TOTAL++)); echo -n "Test $TOTAL: $1... "
    response=$(curl -s -w "\n%{http_code}" -X $2 "$API_BASE_URL$3" \
        -H "Authorization: Bearer $ACCESS_TOKEN" \
        -H "Content-Type: application/json" \
        ${4:+-d "$4"})
    status=$(echo "$response" | tail -n 1)
    [ "$status" = "$5" ] && { echo -e "${GREEN}PASS${NC}"; ((PASSED++)); } || { echo -e "${RED}FAIL (Expected $5, got $status)${NC}"; ((FAILED++)); }
}

echo ""
echo "▶ Create Account"
ACC_PAYLOAD='{"accountNumber":"1000","name":"Cash","type":"ASSET","subType":"CURRENT","normal_balance":"DEBIT"}'
test_api "Create account" "POST" "/accounts" "$ACC_PAYLOAD" "201"

echo "▶ Get All Accounts"
test_api "Get all accounts" "GET" "/accounts" "" "200"

echo "▶ Get Account by ID"
test_api "Get account by ID" "GET" "/accounts/test-id" "" "200"

echo "▶ Update Account"
UPD_PAYLOAD='{"name":"Cash Updated"}'
test_api "Update account" "PATCH" "/accounts/test-id" "$UPD_PAYLOAD" "200"

echo "▶ Delete Account"
test_api "Delete account" "DELETE" "/accounts/test-id" "" "200"

echo ""
echo "═════════════════════════════════════════════════════════════"
echo "Tests: $TOTAL | Passed: ${GREEN}$PASSED${NC} | Failed: ${RED}$FAILED${NC}"
[ $FAILED -eq 0 ] && echo -e "${GREEN}✓ ALL PASSED${NC}" || echo -e "${RED}✗ SOME FAILED${NC}"
