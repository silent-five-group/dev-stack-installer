#!/usr/bin/env bash

# Universal Dev Stack Installer - macOS/Linux
# Cross-platform development environment setup

set -e

# Default values
TIERS=()
INSTALL_ALL=false
LIST_ONLY=false
DRY_RUN=false
FORCE=false
QUIET=false
LOG_FILE="install.log"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
GRAY='\033[0;37m'
NC='\033[0m' # No Color

# Helper functions
header() { echo -e "\n${CYAN}$1${NC}"; }
success() { echo -e "  ${GREEN}✓${NC} $1"; }
warning() { echo -e "  ${YELLOW}⚠${NC} $1"; }
error() { echo -e "  ${RED}✗${NC} $1"; }
info() { echo -e "  ${GRAY}→${NC} $1"; }

# Banner
echo ""
echo -e "${CYAN}╔════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║   Universal Dev Stack Installer - Unix        ║${NC}"
echo -e "${CYAN}║   Cross-Platform Development Environment      ║${NC}"
echo -e "${CYAN}╚════════════════════════════════════════════════╝${NC}"
echo ""

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --tier)
            IFS=',' read -ra TIERS <<< "$2"
            shift 2
            ;;
        --all)
            INSTALL_ALL=true
            shift
            ;;
        --list)
            LIST_ONLY=true
            shift
            ;;
        --dry-run)
            DRY_RUN=true
            shift
            ;;
        --force)
            FORCE=true
            shift
            ;;
        --quiet)
            QUIET=true
            shift
            ;;
        -h|--help)
            echo "Usage: $0 [OPTIONS]"
            echo ""
            echo "Options:"
            echo "  --tier TIER[,TIER...]  Install specific tiers (comma-separated)"
            echo "  --all                  Install all tiers"
            echo "  --list                 List available tiers and tools"
            echo "  --dry-run              Show what would be installed"
            echo "  --force                Force reinstall even if already installed"
            echo "  --quiet                No prompts"
            echo "  -h, --help             Show this help"
            echo ""
            echo "Examples:"
            echo "  $0 --tier essential"
            echo "  $0 --tier essential,ai,web"
            echo "  $0 --all"
            exit 0
            ;;
        *)
            error "Unknown option: $1"
            exit 1
            ;;
    esac
done

# Initialize log
echo "=== Dev Stack Installer Log - $(date) ===" > "$LOG_FILE"

# Detect OS
OS="unknown"
if [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="linux"
else
    error "Unsupported OS: $OSTYPE"
    exit 1
fi

info "Detected OS: $OS"

# Check if jq is available, if not try to install it
if ! command -v jq &> /dev/null; then
    warning "jq not found, attempting to install..."
    if [[ "$OS" == "macos" ]]; then
        brew install jq || error "Failed to install jq"
    elif [[ "$OS" == "linux" ]]; then
        sudo apt-get install -y jq || sudo dnf install -y jq || sudo yum install -y jq || error "Failed to install jq"
    fi
fi

# Load tools manifest
if [[ ! -f "tools.json" ]]; then
    error "tools.json not found! Make sure you're running this from the installer directory."
    exit 1
fi

# List tiers and tools
if $LIST_ONLY; then
    header "Available Installation Tiers:"
    echo ""

    # Parse and display tiers
    jq -r '.tiers | to_entries[] | "\(.key)|\(.value.name)|\(.value.description)|\(.value.tools | length)"' tools.json | while IFS='|' read -r key name desc count; do
        echo -e "  ${YELLOW}${name}${NC}"
        echo -e "  ${GRAY}${desc}${NC}"
        echo -e "  ${CYAN}Tools ($count):${NC}"

        jq -r ".tiers.$key.tools[] | \"    - \(.name): \(.description)\"" tools.json | while read -r line; do
            echo -e "  ${GRAY}${line}${NC}"
        done
        echo ""
    done

    echo -e "${CYAN}Usage Examples:${NC}"
    echo "  $0 --tier essential"
    echo "  $0 --tier essential,ai,web"
    echo "  $0 --all"
    echo ""
    exit 0
fi

# Determine which tiers to install
TIERS_TO_INSTALL=()

if $INSTALL_ALL; then
    mapfile -t TIERS_TO_INSTALL < <(jq -r '.tiers | keys[]' tools.json)
    info "Installing ALL tiers"
else
    if [[ ${#TIERS[@]} -eq 0 ]]; then
        TIERS=("essential")
    fi

    for tier in "${TIERS[@]}"; do
        tier_lower=$(echo "$tier" | tr '[:upper:]' '[:lower:]')
        if jq -e ".tiers.$tier_lower" tools.json > /dev/null 2>&1; then
            TIERS_TO_INSTALL+=("$tier_lower")
        else
            warning "Unknown tier: $tier (skipping)"
        fi
    done
fi

if [[ ${#TIERS_TO_INSTALL[@]} -eq 0 ]]; then
    error "No valid tiers specified!"
    info "Use --list to see available tiers"
    exit 1
fi

info "Selected tiers: ${TIERS_TO_INSTALL[*]}"
echo ""

# Check prerequisites
header "Checking Prerequisites..."

# Check for Homebrew on macOS
if [[ "$OS" == "macos" ]]; then
    if ! command -v brew &> /dev/null; then
        warning "Homebrew not found"
        if ! $QUIET; then
            read -p "Install Homebrew? (y/n) " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
                success "Homebrew installed"
            else
                error "Homebrew is required for macOS installations"
                exit 1
            fi
        fi
    else
        success "Homebrew found"
    fi
fi

# Check for package manager on Linux
if [[ "$OS" == "linux" ]]; then
    if command -v apt-get &> /dev/null; then
        PKG_MANAGER="apt-get"
        success "Package manager: apt-get"
    elif command -v dnf &> /dev/null; then
        PKG_MANAGER="dnf"
        success "Package manager: dnf"
    elif command -v yum &> /dev/null; then
        PKG_MANAGER="yum"
        success "Package manager: yum"
    else
        error "No supported package manager found (apt-get, dnf, or yum)"
        exit 1
    fi
fi

# Function to check if tool is installed
check_tool_installed() {
    local check_cmd="$1"

    # Handle different check commands
    if [[ "$check_cmd" == *"echo"* ]]; then
        return 1  # Always install if it's just an echo
    fi

    eval "$check_cmd" &> /dev/null
    return $?
}

# Function to install a tool
install_tool() {
    local tool_name="$1"
    local tool_desc="$2"
    local check_cmd="$3"
    local install_cmd="$4"

    if [[ -z "$install_cmd" || "$install_cmd" == "null" ]]; then
        warning "$tool_name: No $OS installation command"
        return 1
    fi

    # Check if already installed
    if ! $FORCE && check_tool_installed "$check_cmd"; then
        success "$tool_name: Already installed (skipping)"
        return 0
    fi

    if $DRY_RUN; then
        info "$tool_name: Would install with: $install_cmd"
        return 0
    fi

    info "$tool_name: Installing..."
    echo "$tool_name: $install_cmd" >> "$LOG_FILE"

    # Handle different command types
    if [[ "$install_cmd" == *"echo"* ]]; then
        local msg=$(echo "$install_cmd" | sed "s/echo '\(.*\)'/\1/" | sed 's/echo "\(.*\)"/\1/')
        info "  $msg"
        return 0
    fi

    # Execute installation command
    if eval "$install_cmd" >> "$LOG_FILE" 2>&1; then
        success "$tool_name: Installed successfully"
        return 0
    else
        error "$tool_name: Installation failed (exit code: $?)"
        return 1
    fi
}

# Collect all tools to install
TOTAL_TOOLS=0
for tier in "${TIERS_TO_INSTALL[@]}"; do
    tier_name=$(jq -r ".tiers.$tier.name" tools.json)
    tier_desc=$(jq -r ".tiers.$tier.description" tools.json)
    tool_count=$(jq -r ".tiers.$tier.tools | length" tools.json)

    header "Tier: $tier_name"
    info "$tier_desc"
    info "$tool_count tools to process"
    echo ""

    TOTAL_TOOLS=$((TOTAL_TOOLS + tool_count))
done

# Confirmation
if ! $QUIET && ! $DRY_RUN; then
    header "Installation Summary"
    info "Total tools: $TOTAL_TOOLS"
    info "Tiers: ${TIERS_TO_INSTALL[*]}"
    echo ""

    read -p "Proceed with installation? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        warning "Installation cancelled"
        exit 0
    fi
    echo ""
fi

# Install tools
SUCCESS_COUNT=0
FAIL_COUNT=0

header "Installing Tools..."
echo ""

for tier in "${TIERS_TO_INSTALL[@]}"; do
    tier_name=$(jq -r ".tiers.$tier.name" tools.json)
    echo -e "${CYAN}[$tier_name]${NC}"

    tool_count=$(jq -r ".tiers.$tier.tools | length" tools.json)

    for ((i=0; i<tool_count; i++)); do
        tool_name=$(jq -r ".tiers.$tier.tools[$i].name" tools.json)
        tool_desc=$(jq -r ".tiers.$tier.tools[$i].description" tools.json)
        check_cmd=$(jq -r ".tiers.$tier.tools[$i].check" tools.json)
        install_cmd=$(jq -r ".tiers.$tier.tools[$i].install.$OS" tools.json)

        if install_tool "$tool_name" "$tool_desc" "$check_cmd" "$install_cmd"; then
            ((SUCCESS_COUNT++))
        else
            ((FAIL_COUNT++))
        fi
    done

    echo ""
done

# Summary
header "Installation Complete!"
echo ""

if $DRY_RUN; then
    info "Dry run completed - no tools were actually installed"
    info "Total tools checked: $TOTAL_TOOLS"
else
    success "Successfully installed: $SUCCESS_COUNT tools"

    if [[ $FAIL_COUNT -gt 0 ]]; then
        warning "Failed installations: $FAIL_COUNT tools"
        info "Check $LOG_FILE for details"
    fi
fi

echo ""
info "Log file: $LOG_FILE"
echo ""

# Post-install instructions
header "Next Steps:"
echo ""
info "1. Restart your terminal to refresh PATH"
info "2. Verify installations:"
echo "     git --version"
echo "     docker --version"
echo "     python --version || python3 --version"
echo "     node --version"
echo ""
info "3. Configure your tools (API keys, auth, etc.)"
echo ""

if [[ $FAIL_COUNT -gt 0 ]]; then
    warning "Some installations failed. You may need to:"
    info "- Run with sudo"
    info "- Install manually from official websites"
    info "- Check $LOG_FILE for error details"
    echo ""
    exit 1
fi

exit 0
