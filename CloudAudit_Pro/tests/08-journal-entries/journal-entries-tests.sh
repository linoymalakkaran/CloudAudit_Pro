#!/bin/bash
API_BASE_URL="http://localhost:8000/api"
RED='\033[0;31m'; GREEN='\033[0;32m'; NC='\033[0m'
echo "╔════════════════════════════════════════════════════════════╗"
echo "║        CLOUDAUDIT PRO - JOURNAL ENTRIES TESTS               ║"
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
JE_PAYLOAD='{"referenceNumber":"JE-001","description":"Test Entry","entries":[{"accountId":"acc-1","debit":100},{"accountId":"acc-2","credit":100}]}'
test_api "Create journal entry" "POST" "/journal-entries" "$JE_PAYLOAD" "201"
test_api "Get all entries" "GET" "/journal-entries" "" "200"
test_api "Get entry by ID" "GET" "/journal-entries/test-id" "" "200"
test_api "Update entry" "PUT" "/journal-entries/test-id" '{"description":"Updated"}' "200"
test_api "Get statistics" "GET" "/journal-entries/statistics" "" "200"
test_api "Submit entry" "PUT" "/journal-entries/test-id/submit" "" "200"
test_api "Review entry" "POST" "/journal-entries/test-id/review" '{"action":"APPROVE"}' "200"
test_api "Post entry" "PUT" "/journal-entries/test-id/post" "" "200"
test_api "Delete entry" "DELETE" "/journal-entries/test-id" "" "200"
echo ""
echo "═════════════════════════════════════════════════════════════"
echo "Tests: $TOTAL | Passed: ${GREEN}$PASSED${NC} | Failed: ${RED}$FAILED${NC}"
[ $FAILED -eq 0 ] && echo -e "${GREEN}✓ ALL PASSED${NC}" || echo -e "${RED}✗ SOME FAILED${NC}"
