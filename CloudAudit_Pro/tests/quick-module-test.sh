#!/bin/bash

# Quick module test runner
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

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
  "16-tenants"
  "17-currency-exchange"
  "18-bank-country"
  "19-financial-schedules"
  "20-review-qc"
  "21-audit-finalization"
  "22-advanced-testing"
  "23-document-advanced"
  "24-dashboard-analytics"
  "25-reporting-advanced"
  "26-notifications-preferences"
  "27-data-management"
  "28-integrations"
  "29-procedure-templates"
  "30-system-config"
)

total_modules=0
passed_modules=0
failed_modules=0

echo "╔════════════════════════════════════════════════════════════╗"
echo "║         QUICK MODULE TEST - SUMMARY ONLY                    ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""

for module in "${modules[@]}"; do
  total_modules=$((total_modules + 1))
  test_file=$(find "$module" -name "*-tests.sh" 2>/dev/null | head -1)
  
  if [ -n "$test_file" ]; then
    result=$(bash "$test_file" 2>&1 | grep -E "Success Rate:|ALL TESTS PASSED|test\(s\) failed" | tail -1)
    
    if echo "$result" | grep -qE "100%|ALL TESTS PASSED"; then
      echo "✓ $module: PASSED"
      passed_modules=$((passed_modules + 1))
    else
      echo "✗ $module: FAILED"
      failed_modules=$((failed_modules + 1))
    fi
  else
    echo "⚠ $module: NOT FOUND"
  fi
done

echo ""
echo "╔════════════════════════════════════════════════════════════╗"
echo "║                  FINAL SUMMARY                              ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo "Total Modules: $total_modules"
echo "Passed: $passed_modules"
echo "Failed: $failed_modules"
echo ""

if [ $failed_modules -eq 0 ]; then
  echo "✓ ALL MODULES PASSED!"
  exit 0
else
  echo "✗ $failed_modules module(s) failed"
  exit 1
fi
