#!/usr/bin/env node

import { spawn } from 'child_process';
import { dirname, join } from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

// Define greetings in different languages
const greetings = {
    English: (name) => `Hello, ${name}!`,
    Spanish: (name) => `¡Hola, ${name}!`,
    French: (name) => `Bonjour, ${name}!`,
    German: (name) => `Hallo, ${name}!`,
    Japanese: (name) => `こんにちは, ${name}!`,
    Chinese: (name) => `你好, ${name}!`,
    Korean: (name) => `안녕하세요, ${name}!`,
};

// Start the Go server
const goServer = spawn('go', ['run', join(__dirname, 'mcp-server', 'main.go')], {
    stdio: ['pipe', 'pipe', 'pipe']
});

// Handle server output
goServer.stdout.on('data', (data) => {
    process.stdout.write(data);
});

goServer.stderr.on('data', (data) => {
    process.stderr.write(data);
});

// Handle server errors
goServer.on('error', (error) => {
    console.error('Failed to start Go server:', error);
    process.exit(1);
});

goServer.on('close', (code) => {
    console.error(`Go server exited with code ${code}`);
    process.exit(code);
});

// Forward stdin to Go server
process.stdin.pipe(goServer.stdin);

// Handle graceful shutdown
process.on('SIGINT', () => {
    console.error('Shutting down server...');
    goServer.kill('SIGINT');
    process.exit(0);
});

process.on('SIGTERM', () => {
    console.error('Shutting down server...');
    goServer.kill('SIGTERM');
    process.exit(0);
});

console.error('Greetings MCP server running on stdio (via Go server)');