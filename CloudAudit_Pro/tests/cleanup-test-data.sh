#!/bin/bash

# Cleanup script for test data
# Removes test entries created during test execution

API_BASE_URL="${API_BASE_URL:-http://localhost:8000/api}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "╔════════════════════════════════════════════════════════════╗"
echo "║              TEST DATA CLEANUP                              ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""

# Get admin credentials for cleanup
echo "🔑 Authenticating for cleanup..."

# Try to get admin token
source "$SCRIPT_DIR/auth-helper.sh"
if ! init_auth; then
    echo "❌ Failed to authenticate for cleanup"
    echo "⚠️  Manual cleanup may be required"
    exit 1
fi

echo ""
echo "🗑️  Starting cleanup..."
echo ""

cleanup_count=0
error_count=0

# Function to delete resources
delete_resource() {
    local resource_type=$1
    local endpoint=$2
    
    echo "▶ Cleaning up $resource_type..."
    
    # Get all resources
    local response=$(curl -s -X GET "$API_BASE_URL$endpoint" \
        -H "Authorization: Bearer $SHARED_AUTH_TOKEN" \
        -H "Content-Type: application/json")
    
    # Check if response is array
    if ! echo "$response" | jq -e 'type == "array"' >/dev/null 2>&1; then
        echo "  ⚠️  No $resource_type found or endpoint not accessible"
        return
    fi
    
    # Get IDs of test resources
    local ids=$(echo "$response" | jq -r '.[] | select(.name? | test("Test|test|Co[0-9]|AdminCo")) | .id' 2>/dev/null)
    
    if [ -z "$ids" ]; then
        echo "  ✓ No test $resource_type to clean up"
        return
    fi
    
    # Delete each resource
    local count=0
    while IFS= read -r id; do
        if [ -n "$id" ]; then
            local del_response=$(curl -s -X DELETE "$API_BASE_URL$endpoint/$id" \
                -H "Authorization: Bearer $SHARED_AUTH_TOKEN" \
                -H "Content-Type: application/json" \
                -w "\n%{http_code}")
            
            local status=$(echo "$del_response" | tail -n 1)
            
            if [ "$status" = "200" ] || [ "$status" = "204" ]; then
                ((count++))
                ((cleanup_count++))
            else
                ((error_count++))
                echo "  ⚠️  Failed to delete $id (status: $status)"
            fi
        fi
    done <<< "$ids"
    
    if [ $count -gt 0 ]; then
        echo "  ✓ Cleaned up $count test $resource_type"
    fi
}

# Cleanup different resource types
# Note: Adjust endpoints based on your actual API structure

delete_resource "companies" "/companies"
delete_resource "periods" "/periods"
delete_resource "accounts" "/accounts"
delete_resource "procedures" "/procedures"
delete_resource "workpapers" "/workpapers"
delete_resource "findings" "/findings"
delete_resource "journal entries" "/journal-entries"
delete_resource "documents" "/documents"
delete_resource "reports" "/reports"

echo ""
echo "╔════════════════════════════════════════════════════════════╗"
echo "║              CLEANUP SUMMARY                                ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""
echo "✓ Cleaned up: $cleanup_count resources"
if [ $error_count -gt 0 ]; then
    echo "⚠️  Errors: $error_count resources"
fi
echo ""

if [ $error_count -eq 0 ]; then
    echo "✓ Cleanup completed successfully"
    exit 0
else
    echo "⚠️  Cleanup completed with errors"
    exit 1
fi
