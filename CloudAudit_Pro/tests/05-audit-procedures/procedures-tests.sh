#!/bin/bash
# CloudAudit Pro - Audit Procedures Tests

API_BASE_URL="http://localhost:8000/api"
RED='\033[0;31m'; GREEN='\033[0;32m'; NC='\033[0m'

echo "╔════════════════════════════════════════════════════════════╗"
echo "║       CLOUDAUDIT PRO - AUDIT PROCEDURES TESTS               ║"
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
    [ "$status" = "$5" ] && { echo -e "${GREEN}PASS${NC}"; ((PASSED++)); } || { echo -e "${RED}FAIL (Got $status)${NC}"; ((FAILED++)); }
}

echo ""
echo "▶ Create Procedure"
PROC_PAYLOAD='{"name":"Test Procedure","description":"Test Description","type":"ANALYTICAL","status":"OPEN","priority":"HIGH"}'
test_api "Create audit procedure" "POST" "/procedures" "$PROC_PAYLOAD" "201"

echo "▶ Get All Procedures"
test_api "Get all procedures" "GET" "/procedures" "" "200"

echo "▶ Start Procedure"
test_api "Start procedure" "POST" "/procedures/test-id/start" "" "200"

echo "▶ Review Procedure"
REVIEW_PAYLOAD='{"status":"IN_REVIEW"}'
test_api "Review procedure" "POST" "/procedures/test-id/review" "$REVIEW_PAYLOAD" "200"

echo "▶ Complete Procedure"
test_api "Complete procedure" "POST" "/procedures/test-id/complete" "" "200"

echo "▶ Get Procedure Statistics"
test_api "Get statistics" "GET" "/procedures/statistics" "" "200"

echo "▶ Get Procedure Templates"
test_api "Get templates" "GET" "/procedures/templates" "" "200"

echo "▶ Delete Procedure"
test_api "Delete procedure" "DELETE" "/procedures/test-id" "" "200"

echo ""
echo "═════════════════════════════════════════════════════════════"
echo "Tests: $TOTAL | Passed: ${GREEN}$PASSED${NC} | Failed: ${RED}$FAILED${NC}"
[ $FAILED -eq 0 ] && echo -e "${GREEN}✓ ALL PASSED${NC}" || echo -e "${RED}✗ SOME FAILED${NC}"
