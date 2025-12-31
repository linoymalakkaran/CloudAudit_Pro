#!/bin/bash

# Dashboard Analytics Tests with Pre-seeded Data
# This script seeds data first, then runs dashboard tests with that auth token

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Seed test data and capture credentials
echo "🌱 Seeding test data first..."
SEED_OUTPUT=$(bash "$SCRIPT_DIR/seed-dashboard-test-data.sh" 2>&1)

# Check if seeding was successful
if [[ ! $SEED_OUTPUT =~ "Test data seeded successfully" ]]; then
    echo "❌ Test data seeding failed"
    echo "$SEED_OUTPUT"
    exit 1
fi

echo ""
echo "$SEED_OUTPUT" | grep -A 5 "You can now run tests"
echo ""

# Extract token and email from seed output
export SHARED_AUTH_TOKEN=$(echo "$SEED_OUTPUT" | grep "export SHARED_AUTH_TOKEN" | sed "s/.*export SHARED_AUTH_TOKEN='\\(.*\\)'/\\1/")
export SHARED_USER_EMAIL=$(echo "$SEED_OUTPUT" | grep "export SHARED_USER_EMAIL" | sed "s/.*export SHARED_USER_EMAIL='\\(.*\\)'/\\1/")

# Run dashboard tests
echo "🧪 Running dashboard analytics tests..."
cd "$SCRIPT_DIR/24-dashboard-analytics"
bash dashboard-analytics-tests.sh
