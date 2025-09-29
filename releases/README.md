# MCP Greetings Server - Pure Go Release v1.1.0

This is a pure Go implementation of the MCP Greetings Server. No Node.js or npm required!

## Quick Installation

### Linux/macOS
```bash
# Download and run installer
curl -L https://github.com/mochammadshenna/mcp-greetings/releases/download/v1.1.0/install.sh | bash

# Or manually
wget https://github.com/mochammadshenna/mcp-greetings/releases/download/v1.1.0/mcp-greetings-linux-amd64
chmod +x mcp-greetings-linux-amd64
sudo mv mcp-greetings-linux-amd64 /usr/local/bin/mcp-greetings
```

### Windows
```cmd
# Download install.bat and run
install.bat
```

## Manual Installation

1. Download the binary for your platform:
   - **macOS Intel**: `mcp-greetings-darwin-amd64`
   - **macOS Apple Silicon**: `mcp-greetings-darwin-arm64`
   - **Linux Intel**: `mcp-greetings-linux-amd64`
   - **Linux ARM**: `mcp-greetings-linux-arm64`
   - **Windows Intel**: `mcp-greetings-windows-amd64.exe`
   - **Windows ARM**: `mcp-greetings-windows-arm64.exe`

2. Make it executable (Unix systems):
   ```bash
   chmod +x mcp-greetings-*
   ```

3. Move to your PATH:
   ```bash
   # Linux/macOS
   sudo mv mcp-greetings-* /usr/local/bin/mcp-greetings
   
   # Windows
   # Move to a directory in your PATH
   ```

## Configuration

### Cursor IDE
Add to `~/.cursor/mcp.json`:
```json
{
  "mcpServers": {
    "greetings": {
      "command": "/usr/local/bin/mcp-greetings"
    }
  }
}
```

### Claude Desktop
Add to `claude_desktop_config.json`:
```json
{
  "mcpServers": {
    "greetings": {
      "command": "/usr/local/bin/mcp-greetings"
    }
  }
}
```

## Features

- 🌍 **Multilingual Support**: 7 languages (English, Spanish, French, German, Japanese, Chinese, Korean)
- 🚀 **Pure Go**: No Node.js dependencies
- 📦 **Single Binary**: Easy to install and distribute
- 🔧 **Cross-platform**: Works on macOS, Linux, Windows

## Tool: sayGreetings

- `name` (required): Name of the person to greet
- `language` (optional): Language for greeting (default: English)
