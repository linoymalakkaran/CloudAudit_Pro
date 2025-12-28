#!/bin/bash

# Quick script to cleanup and run specific test module
set -e

MODULE=$1

if [ -z "$MODULE" ]; then
    echo "Usage: $0 <module-number>"
    echo "Example: $0 13  (runs module 13-ledger)"
    exit 1
fi

# Pad module number to 2 digits
MODULE_PADDED=$(printf "%02d" $MODULE)

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

echo "🧹 Cleaning up test data..."
cd "$PROJECT_ROOT/backend"
npm run cleanup:test

echo ""
echo "🌱 Seeding database..."
npm run db:seed

echo ""
echo "🧪 Running test module $MODULE_PADDED..."
cd "$PROJECT_ROOT/tests"

# Find the matching directory
TEST_DIR=$(find . -maxdepth 1 -type d -name "${MODULE_PADDED}-*" | head -n 1)

if [ -z "$TEST_DIR" ]; then
    echo "❌ Module $MODULE_PADDED not found!"
    exit 1
fi

echo "Found: $TEST_DIR"
bash "$TEST_DIR/"*.sh

echo ""
echo "✅ Test completed!"
