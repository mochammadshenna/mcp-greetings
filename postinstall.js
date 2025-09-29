#!/usr/bin/env node

import { promises as fs } from 'fs';
import { join, dirname } from 'path';
import { fileURLToPath } from 'url';
import { chmod } from 'fs/promises';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

async function setupBinary() {
  const platform = process.platform;
  const arch = process.arch;
  
  let binaryName;
  if (platform === 'darwin') {
    binaryName = `mcp-greetings-darwin-${arch === 'arm64' ? 'arm64' : 'amd64'}`;
  } else if (platform === 'linux') {
    binaryName = `mcp-greetings-linux-${arch === 'arm64' ? 'arm64' : 'amd64'}`;
  } else if (platform === 'win32') {
    binaryName = `mcp-greetings-windows-${arch === 'arm64' ? 'arm64' : 'amd64'}.exe`;
  } else {
    console.error('Unsupported platform:', platform);
    process.exit(1);
  }
  
  const binaryPath = join(__dirname, 'dist', binaryName);
  const targetPath = join(__dirname, 'mcp-greetings' + (platform === 'win32' ? '.exe' : ''));
  
  try {
    await fs.copyFile(binaryPath, targetPath);
    await chmod(targetPath, 0o755);
    console.log(`✅ Binary installed: ${targetPath}`);
  } catch (error) {
    console.error('Failed to install binary:', error);
    process.exit(1);
  }
}

setupBinary().catch(console.error);
