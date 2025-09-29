#!/usr/bin/env node

import { spawn } from 'child_process';
import { dirname, join } from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

async function testMCP() {
    console.log('🧪 Testing MCP Greetings Server...\n');

    const binaryPath = join(__dirname, 'mcp-greetings' + (process.platform === 'win32' ? '.exe' : ''));

    const tests = [
        {
            name: 'Initialize',
            request: {
                jsonrpc: '2.0',
                id: 1,
                method: 'initialize',
                params: {
                    protocolVersion: '2024-11-05',
                    capabilities: {},
                    clientInfo: {
                        name: 'test-client',
                        version: '1.0.0'
                    }
                }
            }
        },
        {
            name: 'List Tools',
            request: {
                jsonrpc: '2.0',
                id: 2,
                method: 'tools/list',
                params: {}
            }
        },
        {
            name: 'Say Greetings (English)',
            request: {
                jsonrpc: '2.0',
                id: 3,
                method: 'tools/call',
                params: {
                    name: 'sayGreetings',
                    arguments: {
                        name: 'John',
                        language: 'English'
                    }
                }
            }
        },
        {
            name: 'Say Greetings (Spanish)',
            request: {
                jsonrpc: '2.0',
                id: 4,
                method: 'tools/call',
                params: {
                    name: 'sayGreetings',
                    arguments: {
                        name: 'Maria',
                        language: 'Spanish'
                    }
                }
            }
        },
        {
            name: 'Say Greetings (Japanese)',
            request: {
                jsonrpc: '2.0',
                id: 5,
                method: 'tools/call',
                params: {
                    name: 'sayGreetings',
                    arguments: {
                        name: 'Taro',
                        language: 'Japanese'
                    }
                }
            }
        }
    ];

    for (const test of tests) {
        console.log(`📋 ${test.name}:`);
        console.log(`Request: ${JSON.stringify(test.request)}`);

        try {
            const result = await sendRequest(binaryPath, test.request);
            console.log(`Response: ${JSON.stringify(result, null, 2)}\n`);
        } catch (error) {
            console.error(`❌ Error: ${error.message}\n`);
        }
    }
}

function sendRequest(binaryPath, request) {
    return new Promise((resolve, reject) => {
        const process = spawn(binaryPath, [], {
            stdio: ['pipe', 'pipe', 'pipe']
        });

        let output = '';
        let error = '';

        process.stdout.on('data', (data) => {
            output += data.toString();
        });

        process.stderr.on('data', (data) => {
            error += data.toString();
        });

        process.on('close', (code) => {
            if (code !== 0) {
                reject(new Error(`Process exited with code ${code}: ${error}`));
                return;
            }

            try {
                const response = JSON.parse(output.trim());
                resolve(response);
            } catch (e) {
                reject(new Error(`Invalid JSON response: ${output}`));
            }
        });

        process.stdin.write(JSON.stringify(request) + '\n');
        process.stdin.end();
    });
}

testMCP().catch(console.error);
