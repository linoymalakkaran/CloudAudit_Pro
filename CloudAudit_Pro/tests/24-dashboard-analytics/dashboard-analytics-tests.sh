#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../test-helpers.sh"
source "$SCRIPT_DIR/../auth-helper.sh"

echo "╔════════════════════════════════════════════════════════════╗"
echo "║         DASHBOARD & ANALYTICS TESTS                         ║"
echo "╚════════════════════════════════════════════════════════════╝"

validate_dashboard() { 
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
echo "━━━ Dashboard Overview Tests ━━━"

echo "" && echo "━━━ Test 1: Get Executive Dashboard ━━━"
test_endpoint "Executive Dashboard" "GET" "/dashboard/executive" "" "200" "$TOKEN" "" >/dev/null

echo "" && echo "━━━ Test 2: Get Financial Dashboard ━━━"
test_endpoint "Financial Dashboard" "GET" "/dashboard/financial" "" "200" "$TOKEN" "" >/dev/null

echo "" && echo "━━━ Test 3: Get Audit Dashboard ━━━"
test_endpoint "Audit Dashboard" "GET" "/dashboard/audit" "" "200" "$TOKEN" "" >/dev/null

echo "" && echo "━━━ Test 4: Get Operational Dashboard ━━━"
test_endpoint "Operational Dashboard" "GET" "/dashboard/operational" "" "200" "$TOKEN" "" >/dev/null

echo "" && echo "━━━ Test 5: Get Custom Dashboard ━━━"
CUSTOM_DATA='{"metrics":["revenue","profit","expenses"],"period":"monthly"}'
test_endpoint "Custom Dashboard" "POST" "/dashboard/custom" "$CUSTOM_DATA" "200" "$TOKEN" "" >/dev/null

echo "" && echo "━━━ Test 6: Get Realtime Metrics ━━━"
test_endpoint "Realtime Metrics" "GET" "/dashboard/realtime" "" "200" "$TOKEN" "" >/dev/null

echo "" && echo "━━━ Test 7: Get Company Financial Overview ━━━"
test_endpoint "Company Financial" "GET" "/dashboard/company/test-company-id/financial" "" "200" "$TOKEN" "" >/dev/null

echo "" && echo "━━━ Test 8: Get Company Audit Overview ━━━"
test_endpoint "Company Audit" "GET" "/dashboard/company/test-company-id/audit" "" "200" "$TOKEN" "" >/dev/null

echo "" && echo "━━━ Test 9: Get Company KPIs ━━━"
test_endpoint "Company KPIs" "GET" "/dashboard/kpis/test-company-id" "" "200" "$TOKEN" "" >/dev/null

echo "" && echo "━━━ Test 10: Get Active Alerts ━━━"
test_endpoint "Get Alerts" "GET" "/dashboard/alerts" "" "200" "$TOKEN" "" >/dev/null

echo "" && echo "━━━ Test 11: Create Alert ━━━"
CREATE_ALERT='{"title":"Test Alert","message":"Test alert message","severity":"MEDIUM","type":"SYSTEM"}'
alert_resp=$(test_endpoint "Create Alert" "POST" "/dashboard/alerts" "$CREATE_ALERT" "201" "$TOKEN" "")
ALERT_ID=$(echo "$alert_resp" | jq -r '.id' 2>/dev/null)

if [ -n "$ALERT_ID" ] && [ "$ALERT_ID" != "null" ]; then
    echo "" && echo "━━━ Test 12: Acknowledge Alert ━━━"
    test_endpoint "Acknowledge Alert" "PATCH" "/dashboard/alerts/$ALERT_ID/acknowledge" "" "200" "$TOKEN" "" >/dev/null
fi

echo "" && echo "━━━ Test 13: Get Trend Analysis ━━━"
test_endpoint "Trend Analysis" "GET" "/dashboard/trends/test-company-id" "" "200" "$TOKEN" "" >/dev/null

echo "" && echo "━━━ Test 14: Get Performance Metrics ━━━"
test_endpoint "Performance Metrics" "GET" "/dashboard/performance/test-company-id" "" "200" "$TOKEN" "" >/dev/null

echo "" && echo "━━━ Test 15: Get Analytics Summary ━━━"
test_endpoint "Analytics Summary" "GET" "/dashboard/analytics/test-company-id/summary" "" "200" "$TOKEN" "" >/dev/null

echo "" && echo "━━━ Test 16: Get System Health ━━━"
test_endpoint "System Health" "GET" "/dashboard/health" "" "200" "$TOKEN" "" >/dev/null

echo ""
echo "━━━ Custom Dashboards Tests ━━━"

echo "" && echo "━━━ Test 17: Create Dashboard ━━━"
CREATE_DASH='{"name":"Test Dashboard '$TS'","description":"Test dashboard","layout":"grid","widgets":[{"type":"chart","config":{}}]}'
dash_resp=$(test_endpoint "Create Dashboard" "POST" "/dashboards" "$CREATE_DASH" "201" "$TOKEN" "validate_dashboard")
DASH_ID=$(echo "$dash_resp" | jq -r '.id' 2>/dev/null)

if [ -n "$DASH_ID" ] && [ "$DASH_ID" != "null" ]; then
    echo "  → Created dashboard ID: $DASH_ID"
    
    echo "" && echo "━━━ Test 18: Get Dashboard by ID ━━━"
    test_endpoint "Get Dashboard" "GET" "/dashboards/$DASH_ID" "" "200" "$TOKEN" "validate_dashboard" >/dev/null
    
    echo "" && echo "━━━ Test 19: Update Dashboard ━━━"
    UPDATE_DASH='{"description":"Updated dashboard description"}'
    test_endpoint "Update Dashboard" "PATCH" "/dashboards/$DASH_ID" "$UPDATE_DASH" "200" "$TOKEN" "validate_dashboard" >/dev/null
    
    echo "" && echo "━━━ Test 20: Get All Dashboards ━━━"
    test_endpoint "List Dashboards" "GET" "/dashboards" "" "200" "$TOKEN" "validate_list" >/dev/null
    
    echo "" && echo "━━━ Test 21: Get Default Dashboard ━━━"
    test_endpoint "Get Default Dashboard" "GET" "/dashboards/default" "" "200" "$TOKEN" "" >/dev/null
    
    echo "" && echo "━━━ Test 22: Duplicate Dashboard ━━━"
    test_endpoint "Duplicate Dashboard" "POST" "/dashboards/$DASH_ID/duplicate" '{"name":"Duplicated Dashboard"}' "201" "$TOKEN" "" >/dev/null
    
    echo "" && echo "━━━ Test 23: Set as Default Dashboard ━━━"
    test_endpoint "Set Default Dashboard" "POST" "/dashboards/$DASH_ID/set-default" "" "200" "$TOKEN" "" >/dev/null
    
    echo "" && echo "━━━ Test 24: Share Dashboard ━━━"
    SHARE_DATA='{"userIds":["user1","user2"],"permissions":"VIEW"}'
    test_endpoint "Share Dashboard" "POST" "/dashboards/$DASH_ID/share" "$SHARE_DATA" "200" "$TOKEN" "" >/dev/null
    
    echo "" && echo "━━━ Test 25: Unshare Dashboard ━━━"
    UNSHARE_DATA='{"userIds":["user1"]}'
    test_endpoint "Unshare Dashboard" "POST" "/dashboards/$DASH_ID/unshare" "$UNSHARE_DATA" "200" "$TOKEN" "" >/dev/null
    
    echo "" && echo "━━━ Test 26: Get Widget Data ━━━"
    WIDGET_DATA='{"widgetType":"revenue_chart","filters":{}}'
    test_endpoint "Get Widget Data" "POST" "/dashboards/widget-data" "$WIDGET_DATA" "200" "$TOKEN" "" >/dev/null
    
    echo "" && echo "━━━ Test 27: Delete Dashboard ━━━"
    test_endpoint "Delete Dashboard" "DELETE" "/dashboards/$DASH_ID" "" "200" "$TOKEN" "" >/dev/null
fi

echo ""
echo "━━━ Analytics Tests ━━━"

echo "" && echo "━━━ Test 28: Get Analytics Overview ━━━"
test_endpoint "Analytics Overview" "GET" "/analytics/overview" "" "200" "$TOKEN" "" >/dev/null

echo "" && echo "━━━ Test 29: Custom Analytics Query ━━━"
QUERY_DATA='{"metrics":["revenue","expenses"],"dimensions":["time","category"],"filters":{}}'
test_endpoint "Custom Analytics Query" "POST" "/analytics/query" "$QUERY_DATA" "200" "$TOKEN" "" >/dev/null

echo "" && echo "━━━ Test 30: Get Financial Ratios ━━━"
test_endpoint "Financial Ratios" "GET" "/analytics/financial-ratios?companyId=test-company&periodId=test-period" "" "200" "$TOKEN" "" >/dev/null

echo "" && echo "━━━ Test 31: Get Trend Analysis for Metric ━━━"
test_endpoint "Metric Trends" "GET" "/analytics/trends/revenue?companyId=test-company" "" "200" "$TOKEN" "" >/dev/null

echo "" && echo "━━━ Test 32: Get Variance Analysis ━━━"
test_endpoint "Variance Analysis" "GET" "/analytics/variance?companyId=test-company&periodId=test-period" "" "200" "$TOKEN" "" >/dev/null

echo "" && echo "━━━ Test 33: Get Aging Analysis ━━━"
test_endpoint "Aging Analysis" "GET" "/analytics/aging?companyId=test-company&accountType=RECEIVABLES" "" "200" "$TOKEN" "" >/dev/null

echo "" && echo "━━━ Test 34: Calculate Materiality ━━━"
test_endpoint "Materiality" "GET" "/analytics/materiality?companyId=test-company&totalAssets=1000000" "" "200" "$TOKEN" "" >/dev/null

echo "" && echo "━━━ Test 35: Create Analytics Snapshot ━━━"
SNAPSHOT_DATA='{"name":"Test Snapshot","companyId":"test-company","metrics":["revenue","profit"]}'
test_endpoint "Create Snapshot" "POST" "/analytics/snapshots" "$SNAPSHOT_DATA" "201" "$TOKEN" "" >/dev/null

echo "" && echo "━━━ Test 36: Get Analytics Snapshots ━━━"
test_endpoint "Get Snapshots" "GET" "/analytics/snapshots?companyId=test-company" "" "200" "$TOKEN" "" >/dev/null

echo "" && echo "━━━ Test 37: Unauthorized Access ━━━"
test_endpoint "No Auth" "GET" "/dashboard/executive" "" "401" "" "" >/dev/null

print_summary
