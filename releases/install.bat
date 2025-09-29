@echo off
setlocal

set BINARY_NAME=mcp-greetings
set INSTALL_DIR=%USERPROFILE%\.local\bin

REM Detect architecture
if "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
    set ARCH=amd64
) else (
    set ARCH=arm64
)

set BINARY_FILE=%BINARY_NAME%-windows-%ARCH%.exe

if not exist "%BINARY_FILE%" (
    echo ❌ Binary not found: %BINARY_FILE%
    exit /b 1
)

if not exist "%INSTALL_DIR%" mkdir "%INSTALL_DIR%"
copy "%BINARY_FILE%" "%INSTALL_DIR%\%BINARY_NAME%.exe"

echo ✅ Installed to %INSTALL_DIR%\%BINARY_NAME%.exe
echo.
echo Add to PATH: set PATH=%INSTALL_DIR%;%PATH%
echo.
echo For Cursor, add to %%APPDATA%%\Cursor\User\globalStorage\mcp.json:
echo {
echo   "mcpServers": {
echo     "greetings": {
echo       "command": "%INSTALL_DIR%\%BINARY_NAME%.exe"
echo     }
echo   }
echo }
