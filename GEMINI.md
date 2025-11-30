# Microsoft Graph MCP Server Setup

## Project Overview
This is a Model Context Protocol (MCP) server for Microsoft Graph API, written in C#. It enables AI assistants (Claude, GitHub Copilot, etc.) to interact with Microsoft Graph APIs.

## Prerequisites

### 1. .NET SDK Installation
This project requires .NET SDK (version 6.0 or later).

**Install on Ubuntu:**
```bash
wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb
sudo apt-get update
sudo apt-get install -y dotnet-sdk-9.0
```

### 2. Azure Entra ID Application Setup
You need to register an application in Azure Entra ID (formerly Azure AD):

1. Go to [Azure Portal](https://portal.azure.com) → Entra ID → App registrations
2. Create a new registration
3. Add API permissions:
   - Microsoft Graph → Application permissions → `User.Read.All` (minimum)
   - Add other permissions as needed for your use case
4. Grant admin consent for the permissions
5. Create a client secret under "Certificates & secrets"
6. Note down:
   - Tenant ID
   - Client ID (Application ID)
   - Client Secret

## Building the MCP Server

```bash
cd /home/bmoore/Projects/microsoft-graph-mcp/McpServerGraphAPI
dotnet build
```

## Configuration for GitHub Copilot CLI

GitHub Copilot CLI currently uses MCP servers through configuration. The exact configuration method may vary based on the Copilot CLI version.

### Option 1: Environment Variables
Export these before using the MCP server:

```bash
export TENANT_ID="<your-tenant-id>"
export CLIENT_ID="<your-client-id>"
export CLIENT_SECRET="<your-client-secret>"
export NATIONAL_CLOUD="Global"
```

### Option 2: MCP Configuration File
Check if GitHub Copilot CLI supports MCP server configuration at:
- `~/.config/github-copilot/mcp-config.json`
- `~/.github-copilot/config.json`

Configuration format (similar to Claude Desktop):
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
                "TENANT_ID": "<tenant_id>",
                "CLIENT_ID": "<client_id>",
                "CLIENT_SECRET": "<client_secret>",
                "NATIONAL_CLOUD": "Global"
            }
        }
    }
}
```

## Running the Server

```bash
cd /home/bmoore/Projects/microsoft-graph-mcp/McpServerGraphAPI
dotnet run
```

## National Cloud Options
- **Global**: https://graph.microsoft.com (default)
- **US_GOV**: https://graph.microsoft.us
- **US_GOV_DOD**: https://dod-graph.microsoft.us
- **China**: https://microsoftgraph.chinacloudapi.cn
- **Germany**: https://graph.microsoft.de

## Tech Stack
- Language: C#
- Framework: .NET 6.0+
- Protocol: Model Context Protocol (MCP)
- API: Microsoft Graph API

## Current Status
- ✅ Repository cloned from: https://github.com/MartinM85/mcp-server-graph-api
- ✅ Azure credentials configured (using existing Azure IaC M365 app)
- ✅ `.env` file created with credentials
- ⏳ Requires .NET SDK installation
- ⏳ Awaiting GitHub Copilot CLI MCP configuration support

## Azure App Registration Details
- **App Name**: Azure IaC M365
- **Client ID**: 53b1c171-76ca-4211-9b31-d1eea9451eb6
- **Tenant ID**: e5050446-5747-425e-b39e-d7dcfdf86bf6
- **Permissions**: Sites, Files, Teams, and User.Read.All (12+ permissions granted)
