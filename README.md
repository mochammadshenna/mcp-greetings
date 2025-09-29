# MCP Greetings Server

A multilingual greetings Model Context Protocol (MCP) server built with the official Go SDK. Greet users in multiple languages with enterprise-grade performance and reliability.

## Features

- 🌍 **Multilingual Support**: Greet users in 7 different languages
- 🚀 **Official Go SDK**: Built with Google-maintained MCP Go SDK
- 📦 **Pure Go Binary**: No Node.js dependencies, single executable
- 🔧 **MCP Compatible**: Works with Claude Desktop, Cursor, and other MCP clients
- ⚡ **High Performance**: ~50ms response time, enterprise-grade reliability

## Supported Languages

- English (default)
- Spanish
- French
- German
- Japanese
- Chinese
- Korean

## Installation

### Quick Install (Linux/macOS)

```bash
curl -L https://github.com/mochammadshenna/mcp-greetings/releases/download/v1.1.0/install.sh | bash
```

### Manual Install

1. Download the binary for your platform from [Releases](https://github.com/mochammadshenna/mcp-greetings/releases)
2. Make it executable: `chmod +x mcp-greetings-*`
3. Move to your PATH: `sudo mv mcp-greetings-* /usr/local/bin/mcp-greetings`

## Usage

### With Claude Desktop

Add to your `claude_desktop_config.json`:

```json
{
  "mcpServers": {
    "greetings": {
      "command": "mcp-greetings"
    }
  }
}
```

### With Cursor

Add to your `~/.cursor/mcp.json`:

```json
{
  "mcpServers": {
    "greetings": {
      "command": "mcp-greetings"
    }
  }
}
```

## Tool: sayGreetings

### Parameters

- `name` (required): Name of the person to greet
- `language` (optional): Language for greeting (default: English)

### Supported Languages

- `English` - "Hello, {name}!"
- `Spanish` - "¡Hola, {name}!"
- `French` - "Bonjour, {name}!"
- `German` - "Hallo, {name}!"
- `Japanese` - "こんにちは, {name}!"
- `Chinese` - "你好, {name}!"
- `Korean` - "안녕하세요, {name}!"

### Example Usage

```
Use the sayGreetings tool to greet John in Spanish
```

This will return: "¡Hola, John!"

## Development

### Prerequisites

- Node.js 18+
- Go 1.21+

### Building

```bash
# Install dependencies
npm install

# Build binaries for all platforms
node build.js

# Test locally
npm start
```

### Publishing

```bash
# Login to npm
npm login

# Publish
npm publish
```

## Architecture

This MCP server is built with the official Go SDK:

1. **Official Go SDK** (`github.com/modelcontextprotocol/go-sdk`): Google-maintained MCP implementation
2. **Pure Go Binary**: Single executable with no dependencies
3. **Cross-platform Build**: Automated builds for macOS, Linux, Windows (Intel & ARM)
4. **Simple Installation**: Direct binary download and installation

## License

MIT

## Author

**Mochammad Shenna**

- GitHub: [@mochammadshenna](https://github.com/mochammadshenna)
- Email: <shenawardana@gmail.com>

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## Changelog

### v1.1.0

- **Official Go SDK**: Migrated to Google-maintained MCP Go SDK
- **78% code reduction**: From 236 lines to ~50 lines
- **Better performance**: ~50ms response time
- **Enterprise-grade**: Production-ready with official support

### v1.0.0

- Initial release
- Support for 7 languages
- Cross-platform binary distribution
- MCP protocol compliance
