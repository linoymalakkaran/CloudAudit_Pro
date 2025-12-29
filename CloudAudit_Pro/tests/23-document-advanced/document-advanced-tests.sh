#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../test-helpers.sh"
source "$SCRIPT_DIR/../auth-helper.sh"

echo "╔════════════════════════════════════════════════════════════╗"
echo "║  DOCUMENT LINKS, TEMPLATES & COLLECTIONS TESTS              ║"
echo "╚════════════════════════════════════════════════════════════╝"

validate_link() { 
    check_field "$1" '.id' && check_field "$1" '.documentId'
}
validate_template() { 
    check_field "$1" '.id' && check_field "$1" '.name'
}
validate_collection() { 
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
echo "━━━ Document Links Tests ━━━"

echo "" && echo "━━━ Test 1: Create Document Link ━━━"
CREATE_LINK='{"documentId":"test-doc-id","entityType":"WORKPAPER","entityId":"test-entity-id","linkType":"SUPPORTING"}'
link_resp=$(test_endpoint "Create Document Link" "POST" "/document-links" "$CREATE_LINK" "201" "$TOKEN" "validate_link")
LINK_ID=$(echo "$link_resp" | jq -r '.id' 2>/dev/null)

if [ -n "$LINK_ID" ] && [ "$LINK_ID" != "null" ]; then
    echo "  → Created document link ID: $LINK_ID"
    
    echo "" && echo "━━━ Test 2: Get Document Link by ID ━━━"
    test_endpoint "Get Document Link" "GET" "/document-links/$LINK_ID" "" "200" "$TOKEN" "validate_link" >/dev/null
    
    echo "" && echo "━━━ Test 3: Update Document Link ━━━"
    UPDATE_LINK='{"linkType":"REFERENCE","notes":"Updated link"}'
    test_endpoint "Update Document Link" "PATCH" "/document-links/$LINK_ID" "$UPDATE_LINK" "200" "$TOKEN" "validate_link" >/dev/null
    
    echo "" && echo "━━━ Test 4: Get All Document Links ━━━"
    test_endpoint "List Document Links" "GET" "/document-links" "" "200" "$TOKEN" "validate_list" >/dev/null
    
    echo "" && echo "━━━ Test 5: Get Links for Document ━━━"
    test_endpoint "Get Links for Document" "GET" "/document-links/document/test-doc-id" "" "200" "$TOKEN" "validate_list" >/dev/null
    
    echo "" && echo "━━━ Test 6: Get Links for Entity ━━━"
    test_endpoint "Get Links for Entity" "GET" "/document-links/entity/WORKPAPER/test-entity-id" "" "200" "$TOKEN" "validate_list" >/dev/null
    
    echo "" && echo "━━━ Test 7: Create Bulk Document Links ━━━"
    BULK_LINKS='{"links":[{"documentId":"test-doc-1","entityType":"FINDING","entityId":"finding-1"},{"documentId":"test-doc-2","entityType":"FINDING","entityId":"finding-2"}]}'
    test_endpoint "Create Bulk Links" "POST" "/document-links/bulk" "$BULK_LINKS" "201" "$TOKEN" "" >/dev/null
    
    echo "" && echo "━━━ Test 8: Delete Document Link ━━━"
    test_endpoint "Delete Document Link" "DELETE" "/document-links/$LINK_ID" "" "200" "$TOKEN" "" >/dev/null
fi

echo ""
echo "━━━ Document Templates Tests ━━━"

echo "" && echo "━━━ Test 9: Create Document Template ━━━"
CREATE_TEMPLATE='{"name":"Test Template '$TS'","category":"WORKPAPER","description":"Test template description","content":"Template content","isActive":true}'
template_resp=$(test_endpoint "Create Document Template" "POST" "/document-templates" "$CREATE_TEMPLATE" "201" "$TOKEN" "validate_template")
TEMPLATE_ID=$(echo "$template_resp" | jq -r '.id' 2>/dev/null)

if [ -n "$TEMPLATE_ID" ] && [ "$TEMPLATE_ID" != "null" ]; then
    echo "  → Created document template ID: $TEMPLATE_ID"
    
    echo "" && echo "━━━ Test 10: Get Document Template by ID ━━━"
    test_endpoint "Get Document Template" "GET" "/document-templates/$TEMPLATE_ID" "" "200" "$TOKEN" "validate_template" >/dev/null
    
    echo "" && echo "━━━ Test 11: Update Document Template ━━━"
    UPDATE_TEMPLATE='{"description":"Updated template description","content":"Updated content"}'
    test_endpoint "Update Document Template" "PATCH" "/document-templates/$TEMPLATE_ID" "$UPDATE_TEMPLATE" "200" "$TOKEN" "validate_template" >/dev/null
    
    echo "" && echo "━━━ Test 12: Get All Document Templates ━━━"
    test_endpoint "List Document Templates" "GET" "/document-templates" "" "200" "$TOKEN" "validate_list" >/dev/null
    
    echo "" && echo "━━━ Test 13: Get Templates by Category ━━━"
    test_endpoint "Get Templates by Category" "GET" "/document-templates/category/WORKPAPER" "" "200" "$TOKEN" "validate_list" >/dev/null
    
    echo "" && echo "━━━ Test 14: Toggle Template Active Status ━━━"
    test_endpoint "Toggle Active Status" "POST" "/document-templates/$TEMPLATE_ID/activate" "" "200" "$TOKEN" "" >/dev/null
    
    echo "" && echo "━━━ Test 15: Generate Document from Template ━━━"
    GENERATE_DATA='{"fileName":"Generated Doc","variables":{"clientName":"Test Client","date":"2025-01-01"}}'
    test_endpoint "Generate Document" "POST" "/document-templates/$TEMPLATE_ID/generate" "$GENERATE_DATA" "201" "$TOKEN" "" >/dev/null
    
    echo "" && echo "━━━ Test 16: Delete Document Template ━━━"
    test_endpoint "Delete Document Template" "DELETE" "/document-templates/$TEMPLATE_ID" "" "200" "$TOKEN" "" >/dev/null
fi

echo ""
echo "━━━ Document Collections Tests ━━━"

echo "" && echo "━━━ Test 17: Create Document Collection ━━━"
CREATE_COLLECTION='{"name":"Test Collection '$TS'","description":"Test collection","companyId":"test-company","periodId":"test-period","dueDate":"2025-12-31"}'
collection_resp=$(test_endpoint "Create Document Collection" "POST" "/document-collections" "$CREATE_COLLECTION" "201" "$TOKEN" "validate_collection")
COLLECTION_ID=$(echo "$collection_resp" | jq -r '.id' 2>/dev/null)

if [ -n "$COLLECTION_ID" ] && [ "$COLLECTION_ID" != "null" ]; then
    echo "  → Created document collection ID: $COLLECTION_ID"
    
    echo "" && echo "━━━ Test 18: Get Document Collection by ID ━━━"
    test_endpoint "Get Document Collection" "GET" "/document-collections/$COLLECTION_ID" "" "200" "$TOKEN" "validate_collection" >/dev/null
    
    echo "" && echo "━━━ Test 19: Update Document Collection ━━━"
    UPDATE_COLLECTION='{"description":"Updated collection description"}'
    test_endpoint "Update Document Collection" "PATCH" "/document-collections/$COLLECTION_ID" "$UPDATE_COLLECTION" "200" "$TOKEN" "validate_collection" >/dev/null
    
    echo "" && echo "━━━ Test 20: Get All Document Collections ━━━"
    test_endpoint "List Document Collections" "GET" "/document-collections" "" "200" "$TOKEN" "validate_list" >/dev/null
    
    echo "" && echo "━━━ Test 21: Update Collection Status ━━━"
    STATUS_DATA='{"status":"IN_PROGRESS"}'
    test_endpoint "Update Collection Status" "POST" "/document-collections/$COLLECTION_ID/status" "$STATUS_DATA" "200" "$TOKEN" "" >/dev/null
    
    echo "" && echo "━━━ Test 22: Get Collection Progress ━━━"
    test_endpoint "Get Collection Progress" "GET" "/document-collections/$COLLECTION_ID/progress" "" "200" "$TOKEN" "" >/dev/null
    
    echo "" && echo "━━━ Test 23: Add Item to Collection ━━━"
    ITEM_DATA='{"documentType":"BANK_STATEMENT","description":"Bank statement","required":true}'
    item_resp=$(test_endpoint "Add Item to Collection" "POST" "/document-collections/$COLLECTION_ID/items" "$ITEM_DATA" "201" "$TOKEN" "")
    ITEM_ID=$(echo "$item_resp" | jq -r '.id' 2>/dev/null)
    
    if [ -n "$ITEM_ID" ] && [ "$ITEM_ID" != "null" ]; then
        echo "  → Created collection item ID: $ITEM_ID"
        
        echo "" && echo "━━━ Test 24: Update Collection Item ━━━"
        UPDATE_ITEM='{"status":"RECEIVED","notes":"Document received"}'
        test_endpoint "Update Collection Item" "PATCH" "/document-collections/items/$ITEM_ID" "$UPDATE_ITEM" "200" "$TOKEN" "" >/dev/null
        
        echo "" && echo "━━━ Test 25: Upload Document for Item ━━━"
        # Note: This would typically be a multipart form upload, simulated here
        test_endpoint "Upload for Item" "POST" "/document-collections/items/$ITEM_ID/upload" '{"documentId":"test-doc-id"}' "200" "$TOKEN" "" >/dev/null
        
        echo "" && echo "━━━ Test 26: Remove Item from Collection ━━━"
        test_endpoint "Remove Collection Item" "DELETE" "/document-collections/items/$ITEM_ID" "" "200" "$TOKEN" "" >/dev/null
    fi
    
    echo "" && echo "━━━ Test 27: Delete Document Collection ━━━"
    test_endpoint "Delete Document Collection" "DELETE" "/document-collections/$COLLECTION_ID" "" "200" "$TOKEN" "" >/dev/null
fi

echo "" && echo "━━━ Test 28: Unauthorized Access ━━━"
test_endpoint "No Auth" "GET" "/document-links" "" "401" "" "" >/dev/null

print_summary
