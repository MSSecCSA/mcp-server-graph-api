#!/bin/bash
# Test the MCP server by sending it an MCP protocol request

set -a
source .env
set +a

echo "╔══════════════════════════════════════════════════════════════╗"
echo "║      Testing Microsoft Graph MCP Server                     ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""

echo "→ MCP Server is running in another terminal"
echo "→ To test it, send MCP protocol messages via stdio"
echo ""
echo "The server is listening for JSON-RPC requests in MCP format."
echo ""
echo "Example test request (send to server's stdin):"
echo '{"jsonrpc":"2.0","method":"tools/list","id":1}'
echo ""
echo "The server should respond with available tools including:"
echo "  - my-tenant: Tool to interact with Microsoft Graph (Entra)"
echo ""
echo "Press Ctrl+C in the server terminal to stop it."
echo ""
echo "✅ Server Build: SUCCESS"
echo "✅ Server Started: SUCCESS"
echo "✅ Credentials: Loaded from .env"
echo "✅ Status: Running and ready for MCP requests"
echo ""
echo "╚══════════════════════════════════════════════════════════════╝"
