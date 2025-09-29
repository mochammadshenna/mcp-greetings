# Frequently Asked Questions

## General Questions

### What is MCP?

MCP (Model Context Protocol) is a standard that enables AI assistants to connect with external tools and data sources. It allows AI models like Claude to interact with specialized servers that provide specific capabilities.

### What does this server do?

The MCP Greetings Server provides multilingual greeting capabilities to AI assistants. It can say hello in 7 different languages: English, Spanish, French, German, Japanese, Chinese, and Korean.

### Why do I need this?

If you want your AI assistant to greet users in different languages, this server provides a simple, standardized way to do that. It's particularly useful for:

- Multilingual applications
- International user bases
- Language learning tools
- Cultural inclusivity

## Installation Questions

### Do I need to install Node.js?

Yes, Node.js 18.0.0 or higher is required. You can download it from [nodejs.org](https://nodejs.org/).

### Can I use it without installing?

Yes! You can use it directly with `npx` without installation:

```bash
npx @mochammadshenna/mcp-greetings
```

### What if I don't have Go installed?

The NPM package includes the compiled Go binary, so you don't need Go installed to use it.

### Is it available on other package managers?

Currently, it's only available on NPM. We're considering adding support for other package managers based on demand.

## Usage Questions

### How do I use it with Claude Desktop?

1. Install the package: `npm install -g @mochammadshenna/mcp-greetings`
2. Add to Claude Desktop config:

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

3. Restart Claude Desktop

### How do I use it with Cursor IDE?

1. Install the package: `npm install -g @mochammadshenna/mcp-greetings`
2. Add to Cursor config:

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

3. Restart Cursor

### Can I use it with other AI models?

Yes! Any AI model that supports MCP can use this server. This includes:

- ChatGPT (via MCP bridge)
- Google Gemini (via MCP bridge)
- Custom AI applications

### What languages are supported?

Currently supported languages:

- English (default)
- Spanish
- French
- German
- Japanese
- Chinese
- Korean

### Can I add more languages?

Yes! You can contribute by:

1. Forking the repository
2. Adding new languages to the code
3. Submitting a pull request

## Technical Questions

### How does it work?

The server implements the MCP protocol using JSON-RPC 2.0. It:

1. Receives tool calls from AI assistants
2. Processes greeting requests with language selection
3. Returns formatted greetings in the requested language

### Is it secure?

Yes, the server:

- Runs locally on your machine
- Doesn't send data to external servers
- Uses standard MCP security practices
- Has minimal dependencies

### What are the system requirements?

- **Node.js**: 18.0.0 or higher
- **Operating System**: Windows, macOS, or Linux
- **Memory**: Minimal (typically < 10MB)
- **Storage**: ~5MB for the package

### Can I run it in production?

Yes, the server is designed to be production-ready with:

- Error handling
- Graceful shutdown
- Minimal resource usage
- Standard logging

## Troubleshooting Questions

### The server won't start

Common solutions:

1. Check Node.js version: `node --version`
2. Test manually: `npx @mochammadshenna/mcp-greetings`
3. Check configuration syntax
4. Restart your AI application

### Claude Desktop doesn't see the tool

Try these steps:

1. Restart Claude Desktop completely
2. Check the configuration file syntax
3. Verify the server starts manually
4. Check Claude Desktop logs for errors

### Permission denied errors

On Unix systems:

```bash
chmod +x $(which npx)
```

Or install globally:

```bash
npm install -g @mochammadshenna/mcp-greetings
```

### Network/firewall issues

If you're behind a corporate firewall:

```bash
npm config set proxy http://proxy.company.com:8080
npm config set https-proxy http://proxy.company.com:8080
```

## Development Questions

### Can I contribute?

Absolutely! We welcome contributions:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

### How do I set up development?

```bash
git clone https://github.com/mochammadshenna/mcp-greetings.git
cd mcp-greetings
npm install
npm start
```

### What technologies are used?

- **Go**: Core server implementation
- **Node.js**: Package wrapper and distribution
- **JSON-RPC 2.0**: Communication protocol
- **MCP**: Model Context Protocol

### How do I add new features?

1. Plan the feature
2. Create an issue for discussion
3. Implement the feature
4. Add tests
5. Update documentation
6. Submit a pull request

## Support Questions

### Where can I get help?

- [GitHub Issues](https://github.com/mochammadshenna/mcp-greetings/issues)
- [Documentation](README.md)
- [Troubleshooting Guide](troubleshooting.md)

### How do I report bugs?

1. Check existing issues first
2. Create a new issue with:
   - Clear description
   - Steps to reproduce
   - Expected vs actual behavior
   - System information

### How do I request features?

1. Check existing feature requests
2. Create a new issue with:
   - Clear feature description
   - Use case and benefits
   - Proposed implementation (if you have ideas)

### Is there a roadmap?

Yes! Check our [Roadmap](roadmap.md) for planned features and improvements.

## Commercial Questions

### Can I use this commercially?

Yes, the MIT license allows commercial use. See the [LICENSE](LICENSE) file for details.

### Do you offer support contracts?

Currently, we provide community support only. For enterprise support, please contact us through GitHub issues.

### Can I modify and redistribute?

Yes, the MIT license allows modification and redistribution with proper attribution.

### Is there a premium version?

No, this is a free, open-source project. All features are available to everyone.

## Still have questions?

If you don't see your question here:

1. Check the [Documentation](README.md)
2. Search [GitHub Issues](https://github.com/mochammadshenna/mcp-greetings/issues)
3. Create a new issue with your question
4. Join our community discussions

We're here to help! 🚀
