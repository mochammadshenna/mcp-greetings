#!/bin/bash

# Pure Go installation script for MCP Greetings Server

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
REPO="mochammadshenna/mcp-greetings"
BINARY_NAME="mcp-greetings"
INSTALL_DIR="$HOME/.local/bin"
CONFIG_DIR="$HOME/.config"

echo -e "${BLUE}🚀 Installing MCP Greetings Server (Pure Go)${NC}"

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
        echo -e "${RED}❌ Unsupported architecture: $ARCH${NC}"
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
        echo -e "${RED}❌ Unsupported OS: $OS${NC}"
        exit 1
        ;;
esac

# Create install directory
mkdir -p "$INSTALL_DIR"

echo -e "${YELLOW}📦 Building binary for $OS-$ARCH...${NC}"

# Build the binary
cd "$(dirname "$0")"
go build -o "$INSTALL_DIR/$BINARY_NAME" -ldflags "-s -w" mcp-server/main.go

# Make it executable
chmod +x "$INSTALL_DIR/$BINARY_NAME"

echo -e "${GREEN}✅ Binary installed to $INSTALL_DIR/$BINARY_NAME${NC}"

# Add to PATH if not already there
if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    echo -e "${YELLOW}📝 Adding $INSTALL_DIR to PATH...${NC}"
    
    # Detect shell
    SHELL_RC=""
    if [[ "$SHELL" == *"zsh"* ]]; then
        SHELL_RC="$HOME/.zshrc"
    elif [[ "$SHELL" == *"bash"* ]]; then
        SHELL_RC="$HOME/.bashrc"
    fi
    
    if [[ -n "$SHELL_RC" ]]; then
        echo "export PATH=\"$INSTALL_DIR:\$PATH\"" >> "$SHELL_RC"
        echo -e "${GREEN}✅ Added to PATH in $SHELL_RC${NC}"
        echo -e "${YELLOW}💡 Please run: source $SHELL_RC${NC}"
    fi
fi

echo -e "${BLUE}🎉 Installation complete!${NC}"
echo -e "${YELLOW}📋 To use with Cursor, add to ~/.cursor/mcp.json:${NC}"
echo ""
echo "{"
echo "  \"mcpServers\": {"
echo "    \"greetings\": {"
echo "      \"command\": \"$INSTALL_DIR/$BINARY_NAME\""
echo "    }"
echo "  }"
echo "}"
echo ""
echo -e "${YELLOW}📋 To use with Claude Desktop, add to claude_desktop_config.json:${NC}"
echo ""
echo "{"
echo "  \"mcpServers\": {"
echo "    \"greetings\": {"
echo "      \"command\": \"$INSTALL_DIR/$BINARY_NAME\""
echo "    }"
echo "  }"
echo "}"
