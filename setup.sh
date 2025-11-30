#!/bin/bash
################################################################################
# Microsoft Graph MCP Server - Quick Setup
# 
# This script installs .NET SDK and builds the MCP server.
# Azure credentials are already configured in .env file.
################################################################################

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║     Microsoft Graph MCP Server - Quick Setup                ║${NC}"
echo -e "${BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"
echo ""

# Check if dotnet is already installed
if command -v dotnet &> /dev/null; then
    echo -e "${GREEN}✓ .NET SDK is already installed${NC}"
    dotnet --version
else
    echo -e "${YELLOW}→ Installing .NET SDK 9.0...${NC}"
    echo -e "${YELLOW}  This requires sudo privileges${NC}"
    
    # Check if running as root
    if [ "$EUID" -eq 0 ]; then
        # Running as root, download to /tmp with different approach
        curl -L https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb -o /tmp/packages-microsoft-prod.deb
        dpkg -i /tmp/packages-microsoft-prod.deb
        rm -f /tmp/packages-microsoft-prod.deb
        
        # Update package list and install .NET SDK
        apt-get update
        apt-get install -y dotnet-sdk-9.0
    else
        # Not running as root, use sudo
        wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb -O /tmp/packages-microsoft-prod.deb
        sudo dpkg -i /tmp/packages-microsoft-prod.deb
        rm /tmp/packages-microsoft-prod.deb
        
        # Update package list and install .NET SDK
        sudo apt-get update
        sudo apt-get install -y dotnet-sdk-9.0
    fi
    
    echo -e "${GREEN}✓ .NET SDK installed successfully${NC}"
    dotnet --version
fi

echo ""
echo -e "${YELLOW}→ Building Microsoft Graph MCP Server...${NC}"

# Navigate to project directory
cd "$(dirname "$0")/McpServerGraphAPI"

# Restore dependencies
echo -e "${BLUE}  Restoring NuGet packages...${NC}"
dotnet restore

# Build the project
echo -e "${BLUE}  Building project...${NC}"
dotnet build --no-restore

echo ""
echo -e "${GREEN}╔══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║                    Setup Complete! ✓                         ║${NC}"
echo -e "${GREEN}╚══════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${BLUE}Configuration:${NC}"
echo -e "  ✓ Azure credentials: Configured in .env"
echo -e "  ✓ Tenant: mooreteq.onmicrosoft.com"
echo -e "  ✓ App: Azure IaC M365"
echo ""
echo -e "${BLUE}Test the server:${NC}"
echo -e "  ${GREEN}cd McpServerGraphAPI && dotnet run${NC}"
echo ""
echo -e "${BLUE}For GitHub Copilot CLI integration:${NC}"
echo -e "  The server can be configured once GitHub Copilot CLI"
echo -e "  officially supports MCP servers via configuration files."
echo ""
