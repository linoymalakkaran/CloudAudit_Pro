#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../test-helpers.sh"
source "$SCRIPT_DIR/../auth-helper.sh"

echo "╔════════════════════════════════════════════════════════════╗"
echo "║           CURRENCY & EXCHANGE RATE TESTS                    ║"
echo "╚════════════════════════════════════════════════════════════╝"

validate_currency() { 
    check_field "$1" '.id' && check_field "$1" '.code'
}
validate_exchange_rate() { 
    check_field "$1" '.id' && check_field "$1" '.rate'
}
validate_list() { 
    echo "$1" | jq -e 'type == "array"' >/dev/null 2>&1
}

# Initialize authentication
if ! init_auth; then
    auth_status=$?
    if [ $auth_status -eq 2 ]; then
        echo "⚠️  Skipping protected endpoint tests (account pending approval)"
        print_summary
        exit 0
    fi
    echo "❌ Failed to authenticate"
    exit 1
fi

TOKEN="$SHARED_AUTH_TOKEN"
TS=$(date +%s)

echo ""
echo "━━━ Currency Tests ━━━"

echo "" && echo "━━━ Test 1: Create Currency ━━━"
CREATE_CURRENCY='{"code":"TST","name":"Test Currency","symbol":"T$","decimalPlaces":2,"isActive":true}'
create_resp=$(test_endpoint "Create Currency" "POST" "/currencies" "$CREATE_CURRENCY" "201" "$TOKEN" "validate_currency")
CURRENCY_ID=$(echo "$create_resp" | jq -r '.id' 2>/dev/null)

if [ -n "$CURRENCY_ID" ] && [ "$CURRENCY_ID" != "null" ]; then
    echo "  → Created currency ID: $CURRENCY_ID"
    
    echo "" && echo "━━━ Test 2: Get Currency by ID ━━━"
    test_endpoint "Get Currency" "GET" "/currencies/$CURRENCY_ID" "" "200" "$TOKEN" "validate_currency" >/dev/null
    
    echo "" && echo "━━━ Test 3: Get Currency by Code ━━━"
    test_endpoint "Get Currency by Code" "GET" "/currencies/code/TST" "" "200" "$TOKEN" "validate_currency" >/dev/null
    
    echo "" && echo "━━━ Test 4: Update Currency ━━━"
    UPDATE_CURRENCY='{"name":"Updated Test Currency","symbol":"TS$"}'
    test_endpoint "Update Currency" "PATCH" "/currencies/$CURRENCY_ID" "$UPDATE_CURRENCY" "200" "$TOKEN" "validate_currency" >/dev/null
    
    echo "" && echo "━━━ Test 5: Get All Currencies ━━━"
    test_endpoint "List Currencies" "GET" "/currencies" "" "200" "$TOKEN" "validate_list" >/dev/null
    
    echo "" && echo "━━━ Test 6: Get Base Currency ━━━"
    test_endpoint "Get Base Currency" "GET" "/currencies/base" "" "200" "$TOKEN" "validate_currency" >/dev/null
    
    echo "" && echo "━━━ Test 7: Update Currency Status ━━━"
    STATUS_DATA='{"isActive":false}'
    test_endpoint "Update Currency Status" "PATCH" "/currencies/$CURRENCY_ID/status" "$STATUS_DATA" "200" "$TOKEN" "" >/dev/null
fi

echo ""
echo "━━━ Exchange Rate Tests ━━━"

echo "" && echo "━━━ Test 8: Create Exchange Rate ━━━"
CREATE_RATE='{"fromCurrency":"USD","toCurrency":"EUR","rate":0.85,"effectiveDate":"2025-01-01"}'
rate_resp=$(test_endpoint "Create Exchange Rate" "POST" "/exchange-rates" "$CREATE_RATE" "201" "$TOKEN" "validate_exchange_rate")
RATE_ID=$(echo "$rate_resp" | jq -r '.id' 2>/dev/null)

if [ -n "$RATE_ID" ] && [ "$RATE_ID" != "null" ]; then
    echo "  → Created exchange rate ID: $RATE_ID"
    
    echo "" && echo "━━━ Test 9: Get Exchange Rate by ID ━━━"
    test_endpoint "Get Exchange Rate" "GET" "/exchange-rates/$RATE_ID" "" "200" "$TOKEN" "validate_exchange_rate" >/dev/null
    
    echo "" && echo "━━━ Test 10: Get All Exchange Rates ━━━"
    test_endpoint "List Exchange Rates" "GET" "/exchange-rates" "" "200" "$TOKEN" "validate_list" >/dev/null
    
    echo "" && echo "━━━ Test 11: Get Latest Exchange Rate ━━━"
    test_endpoint "Get Latest Rate" "GET" "/exchange-rates/latest?fromCurrency=USD&toCurrency=EUR" "" "200" "$TOKEN" "validate_exchange_rate" >/dev/null
    
    echo "" && echo "━━━ Test 12: Convert Currency ━━━"
    test_endpoint "Convert Currency" "GET" "/exchange-rates/convert?fromCurrency=USD&toCurrency=EUR&amount=100" "" "200" "$TOKEN" "" >/dev/null
    
    echo "" && echo "━━━ Test 13: Update Exchange Rate ━━━"
    UPDATE_RATE='{"rate":0.87}'
    test_endpoint "Update Exchange Rate" "PATCH" "/exchange-rates/$RATE_ID" "$UPDATE_RATE" "200" "$TOKEN" "validate_exchange_rate" >/dev/null
    
    echo "" && echo "━━━ Test 14: Delete Exchange Rate ━━━"
    test_endpoint "Delete Exchange Rate" "DELETE" "/exchange-rates/$RATE_ID" "" "200" "$TOKEN" "" >/dev/null
fi

if [ -n "$CURRENCY_ID" ] && [ "$CURRENCY_ID" != "null" ]; then
    echo "" && echo "━━━ Test 15: Delete Currency ━━━"
    test_endpoint "Delete Currency" "DELETE" "/currencies/$CURRENCY_ID" "" "200" "$TOKEN" "" >/dev/null
fi

echo "" && echo "━━━ Test 16: Unauthorized Access ━━━"
test_endpoint "No Auth" "GET" "/currencies" "" "401" "" "" >/dev/null

print_summary
