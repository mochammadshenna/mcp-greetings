# API Reference - Tools

The MCP Greetings Server provides one main tool for multilingual greetings.

## sayGreetings

Say hello to someone in different languages.

### Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `name` | string | ✅ Yes | Name of the person to greet |
| `language` | string | ❌ No | Language for greeting (default: English) |

### Supported Languages

| Language | Code | Example Output |
|----------|------|----------------|
| English | `English` | `Hello, John!` |
| Spanish | `Spanish` | `¡Hola, John!` |
| French | `French` | `Bonjour, John!` |
| German | `German` | `Hallo, John!` |
| Japanese | `Japanese` | `こんにちは, John!` |
| Chinese | `Chinese` | `你好, John!` |
| Korean | `Korean` | `안녕하세요, John!` |

### Request Format

```json
{
  "jsonrpc": "2.0",
  "id": 1,
  "method": "tools/call",
  "params": {
    "name": "sayGreetings",
    "arguments": {
      "name": "Alice",
      "language": "Spanish"
    }
  }
}
```

### Response Format

```json
{
  "jsonrpc": "2.0",
  "id": 1,
  "result": {
    "content": [
      {
        "type": "text",
        "text": "¡Hola, Alice!"
      }
    ]
  }
}
```

## Examples

### Basic Greeting (English)

```json
{
  "name": "sayGreetings",
  "arguments": {
    "name": "World"
  }
}
```

**Response:** `Hello, World!`

### Multilingual Greetings

#### Spanish

```json
{
  "name": "sayGreetings",
  "arguments": {
    "name": "María",
    "language": "Spanish"
  }
}
```

**Response:** `¡Hola, María!`

#### French

```json
{
  "name": "sayGreetings",
  "arguments": {
    "name": "Pierre",
    "language": "French"
  }
}
```

**Response:** `Bonjour, Pierre!`

#### Japanese

```json
{
  "name": "sayGreetings",
  "arguments": {
    "name": "田中",
    "language": "Japanese"
  }
}
```

**Response:** `こんにちは, 田中!`

#### Chinese

```json
{
  "name": "sayGreetings",
  "arguments": {
    "name": "小明",
    "language": "Chinese"
  }
}
```

**Response:** `你好, 小明!`

#### Korean

```json
{
  "name": "sayGreetings",
  "arguments": {
    "name": "지민",
    "language": "Korean"
  }
}
```

**Response:** `안녕하세요, 지민!`

#### German

```json
{
  "name": "sayGreetings",
  "arguments": {
    "name": "Hans",
    "language": "German"
  }
}
```

**Response:** `Hallo, Hans!`

## Error Handling

### Invalid Language

If an unsupported language is provided, the server defaults to English:

```json
{
  "name": "sayGreetings",
  "arguments": {
    "name": "John",
    "language": "InvalidLanguage"
  }
}
```

**Response:** `Hello, John!`

### Missing Name

If the required `name` parameter is missing:

```json
{
  "jsonrpc": "2.0",
  "id": 1,
  "method": "tools/call",
  "params": {
    "name": "sayGreetings",
    "arguments": {}
  }
}
```

**Response:**

```json
{
  "jsonrpc": "2.0",
  "id": 1,
  "error": {
    "message": "Name is required"
  }
}
```

### Unknown Tool

If an unsupported tool is called:

```json
{
  "jsonrpc": "2.0",
  "id": 1,
  "method": "tools/call",
  "params": {
    "name": "unknownTool",
    "arguments": {}
  }
}
```

**Response:**

```json
{
  "jsonrpc": "2.0",
  "id": 1,
  "error": {
    "message": "Unknown tool"
  }
}
```

## Protocol Methods

### initialize

Initialize the MCP server connection.

```json
{
  "jsonrpc": "2.0",
  "id": 1,
  "method": "initialize",
  "params": {
    "protocolVersion": "2024-11-05",
    "capabilities": {
      "tools": {}
    },
    "clientInfo": {
      "name": "client-name",
      "version": "1.0.0"
    }
  }
}
```

### tools/list

List available tools.

```json
{
  "jsonrpc": "2.0",
  "id": 1,
  "method": "tools/list"
}
```

**Response:**

```json
{
  "jsonrpc": "2.0",
  "id": 1,
  "result": {
    "tools": [
      {
        "name": "sayGreetings",
        "description": "Say hello to someone in different languages",
        "inputSchema": {
          "type": "object",
          "properties": {
            "name": {
              "type": "string",
              "description": "Name of the person to greet"
            },
            "language": {
              "type": "string",
              "description": "Language for greeting (optional, default: English)",
              "enum": ["English", "Spanish", "French", "German", "Japanese", "Chinese", "Korean"]
            }
          },
          "required": ["name"]
        }
      }
    ]
  }
}
```
