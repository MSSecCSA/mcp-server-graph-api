# Microsoft Graph MCP Server - CRUD Operations Guide

## Overview

The MCP server exposes **ONE flexible tool** called `my-tenant` that can perform **any** Microsoft Graph API operation. It supports full CRUD operations (Create, Read, Update, Delete) across all Graph endpoints.

## The MCP Tool

**Tool Name**: `my-tenant`  
**Description**: Tool to interact with Microsoft Graph (Entra)

### Parameters

| Parameter | Type | Description | Required |
|-----------|------|-------------|----------|
| `path` | string | Graph API endpoint path (e.g., `/users`, `/groups`) | Yes |
| `method` | string | HTTP method: GET, POST, PUT, PATCH, DELETE | Yes |
| `queryParameters` | object | Query params like `$filter`, `$select`, `$orderby` | No |
| `body` | string | JSON request body for POST/PUT/PATCH | No |
| `graphVersion` | string | API version: `v1.0` (default) or `beta` | No |

## CRUD Operations Examples

---

## 📖 READ (Query) Operations

### Example 1: Get All Users
```json
{
  "path": "/users",
  "method": "GET",
  "queryParameters": {
    "$top": "10",
    "$select": "displayName,mail,userPrincipalName"
  },
  "graphVersion": "v1.0"
}
```

**What it returns**: List of up to 10 users with their display name, email, and UPN.

### Example 2: Get Specific User by ID
```json
{
  "path": "/users/9a24d8f5-6b60-4be8-aa00-13e44582ee49",
  "method": "GET",
  "queryParameters": {},
  "graphVersion": "v1.0"
}
```

**What it returns**: Complete profile of the specified user.

### Example 3: Search Users by Name
```json
{
  "path": "/users",
  "method": "GET",
  "queryParameters": {
    "$filter": "startsWith(displayName,'Ben')",
    "$select": "displayName,mail"
  },
  "graphVersion": "v1.0"
}
```

**What it returns**: All users whose display name starts with "Ben".

### Example 4: Get SharePoint Sites
```json
{
  "path": "/sites",
  "method": "GET",
  "queryParameters": {
    "$top": "5"
  },
  "graphVersion": "v1.0"
}
```

**What it returns**: First 5 SharePoint sites in your tenant.

### Example 5: Get Groups
```json
{
  "path": "/groups",
  "method": "GET",
  "queryParameters": {
    "$filter": "groupTypes/any(c:c eq 'Unified')",
    "$select": "displayName,description,mail"
  },
  "graphVersion": "v1.0"
}
```

**What it returns**: All Microsoft 365 groups with basic info.

### Example 6: Get Organization Info
```json
{
  "path": "/organization",
  "method": "GET",
  "queryParameters": {},
  "graphVersion": "v1.0"
}
```

**What it returns**: Your tenant's organization details, verified domains, etc.

---

## ➕ CREATE Operations

### Example 7: Create a New User
```json
{
  "path": "/users",
  "method": "POST",
  "queryParameters": {},
  "body": "{\"accountEnabled\":true,\"displayName\":\"John Doe\",\"mailNickname\":\"johndoe\",\"userPrincipalName\":\"johndoe@mooreteq.onmicrosoft.com\",\"passwordProfile\":{\"forceChangePasswordNextSignIn\":true,\"password\":\"TempPass123!\"}}",
  "graphVersion": "v1.0"
}
```

**What it does**: Creates a new user account with the specified details.

**Required Permission**: `User.ReadWrite.All`

### Example 8: Create a Security Group
```json
{
  "path": "/groups",
  "method": "POST",
  "queryParameters": {},
  "body": "{\"displayName\":\"Marketing Team\",\"mailEnabled\":false,\"mailNickname\":\"marketing-team\",\"securityEnabled\":true}",
  "graphVersion": "v1.0"
}
```

**What it does**: Creates a new security group.

**Required Permission**: `Group.ReadWrite.All`

### Example 9: Create a Microsoft 365 Group
```json
{
  "path": "/groups",
  "method": "POST",
  "queryParameters": {},
  "body": "{\"displayName\":\"Project Team\",\"description\":\"Collaboration group for project\",\"groupTypes\":[\"Unified\"],\"mailEnabled\":true,\"mailNickname\":\"projectteam\",\"securityEnabled\":false}",
  "graphVersion": "v1.0"
}
```

**What it does**: Creates a Microsoft 365 group (with Teams, SharePoint, etc.).

**Required Permission**: `Group.ReadWrite.All`

### Example 10: Create a Team from Group
```json
{
  "path": "/groups/{group-id}/team",
  "method": "PUT",
  "queryParameters": {},
  "body": "{\"memberSettings\":{\"allowCreateUpdateChannels\":true},\"messagingSettings\":{\"allowUserEditMessages\":true,\"allowUserDeleteMessages\":true},\"funSettings\":{\"allowGiphy\":true,\"giphyContentRating\":\"moderate\"}}",
  "graphVersion": "v1.0"
}
```

**What it does**: Converts an existing Microsoft 365 group into a Team.

**Required Permission**: `Team.Create`

### Example 11: Create a SharePoint List
```json
{
  "path": "/sites/{site-id}/lists",
  "method": "POST",
  "queryParameters": {},
  "body": "{\"displayName\":\"Customer Contacts\",\"columns\":[{\"name\":\"CustomerName\",\"text\":{}},{\"name\":\"Email\",\"text\":{}},{\"name\":\"Phone\",\"text\":{}}],\"list\":{\"template\":\"genericList\"}}",
  "graphVersion": "v1.0"
}
```

**What it does**: Creates a new list in SharePoint with custom columns.

**Required Permission**: `Sites.ReadWrite.All`

---

## ✏️ UPDATE (Modify) Operations

### Example 12: Update User Properties
```json
{
  "path": "/users/9a24d8f5-6b60-4be8-aa00-13e44582ee49",
  "method": "PATCH",
  "queryParameters": {},
  "body": "{\"jobTitle\":\"Senior Developer\",\"department\":\"Engineering\",\"mobilePhone\":\"+1-555-0100\"}",
  "graphVersion": "v1.0"
}
```

**What it does**: Updates the specified user's job title, department, and phone number.

**Required Permission**: `User.ReadWrite.All`

### Example 13: Update Group Description
```json
{
  "path": "/groups/{group-id}",
  "method": "PATCH",
  "queryParameters": {},
  "body": "{\"description\":\"Updated group description for Q4 2025\"}",
  "graphVersion": "v1.0"
}
```

**What it does**: Updates the group's description.

**Required Permission**: `Group.ReadWrite.All`

### Example 14: Add User to Group
```json
{
  "path": "/groups/{group-id}/members/$ref",
  "method": "POST",
  "queryParameters": {},
  "body": "{\"@odata.id\":\"https://graph.microsoft.com/v1.0/directoryObjects/{user-id}\"}",
  "graphVersion": "v1.0"
}
```

**What it does**: Adds a user as a member of the specified group.

**Required Permission**: `GroupMember.ReadWrite.All`

### Example 15: Update Team Settings
```json
{
  "path": "/teams/{team-id}",
  "method": "PATCH",
  "queryParameters": {},
  "body": "{\"memberSettings\":{\"allowCreateUpdateChannels\":false},\"messagingSettings\":{\"allowUserEditMessages\":false}}",
  "graphVersion": "v1.0"
}
```

**What it does**: Restricts team members from creating channels or editing messages.

**Required Permission**: `TeamSettings.ReadWrite.All`

---

## 🗑️ DELETE Operations

### Example 16: Delete a User
```json
{
  "path": "/users/{user-id}",
  "method": "DELETE",
  "queryParameters": {},
  "graphVersion": "v1.0"
}
```

**What it does**: Soft-deletes the user (moves to deleted items for 30 days).

**Required Permission**: `User.ReadWrite.All`

**⚠️ Warning**: Destructive operation. User will lose access immediately.

### Example 17: Delete a Group
```json
{
  "path": "/groups/{group-id}",
  "method": "DELETE",
  "queryParameters": {},
  "graphVersion": "v1.0"
}
```

**What it does**: Deletes the group and all associated resources.

**Required Permission**: `Group.ReadWrite.All`

**⚠️ Warning**: For M365 groups, this also deletes the Team, SharePoint site, etc.

### Example 18: Remove User from Group
```json
{
  "path": "/groups/{group-id}/members/{user-id}/$ref",
  "method": "DELETE",
  "queryParameters": {},
  "graphVersion": "v1.0"
}
```

**What it does**: Removes a specific user from the group.

**Required Permission**: `GroupMember.ReadWrite.All`

### Example 19: Delete a SharePoint List Item
```json
{
  "path": "/sites/{site-id}/lists/{list-id}/items/{item-id}",
  "method": "DELETE",
  "queryParameters": {},
  "graphVersion": "v1.0"
}
```

**What it does**: Deletes a specific item from a SharePoint list.

**Required Permission**: `Sites.ReadWrite.All`

### Example 20: Delete a Channel from Team
```json
{
  "path": "/teams/{team-id}/channels/{channel-id}",
  "method": "DELETE",
  "queryParameters": {},
  "graphVersion": "v1.0"
}
```

**What it does**: Deletes a channel from a Team.

**Required Permission**: `ChannelSettings.ReadWrite.All`

**⚠️ Warning**: Cannot delete the "General" channel.

---

## Advanced Query Examples

### Example 21: Count Users
```json
{
  "path": "/users/$count",
  "method": "GET",
  "queryParameters": {},
  "graphVersion": "v1.0"
}
```

**What it returns**: Total number of users in the tenant.

### Example 22: Get User's Manager
```json
{
  "path": "/users/{user-id}/manager",
  "method": "GET",
  "queryParameters": {},
  "graphVersion": "v1.0"
}
```

**What it returns**: The manager of the specified user.

### Example 23: Get User's Direct Reports
```json
{
  "path": "/users/{user-id}/directReports",
  "method": "GET",
  "queryParameters": {},
  "graphVersion": "v1.0"
}
```

**What it returns**: All users who report to the specified user.

### Example 24: Get OneDrive Files
```json
{
  "path": "/users/{user-id}/drive/root/children",
  "method": "GET",
  "queryParameters": {
    "$select": "name,size,lastModifiedDateTime"
  },
  "graphVersion": "v1.0"
}
```

**What it returns**: Files in the user's OneDrive root folder.

### Example 25: Get Team Channels
```json
{
  "path": "/teams/{team-id}/channels",
  "method": "GET",
  "queryParameters": {
    "$select": "displayName,description"
  },
  "graphVersion": "v1.0"
}
```

**What it returns**: All channels in the specified Team.

---

## Testing with curl

You can test these operations directly using the test scripts:

```bash
cd /home/bmoore/Projects/microsoft-graph-mcp

# Basic test - get users
./test_graph_access.sh

# Comprehensive test - multiple endpoints
./test_graph_permissions.sh
```

Or directly with curl:

```bash
# Get access token
source .env
TOKEN=$(curl -s -X POST "https://login.microsoftonline.com/$TENANT_ID/oauth2/v2.0/token" \
  -d "client_id=$CLIENT_ID" \
  -d "client_secret=$CLIENT_SECRET" \
  -d "scope=https://graph.microsoft.com/.default" \
  -d "grant_type=client_credentials" | jq -r .access_token)

# Query users
curl -H "Authorization: Bearer $TOKEN" \
  "https://graph.microsoft.com/v1.0/users?\$top=5"
```

---

## Permission Requirements Summary

| Operation Type | Common Permissions Needed |
|----------------|---------------------------|
| Read Users | `User.Read.All` |
| Create/Update/Delete Users | `User.ReadWrite.All` |
| Read Groups | `Group.Read.All` |
| Create/Update/Delete Groups | `Group.ReadWrite.All` |
| Read Teams | `Team.ReadBasic.All` |
| Create/Update Teams | `Team.Create`, `TeamSettings.ReadWrite.All` |
| Read SharePoint | `Sites.Read.All` |
| Write SharePoint | `Sites.ReadWrite.All` |
| Read Files | `Files.Read.All` |
| Write Files | `Files.ReadWrite.All` |

**Your current app has all these permissions! ✅**

---

## Best Practices

1. **Use $select**: Only request fields you need to reduce response size
2. **Use $filter**: Filter server-side instead of client-side
3. **Use $top**: Limit results for better performance
4. **Test with GET first**: Verify paths before using POST/PATCH/DELETE
5. **Check permissions**: Ensure your app has the required permission before attempting operations
6. **Use v1.0**: Stick to stable API unless you need beta features
7. **Handle errors**: Check HTTP status codes and error messages

---

## How to Use with MCP Client

When GitHub Copilot CLI supports MCP, you'll be able to ask natural language questions like:

- "Show me all users in the Engineering department"
- "Create a new Team called Project Alpha"
- "Add john.doe@example.com to the Marketing group"
- "What SharePoint sites do we have?"
- "Delete the user with email temp@example.com"

The MCP server will translate these to Graph API calls automatically!

---

## Additional Resources

- [Microsoft Graph REST API Documentation](https://learn.microsoft.com/en-us/graph/api/overview)
- [Graph Explorer](https://developer.microsoft.com/graph/graph-explorer) - Interactive testing tool
- [Graph API Permissions Reference](https://learn.microsoft.com/en-us/graph/permissions-reference)

---

**Status**: All 25 example operations are available and ready to use! 🚀
