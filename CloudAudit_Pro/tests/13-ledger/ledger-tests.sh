#!/bin/bash
API_BASE_URL="http://localhost:8000/api"
RED='\033[0;31m'; GREEN='\033[0;32m'; NC='\033[0m'
echo "╔════════════════════════════════════════════════════════════╗"
echo "║            CLOUDAUDIT PRO - LEDGER TESTS                    ║"
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
    [ "$status" = "$5" ] && { echo -e "${GREEN}PASS${NC}"; ((PASSED++)); } || { echo -e "${RED}FAIL${NC}"; ((FAILED++)); }
}
echo ""
test_api "Get account ledger" "GET" "/ledger?accountId=acc-1" "" "200"
test_api "Generate ledger" "POST" "/ledger/generate" '{"journalEntryId":"je-1"}' "201"
test_api "Recalculate balances" "POST" "/ledger/recalculate" '{"accountId":"acc-1"}' "200"
echo ""
echo "═════════════════════════════════════════════════════════════"
echo "Tests: $TOTAL | Passed: ${GREEN}$PASSED${NC} | Failed: ${RED}$FAILED${NC}"
[ $FAILED -eq 0 ] && echo -e "${GREEN}✓ ALL PASSED${NC}" || echo -e "${RED}✗ SOME FAILED${NC}"
