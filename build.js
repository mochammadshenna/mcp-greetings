#!/usr/bin/env node

import { spawn } from 'child_process';
import { promises as fs } from 'fs';
import { dirname, join } from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

const platforms = [
    { GOOS: 'darwin', GOARCH: 'amd64', name: 'darwin-amd64' },
    { GOOS: 'darwin', GOARCH: 'arm64', name: 'darwin-arm64' },
    { GOOS: 'linux', GOARCH: 'amd64', name: 'linux-amd64' },
    { GOOS: 'linux', GOARCH: 'arm64', name: 'linux-arm64' },
    { GOOS: 'windows', GOARCH: 'amd64', name: 'windows-amd64.exe' },
    { GOOS: 'windows', GOARCH: 'arm64', name: 'windows-arm64.exe' },
];

async function buildBinaries() {
    console.log('Building Go binaries for multiple platforms...');

    const distDir = join(__dirname, 'dist');
    await fs.mkdir(distDir, { recursive: true });

    for (const platform of platforms) {
        console.log(`Building for ${platform.name}...`);

        const outputPath = join(distDir, `mcp-greetings-${platform.name}`);

        await new Promise((resolve, reject) => {
            const buildProcess = spawn('go', [
                'build',
                '-o', outputPath,
                '-ldflags', '-s -w',
                'mcp-server/main.go'
            ], {
                env: {
                    ...process.env,
                    GOOS: platform.GOOS,
                    GOARCH: platform.GOARCH,
                },
                stdio: 'inherit'
            });

            buildProcess.on('close', (code) => {
                if (code === 0) {
                    console.log(`✅ Built ${platform.name}`);
                    resolve();
                } else {
                    reject(new Error(`Build failed for ${platform.name}`));
                }
            });
        });
    }

    console.log('✅ All binaries built successfully!');
}

async function createPackageJson() {
    console.log('Creating package.json for distribution...');

    const packageJson = {
        name: "@mochammadshenna/mcp-greetings",
        version: "1.0.0",
        description: "Multilingual greetings MCP server",
        main: "index.js",
        bin: {
            "mcp-greetings": "./index.js"
        },
        type: "module",
        scripts: {
            "start": "node index.js",
            "postinstall": "node postinstall.js"
        },
        keywords: [
            "mcp",
            "model-context-protocol",
            "greetings",
            "multilingual",
            "ai",
            "claude",
            "cursor"
        ],
        author: {
            name: "Mochammad Shenna",
            email: "shenawardana@gmail.com",
            url: "https://github.com/mochammadshenna"
        },
        license: "MIT",
        repository: {
            type: "git",
            url: "https://github.com/mochammadshenna/mcp-greetings.git"
        },
        bugs: {
            url: "https://github.com/mochammadshenna/mcp-greetings/issues"
        },
        homepage: "https://github.com/mochammadshenna/mcp-greetings#readme",
        dependencies: {},
        engines: {
            node: ">=18.0.0"
        },
        files: [
            "index.js",
            "postinstall.js",
            "dist/",
            "README.md",
            "LICENSE"
        ],
        os: ["darwin", "linux", "win32"],
        cpu: ["x64", "arm64"]
    };

    await fs.writeFile(join(__dirname, 'package.json'), JSON.stringify(packageJson, null, 2));
    console.log('✅ package.json created');
}

async function createPostInstall() {
    console.log('Creating postinstall script...');

    const postInstallScript = `#!/usr/bin/env node

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
    binaryName = \`mcp-greetings-darwin-\${arch === 'arm64' ? 'arm64' : 'amd64'}\`;
  } else if (platform === 'linux') {
    binaryName = \`mcp-greetings-linux-\${arch === 'arm64' ? 'arm64' : 'amd64'}\`;
  } else if (platform === 'win32') {
    binaryName = \`mcp-greetings-windows-\${arch === 'arm64' ? 'arm64' : 'amd64'}.exe\`;
  } else {
    console.error('Unsupported platform:', platform);
    process.exit(1);
  }
  
  const binaryPath = join(__dirname, 'dist', binaryName);
  const targetPath = join(__dirname, 'mcp-greetings' + (platform === 'win32' ? '.exe' : ''));
  
  try {
    await fs.copyFile(binaryPath, targetPath);
    await chmod(targetPath, 0o755);
    console.log(\`✅ Binary installed: \${targetPath}\`);
  } catch (error) {
    console.error('Failed to install binary:', error);
    process.exit(1);
  }
}

setupBinary().catch(console.error);
`;

    await fs.writeFile(join(__dirname, 'postinstall.js'), postInstallScript);
    console.log('✅ postinstall.js created');
}

async function main() {
    try {
        await buildBinaries();
        await createPackageJson();
        await createPostInstall();
        console.log('\\n🎉 Build complete! Ready for publishing.');
        console.log('\\nTo publish:');
        console.log('1. npm login');
        console.log('2. npm publish');
    } catch (error) {
        console.error('Build failed:', error);
        process.exit(1);
    }
}

main();
