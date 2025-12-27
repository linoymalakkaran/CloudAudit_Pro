#!/bin/bash

# Common test helpers for CloudAudit Pro API tests

API_BASE_URL="${API_BASE_URL:-http://localhost:8000/api}"

# Colors
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[1;33m'
export BLUE='\033[0;34m'
export NC='\033[0m'

# Counters
export TOTAL_TESTS=0
export PASSED_TESTS=0
export FAILED_TESTS=0

# Validate JSON
validate_json() {
    echo "$1" | jq empty 2>/dev/null
    return $?
}

# Check if field exists
check_field() {
    echo "$1" | jq -e "$2" >/dev/null 2>&1
    return $?
}

# Make API request
api_request() {
    local method=$1
    local endpoint=$2
    local data=$3
    local token=$4
    
    local cmd="curl -s -w '\n%{http_code}' -X $method '$API_BASE_URL$endpoint'"
    
    if [ -n "$data" ]; then
        cmd="$cmd -H 'Content-Type: application/json' -d '$data'"
    fi
    
    if [ -n "$token" ]; then
        cmd="$cmd -H 'Authorization: Bearer $token'"
    fi
    
    eval "$cmd" 2>&1
}

# Test API endpoint with validation
test_endpoint() {
    local test_name=$1
    local method=$2
    local endpoint=$3
    local data=$4
    local expected_status=$5
    local auth_token=$6
    local validator=$7
    
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
    
    echo ""
    echo -e "${BLUE}▶ Test $TOTAL_TESTS: $test_name${NC}"
    echo "  Method: $method"
    echo "  Endpoint: $endpoint"
    
    # Make request
    local response=$(api_request "$method" "$endpoint" "$data" "$auth_token")
    local status=$(echo "$response" | tail -n 1)
    local body=$(echo "$response" | sed '$d')
    
    echo "  Expected Status: $expected_status"
    echo "  Actual Status: $status"
    
    local test_passed=true
    
    # Validate status code
    if [ "$status" != "$expected_status" ]; then
        echo -e "  ${RED}✗ Status Code: FAIL${NC}"
        test_passed=false
    else
        echo -e "  ${GREEN}✓ Status Code: PASS${NC}"
    fi
    
    # Validate JSON
    if validate_json "$body"; then
        echo -e "  ${GREEN}✓ Valid JSON: PASS${NC}"
        
        # Run custom validation
        if [ -n "$validator" ] && [ "$test_passed" = "true" ]; then
            if $validator "$body"; then
                echo -e "  ${GREEN}✓ Schema Validation: PASS${NC}"
            else
                echo -e "  ${RED}✗ Schema Validation: FAIL${NC}"
                test_passed=false
            fi
        fi
    else
        echo -e "  ${RED}✗ Valid JSON: FAIL${NC}"
        echo "  Response: $body" | head -c 200
        test_passed=false
    fi
    
    # Update counters
    if [ "$test_passed" = "true" ]; then
        echo -e "  ${GREEN}✓ OVERALL: PASS${NC}"
        PASSED_TESTS=$((PASSED_TESTS + 1))
    else
        echo -e "  ${RED}✗ OVERALL: FAIL${NC}"
        FAILED_TESTS=$((FAILED_TESTS + 1))
    fi
    
    # Return the body for further processing
    echo "$body"
}

# Print test summary
print_summary() {
    echo ""
    echo "╔════════════════════════════════════════════════════════════╗"
    echo "║                    TEST SUMMARY                             ║"
    echo "╚════════════════════════════════════════════════════════════╝"
    echo ""
    echo "Total Tests: $TOTAL_TESTS"
    echo -e "Passed: ${GREEN}$PASSED_TESTS${NC}"
    echo -e "Failed: ${RED}$FAILED_TESTS${NC}"
    
    if [ $TOTAL_TESTS -gt 0 ]; then
        local success_rate=$((PASSED_TESTS * 100 / TOTAL_TESTS))
        echo "Success Rate: $success_rate%"
    fi
    
    echo ""
    
    if [ $FAILED_TESTS -eq 0 ]; then
        echo -e "${GREEN}✓ ALL TESTS PASSED!${NC}"
        return 0
    else
        echo -e "${RED}✗ $FAILED_TESTS test(s) failed${NC}"
        return 1
    fi
}
