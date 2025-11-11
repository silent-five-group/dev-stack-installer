# Universal Dev Stack Installer

<div align="center">

**Cross-platform development environment setup made easy.**

Automate installation of 100+ development tools across Windows, macOS, and Linux.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Platform](https://img.shields.io/badge/platform-Windows%20%7C%20macOS%20%7C%20Linux-blue)]()
[![PowerShell](https://img.shields.io/badge/PowerShell-5.1%2B-blue)]()
[![Bash](https://img.shields.io/badge/Bash-4.0%2B-green)]()

[Quick Start](#quick-start) • [Documentation](#installation-tiers) • [Examples](EXAMPLES.md) • [Contributing](CONTRIBUTING.md)

</div>

---

## Overview

The Universal Dev Stack Installer automates the tedious process of setting up development environments. Install everything you need to build web apps, APIs, AI tools, automation workflows, and more with a single command.

**Features:**
- 🚀 **100+ tools** across 10 specialized tiers
- 🔄 **Cross-platform** - Works on Windows, macOS, and Linux
- 🎯 **Smart detection** - Skips already-installed tools
- 📦 **Tier-based** - Install exactly what you need
- 🔍 **Dry-run mode** - Preview before installing
- 📝 **Detailed logging** - Track what was installed
- ⚙️ **Customizable** - Add your own tools via JSON

---

## Quick Start

### One-Line Install (Any OS)

**Windows (PowerShell):**
```powershell
.\install.ps1
```

**macOS/Linux (Bash):**
```bash
chmod +x install.sh
./install.sh
```

By default, this installs the **Essential** tier (Git, Docker, Python, Node.js, VS Code, PostgreSQL, etc.).

---

## Installation Tiers

Choose what to install based on your needs:

### 🎯 **Essential** (Recommended for Everyone)
Core development tools:
- Git, GitHub CLI
- Docker Desktop
- VS Code
- Python 3.12+, Node.js, Go
- PostgreSQL
- jq, curl, wget

### 🤖 **AI** (AI Development & Coding Assistants)
AI tools and LLM frameworks:
- Ollama (local LLMs)
- LM Studio
- OpenAI CLI, Anthropic API
- LangChain, LlamaIndex
- Aider (AI pair programming)
- Cursor IDE

### 🌐 **Web** (Web & API Development)
Frontend, backend, and API tools:
- Postman, Insomnia, Bruno
- Vite, Webpack, Turbo
- Playwright, Cypress
- Tailwind CSS

### 📊 **Data** (Data Engineering & ML)
Databases and data science:
- MongoDB, Redis, ElasticSearch
- MySQL, DuckDB
- Jupyter, pandas, NumPy
- TensorFlow, PyTorch
- DBeaver

### 🔄 **Automation** (Workflow & Process Automation)
Integration and orchestration:
- n8n (self-hosted Zapier)
- Zapier CLI
- Apache Airflow, Prefect
- Selenium, Puppeteer
- Make, Task, Just

### ⚙️ **DevOps** (Infrastructure & Deployment)
Cloud and infrastructure tools:
- Terraform, Pulumi
- Kubernetes (kubectl, Helm, K9s)
- AWS CLI, Azure CLI, Google Cloud SDK
- Ansible, Vagrant
- Ngrok, Cloudflared

### 🧪 **Testing** (QA & Performance Testing)
Testing frameworks:
- Pytest, Jest, Mocha
- K6, JMeter, Artillery
- Selenium, Playwright

### 🔒 **Security** (Security & Secrets Management)
Security tools:
- 1Password CLI, Bitwarden CLI
- HashiCorp Vault
- OWASP ZAP
- Trivy (vulnerability scanner)

### 🎨 **Design** (UI/UX & Media)
Design and media tools:
- Figma
- FFmpeg, ImageMagick
- Blender, OBS Studio

### 🎮 **GameDev** (Game Development)
Game engines:
- Unity Hub
- Godot
- Unreal Engine (manual)

---

## Usage

### Install Everything
```powershell
# Windows
.\install.ps1 -Tier All

# macOS/Linux
./install.sh --tier all
```

### Install Specific Tiers
```powershell
# Windows
.\install.ps1 -Tier Essential,AI,Web

# macOS/Linux
./install.sh --tier essential,ai,web
```

### List Available Tools
```powershell
# Windows
.\install.ps1 -List

# macOS/Linux
./install.sh --list
```

### Dry Run (Preview Without Installing)
```powershell
# Windows
.\install.ps1 -Tier Essential -DryRun

# macOS/Linux
./install.sh --tier essential --dry-run
```

### Force Reinstall
```powershell
# Windows
.\install.ps1 -Tier Essential -Force

# macOS/Linux
./install.sh --tier essential --force
```

### Quiet Mode (No Prompts)
```powershell
# Windows
.\install.ps1 -Tier Essential -Quiet

# macOS/Linux
./install.sh --tier essential --quiet
```

---

## Prerequisites

### Windows
- Windows 10 (1809+) or Windows 11
- PowerShell 5.1+
- Windows Package Manager (winget) - comes with Windows
- Administrator access (for some tools)

### macOS
- macOS 10.15 (Catalina) or later
- Homebrew (installs automatically if missing)
- Command Line Tools (installs automatically if missing)

### Linux
- Ubuntu 20.04+, Debian 11+, Fedora 35+, or similar
- apt, dnf, or yum package manager
- sudo access

---

## How It Works

All tools are installed using official package managers:

| OS | Package Manager | Tools Location |
|----|----------------|----------------|
| **Windows** | winget, npm, pip | Standard Windows paths |
| **macOS** | Homebrew, npm, pip | `/usr/local/bin`, `/opt/homebrew` |
| **Linux** | apt/dnf/yum, npm, pip | `/usr/local/bin`, `/usr/bin` |

### Language-Specific Packages
- **Python packages:** Installed globally via pip
- **Node.js packages:** Installed globally via npm
- **Rust packages:** Installed via cargo
- **Go packages:** Installed via go install

The installer:
1. ✅ Checks if each tool is already installed
2. ⏭️ Skips tools that are present (unless `-Force` is used)
3. 📦 Installs missing tools using OS-appropriate package manager
4. 📝 Logs all operations to `install.log`
5. ✨ Reports success/failure for each tool

---

## Examples

See [EXAMPLES.md](EXAMPLES.md) for detailed use cases.

### Full-Stack Web Developer Setup
```powershell
.\install.ps1 -Tier Essential,Web,Data,DevOps
```
**Installs:** Git, Docker, VS Code, Python, Node.js, Postman, Vite, MongoDB, PostgreSQL, Terraform, kubectl

### AI/ML Engineer Setup
```powershell
.\install.ps1 -Tier Essential,AI,Data
```
**Installs:** Python, Node.js, Ollama, LM Studio, LangChain, Jupyter, pandas, TensorFlow, PyTorch

### DevOps Engineer Setup
```powershell
.\install.ps1 -Tier Essential,DevOps,Testing,Security
```
**Installs:** Git, Docker, Terraform, kubectl, Helm, K9s, AWS CLI, pytest, K6, Vault, Trivy

### Automation Specialist Setup
```powershell
.\install.ps1 -Tier Essential,Automation,Web
```
**Installs:** Python, Node.js, n8n, Airflow, Prefect, Selenium, Playwright, Make

---

## Customization

### Adding Your Own Tools

Edit `tools.json` to add custom tools:

```json
{
  "id": "my-tool",
  "name": "My Tool",
  "description": "Description of my tool",
  "check": "mytool --version",
  "install": {
    "windows": "winget install --id MyCompany.MyTool",
    "macos": "brew install mytool",
    "linux": "sudo apt-get install -y mytool"
  }
}
```

### Creating Custom Tiers

Add a new tier to `tools.json`:

```json
{
  "tiers": {
    "mycompany": {
      "name": "My Company Stack",
      "description": "Custom tools for our team",
      "tools": [...]
    }
  }
}
```

Then install:
```bash
./install.sh --tier mycompany
```

---

## Troubleshooting

### Windows: "winget not found"
Update Windows to the latest version. Winget comes with Windows 10 (1809+) and Windows 11.

### Windows: "Installation returned code -1978335212"
Some tools require Administrator privileges. Run PowerShell as Administrator.

### macOS: "Homebrew not found"
The installer will prompt to install Homebrew automatically. Accept the prompt.

### Linux: "Permission denied"
Run with sudo:
```bash
sudo ./install.sh --tier essential
```

### Tool installation failed
Check the log file for details:
```bash
cat install.log
```

Common issues:
- **Network timeout:** Retry the installation
- **Package not found:** The package ID may have changed, update `tools.json`
- **Permission denied:** Run as Administrator/sudo
- **Already installed:** Use `-Force` to reinstall

---

## Project Structure

```
dev-stack-installer/
├── install.ps1              # Windows PowerShell installer
├── install.sh               # macOS/Linux bash installer
├── quick-start.sh           # Auto-detect OS and run appropriate installer
├── tools.json               # Tool manifest (100+ tools defined here)
├── README.md                # This file
├── EXAMPLES.md              # Detailed usage examples
├── CONTRIBUTING.md          # Contribution guidelines
├── LICENSE                  # MIT License
├── .gitignore               # Git exclusions
└── install.log              # Installation log (generated)
```

---

## Contributing

We welcome contributions! See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

**Ways to contribute:**
- 🔧 Add new tools to `tools.json`
- 🐛 Report bugs or issues
- 📝 Improve documentation
- ✨ Suggest new features
- 🧪 Test on different platforms

---

## License

MIT License - See [LICENSE](LICENSE) for details.

Use freely for personal or commercial projects.

---

## Acknowledgments

Built with [Claude Code](https://claude.com/claude-code) 🤖

Inspired by the need to streamline development environment setup across teams and projects.

---

## Support

- **Issues:** [GitHub Issues](https://github.com/silent-five-group/dev-stack-installer/issues)
- **Discussions:** [GitHub Discussions](https://github.com/silent-five-group/dev-stack-installer/discussions)
- **Documentation:** [Full Docs](https://github.com/silent-five-group/dev-stack-installer)

---

<div align="center">

**Made with ❤️ by Silent Five Group**

⭐ Star this repo if you find it useful!

</div>
