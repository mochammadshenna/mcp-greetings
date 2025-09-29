# MCP Greetings Server

A multilingual greetings server for the Model Context Protocol (MCP). Say hello to users in 7 different languages with a simple, lightweight MCP server.

## 🌟 Features

- **Multilingual Support**: 7 languages including English, Spanish, French, German, Japanese, Chinese, and Korean
- **AI Assistant Ready**: Compatible with Claude Desktop, Cursor IDE, ChatGPT, and other AI models
- **Easy Installation**: Available as NPM package with one command
- **JSON-RPC 2.0 Compliant**: Full Model Context Protocol specification compliance
- **Lightweight**: Fast Go implementation with minimal dependencies
- **Cross-Platform**: Works on Windows, macOS, and Linux

## 🚀 Quick Start

### Installation

```bash
# Install via NPM
npm install -g @mochammadshenna/mcp-greetings

# Or use directly without installation
npx @mochammadshenna/mcp-greetings
```

### Basic Usage

The server provides a `sayGreetings` tool that can greet users in different languages:

```json
{
  "name": "sayGreetings",
  "arguments": {
    "name": "Alice",
    "language": "Spanish"
  }
}
```

**Response:** `¡Hola, Alice!`

## 🔧 Integration

### Claude Desktop

Add to your Claude Desktop configuration (`~/.config/claude-desktop/config.json`):

```json
{
  "mcpServers": {
    "greetings": {
      "command": "npx",
      "args": ["@mochammadshenna/mcp-greetings"]
    }
  }
}
```

### Cursor IDE

Add to your Cursor configuration (`~/.cursor/mcp.json`):

```json
{
  "mcpServers": {
    "greetings": {
      "command": "npx",
      "args": ["@mochammadshenna/mcp-greetings"]
    }
  }
}
```

## 🌍 Supported Languages

| Language | Code | Example Output |
|----------|------|----------------|
| English | `English` | `Hello, John!` |
| Spanish | `Spanish` | `¡Hola, John!` |
| French | `French` | `Bonjour, John!` |
| German | `German` | `Hallo, John!` |
| Japanese | `Japanese` | `こんにちは, John!` |
| Chinese | `Chinese` | `你好, John!` |
| Korean | `Korean` | `안녕하세요, John!` |

## 📖 Documentation

For detailed documentation, visit: [https://mochammadshenna.github.io/mcp-greetings](https://mochammadshenna.github.io/mcp-greetings)

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guide](CONTRIBUTING.md) for details.

## 📄 License

MIT License - see [LICENSE](LICENSE) for details.

## 🆘 Support

- [GitHub Issues](https://github.com/mochammadshenna/mcp-greetings/issues) - Bug reports and feature requests
- [Documentation](https://mochammadshenna.github.io/mcp-greetings) - Complete usage guide
