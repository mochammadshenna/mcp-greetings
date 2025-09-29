# Installation

This guide covers different ways to install and use the MCP Greetings Server.

## 📦 NPM Installation (Recommended)

### Global Installation

Install the package globally to use it from anywhere:

```bash
npm install -g @mochammadshenna/mcp-greetings
```

### Local Installation

Install in a specific project:

```bash
npm install @mochammadshenna/mcp-greetings
```

### Direct Usage (No Installation)

Use the package directly without installation:

```bash
npx @mochammadshenna/mcp-greetings
```

## 🐳 Docker Installation

### Using Docker Hub

```bash
docker pull mochammadshenna/mcp-greetings:latest
docker run -it mochammadshenna/mcp-greetings
```

### Build from Source

```bash
git clone https://github.com/mochammadshenna/mcp-greetings.git
cd mcp-greetings
docker build -t mcp-greetings .
docker run -it mcp-greetings
```

## 🛠️ Development Installation

### Prerequisites

- Node.js 18.0.0 or higher
- Go 1.21 or higher (for development)

### Clone and Install

```bash
# Clone the repository
git clone https://github.com/mochammadshenna/mcp-greetings.git
cd mcp-greetings

# Install dependencies
npm install

# Run in development mode
npm start
```

### Build from Source

```bash
# Build the Go server
cd mcp-server
go build -o mcp-server main.go

# Run the built binary
./mcp-server
```

## 🔧 Configuration

### Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `MCP_GREETINGS_LOG_LEVEL` | Logging level | `info` |
| `MCP_GREETINGS_PORT` | Server port (if using HTTP) | `3000` |

### Configuration File

Create a `config.json` file in your project root:

```json
{
  "logLevel": "info",
  "defaultLanguage": "English",
  "supportedLanguages": [
    "English", "Spanish", "French", 
    "German", "Japanese", "Chinese", "Korean"
  ]
}
```

## ✅ Verification

### Test Installation

Test your installation by running the server:

```bash
# Test with NPM package
npx @mochammadshenna/mcp-greetings

# Test with local installation
npm test
```

### Expected Output

You should see:

```
Greetings MCP server running on stdio (via Go server)
```

### Integration Test

Test with an MCP client:

```bash
echo '{"jsonrpc":"2.0","id":1,"method":"initialize","params":{"protocolVersion":"2024-11-05","capabilities":{"tools":{}},"clientInfo":{"name":"test-client","version":"1.0.0"}}}' | npx @mochammadshenna/mcp-greetings
```

## 🚨 Troubleshooting

### Common Issues

#### Node.js Version

Ensure you have Node.js 18.0.0 or higher:

```bash
node --version
```

#### Go Version (Development)

For development builds, ensure Go 1.21 or higher:

```bash
go version
```

#### Permission Issues

On Unix systems, you might need to make the script executable:

```bash
chmod +x index.js
```

#### Network Issues

If you're behind a corporate firewall, configure npm proxy:

```bash
npm config set proxy http://proxy.company.com:8080
npm config set https-proxy http://proxy.company.com:8080
```

### Getting Help

- [GitHub Issues](https://github.com/mochammadshenna/mcp-greetings/issues)
- [FAQ](faq.md)
- [Troubleshooting Guide](troubleshooting.md)
