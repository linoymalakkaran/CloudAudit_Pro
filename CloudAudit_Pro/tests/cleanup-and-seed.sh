#!/bin/bash

# Script to cleanup test data and reseed database for fresh test runs

echo "╔════════════════════════════════════════════════════════════╗"
echo "║        CloudAudit Pro - Test Data Reset Script             ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""

# Check if we're in the tests directory
if [ ! -f "test-helpers.sh" ]; then
    echo "❌ Error: Must run this script from the tests directory"
    exit 1
fi

echo "🧹 Cleaning up test data..."
echo ""

# Run cleanup script inside backend container
docker exec cloudaudit-backend sh -c "cd /app/backend && npm run db:cleanup"

if [ $? -ne 0 ]; then
    echo ""
    echo "❌ Cleanup failed!"
    exit 1
fi

echo ""
echo "🌱 Seeding database..."
echo ""

# Run seed script inside backend container
docker exec cloudaudit-backend sh -c "cd /app/backend && npm run db:seed"

if [ $? -ne 0 ]; then
    echo ""
    echo "❌ Seeding failed!"
    exit 1
fi

echo ""
echo "✅ Database reset completed successfully!"
echo ""
echo "💡 You can now run your test suites with fresh data"
echo ""
