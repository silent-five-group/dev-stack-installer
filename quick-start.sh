#!/usr/bin/env bash

# Quick Start - Auto-detect OS and run appropriate installer
# Works on Windows (Git Bash), macOS, and Linux

echo ""
echo "═══════════════════════════════════════════════"
echo "  Universal Dev Stack Installer - Quick Start"
echo "═══════════════════════════════════════════════"
echo ""

# Detect OS
if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
    echo "→ Detected: Windows"
    echo "→ Running PowerShell installer..."
    echo ""
    powershell.exe -ExecutionPolicy Bypass -File install.ps1 "$@"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    echo "→ Detected: macOS"
    echo "→ Running Unix installer..."
    echo ""
    chmod +x install.sh
    ./install.sh "$@"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "→ Detected: Linux"
    echo "→ Running Unix installer..."
    echo ""
    chmod +x install.sh
    ./install.sh "$@"
else
    echo "✗ Unsupported OS: $OSTYPE"
    echo ""
    echo "Please run the appropriate installer manually:"
    echo "  Windows: powershell ./install.ps1"
    echo "  macOS/Linux: ./install.sh"
    exit 1
fi
