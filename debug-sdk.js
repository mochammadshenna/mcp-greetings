#!/usr/bin/env node

import { spawn } from 'child_process';

console.log('🔍 Debugging Official SDK...\n');

const process = spawn('go', ['run', 'mcp-server/main.go'], {
    stdio: ['pipe', 'pipe', 'pipe']
});

process.stdout.on('data', (data) => {
    console.log('STDOUT:', data.toString());
});

process.stderr.on('data', (data) => {
    console.log('STDERR:', data.toString());
});

process.on('close', (code) => {
    console.log(`Process exited with code: ${code}`);
});

// Send a simple request
setTimeout(() => {
    const request = {
        jsonrpc: '2.0',
        id: 1,
        method: 'initialize',
        params: {
            protocolVersion: '2024-11-05',
            capabilities: {},
            clientInfo: { name: 'debug', version: '1.0.0' }
        }
    };

    console.log('Sending request:', JSON.stringify(request));
    process.stdin.write(JSON.stringify(request) + '\n');

    setTimeout(() => {
        process.kill();
    }, 2000);
}, 1000);
