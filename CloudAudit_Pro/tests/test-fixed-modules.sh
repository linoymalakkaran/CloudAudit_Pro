#!/bin/bash

# Test the fixed modules
cd "$(dirname "$0")"

echo "╔════════════════════════════════════════════════════════════╗"
echo "║         TESTING FIXED MODULES                               ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""

echo "Testing Module 24: Dashboard Analytics..."
bash 24-dashboard-analytics/dashboard-analytics-tests.sh 2>&1 | grep -E "TEST SUMMARY|Total Tests|Passed|Failed|Success Rate" | tail -5
echo ""

echo "Testing Module 27: Data Management..."
bash 27-data-management/data-management-tests.sh 2>&1 | grep -E "TEST SUMMARY|Total Tests|Passed|Failed|Success Rate" | tail -5
echo ""

echo "✓ Test execution complete"
