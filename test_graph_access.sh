#!/bin/bash
# Test Microsoft Graph API access with service principal

# Load environment variables
set -a
source .env
set +a

echo "Testing Microsoft Graph API access..."
echo "Tenant: $TENANT_ID"
echo "Client: $CLIENT_ID"
echo ""

# Get access token
echo "Getting access token..."
TOKEN_RESPONSE=$(curl -s -X POST "https://login.microsoftonline.com/$TENANT_ID/oauth2/v2.0/token" \
  -d "client_id=$CLIENT_ID" \
  -d "client_secret=$CLIENT_SECRET" \
  -d "scope=https://graph.microsoft.com/.default" \
  -d "grant_type=client_credentials")

ACCESS_TOKEN=$(echo $TOKEN_RESPONSE | grep -o '"access_token":"[^"]*' | cut -d'"' -f4)

if [ -z "$ACCESS_TOKEN" ]; then
    echo "❌ Failed to get access token"
    echo "Response: $TOKEN_RESPONSE"
    exit 1
fi

echo "✅ Access token obtained"
echo ""

# Test Graph API call - Get users
echo "Testing Graph API call: GET /v1.0/users?\$top=2"
GRAPH_RESPONSE=$(curl -s -X GET "https://graph.microsoft.com/v1.0/users?\$top=2" \
  -H "Authorization: Bearer $ACCESS_TOKEN" \
  -H "Content-Type: application/json")

echo "$GRAPH_RESPONSE" | jq '.'

if echo "$GRAPH_RESPONSE" | jq -e '.value[0]' > /dev/null 2>&1; then
    echo ""
    echo "✅ Graph API call successful!"
    echo "Retrieved users:"
    echo "$GRAPH_RESPONSE" | jq -r '.value[] | "  - \(.displayName) (\(.userPrincipalName))"'
    echo ""
    echo "✅ Microsoft Graph MCP credentials are valid and working!"
else
    echo ""
    echo "❌ Graph API call failed"
fi
