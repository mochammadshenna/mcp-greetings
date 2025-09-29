#!/bin/bash

# Pure Go MCP Greetings Server Installer

set -e

BINARY_NAME="mcp-greetings"
INSTALL_DIR="$HOME/.local/bin"

# Detect OS and architecture
OS=$(uname -s | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m)

case $ARCH in
    x86_64)
        ARCH="amd64"
        ;;
    arm64|aarch64)
        ARCH="arm64"
        ;;
    *)
        echo "❌ Unsupported architecture: $ARCH"
        exit 1
        ;;
esac

case $OS in
    darwin)
        OS="darwin"
        ;;
    linux)
        OS="linux"
        ;;
    *)
        echo "❌ Unsupported OS: $OS"
        exit 1
        ;;
esac

BINARY_FILE="$BINARY_NAME-$OS-$ARCH"

if [[ ! -f "$BINARY_FILE" ]]; then
    echo "❌ Binary not found: $BINARY_FILE"
    exit 1
fi

mkdir -p "$INSTALL_DIR"
cp "$BINARY_FILE" "$INSTALL_DIR/$BINARY_NAME"
chmod +x "$INSTALL_DIR/$BINARY_NAME"

echo "✅ Installed to $INSTALL_DIR/$BINARY_NAME"
echo ""
echo "Add to PATH: export PATH=\"$INSTALL_DIR:\$PATH\""
echo ""
echo "For Cursor, add to ~/.cursor/mcp.json:"
echo "{"
echo "  \"mcpServers\": {"
echo "    \"greetings\": {"
echo "      \"command\": \"$INSTALL_DIR/$BINARY_NAME\""
echo "    }"
echo "  }"
echo "}"
