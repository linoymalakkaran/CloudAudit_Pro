#!/bin/bash

# Shared authentication helper for test suites
# Provides reusable auth token generation

API_BASE_URL="${API_BASE_URL:-http://localhost:8000/api}"

# Global variable to store auth token
export SHARED_AUTH_TOKEN=""
export SHARED_USER_EMAIL=""
export SHARED_TENANT_SUBDOMAIN=""

# Get authenticated token (register + login)
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
    
    # Check if registration succeeded
    local reg_status=$(echo "$reg_response" | jq -r '.status // .message' 2>/dev/null)
    
    if [ -z "$reg_status" ]; then
        echo "❌ Registration failed: No response"
        return 1
    fi
    
    # Login to get token
    local LOGIN_DATA="{\"email\":\"$SHARED_USER_EMAIL\",\"password\":\"$PASSWORD\",\"tenantSubdomain\":\"$SHARED_TENANT_SUBDOMAIN\"}"
    
    local login_response=$(curl -s -X POST "$API_BASE_URL/auth/login" \
        -H "Content-Type: application/json" \
        -d "$LOGIN_DATA")
    
    SHARED_AUTH_TOKEN=$(echo "$login_response" | jq -r '.accessToken' 2>/dev/null)
    
    if [ -z "$SHARED_AUTH_TOKEN" ] || [ "$SHARED_AUTH_TOKEN" = "null" ]; then
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
    
    SHARED_AUTH_TOKEN=$(echo "$login_response" | jq -r '.accessToken' 2>/dev/null)
    
    if [ -z "$SHARED_AUTH_TOKEN" ] || [ "$SHARED_AUTH_TOKEN" = "null" ]; then
        return 1
    fi
    
    return 0
}

# Initialize auth (tries pre-approved, falls back to new registration)
init_auth() {
    echo "🔐 Initializing authentication..."
    
    # Try pre-approved account first
    if use_preapproved_account; then
        echo "✓ Using pre-approved test account: $SHARED_USER_EMAIL"
        return 0
    fi
    
    # Fall back to new registration
    if get_auth_token; then
        echo "✓ Authentication successful: $SHARED_USER_EMAIL"
        return 0
    fi
    
    echo "❌ Authentication failed"
    return 1
}
