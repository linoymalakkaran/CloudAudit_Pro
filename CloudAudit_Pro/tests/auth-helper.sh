#!/bin/bash

# Shared authentication helper for test suites
# Provides reusable auth token generation

API_BASE_URL="${API_BASE_URL:-http://localhost:8000/api}"

# Global variable to store auth token
export SHARED_AUTH_TOKEN=""
export SHARED_USER_EMAIL=""
export SHARED_TENANT_SUBDOMAIN=""
export AUTH_INFO=""

# Get authenticated token (register + auto-approve + login)
# Returns: Sets SHARED_AUTH_TOKEN, SHARED_USER_EMAIL, SHARED_TENANT_SUBDOMAIN
get_auth_token() {
    local TS=$(date +%s)
    SHARED_USER_EMAIL="testadmin${TS}@test.com"
    SHARED_TENANT_SUBDOMAIN="tenant${TS}"
    
    local PASSWORD="Test@12345"
    local FIRST_NAME="Admin"
    local LAST_NAME="User"
    local COMPANY_NAME="AdminCo${TS}"
    
    # Register new user
    local REG_DATA="{\"email\":\"$SHARED_USER_EMAIL\",\"password\":\"$PASSWORD\",\"firstName\":\"$FIRST_NAME\",\"lastName\":\"$LAST_NAME\",\"companyName\":\"$COMPANY_NAME\",\"tenantSubdomain\":\"$SHARED_TENANT_SUBDOMAIN\"}"
    
    local reg_response=$(curl -s -X POST "$API_BASE_URL/auth/register" \
        -H "Content-Type: application/json" \
        -d "$REG_DATA")
    
    # Get tenant ID and user ID from registration
    local tenant_id=$(echo "$reg_response" | jq -r '.tenant.id' 2>/dev/null)
    local user_id=$(echo "$reg_response" | jq -r '.user.id' 2>/dev/null)
    local reg_status=$(echo "$reg_response" | jq -r '.status' 2>/dev/null)
    local reg_token=$(echo "$reg_response" | jq -r '.access_token' 2>/dev/null)
    
    if [ -z "$tenant_id" ] || [ "$tenant_id" = "null" ]; then
        echo "❌ Registration failed: No tenant ID"
        return 1
    fi
    
    # If registration directly returns a token (auto-approved), use it
    if [ -n "$reg_token" ] && [ "$reg_token" != "null" ]; then
        echo "✅ Registration auto-approved, token received"
        SHARED_AUTH_TOKEN="$reg_token"
        # Store registration response as AUTH_INFO
        AUTH_INFO="$reg_response"
        return 0
    fi
    
    # If status is PENDING_APPROVAL, we need to use a workaround
    # Create a new test account that bypasses approval (if available)
    # Or use environment variable to get a pre-approved account
    
    if [ "$reg_status" = "PENDING_APPROVAL" ]; then
        echo "⚠️  Account pending approval, trying workaround..."
        
        # Try to use pre-configured test account
        if [ -n "$TEST_USER_EMAIL" ]; then
            SHARED_USER_EMAIL="$TEST_USER_EMAIL"
            SHARED_TENANT_SUBDOMAIN="${TEST_TENANT:-cloudaudit}"
            PASSWORD="${TEST_PASSWORD:-Admin@123}"
        else
            # For now, skip the approval and try to login (will fail with 401)
            echo "ℹ️  Using pending account (tests will validate rejection properly)"
        fi
    fi
    
    # Login to get token
    local LOGIN_DATA="{\"email\":\"$SHARED_USER_EMAIL\",\"password\":\"$PASSWORD\",\"tenantSubdomain\":\"$SHARED_TENANT_SUBDOMAIN\"}"
    
    local login_response=$(curl -s -X POST "$API_BASE_URL/auth/login" \
        -H "Content-Type: application/json" \
        -d "$LOGIN_DATA")
    
    # Store full auth info for use by tests
    AUTH_INFO="$login_response"
    # Debug: Verify AUTH_INFO is set (remove in production)
    # echo "DEBUG: AUTH_INFO length: ${#AUTH_INFO}" >&2
    
    SHARED_AUTH_TOKEN=$(echo "$login_response" | jq -r '.accessToken' 2>/dev/null)
    
    if [ -z "$SHARED_AUTH_TOKEN" ] || [ "$SHARED_AUTH_TOKEN" = "null" ]; then
        # Check if it's due to pending approval
        local error_msg=$(echo "$login_response" | jq -r '.message' 2>/dev/null)
        if echo "$error_msg" | grep -qi "pending\|approval"; then
            echo "ℹ️  Account pending approval - using mock token for testing"
            # Set a placeholder to indicate we tried
            SHARED_AUTH_TOKEN="PENDING_APPROVAL"
            return 2  # Special return code for pending approval
        fi
        echo "❌ Login failed: Token not found"
        echo "Response: $login_response" | head -c 200
        return 1
    fi
    
    return 0
}

# Pre-approved test account (if configured in test environment)
# This can be used if auto-approval is enabled
use_preapproved_account() {
    SHARED_USER_EMAIL="${TEST_USER_EMAIL:-admin@cloudaudit.test}"
    SHARED_TENANT_SUBDOMAIN="${TEST_TENANT:-cloudaudit}"
    local PASSWORD="${TEST_PASSWORD:-Admin@123}"
    
    local LOGIN_DATA="{\"email\":\"$SHARED_USER_EMAIL\",\"password\":\"$PASSWORD\",\"tenantSubdomain\":\"$SHARED_TENANT_SUBDOMAIN\"}"
    
    local login_response=$(curl -s -X POST "$API_BASE_URL/auth/login" \
        -H "Content-Type: application/json" \
        -d "$LOGIN_DATA")
    
    # Store full auth info for use by tests
    AUTH_INFO="$login_response"
    
    SHARED_AUTH_TOKEN=$(echo "$login_response" | jq -r '.accessToken' 2>/dev/null)
    
    if [ -z "$SHARED_AUTH_TOKEN" ] || [ "$SHARED_AUTH_TOKEN" = "null" ]; then
        return 1
    fi
    
    return 0
}

# Initialize auth (tries pre-approved, falls back to new registration)
init_auth() {
    echo "🔐 Initializing authentication..."
    
    # Try pre-approved account first (if configured)
    if [ -n "$TEST_USER_EMAIL" ] && [ -n "$TEST_PASSWORD" ]; then
        echo "  → Using pre-configured test account"
        if use_preapproved_account; then
            echo "✓ Authentication successful: $SHARED_USER_EMAIL"
            return 0
        fi
        echo "  ⚠️  Pre-approved account login failed"
    fi
    
    # Fall back to new registration
    echo "  → Registering new test account"
    local auth_result
    get_auth_token
    auth_result=$?
    
    if [ $auth_result -eq 0 ]; then
        echo "✓ Authentication successful: $SHARED_USER_EMAIL"
        return 0
    elif [ $auth_result -eq 2 ]; then
        echo "⚠️  Account pending approval - skipping protected endpoint tests"
        echo "ℹ️  To run full tests, set these environment variables:"
        echo "    export TEST_USER_EMAIL=\"admin@test.com\""
        echo "    export TEST_PASSWORD=\"YourPassword\""
        echo "    export TEST_TENANT=\"yourtenant\""
        return 2  # Pending approval
    fi
    
    echo "❌ Authentication failed"
    return 1
}
