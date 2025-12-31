#!/bin/bash

# Quick test of dashboard endpoints

echo "🧪 Quick Dashboard Test"
echo "======================"

cd "$(dirname "$0")"
export API_BASE_URL="http://localhost:8000/api"

# Get auth
source auth-helper.sh
get_auth_token

if [ -z "$SHARED_AUTH_TOKEN" ]; then
    echo "❌ Failed to get auth token"
    exit 1
fi

echo "✅ Got auth token"
echo ""

# Test executive dashboard
echo "Testing /dashboard/executive..."
RESPONSE=$(curl -s -X GET "$API_BASE_URL/dashboard/executive" -H "Authorization: Bearer $SHARED_AUTH_TOKEN")
STATUS=$(echo "$RESPONSE" | jq -r '.statusCode // "success"')

if [ "$STATUS" = "success" ] || [ "$STATUS" = "null" ]; then
    echo "✅ Executive Dashboard: PASS"
else
    echo "❌ Executive Dashboard: FAIL (status: $STATUS)"
    echo "   Response: $(echo "$RESPONSE" | jq -c .)"
fi

echo ""
echo "Testing /dashboard/financial..."
RESPONSE=$(curl -s -X GET "$API_BASE_URL/dashboard/financial" -H "Authorization: Bearer $SHARED_AUTH_TOKEN")
STATUS=$(echo "$RESPONSE" | jq -r '.statusCode // "success"')

if [ "$STATUS" = "success" ] || [ "$STATUS" = "null" ]; then
    echo "✅ Financial Dashboard: PASS"
else
    echo "❌ Financial Dashboard: FAIL (status: $STATUS)"
fi

echo ""
echo "Testing /dashboard/audit..."
RESPONSE=$(curl -s -X GET "$API_BASE_URL/dashboard/audit" -H "Authorization: Bearer $SHARED_AUTH_TOKEN")
STATUS=$(echo "$RESPONSE" | jq -r '.statusCode // "success"')

if [ "$STATUS" = "success" ] || [ "$STATUS" = "null" ]; then
    echo "✅ Audit Dashboard: PASS"
else
    echo "❌ Audit Dashboard: FAIL (status: $STATUS)"
fi

echo ""
echo "✅ Quick test complete"
