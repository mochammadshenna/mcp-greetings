#!/bin/bash

# Pure Go release script for MCP Greetings Server

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
BINARY_NAME="mcp-greetings"
VERSION=${1:-"1.0.0"}
RELEASE_DIR="releases"

echo -e "${BLUE}🚀 Creating Pure Go Release v$VERSION${NC}"

# Clean and create release directory
rm -rf "$RELEASE_DIR"
mkdir -p "$RELEASE_DIR"

# Platforms to build for
PLATFORMS=(
    "darwin/amd64"
    "darwin/arm64"
    "linux/amd64"
    "linux/arm64"
    "windows/amd64"
    "windows/arm64"
)

echo -e "${YELLOW}📦 Building binaries for multiple platforms...${NC}"

for platform in "${PLATFORMS[@]}"; do
    IFS='/' read -r os arch <<< "$platform"
    
    output_name="$BINARY_NAME-$os-$arch"
    if [[ "$os" == "windows" ]]; then
        output_name="$output_name.exe"
    fi
    
    echo -e "${YELLOW}  Building $output_name...${NC}"
    
    GOOS="$os" GOARCH="$arch" go build \
        -o "$RELEASE_DIR/$output_name" \
        -ldflags "-s -w -X main.version=$VERSION" \
        mcp-server/main.go
done

echo -e "${GREEN}✅ All binaries built successfully!${NC}"

# Create installation scripts for each platform
echo -e "${YELLOW}📝 Creating installation scripts...${NC}"

# Linux/macOS install script
cat > "$RELEASE_DIR/install.sh" << 'EOF'
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
EOF

chmod +x "$RELEASE_DIR/install.sh"

# Windows install script
cat > "$RELEASE_DIR/install.bat" << 'EOF'
@echo off
setlocal

set BINARY_NAME=mcp-greetings
set INSTALL_DIR=%USERPROFILE%\.local\bin

REM Detect architecture
if "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
    set ARCH=amd64
) else (
    set ARCH=arm64
)

set BINARY_FILE=%BINARY_NAME%-windows-%ARCH%.exe

if not exist "%BINARY_FILE%" (
    echo ❌ Binary not found: %BINARY_FILE%
    exit /b 1
)

if not exist "%INSTALL_DIR%" mkdir "%INSTALL_DIR%"
copy "%BINARY_FILE%" "%INSTALL_DIR%\%BINARY_NAME%.exe"

echo ✅ Installed to %INSTALL_DIR%\%BINARY_NAME%.exe
echo.
echo Add to PATH: set PATH=%INSTALL_DIR%;%PATH%
echo.
echo For Cursor, add to %%APPDATA%%\Cursor\User\globalStorage\mcp.json:
echo {
echo   "mcpServers": {
echo     "greetings": {
echo       "command": "%INSTALL_DIR%\%BINARY_NAME%.exe"
echo     }
echo   }
echo }
EOF

# Create README for releases
cat > "$RELEASE_DIR/README.md" << EOF
# MCP Greetings Server - Pure Go Release v$VERSION

This is a pure Go implementation of the MCP Greetings Server. No Node.js or npm required!

## Quick Installation

### Linux/macOS
\`\`\`bash
# Download and run installer
curl -L https://github.com/mochammadshenna/mcp-greetings/releases/download/v$VERSION/install.sh | bash

# Or manually
wget https://github.com/mochammadshenna/mcp-greetings/releases/download/v$VERSION/mcp-greetings-linux-amd64
chmod +x mcp-greetings-linux-amd64
sudo mv mcp-greetings-linux-amd64 /usr/local/bin/mcp-greetings
\`\`\`

### Windows
\`\`\`cmd
# Download install.bat and run
install.bat
\`\`\`

## Manual Installation

1. Download the binary for your platform:
   - **macOS Intel**: \`mcp-greetings-darwin-amd64\`
   - **macOS Apple Silicon**: \`mcp-greetings-darwin-arm64\`
   - **Linux Intel**: \`mcp-greetings-linux-amd64\`
   - **Linux ARM**: \`mcp-greetings-linux-arm64\`
   - **Windows Intel**: \`mcp-greetings-windows-amd64.exe\`
   - **Windows ARM**: \`mcp-greetings-windows-arm64.exe\`

2. Make it executable (Unix systems):
   \`\`\`bash
   chmod +x mcp-greetings-*
   \`\`\`

3. Move to your PATH:
   \`\`\`bash
   # Linux/macOS
   sudo mv mcp-greetings-* /usr/local/bin/mcp-greetings
   
   # Windows
   # Move to a directory in your PATH
   \`\`\`

## Configuration

### Cursor IDE
Add to \`~/.cursor/mcp.json\`:
\`\`\`json
{
  "mcpServers": {
    "greetings": {
      "command": "/usr/local/bin/mcp-greetings"
    }
  }
}
\`\`\`

### Claude Desktop
Add to \`claude_desktop_config.json\`:
\`\`\`json
{
  "mcpServers": {
    "greetings": {
      "command": "/usr/local/bin/mcp-greetings"
    }
  }
}
\`\`\`

## Features

- 🌍 **Multilingual Support**: 7 languages (English, Spanish, French, German, Japanese, Chinese, Korean)
- 🚀 **Pure Go**: No Node.js dependencies
- 📦 **Single Binary**: Easy to install and distribute
- 🔧 **Cross-platform**: Works on macOS, Linux, Windows

## Tool: sayGreetings

- \`name\` (required): Name of the person to greet
- \`language\` (optional): Language for greeting (default: English)
EOF

# Create checksums
echo -e "${YELLOW}📊 Creating checksums...${NC}"
cd "$RELEASE_DIR"
sha256sum * > checksums.txt
cd ..

echo -e "${GREEN}✅ Release v$VERSION created in $RELEASE_DIR/${NC}"
echo ""
echo -e "${BLUE}📋 Next steps:${NC}"
echo "1. Test the binaries: ./$RELEASE_DIR/install.sh"
echo "2. Create GitHub release with files from $RELEASE_DIR/"
echo "3. Upload all files to GitHub release"
echo ""
echo -e "${YELLOW}📁 Files created:${NC}"
ls -la "$RELEASE_DIR/"
