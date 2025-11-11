# Universal Dev Stack Installer - Windows PowerShell
# Cross-platform development environment setup

param(
    [string[]]$Tier = @("Essential"),
    [switch]$All,
    [switch]$List,
    [switch]$DryRun,
    [switch]$Force,
    [switch]$Quiet
)

$ErrorActionPreference = "Continue"
$LogFile = "install.log"

# Colors
function Write-Header { param($Text) Write-Host "`n$Text" -ForegroundColor Cyan }
function Write-Success { param($Text) Write-Host "  [OK] $Text" -ForegroundColor Green }
function Write-Warning { param($Text) Write-Host "  [!] $Text" -ForegroundColor Yellow }
function Write-Error { param($Text) Write-Host "  [X] $Text" -ForegroundColor Red }
function Write-Info { param($Text) Write-Host "  -> $Text" -ForegroundColor Gray }

# Banner
Write-Host ""
Write-Host "==================================================" -ForegroundColor Cyan
Write-Host "   Universal Dev Stack Installer - Windows" -ForegroundColor Cyan
Write-Host "   Cross-Platform Development Environment" -ForegroundColor Cyan
Write-Host "==================================================" -ForegroundColor Cyan
Write-Host ""

# Initialize log
"=== Dev Stack Installer Log - $(Get-Date) ===" | Out-File $LogFile

# Load tools manifest
if (-not (Test-Path "tools.json")) {
    Write-Error "tools.json not found! Make sure you're running this from the installer directory."
    exit 1
}

$jsonContent = Get-Content "tools.json" -Raw
$manifest = ConvertFrom-Json $jsonContent

# List available tiers and tools
if ($List) {
    Write-Header "Available Installation Tiers:"
    Write-Host ""

    $manifest.tiers.PSObject.Properties | ForEach-Object {
        $tierData = $_.Value
        Write-Host "  $($tierData.name.ToUpper())" -ForegroundColor Yellow
        Write-Host "  $($tierData.description)" -ForegroundColor Gray
        Write-Host "  Tools ($($tierData.tools.Count)):" -ForegroundColor White

        foreach ($tool in $tierData.tools) {
            Write-Host "    - $($tool.name): $($tool.description)" -ForegroundColor Gray
        }
        Write-Host ""
    }

    Write-Host "Usage Examples:" -ForegroundColor Cyan
    Write-Host "  .\install.ps1 -Tier Essential" -ForegroundColor White
    Write-Host "  .\install.ps1 -Tier Essential,AI,Web" -ForegroundColor White
    Write-Host "  .\install.ps1 -All" -ForegroundColor White
    Write-Host ""
    exit 0
}

# Determine which tiers to install
$tiersToInstall = @()

if ($All) {
    $manifest.tiers.PSObject.Properties | ForEach-Object {
        $tiersToInstall += $_.Name
    }
    Write-Info "Installing ALL tiers"
} else {
    foreach ($t in $Tier) {
        $tierKey = $t.ToLower()
        $tierExists = $null -ne ($manifest.tiers.PSObject.Properties | Where-Object { $_.Name -eq $tierKey })

        if ($tierExists) {
            $tiersToInstall += $tierKey
        } else {
            Write-Warning "Unknown tier: $t (skipping)"
        }
    }
}

if ($tiersToInstall.Count -eq 0) {
    Write-Error "No valid tiers specified!"
    Write-Info "Use -List to see available tiers"
    exit 1
}

Write-Info "Selected tiers: $($tiersToInstall -join ', ')"
Write-Host ""

# Check prerequisites
Write-Header "Checking Prerequisites..."

$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    Write-Warning "Not running as Administrator"
    Write-Info "Some installations may require elevated privileges"

    if (-not $Quiet) {
        $response = Read-Host "Continue anyway? (Y/N)"
        if ($response -notmatch "^[Yy]") {
            exit 0
        }
    }
}

# Check if winget is available
try {
    $null = Get-Command winget -ErrorAction Stop
    Write-Success "Windows Package Manager (winget) found"
} catch {
    Write-Error "winget not found!"
    Write-Info "Please update Windows to the latest version"
    Write-Info "winget comes with Windows 10 1809 or later and Windows 11"
    exit 1
}

# Function to check if tool is installed
function Test-ToolInstalled {
    param($CheckCommand)

    try {
        $parts = $CheckCommand -split " "
        $cmd = $parts[0]
        $args = $parts[1..($parts.Length - 1)] -join " "

        if ($args) {
            $null = & $cmd $args.Split() 2>&1
        } else {
            $null = & $cmd 2>&1
        }

        return $LASTEXITCODE -eq 0 -or $LASTEXITCODE -eq $null
    } catch {
        return $false
    }
}

# Function to install a tool
function Install-Tool {
    param($Tool, $DryRun = $false, $Force = $false)

    $installCmd = $Tool.install.windows

    if (-not $installCmd) {
        Write-Warning "$($Tool.name): No Windows installation command"
        return $false
    }

    # Check if already installed
    $isInstalled = Test-ToolInstalled $Tool.check

    if ($isInstalled -and -not $Force) {
        Write-Success "$($Tool.name): Already installed (skipping)"
        return $true
    }

    if ($DryRun) {
        Write-Info "$($Tool.name): Would install with: $installCmd"
        return $true
    }

    Write-Info "$($Tool.name): Installing..."
    "$($Tool.name): $installCmd" | Out-File $LogFile -Append

    try {
        # Handle different command types
        if ($installCmd -like "winget*") {
            Invoke-Expression $installCmd 2>&1 | Out-File $LogFile -Append
        } elseif ($installCmd -like "pip*" -or $installCmd -like "npm*" -or $installCmd -like "cargo*") {
            Invoke-Expression $installCmd 2>&1 | Out-File $LogFile -Append
        } elseif ($installCmd -like "echo*") {
            $msg = $installCmd -replace "echo ", "" -replace "'", "" -replace "`"", ""
            Write-Info "  $msg"
            return $true
        } else {
            Invoke-Expression $installCmd 2>&1 | Out-File $LogFile -Append
        }

        if ($LASTEXITCODE -eq 0 -or $LASTEXITCODE -eq $null) {
            Write-Success "$($Tool.name): Installed successfully"
            return $true
        } else {
            Write-Warning "$($Tool.name): Installation returned code $LASTEXITCODE"
            return $false
        }
    } catch {
        Write-Error "$($Tool.name): Installation failed - $($_.Exception.Message)"
        $_.Exception.Message | Out-File $LogFile -Append
        return $false
    }
}

# Collect all tools to install
$allTools = @()
foreach ($tierKey in $tiersToInstall) {
    $tierProp = $manifest.tiers.PSObject.Properties | Where-Object { $_.Name -eq $tierKey } | Select-Object -First 1
    if ($tierProp) {
        $tierData = $tierProp.Value
        Write-Header "Tier: $($tierData.name)"
        Write-Info "$($tierData.description)"
        Write-Info "$($tierData.tools.Count) tools to process"
        Write-Host ""

        foreach ($tool in $tierData.tools) {
            $allTools += $tool
        }
    }
}

# Confirmation
if (-not $Quiet -and -not $DryRun) {
    Write-Header "Installation Summary"
    Write-Info "Total tools: $($allTools.Count)"
    Write-Info "Tiers: $($tiersToInstall -join ', ')"
    Write-Host ""

    $response = Read-Host "Proceed with installation? (Y/N)"
    if ($response -notmatch "^[Yy]") {
        Write-Warning "Installation cancelled"
        exit 0
    }
    Write-Host ""
}

# Install tools
$successCount = 0
$failCount = 0

Write-Header "Installing Tools..."
Write-Host ""

foreach ($tierKey in $tiersToInstall) {
    $tierProp = $manifest.tiers.PSObject.Properties | Where-Object { $_.Name -eq $tierKey } | Select-Object -First 1
    if ($tierProp) {
        $tierData = $tierProp.Value
        Write-Host "[$($tierData.name)]" -ForegroundColor Cyan

        foreach ($tool in $tierData.tools) {
            $result = Install-Tool -Tool $tool -DryRun:$DryRun -Force:$Force

            if ($result) {
                $successCount++
            } else {
                $failCount++
            }
        }

        Write-Host ""
    }
}

# Summary
Write-Header "Installation Complete!"
Write-Host ""

if ($DryRun) {
    Write-Info "Dry run completed - no tools were actually installed"
    Write-Info "Total tools checked: $($allTools.Count)"
} else {
    Write-Success "Successfully installed: $successCount tools"

    if ($failCount -gt 0) {
        Write-Warning "Failed installations: $failCount tools"
        Write-Info "Check $LogFile for details"
    }
}

Write-Host ""
Write-Info "Log file: $LogFile"
Write-Host ""

# Post-install instructions
Write-Header "Next Steps:"
Write-Host ""
Write-Info "1. Restart your terminal to refresh PATH"
Write-Info "2. Verify installations:"
Write-Host "     git --version" -ForegroundColor Gray
Write-Host "     docker --version" -ForegroundColor Gray
Write-Host "     python --version" -ForegroundColor Gray
Write-Host "     node --version" -ForegroundColor Gray
Write-Host ""
Write-Info "3. Configure your tools (API keys, auth, etc.)"
Write-Host ""

if ($failCount -gt 0) {
    Write-Warning "Some installations failed. You may need to:"
    Write-Info "- Run as Administrator"
    Write-Info "- Install manually from official websites"
    Write-Info "- Check $LogFile for error details"
    Write-Host ""
    exit 1
}

exit 0
