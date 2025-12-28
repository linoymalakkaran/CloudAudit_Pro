#!/bin/bash

# CloudAudit Pro - Comprehensive API Test Suite
# Main test runner script that executes all modular tests

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

API_BASE_URL="http://localhost:8000/api"
HEALTH_URL="http://localhost:8000/api/health"

# Create results directory if it doesn't exist
mkdir -p results

MASTER_RESULTS="results/test-results-master.txt"
DETAILED_RESULTS="results/test-results-detailed.json"

echo ""
echo "╔════════════════════════════════════════════════════════════╗"
echo "║     CLOUDAUDIT PRO - COMPREHENSIVE API TEST SUITE           ║"
echo "║              All Modules Integration Tests                  ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""

# Initialize master results file
> "$MASTER_RESULTS"
> "$DETAILED_RESULTS"
echo "[" > "$DETAILED_RESULTS"
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

# Ask about cleanup
echo ""
read -p "Run cleanup before tests? (y/N): " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Running cleanup..."
    bash cleanup-test-data.sh || true
    echo ""
fi

echo ""
echo "Starting test execution..." 
echo ""

# Arrays to track detailed results
declare -A module_results
declare -A api_results

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
    echo -e "${CYAN}▶ Running tests for $module...${NC}"
    
    # Find test script in module directory (relative to current directory)
    test_script="$module/*-tests.sh"
    test_file=$(ls $test_script 2>/dev/null | head -1)
    
    if [ -f "$test_file" ]; then
        echo "" >> "$MASTER_RESULTS"
        echo "===== $module =====" >> "$MASTER_RESULTS"
        
        # Capture test output
        test_output=$(bash "$test_file" 2>&1)
        test_exit_code=$?
        
        echo "$test_output" >> "$MASTER_RESULTS"
        
        # Parse test results from output
        total=$(echo "$test_output" | grep "Total Tests:" | grep -o '[0-9]\+' | head -1)
        passed=$(echo "$test_output" | grep "Passed:" | grep -o '[0-9]\+' | head -1)
        failed=$(echo "$test_output" | grep "Failed:" | grep -o '[0-9]\+' | head -1)
        
        # Store module result
        module_results[$module]="$total:$passed:$failed"
        
        # Extract API endpoints tested (from the output)
        apis=$(echo "$test_output" | grep "▶ Test" | sed 's/.*Test [0-9]*: //' | sed 's/\x1b\[[0-9;]*m//g')
        
        if [ $test_exit_code -eq 0 ]; then
            echo -e "  ${GREEN}✓ PASS${NC} ($passed/$total tests)"
            ((passed_modules++))
            
            # Mark all APIs as passed
            while IFS= read -r line; do
                if [ -n "$line" ]; then
                    api_results["$module:$line"]="PASS"
                fi
            done <<< "$apis"
        else
            echo -e "  ${RED}✗ FAIL${NC} ($passed/$total tests)"
            ((failed_modules++))
            
            # Parse which APIs failed
            while IFS= read -r line; do
                if [ -n "$line" ]; then
                    # Check if this test passed or failed in output
                    if echo "$test_output" | grep -A 10 "$line" | grep -q "OVERALL: PASS"; then
                        api_results["$module:$line"]="PASS"
                    else
                        api_results["$module:$line"]="FAIL"
                    fi
                fi
            done <<< "$apis"
        fi
        echo ""
    else
        echo -e "${YELLOW}⊘ SKIP${NC} (test script not found: $test_script)"
        module_results[$module]="0:0:0"
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

# Print detailed module results
echo "╔════════════════════════════════════════════════════════════╗"
echo "║              MODULE-BY-MODULE RESULTS                       ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""

total_tests=0
total_passed=0
total_failed=0

for module in "${modules[@]}"; do
    result="${module_results[$module]}"
    if [ -n "$result" ]; then
        IFS=':' read -r mod_total mod_passed mod_failed <<< "$result"
        total_tests=$((total_tests + mod_total))
        total_passed=$((total_passed + mod_passed))
        total_failed=$((total_failed + mod_failed))
        
        if [ "$mod_failed" -eq 0 ] && [ "$mod_total" -gt 0 ]; then
            echo -e "${GREEN}✓${NC} $module: $mod_passed/$mod_total tests passed"
        elif [ "$mod_total" -eq 0 ]; then
            echo -e "${YELLOW}⊘${NC} $module: No tests"
        else
            echo -e "${RED}✗${NC} $module: $mod_passed/$mod_total tests passed, $mod_failed failed"
        fi
    fi
done

echo ""
echo "╔════════════════════════════════════════════════════════════╗"
echo "║              API ENDPOINT RESULTS                           ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""

# Count API results
passed_apis=0
failed_apis=0

echo "✅ PASSING APIs:"
for key in "${!api_results[@]}"; do
    if [ "${api_results[$key]}" = "PASS" ]; then
        echo "   ✓ $key"
        ((passed_apis++))
    fi
done

echo ""
echo "❌ FAILING APIs:"
has_failures=false
for key in "${!api_results[@]}"; do
    if [ "${api_results[$key]}" = "FAIL" ]; then
        echo "   ✗ $key"
        ((failed_apis++))
        has_failures=true
    fi
done

if [ "$has_failures" = false ]; then
    echo "   (none)"
fi

echo ""
echo "╔════════════════════════════════════════════════════════════╗"
echo "║              OVERALL STATISTICS                             ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""
echo "Total Modules Tested: $total_modules"
echo "Total Individual Tests: $total_tests"
echo -e "Total Tests Passed: ${GREEN}$total_passed${NC}"
echo -e "Total Tests Failed: ${RED}$total_failed${NC}"
if [ $total_tests -gt 0 ]; then
    success_rate=$((total_passed * 100 / total_tests))
    echo "Overall Success Rate: $success_rate%"
fi
echo ""
echo "Full results saved to: $MASTER_RESULTS"
echo ""

if [ $failed_modules -eq 0 ] && [ $passed_modules -gt 0 ]; then
    echo -e "${GREEN}✓ ALL TESTS PASSED SUCCESSFULLY!${NC}"
    echo ""
    exit 0
elif [ $passed_modules -eq 0 ]; then
    echo -e "${YELLOW}⚠ No tests were executed${NC}"
    exit 1
else
    echo -e "${RED}✗ $failed_modules module(s) failed${NC}"
    echo ""
    echo "Check $MASTER_RESULTS for detailed error information"
    exit 1
fi
