# Claude Desktop Integration

This guide shows how to integrate the MCP Greetings Server with Claude Desktop.

## Prerequisites

- Claude Desktop installed and running
- Node.js 18.0.0 or higher (for NPM package usage)

## Installation

### Option 1: NPM Package (Recommended)

```bash
npm install -g @mochammadshenna/mcp-greetings
```

### Option 2: Direct Usage

No installation required - uses npx:

```bash
# Test that it works
npx @mochammadshenna/mcp-greetings
```

## Configuration

### Step 1: Locate Configuration File

**macOS:**

```bash
~/.config/claude-desktop/config.json
```

**Windows:**

```bash
%APPDATA%\claude-desktop\config.json
```

**Linux:**

```bash
~/.config/claude-desktop/config.json
```

### Step 2: Edit Configuration

Open the configuration file and add the MCP server:

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

### Step 3: Alternative Configuration

If you have multiple MCP servers, your config might look like:

```json
{
  "mcpServers": {
    "greetings": {
      "command": "npx",
      "args": ["@mochammadshenna/mcp-greetings"]
    },
    "other-server": {
      "command": "node",
      "args": ["/path/to/other/server.js"]
    }
  }
}
```

## Usage

### Step 1: Restart Claude Desktop

After updating the configuration:

1. Close Claude Desktop completely
2. Restart Claude Desktop
3. Wait for the application to fully load

### Step 2: Verify Integration

In Claude Desktop, you should see the greetings tool available. Try asking:

> "Say hello to John in Spanish using the greetings tool"

Claude should respond with: `¡Hola, John!`

### Step 3: Test Different Languages

Try these examples:

- **English**: "Say hello to Alice"
- **Spanish**: "Say hello to María in Spanish"
- **French**: "Say hello to Pierre in French"
- **German**: "Say hello to Hans in German"
- **Japanese**: "Say hello to 田中 in Japanese"
- **Chinese**: "Say hello to 小明 in Chinese"
- **Korean**: "Say hello to 지민 in Korean"

## Troubleshooting

### Server Not Starting

If Claude Desktop shows an error about the MCP server:

1. **Check Node.js version:**

   ```bash
   node --version
   ```

   Should be 18.0.0 or higher.

2. **Test server manually:**

   ```bash
   npx @mochammadshenna/mcp-greetings
   ```

3. **Check configuration syntax:**
   Ensure your JSON is valid.

### Tool Not Available

If the greetings tool doesn't appear:

1. **Restart Claude Desktop** completely
2. **Check logs** in Claude Desktop for error messages
3. **Verify configuration** file path and syntax
4. **Test with minimal config** first

### Permission Issues

On Unix systems, you might need to grant execute permissions:

```bash
chmod +x $(which npx)
```

## Advanced Configuration

### Custom Installation Path

If you installed the package locally:

```json
{
  "mcpServers": {
    "greetings": {
      "command": "node",
      "args": ["/path/to/your/project/node_modules/@mochammadshenna/mcp-greetings/index.js"]
    }
  }
}
```

### Development Mode

For development with local changes:

```json
{
  "mcpServers": {
    "greetings": {
      "command": "node",
      "args": ["/path/to/mcp-greetings/index.js"]
    }
  }
}
```

### Environment Variables

You can set environment variables for the server:

```json
{
  "mcpServers": {
    "greetings": {
      "command": "npx",
      "args": ["@mochammadshenna/mcp-greetings"],
      "env": {
        "MCP_GREETINGS_LOG_LEVEL": "debug"
      }
    }
  }
}
```

## Verification

### Test the Integration

1. **Open Claude Desktop**
2. **Start a new conversation**
3. **Ask Claude**: "What MCP tools do you have available?"
4. **Verify**: You should see "sayGreetings" in the list

### Manual Test

Test the server directly:

```bash
echo '{"jsonrpc":"2.0","id":1,"method":"initialize","params":{"protocolVersion":"2024-11-05","capabilities":{"tools":{}},"clientInfo":{"name":"test","version":"1.0.0"}}}' | npx @mochammadshenna/mcp-greetings
```

Expected output:

```json
{"jsonrpc":"2.0","id":1,"result":{"protocolVersion":"2024-11-05","capabilities":{"tools":{}},"serverInfo":{"name":"greetings-server","version":"1.0.0"}}}
```

## Getting Help

- [GitHub Issues](https://github.com/mochammadshenna/mcp-greetings/issues)
- [FAQ](faq.md)
- [Troubleshooting](troubleshooting.md)
- [Claude Desktop Documentation](https://claude.ai/desktop)
