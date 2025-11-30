# Microsoft Graph MCP Server - Quick Start

## 🚀 One Command Setup

```bash
cd /home/bmoore/Projects/microsoft-graph-mcp
./setup.sh
```

## ✅ What's Already Done

- ✅ Azure credentials configured (from azureinfracreator)
- ✅ App registration: "Azure IaC M365"
- ✅ 12+ Graph API permissions granted
- ✅ Admin consent applied
- ✅ .env file created
- ✅ Git security (.env in .gitignore)

## 📝 Credentials

```
Tenant: mooreteq.onmicrosoft.com
Client ID: 53b1c171-76ca-4211-9b31-d1eea9451eb6
Status: Ready to use
```

## 🔧 What Setup Does

1. Installs .NET SDK 9.0 (requires sudo)
2. Restores NuGet packages
3. Builds MCP server
4. Validates configuration

## 🧪 Test After Setup

```bash
cd McpServerGraphAPI
dotnet run
```

## 🎯 Integration with GitHub Copilot CLI

**Status**: Waiting for official MCP support

**When available**: Server will expose Microsoft Graph operations through natural language:
- Query Azure AD users
- Access SharePoint/OneDrive
- Manage Teams
- Read/write M365 data

## 📚 Documentation

- `READY-TO-DEPLOY.md` - Complete deployment guide
- `SETUP-INSTRUCTIONS.md` - Manual setup steps
- `GEMINI.md` - Project overview
- `README.md` - Original repo documentation

## 🔒 Security

✅ Client secret secured in .env
✅ .env excluded from git
✅ App uses application permissions (daemon mode)

---

**Next step**: Run `./setup.sh` to complete installation!
