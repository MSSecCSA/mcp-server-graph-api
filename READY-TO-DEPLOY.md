# Microsoft Graph MCP Server - Ready to Deploy

## ✅ Configuration Complete

All Azure credentials have been configured and the project is ready for deployment!

### What's Been Done

1. ✅ **Cloned Repository**: Microsoft Graph MCP Server (C# implementation)
2. ✅ **Azure Credentials Configured**: Using existing "Azure IaC M365" app registration
3. ✅ **Permissions Granted**: Admin consent granted for all Graph API permissions
4. ✅ **Environment File Created**: `.env` file with credentials ready to use
5. ✅ **Setup Script Created**: `setup.sh` for one-command installation

### Azure Configuration Details

- **App Registration**: Azure IaC M365
- **Client ID**: `53b1c171-76ca-4211-9b31-d1eea9451eb6`
- **Tenant**: `mooreteq.onmicrosoft.com` (e5050446-5747-425e-b39e-d7dcfdf86bf6)
- **Permissions**: 12+ Microsoft Graph permissions including:
  - Sites.Read.All & Sites.ReadWrite.All (SharePoint)
  - Files.Read.All & Files.ReadWrite.All (OneDrive)
  - Team.* and Channel.* (Teams operations)
  - User.Read.All (User directory)

### Next Steps

#### Option 1: Quick Setup (Recommended)
Run the automated setup script:
```bash
cd /home/bmoore/Projects/microsoft-graph-mcp
./setup.sh
```

This will:
- Install .NET SDK 9.0 (requires sudo)
- Restore NuGet packages
- Build the MCP server

#### Option 2: Manual Setup
If you prefer manual control:
```bash
# Install .NET SDK
wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb -O /tmp/packages-microsoft-prod.deb
sudo dpkg -i /tmp/packages-microsoft-prod.deb
rm /tmp/packages-microsoft-prod.deb
sudo apt-get update
sudo apt-get install -y dotnet-sdk-9.0

# Build the project
cd /home/bmoore/Projects/microsoft-graph-mcp/McpServerGraphAPI
dotnet restore
dotnet build
```

### Testing the Server

Once built, test the server:
```bash
cd /home/bmoore/Projects/microsoft-graph-mcp/McpServerGraphAPI
dotnet run
```

The server will:
- Load credentials from `../.env`
- Connect to Microsoft Graph API
- Expose MCP tools for Graph operations
- Listen for stdio communication

### GitHub Copilot CLI Integration

**Current Status**: GitHub Copilot CLI's MCP support is still being developed.

**When available**, you'll configure it similar to Claude Desktop:

**Potential config location** (may vary):
- `~/.config/github-copilot/mcp-config.json`
- `~/.github-copilot/config.json`

**Configuration format**:
```json
{
    "mcpServers": {
        "graphApi": {
            "command": "dotnet",
            "args": [
                "run",
                "--project",
                "/home/bmoore/Projects/microsoft-graph-mcp/McpServerGraphAPI",
                "--no-build"
            ],
            "env": {
                "TENANT_ID": "<your-tenant-id>",
                "CLIENT_ID": "<your-client-id>",
                "CLIENT_SECRET": "<your-client-secret>",
                "NATIONAL_CLOUD": "Global"
            }
        }
    }
}
```

### What This MCP Server Provides

Once integrated, you'll be able to ask GitHub Copilot to:
- Query user information from Azure AD
- Read/write SharePoint sites and documents
- Manage Teams, channels, and members
- Access OneDrive files and folders
- Perform M365 administrative tasks

All through natural language commands!

### File Structure

```
microsoft-graph-mcp/
├── .env                        # ✅ Azure credentials (configured)
├── setup.sh                    # ✅ Automated setup script
├── GEMINI.md                   # Project overview
├── SETUP-INSTRUCTIONS.md       # Detailed manual instructions
├── README.md                   # Original repository README
└── McpServerGraphAPI/          # C# MCP server project
    ├── Program.cs              # Main server code
    ├── McpServerGraphAPI.csproj # Project file
    └── [other C# files]
```

### Security Notes

- ✅ Client secret is stored in `.env` file (gitignored)
- ✅ App registration uses application permissions (daemon/service)
- ✅ Admin consent has been granted
- ⚠️  Keep credentials secure - don't commit .env to git

### Troubleshooting

**"dotnet: command not found"**
- Run the setup script or manually install .NET SDK

**Build errors**
- Ensure you're in the `McpServerGraphAPI` directory
- Try `dotnet restore` first

**Authentication errors**
- Verify credentials in `.env` are correct
- Check app registration in Azure Portal
- Ensure admin consent was granted

### Resources

- [MCP Protocol Docs](https://modelcontextprotocol.io/)
- [Microsoft Graph API](https://learn.microsoft.com/en-us/graph/)
- [Repository](https://github.com/MartinM85/mcp-server-graph-api)
- [Azure Portal - Your App](https://portal.azure.com/#view/Microsoft_AAD_RegisteredApps/ApplicationMenuBlade/~/CallAnAPI/appId/53b1c171-76ca-4211-9b31-d1eea9451eb6)

---

**Ready to proceed?** Run `./setup.sh` to complete the installation!
