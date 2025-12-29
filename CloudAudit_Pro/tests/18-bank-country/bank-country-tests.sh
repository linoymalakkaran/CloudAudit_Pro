#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../test-helpers.sh"
source "$SCRIPT_DIR/../auth-helper.sh"

echo "╔════════════════════════════════════════════════════════════╗"
echo "║              BANK & COUNTRY TESTS                           ║"
echo "╚════════════════════════════════════════════════════════════╝"

validate_bank() { 
    check_field "$1" '.id' && check_field "$1" '.name'
}
validate_bank_account() { 
    check_field "$1" '.id' && check_field "$1" '.accountNumber'
}
validate_country() { 
    check_field "$1" '.id' && check_field "$1" '.name'
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
echo "━━━ Country Tests ━━━"

echo "" && echo "━━━ Test 1: Seed Countries ━━━"
test_endpoint "Seed Countries" "GET" "/country/seed" "" "200" "$TOKEN" "" >/dev/null

echo "" && echo "━━━ Test 2: Create Country ━━━"
CREATE_COUNTRY='{"name":"Test Country","code":"TC'$TS'","currency":"USD","phoneCode":"+1"}'
country_resp=$(test_endpoint "Create Country" "POST" "/country" "$CREATE_COUNTRY" "201" "$TOKEN" "validate_country")
COUNTRY_ID=$(echo "$country_resp" | jq -r '.id' 2>/dev/null)

if [ -n "$COUNTRY_ID" ] && [ "$COUNTRY_ID" != "null" ]; then
    echo "  → Created country ID: $COUNTRY_ID"
    
    echo "" && echo "━━━ Test 3: Get Country by ID ━━━"
    test_endpoint "Get Country" "GET" "/country/$COUNTRY_ID" "" "200" "$TOKEN" "validate_country" >/dev/null
    
    echo "" && echo "━━━ Test 4: Get Country by Code ━━━"
    COUNTRY_CODE=$(echo "$country_resp" | jq -r '.code' 2>/dev/null)
    test_endpoint "Get Country by Code" "GET" "/country/code/$COUNTRY_CODE" "" "200" "$TOKEN" "validate_country" >/dev/null
    
    echo "" && echo "━━━ Test 5: Update Country ━━━"
    UPDATE_COUNTRY='{"name":"Updated Test Country"}'
    test_endpoint "Update Country" "PATCH" "/country/$COUNTRY_ID" "$UPDATE_COUNTRY" "200" "$TOKEN" "validate_country" >/dev/null
fi

echo "" && echo "━━━ Test 6: Get All Countries ━━━"
test_endpoint "List Countries" "GET" "/country" "" "200" "$TOKEN" "validate_list" >/dev/null

echo ""
echo "━━━ Bank Tests ━━━"

echo "" && echo "━━━ Test 7: Create Bank ━━━"
CREATE_BANK='{"name":"Test Bank '$TS'","code":"TB'$TS'","swiftCode":"TBXXXXXXX","address":"123 Bank St"}'
bank_resp=$(test_endpoint "Create Bank" "POST" "/bank" "$CREATE_BANK" "201" "$TOKEN" "validate_bank")
BANK_ID=$(echo "$bank_resp" | jq -r '.id' 2>/dev/null)

if [ -n "$BANK_ID" ] && [ "$BANK_ID" != "null" ]; then
    echo "  → Created bank ID: $BANK_ID"
    
    echo "" && echo "━━━ Test 8: Get Bank by ID ━━━"
    test_endpoint "Get Bank" "GET" "/bank/$BANK_ID" "" "200" "$TOKEN" "validate_bank" >/dev/null
    
    echo "" && echo "━━━ Test 9: Update Bank ━━━"
    UPDATE_BANK='{"name":"Updated Test Bank '$TS'"}'
    test_endpoint "Update Bank" "PATCH" "/bank/$BANK_ID" "$UPDATE_BANK" "200" "$TOKEN" "validate_bank" >/dev/null
    
    echo "" && echo "━━━ Test 10: Get All Banks ━━━"
    test_endpoint "List Banks" "GET" "/bank" "" "200" "$TOKEN" "validate_list" >/dev/null
    
    echo ""
    echo "━━━ Bank Account Tests ━━━"
    
    echo "" && echo "━━━ Test 11: Create Bank Account ━━━"
    CREATE_ACCOUNT='{"bankId":"'$BANK_ID'","accountNumber":"ACC'$TS'","accountName":"Test Account","accountType":"CHECKING","currency":"USD"}'
    account_resp=$(test_endpoint "Create Bank Account" "POST" "/bank/account" "$CREATE_ACCOUNT" "201" "$TOKEN" "validate_bank_account")
    ACCOUNT_ID=$(echo "$account_resp" | jq -r '.id' 2>/dev/null)
    
    if [ -n "$ACCOUNT_ID" ] && [ "$ACCOUNT_ID" != "null" ]; then
        echo "  → Created bank account ID: $ACCOUNT_ID"
        
        echo "" && echo "━━━ Test 12: Get Bank Account by ID ━━━"
        test_endpoint "Get Bank Account" "GET" "/bank/account/$ACCOUNT_ID" "" "200" "$TOKEN" "validate_bank_account" >/dev/null
        
        echo "" && echo "━━━ Test 13: Update Bank Account ━━━"
        UPDATE_ACCOUNT='{"accountName":"Updated Test Account"}'
        test_endpoint "Update Bank Account" "PATCH" "/bank/account/$ACCOUNT_ID" "$UPDATE_ACCOUNT" "200" "$TOKEN" "validate_bank_account" >/dev/null
        
        echo "" && echo "━━━ Test 14: Get All Bank Accounts ━━━"
        test_endpoint "List Bank Accounts" "GET" "/bank/account" "" "200" "$TOKEN" "validate_list" >/dev/null
        
        echo "" && echo "━━━ Test 15: Delete Bank Account ━━━"
        test_endpoint "Delete Bank Account" "DELETE" "/bank/account/$ACCOUNT_ID" "" "200" "$TOKEN" "" >/dev/null
    fi
    
    echo "" && echo "━━━ Test 16: Delete Bank ━━━"
    test_endpoint "Delete Bank" "DELETE" "/bank/$BANK_ID" "" "200" "$TOKEN" "" >/dev/null
fi

if [ -n "$COUNTRY_ID" ] && [ "$COUNTRY_ID" != "null" ]; then
    echo "" && echo "━━━ Test 17: Delete Country ━━━"
    test_endpoint "Delete Country" "DELETE" "/country/$COUNTRY_ID" "" "200" "$TOKEN" "" >/dev/null
fi

echo "" && echo "━━━ Test 18: Unauthorized Access ━━━"
test_endpoint "No Auth" "GET" "/bank" "" "401" "" "" >/dev/null

print_summary
