#!/bin/bash

# CloudAudit Pro - Comprehensive API Test Suite
# Main test runner script that executes all modular tests

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

API_BASE_URL="http://localhost:8000/api"
HEALTH_URL="http://localhost:8000/api/health"
MASTER_RESULTS="test-results-master.txt"

echo ""
echo "╔════════════════════════════════════════════════════════════╗"
echo "║     CLOUDAUDIT PRO - COMPREHENSIVE API TEST SUITE           ║"
echo "║              All Modules Integration Tests                  ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""

# Initialize master results file
> "$MASTER_RESULTS"
echo "Master Test Execution Date: $(date)" >> "$MASTER_RESULTS"
echo "API Base URL: $API_BASE_URL" >> "$MASTER_RESULTS"
echo "=================================================" >> "$MASTER_RESULTS"
echo "" >> "$MASTER_RESULTS"

# Check if API is accessible
echo -n "Checking API connectivity... "
if curl -s -f "$HEALTH_URL" > /dev/null 2>&1; then
    echo -e "${GREEN}✓ API is accessible${NC}"
    echo "✓ API is accessible" >> "$MASTER_RESULTS"
else
    echo -e "${RED}✗ API is not accessible${NC}"
    echo "✗ API is not accessible at $HEALTH_URL" >> "$MASTER_RESULTS"
    echo ""
    echo "Please ensure the backend is running:"
    echo "  cd CloudAudit_Pro && docker-compose up -d backend"
    echo ""
    exit 1
fi

echo ""
echo "Starting test execution..." 
echo ""

# Test modules in order
modules=(
    "01-authentication"
    "02-companies"
    "03-periods"
    "04-accounts"
    "05-audit-procedures"
    "06-workpapers"
    "07-findings"
    "08-journal-entries"
    "09-financial-statements"
    "10-documents"
    "11-reports"
    "12-users"
    "13-ledger"
    "14-trial-balance"
    "15-config"
)

total_modules=${#modules[@]}
passed_modules=0
failed_modules=0

for module in "${modules[@]}"; do
    echo -n "▶ Running tests for $module... "
    
    # Find test script in module directory (relative to current directory)
    test_script="$module/*-tests.sh"
    test_file=$(ls $test_script 2>/dev/null | head -1)
    
    if [ -f "$test_file" ]; then
        echo "" >> "$MASTER_RESULTS"
        echo "===== $module =====" >> "$MASTER_RESULTS"
        if bash "$test_file" >> "$MASTER_RESULTS" 2>&1; then
            echo -e "${GREEN}✓ PASS${NC}"
            ((passed_modules++))
        else
            echo -e "${RED}✗ FAIL${NC}"
            ((failed_modules++))
        fi
    else
        echo -e "${YELLOW}⊘ SKIP${NC} (test script not found: $test_script)"
    fi
done

echo ""
echo "╔════════════════════════════════════════════════════════════╗"
echo "║                  FINAL TEST SUMMARY                         ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""
echo "Total Modules: $total_modules"
echo -e "Passed: ${GREEN}$passed_modules${NC}"
echo -e "Failed: ${RED}$failed_modules${NC}"
echo ""
echo "Full results saved to: $MASTER_RESULTS"
echo ""

if [ $failed_modules -eq 0 ] && [ $passed_modules -gt 0 ]; then
    echo -e "${GREEN}✓ ALL TESTS PASSED SUCCESSFULLY!${NC}"
    echo ""
    echo "Test Summary:"
    echo "  - $passed_modules modules tested successfully"
    echo "  - All API endpoints are functional"
    echo "  - All modules integrated correctly"
    exit 0
elif [ $passed_modules -eq 0 ]; then
    echo -e "${YELLOW}⚠ No tests were executed${NC}"
    echo ""
    echo "Please check test script locations"
    exit 1
else
    echo -e "${RED}✗ Some test modules failed${NC}"
    echo ""
    echo "Check $MASTER_RESULTS for detailed error information"
    exit 1
fi
