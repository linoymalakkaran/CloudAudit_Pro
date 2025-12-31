#!/bin/bash

# Seed test data for dashboard tests
# This script creates test data with fixed IDs (test-company-id, test-period)
# in the currently authenticated tenant

source "$(dirname "$0")/auth-helper.sh"

echo "🌱 Dashboard Test Data Seeder"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Get auth token
echo "🔐 Authenticating..."
get_auth_token

if [ -z "$SHARED_AUTH_TOKEN" ]; then
    echo "❌ Authentication failed"
    exit 1
fi

# Extract tenant ID from auth response
TENANT_ID=$(echo "$AUTH_INFO" | jq -r '.tenant.id')

if [ -z "$TENANT_ID" ] || [ "$TENANT_ID" = "null" ]; then
    echo "❌ Could not get tenant ID from auth response"
    exit 1
fi

echo "✅ Authenticated for tenant: $TENANT_ID"
echo ""

# Seed test data for this tenant
echo "🌱 Seeding test data with fixed IDs..."
docker exec cloudaudit-backend sh -c "cd /app/backend && TENANT_ID='$TENANT_ID' npx ts-node prisma/demo-data/seed-test.ts"

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Test data seeded successfully!"
    echo ""
    echo "📋 You can now run tests with these credentials:"
    echo "   Email: $SHARED_USER_EMAIL"
    echo "   Token: $SHARED_AUTH_TOKEN"
    echo "   Tenant: $TENANT_ID"
    echo ""
    echo "   export SHARED_AUTH_TOKEN='$SHARED_AUTH_TOKEN'"
    echo "   export SHARED_USER_EMAIL='$SHARED_USER_EMAIL'"
else
    echo ""
    echo "❌ Failed to seed test data"
    exit 1
fi
