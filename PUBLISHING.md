# Publishing Guide

This guide explains how to publish your MCP Greetings server as an npm package that other developers can use.

## Prerequisites

1. **npm account**: Create an account at [npmjs.com](https://www.npmjs.com)
2. **Go installed**: For building binaries
3. **Node.js 18+**: For running the build scripts

## Publishing Steps

### 1. Build the Package

```bash
# Build binaries for all platforms
npm run build

# Test the built package
npm run test
```

### 2. Login to npm

```bash
npm login
```

### 3. Publish to npm

```bash
npm publish
```

### 4. Create a Release (Optional)

```bash
# Tag the version
git tag v1.0.0
git push origin v1.0.0
```

This will trigger the GitHub Actions workflow to automatically build and publish.

## How Users Will Install Your Package

Once published, users can install your MCP server like this:

```bash
npm install -g @mochammadshenna/mcp-greetings
```

## How Users Will Configure It

### Claude Desktop

```json
{
  "mcpServers": {
    "greetings": {
      "command": "npx",
      "args": ["-y", "@mochammadshenna/mcp-greetings"]
    }
  }
}
```

### Cursor

```json
{
  "mcpServers": {
    "greetings": {
      "command": "npx", 
      "args": ["-y", "@mochammadshenna/mcp-greetings"]
    }
  }
}
```

## Package Structure

```
@mochammadshenna/mcp-greetings/
├── index.js              # Main entry point
├── postinstall.js        # Installs correct binary
├── dist/                 # Compiled Go binaries
│   ├── mcp-greetings-darwin-amd64
│   ├── mcp-greetings-darwin-arm64
│   ├── mcp-greetings-linux-amd64
│   ├── mcp-greetings-linux-arm64
│   ├── mcp-greetings-windows-amd64.exe
│   └── mcp-greetings-windows-arm64.exe
├── README.md             # Documentation
└── LICENSE               # MIT License
```

## Key Features of This Setup

1. **Cross-platform**: Works on macOS, Linux, and Windows
2. **No Go dependency**: Users don't need Go installed
3. **Automatic binary selection**: Post-install script selects the right binary
4. **Small package size**: Only includes necessary files
5. **Easy installation**: Simple `npx` command

## Version Management

- Update version in `package.json`
- Create git tag: `git tag v1.0.1`
- Push tag: `git push origin v1.0.1`
- GitHub Actions will automatically publish

## Troubleshooting

### Build Issues

- Ensure Go is installed and in PATH
- Check that all platforms build successfully
- Verify binary permissions

### Publishing Issues

- Ensure you're logged into npm: `npm whoami`
- Check package name availability
- Verify all required files are included

### User Installation Issues

- Check Node.js version compatibility
- Verify platform support
- Check binary permissions after install
