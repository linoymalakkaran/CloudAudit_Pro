#!/bin/bash

# Comprehensive Test Runner for CloudAudit Pro
# Runs all 26 test modules and provides a detailed summary

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Test results tracking
TOTAL_MODULES=0
PASSED_MODULES=0
FAILED_MODULES=0
SKIPPED_MODULES=0

declare -a FAILED_MODULE_NAMES
declare -a PASSED_MODULE_NAMES
declare -a SKIPPED_MODULE_NAMES

# Function to run a single test module
run_module() {
    local module_num=$1
    local module_name=$2
    local test_script=$3
    
    TOTAL_MODULES=$((TOTAL_MODULES + 1))
    
    echo ""
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}Module $module_num: $module_name${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    
    if [ ! -f "$test_script" ]; then
        echo -e "${YELLOW}⚠️  Test script not found: $test_script${NC}"
        SKIPPED_MODULES=$((SKIPPED_MODULES + 1))
        SKIPPED_MODULE_NAMES+=("$module_num: $module_name")
        return
    fi
    
    # Run the test with timeout
    timeout 120 bash "$test_script" > /tmp/test_output_$module_num.log 2>&1
    EXIT_CODE=$?
    
    # Check results
    if [ $EXIT_CODE -eq 0 ]; then
        # Check if actually passed (look for success indicators)
        if grep -q "ALL TESTS PASSED\|Success Rate: 100%" /tmp/test_output_$module_num.log; then
            echo -e "${GREEN}✅ PASSED${NC}"
            PASSED_MODULES=$((PASSED_MODULES + 1))
            PASSED_MODULE_NAMES+=("$module_num: $module_name")
        else
            # Show summary from output
            echo -e "${YELLOW}⚠️  COMPLETED (check results)${NC}"
            tail -20 /tmp/test_output_$module_num.log | grep -E "Success Rate|Total Tests|Passed|Failed" || echo "  Check log: /tmp/test_output_$module_num.log"
            FAILED_MODULES=$((FAILED_MODULES + 1))
            FAILED_MODULE_NAMES+=("$module_num: $module_name")
        fi
    elif [ $EXIT_CODE -eq 124 ]; then
        echo -e "${RED}⏱️  TIMEOUT (exceeded 120 seconds)${NC}"
        FAILED_MODULES=$((FAILED_MODULES + 1))
        FAILED_MODULE_NAMES+=("$module_num: $module_name (TIMEOUT)")
    else
        echo -e "${RED}❌ FAILED (exit code: $EXIT_CODE)${NC}"
        tail -10 /tmp/test_output_$module_num.log | grep -E "Error|FAIL|error" || tail -5 /tmp/test_output_$module_num.log
        FAILED_MODULES=$((FAILED_MODULES + 1))
        FAILED_MODULE_NAMES+=("$module_num: $module_name (EXIT $EXIT_CODE)")
    fi
}

# Print header
clear
echo -e "${BLUE}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║       CloudAudit Pro - Comprehensive Test Suite            ║${NC}"
echo -e "${BLUE}╔════════════════════════════════════════════════════════════╗${NC}"
echo ""
echo "Starting test execution at $(date)"
echo "API Endpoint: http://localhost:8000/api"
echo ""

# Run all modules
run_module "01" "Authentication" "01-authentication/auth-tests.sh"
run_module "02" "Companies" "02-companies/companies-tests.sh"
run_module "03" "Periods" "03-periods/periods-tests.sh"
run_module "04" "Accounts" "04-accounts/accounts-tests.sh"
run_module "05" "Audit Procedures" "05-audit-procedures/audit-procedures-tests.sh"
run_module "06" "Workpapers" "06-workpapers/workpapers-tests.sh"
run_module "07" "Findings" "07-findings/findings-tests.sh"
run_module "08" "Journal Entries" "08-journal-entries/journal-entries-tests.sh"
run_module "09" "Financial Statements" "09-financial-statements/financial-statements-tests.sh"
run_module "10" "Documents" "10-documents/documents-tests.sh"
run_module "11" "Reports" "11-reports/reports-tests.sh"
run_module "12" "Users" "12-users/users-tests.sh"
run_module "13" "Ledger" "13-ledger/ledger-tests.sh"
run_module "14" "Trial Balance" "14-trial-balance/trial-balance-tests.sh"
run_module "15" "Configuration" "15-config/config-tests.sh"
run_module "16" "Tenants" "16-tenants/tenants-tests.sh"
run_module "17" "Currency Exchange" "17-currency-exchange/currency-exchange-tests.sh"
run_module "18" "Bank & Country" "18-bank-country/bank-country-tests.sh"
run_module "19" "Financial Schedules" "19-financial-schedules/financial-schedules-tests.sh"
run_module "20" "Review & QC" "20-review-qc/review-qc-tests.sh"
run_module "21" "Audit Finalization" "21-audit-finalization/audit-finalization-tests.sh"
run_module "22" "Advanced Testing" "22-advanced-testing/advanced-testing-tests.sh"
run_module "23" "Document Advanced" "23-document-advanced/document-advanced-tests.sh"
run_module "24" "Dashboard Analytics" "24-dashboard-analytics/dashboard-analytics-tests.sh"
run_module "25" "Reporting Advanced" "25-reporting-advanced/reporting-advanced-tests.sh"
run_module "26" "Notifications & Preferences" "26-notifications-preferences/notifications-preferences-tests.sh"

# Print comprehensive summary
echo ""
echo -e "${BLUE}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║                    TEST EXECUTION SUMMARY                   ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo "Completed at: $(date)"
echo ""
echo "Total Modules: $TOTAL_MODULES"
echo -e "${GREEN}Passed: $PASSED_MODULES${NC}"
echo -e "${RED}Failed: $FAILED_MODULES${NC}"
echo -e "${YELLOW}Skipped: $SKIPPED_MODULES${NC}"
echo ""

# Calculate success rate
if [ $TOTAL_MODULES -gt 0 ]; then
    SUCCESS_RATE=$(awk "BEGIN {printf \"%.1f\", ($PASSED_MODULES/$TOTAL_MODULES)*100}")
    echo -e "Success Rate: ${GREEN}${SUCCESS_RATE}%${NC}"
fi

# Show passed modules
if [ ${#PASSED_MODULE_NAMES[@]} -gt 0 ]; then
    echo ""
    echo -e "${GREEN}✅ Passed Modules:${NC}"
    for module in "${PASSED_MODULE_NAMES[@]}"; do
        echo -e "   ${GREEN}✓${NC} $module"
    done
fi

# Show failed modules
if [ ${#FAILED_MODULE_NAMES[@]} -gt 0 ]; then
    echo ""
    echo -e "${RED}❌ Failed Modules:${NC}"
    for module in "${FAILED_MODULE_NAMES[@]}"; do
        echo -e "   ${RED}✗${NC} $module"
    done
fi

# Show skipped modules
if [ ${#SKIPPED_MODULE_NAMES[@]} -gt 0 ]; then
    echo ""
    echo -e "${YELLOW}⚠️  Skipped Modules:${NC}"
    for module in "${SKIPPED_MODULE_NAMES[@]}"; do
        echo -e "   ${YELLOW}○${NC} $module"
    done
fi

echo ""
echo "Logs available in: /tmp/test_output_*.log"
echo ""

# Exit with appropriate code
if [ $FAILED_MODULES -eq 0 ] && [ $SKIPPED_MODULES -eq 0 ]; then
    echo -e "${GREEN}🎉 All tests passed successfully!${NC}"
    exit 0
else
    echo -e "${RED}⚠️  Some tests failed or were skipped. Review the results above.${NC}"
    exit 1
fi
