# Microsoft Graph MCP Server - Setup Instructions

## Step 1: Install .NET SDK (Requires sudo)

Run these commands to install .NET SDK 9.0:

```bash
wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb -O /tmp/packages-microsoft-prod.deb
sudo dpkg -i /tmp/packages-microsoft-prod.deb
rm /tmp/packages-microsoft-prod.deb
sudo apt-get update
sudo apt-get install -y dotnet-sdk-9.0
```

Verify installation:
```bash
dotnet --version
```

## Step 2: Set Up Azure Entra ID Application

1. Navigate to [Azure Portal](https://portal.azure.com)
2. Go to **Azure Active Directory** (now Entra ID) → **App registrations**
3. Click **New registration**
   - Name: "Microsoft Graph MCP Server"
   - Supported account types: Single tenant
   - Click **Register**

4. After creation, note the **Application (client) ID** and **Directory (tenant) ID**

5. Add API Permissions:
   - Click **API permissions** → **Add a permission**
   - Select **Microsoft Graph** → **Application permissions**
   - Add at minimum: `User.Read.All`
   - Optional permissions based on your needs:
     - `Mail.Read` - Read mail
     - `Calendars.Read` - Read calendars
     - `Files.Read.All` - Read files
     - `Sites.Read.All` - Read SharePoint sites
   - Click **Grant admin consent** (requires admin)

6. Create Client Secret:
   - Go to **Certificates & secrets** → **New client secret**
   - Description: "MCP Server Secret"
   - Expires: Choose appropriate duration
   - Click **Add**
   - **IMPORTANT**: Copy the secret value immediately (it won't show again)

## Step 3: Build the MCP Server

```bash
cd /home/bmoore/Projects/microsoft-graph-mcp/McpServerGraphAPI
dotnet build
```

## Step 4: Configure Environment Variables

Create a `.env` file or export these variables:

```bash
export TENANT_ID="your-tenant-id-here"
export CLIENT_ID="your-client-id-here"
export CLIENT_SECRET="your-client-secret-here"
export NATIONAL_CLOUD="Global"
```

Or create a file at `/home/bmoore/Projects/microsoft-graph-mcp/.env`:

```
TENANT_ID=your-tenant-id-here
CLIENT_ID=your-client-id-here
CLIENT_SECRET=your-client-secret-here
NATIONAL_CLOUD=Global
```

## Step 5: Test the Server

Run the server manually to ensure it works:

```bash
cd /home/bmoore/Projects/microsoft-graph-mcp/McpServerGraphAPI
source ../.env  # if using .env file
dotnet run
```

## Step 6: Configure for GitHub Copilot CLI

GitHub Copilot CLI MCP server configuration is still evolving. Current options:

### Option A: Check for MCP config support
```bash
# Check if these directories exist
ls -la ~/.config/github-copilot/
ls -la ~/.github-copilot/
```

### Option B: Use as standalone server
The server can run independently and communicate via stdio. GitHub Copilot CLI may support adding it through configuration files when MCP support is fully released.

### Option C: Wait for official support
Microsoft's official MCP Server for Enterprise (mentioned in the Learn documentation) requires:
- Windows with Visual Studio Code
- PowerShell provisioning scripts
- May have better integration with GitHub tools

## Troubleshooting

### .NET not found
Ensure you completed Step 1 and restart your terminal.

### Authentication errors
- Verify your tenant ID, client ID, and client secret are correct
- Ensure admin consent was granted for API permissions
- Check that the Entra ID application is not disabled

### Build errors
- Ensure you're in the `McpServerGraphAPI` subdirectory
- Try `dotnet restore` before `dotnet build`

## Next Steps

Once GitHub Copilot CLI officially supports MCP servers, you'll be able to:
1. Query Microsoft Graph data through natural language
2. Automate Microsoft 365 tasks
3. Integrate organizational data into your development workflow

## Resources

- [Model Context Protocol](https://modelcontextprotocol.io/)
- [Microsoft Graph Documentation](https://learn.microsoft.com/en-us/graph/)
- [GitHub Repository](https://github.com/MartinM85/mcp-server-graph-api)
