#!/bin/bash

# Script to seed database and run tests
set -e

echo "╔════════════════════════════════════════════════════════════╗"
echo "║        CloudAudit Pro - Seed & Test Script                 ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Check if we should cleanup first
if [ "$1" == "--clean" ]; then
    echo "🧹 Cleaning up test data..."
    cd "$PROJECT_ROOT/backend"
    npm run cleanup:test
    echo ""
fi

# Run seed
echo "🌱 Seeding database..."
cd "$PROJECT_ROOT/backend"
npm run db:seed

echo ""
echo "✅ Database seeded successfully!"
echo ""

# Run tests if requested
if [ "$1" == "--test" ] || [ "$2" == "--test" ]; then
    echo "🧪 Running test suite..."
    cd "$PROJECT_ROOT/tests"
    
    # Run all test modules
    for dir in {01..15}-*; do
        if [ -d "$dir" ]; then
            echo ""
            echo "━━━ Testing $dir ━━━"
            bash "$dir/"*.sh | grep -E "(Success Rate|PASSED|FAILED)" || true
        fi
    done
    
    echo ""
    echo "✅ All tests completed!"
fi

echo ""
echo "╔════════════════════════════════════════════════════════════╗"
echo "║                     SCRIPT COMPLETED                        ║"
echo "╚════════════════════════════════════════════════════════════╝"
