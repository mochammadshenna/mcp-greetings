# NPM Publishing Guide

This guide covers how to publish the MCP Greetings Server to NPM for worldwide distribution.

## Prerequisites

- NPM account ([sign up here](https://www.npmjs.com/signup))
- Node.js 18.0.0 or higher
- Git repository set up

## Package Configuration

### package.json

The package is already configured in `package.json`:

```json
{
  "name": "@mochammadshenna/mcp-greetings",
  "version": "1.0.0",
  "description": "Multilingual greetings MCP server - Say hello in 7 different languages",
  "main": "index.js",
  "bin": {
    "mcp-greetings": "./index.js"
  },
  "type": "module",
  "scripts": {
    "start": "node index.js",
    "test": "node test.js",
    "postinstall": "node postinstall.js"
  },
  "keywords": [
    "mcp",
    "model-context-protocol",
    "greetings",
    "multilingual",
    "ai",
    "claude",
    "cursor",
    "chatgpt",
    "anthropic",
    "json-rpc"
  ],
  "author": {
    "name": "Mochammad Shenna",
    "email": "mochammadshenna@example.com",
    "url": "https://github.com/mochammadshenna"
  },
  "license": "MIT",
  "repository": {
    "type": "git",
    "url": "https://github.com/mochammadshenna/mcp-greetings.git"
  },
  "bugs": {
    "url": "https://github.com/mochammadshenna/mcp-greetings/issues"
  },
  "homepage": "https://github.com/mochammadshenna/mcp-greetings#readme",
  "engines": {
    "node": ">=18.0.0"
  },
  "files": [
    "index.js",
    "postinstall.js",
    "mcp-server/",
    "go.mod",
    "go.sum",
    "README.md",
    "LICENSE"
  ]
}
```

## Publishing Steps

### Step 1: Login to NPM

```bash
npm login
```

Enter your NPM credentials:

- Username
- Password
- Email

### Step 2: Verify Package

Before publishing, verify the package contents:

```bash
# Check what will be published
npm pack --dry-run

# Test the package locally
npm link
```

### Step 3: Publish

```bash
# Publish to NPM (scoped package)
npm publish --access public

# For unscoped packages (if changing name)
npm publish
```

### Step 4: Verify Publication

Check that your package is available:

```bash
# Search for your package
npm search @mochammadshenna/mcp-greetings

# Install and test
npm install -g @mochammadshenna/mcp-greetings
```

## Usage After Publishing

### Global Installation

```bash
npm install -g @mochammadshenna/mcp-greetings
```

### Direct Usage (No Installation)

```bash
npx @mochammadshenna/mcp-greetings
```

### Local Installation

```bash
npm install @mochammadshenna/mcp-greetings
```

## Configuration Examples

### Claude Desktop

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

## Version Management

### Semantic Versioning

Follow semantic versioning (semver):

- **Major** (1.0.0 → 2.0.0): Breaking changes
- **Minor** (1.0.0 → 1.1.0): New features, backward compatible
- **Patch** (1.0.0 → 1.0.1): Bug fixes, backward compatible

### Updating Version

```bash
# Patch version (bug fixes)
npm version patch

# Minor version (new features)
npm version minor

# Major version (breaking changes)
npm version major
```

### Publishing Updates

```bash
# After updating version
npm publish
```

## Package Maintenance

### Updating Dependencies

```bash
# Check for outdated dependencies
npm outdated

# Update dependencies
npm update
```

### Security Audit

```bash
# Check for security vulnerabilities
npm audit

# Fix vulnerabilities
npm audit fix
```

## Distribution Strategies

### 1. NPM Only (Recommended)

- **Pros**: Easy installation, version management, dependency resolution
- **Cons**: Requires Node.js
- **Best for**: Most users, easy setup

### 2. NPM + GitHub Releases

- **Pros**: Multiple installation methods, source code available
- **Cons**: More maintenance
- **Best for**: Developers who want source access

### 3. NPM + Docker

- **Pros**: Containerized deployment, no Node.js required
- **Cons**: Larger download size
- **Best for**: Enterprise deployments

## Monitoring

### Download Statistics

Monitor package usage:

```bash
# View download statistics
npm view @mochammadshenna/mcp-greetings

# Check specific version
npm view @mochammadshenna/mcp-greetings@1.0.0
```

### NPM Analytics

Visit your package page on NPM:
<https://www.npmjs.com/package/@mochammadshenna/mcp-greetings>

## Troubleshooting

### Common Issues

#### Authentication Failed

```bash
# Re-login to NPM
npm logout
npm login
```

#### Package Already Exists

```bash
# Check if package name is taken
npm view @mochammadshenna/mcp-greetings

# Use different name or scope
npm publish --access public
```

#### Permission Denied

```bash
# Check if you own the package
npm owner ls @mochammadshenna/mcp-greetings

# Add yourself as owner
npm owner add mochammadshenna @mochammadshenna/mcp-greetings
```

#### Version Conflict

```bash
# Check current version
npm view @mochammadshenna/mcp-greetings version

# Update version before publishing
npm version patch
```

## Best Practices

### 1. Package Quality

- ✅ Comprehensive README
- ✅ Clear documentation
- ✅ Working examples
- ✅ Proper error handling
- ✅ Test coverage

### 2. Metadata

- ✅ Descriptive name and description
- ✅ Relevant keywords
- ✅ Proper author information
- ✅ License information
- ✅ Repository links

### 3. Files

- ✅ Only include necessary files
- ✅ Use `.npmignore` if needed
- ✅ Include all dependencies
- ✅ Test before publishing

### 4. Versioning

- ✅ Follow semantic versioning
- ✅ Document breaking changes
- ✅ Maintain changelog
- ✅ Tag releases in Git

## Automation

### GitHub Actions

Set up automated publishing with GitHub Actions:

```yaml
name: Publish to NPM

on:
  push:
    tags:
      - 'v*'

jobs:
  publish:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: '18'
          registry-url: 'https://registry.npmjs.org'
      - run: npm ci
      - run: npm publish
        env:
          NODE_AUTH_TOKEN: ${{ secrets.NPM_TOKEN }}
```

### NPM Token

1. Generate NPM token: <https://www.npmjs.com/settings/tokens>
2. Add to GitHub Secrets as `NPM_TOKEN`
3. Tag releases to trigger publishing

## Success Metrics

### Key Metrics

- **Downloads**: Daily/weekly/monthly downloads
- **Users**: Unique users installing the package
- **Stars**: GitHub repository stars
- **Issues**: Bug reports and feature requests
- **Forks**: Community contributions

### Monitoring Tools

- NPM package page analytics
- GitHub repository insights
- Google Analytics (for documentation)
- User feedback and surveys

## Next Steps

1. **Publish Initial Version**: Get v1.0.0 live
2. **Monitor Usage**: Track downloads and feedback
3. **Gather Feedback**: Collect user suggestions
4. **Iterate**: Improve based on user needs
5. **Community**: Build user community and contributors
