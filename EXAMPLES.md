# Usage Examples

Real-world scenarios for using the Universal Dev Stack Installer.

---

## Basic Usage

### Install Essential Tools Only
Get started with the core development stack:

```powershell
# Windows
.\install.ps1 -Tier Essential

# macOS/Linux
./install.sh --tier essential
```

**Installs:** Git, GitHub CLI, Docker, VS Code, Python, Node.js, Go, PostgreSQL, jq

---

## Role-Based Setups

### 🚀 Full-Stack Web Developer

```powershell
# Windows
.\install.ps1 -Tier Essential,Web,Data,DevOps

# macOS/Linux
./install.sh --tier essential,web,data,devops
```

**Installs:**
- **Essential:** Git, Docker, VS Code, Python, Node.js, Go, PostgreSQL
- **Web:** Postman, Insomnia, Bruno, Vite, Playwright, Cypress, Turbo
- **Data:** MongoDB, DBeaver, Jupyter, pandas, DuckDB
- **DevOps:** Terraform, kubectl, Helm, K9s, AWS CLI, Google Cloud SDK, ngrok

---

### 🤖 AI/ML Engineer

```powershell
# Windows
.\install.ps1 -Tier Essential,AI,Data

# macOS/Linux
./install.sh --tier essential,ai,data
```

**Installs:**
- **Essential:** Core development tools
- **AI:** Ollama, LM Studio, Cursor, Aider, OpenAI CLI, Anthropic SDK, LangChain, LlamaIndex
- **Data:** MongoDB, Jupyter, pandas, NumPy, TensorFlow, PyTorch

**Use Cases:**
- Build LLM applications with LangChain
- Run local models with Ollama
- AI pair programming with Aider
- Train ML models with TensorFlow/PyTorch
- Analyze data in Jupyter notebooks

---

### ⚙️ DevOps Engineer

```powershell
# Windows
.\install.ps1 -Tier Essential,DevOps,Testing,Security

# macOS/Linux
./install.sh --tier essential,devops,testing,security
```

**Installs:**
- **Essential:** Core tools
- **DevOps:** Terraform, Pulumi, kubectl, Helm, K9s, AWS CLI, Azure CLI, Google Cloud SDK, ngrok
- **Testing:** pytest, K6, Selenium
- **Security:** 1Password CLI, Vault, Trivy

**Use Cases:**
- Infrastructure as code with Terraform
- Kubernetes cluster management
- Multi-cloud deployments
- Load testing with K6
- Vulnerability scanning with Trivy

---

### 🔄 Automation Specialist

```powershell
# Windows
.\install.ps1 -Tier Essential,Automation,Web

# macOS/Linux
./install.sh --tier essential,automation,web
```

**Installs:**
- **Essential:** Core development tools
- **Automation:** n8n, Make, Just, Apache Airflow, Prefect
- **Web:** API testing tools, Playwright, Selenium

**Use Cases:**
- Build workflows with n8n (self-hosted Zapier)
- Data pipelines with Apache Airflow
- Web scraping automation
- API integration workflows
- Task automation with Make/Just

---

### 🎨 Frontend Developer

```powershell
# Windows
.\install.ps1 -Tier Essential,Web,Design

# macOS/Linux
./install.sh --tier essential,web,design
```

**Installs:**
- **Essential:** Core tools
- **Web:** Postman, Vite, Playwright, Cypress, Turbo
- **Design:** Figma, FFmpeg, ImageMagick

**Use Cases:**
- Modern React/Vue/Svelte development
- Component testing with Storybook
- E2E testing with Playwright/Cypress
- Design collaboration with Figma
- Image optimization with ImageMagick

---

### 📊 Data Engineer

```powershell
# Windows
.\install.ps1 -Tier Essential,Data,Automation

# macOS/Linux
./install.sh --tier essential,data,automation
```

**Installs:**
- **Essential:** Core tools
- **Data:** PostgreSQL, MongoDB, DuckDB, DBeaver, Jupyter, pandas
- **Automation:** Airflow, Prefect, n8n

**Use Cases:**
- ETL pipelines with Apache Airflow
- Data analysis with pandas/Jupyter
- Database management with DBeaver
- Real-time data processing
- Analytics workflows

---

## Advanced Usage

### Install Everything

```powershell
# Windows
.\install.ps1 -All

# macOS/Linux
./install.sh --all
```

Installs all 100+ tools across all tiers. Perfect for a "kitchen sink" setup.

---

### Dry Run (Preview)

See what would be installed without actually installing:

```powershell
# Windows
.\install.ps1 -Tier Essential,AI -DryRun

# macOS/Linux
./install.sh --tier essential,ai --dry-run
```

---

### Force Reinstall

Reinstall even if tools are already present:

```powershell
# Windows
.\install.ps1 -Tier Essential -Force

# macOS/Linux
./install.sh --tier essential --force
```

---

### Quiet Mode (No Prompts)

Useful for automated setups or CI/CD:

```powershell
# Windows
.\install.ps1 -Tier Essential -Quiet

# macOS/Linux
./install.sh --tier essential --quiet
```

---

## Project-Specific Setups

### New Web App Project

```bash
# Install tools
./install.sh --tier essential,web

# Start building
mkdir my-web-app && cd my-web-app
npm create vite@latest
docker-compose up
```

---

### Newsletter Acquisition Platform (Your Project!)

```powershell
# Install dependencies
.\install.ps1 -Tier Essential,Web,Data

# Clone and run
git clone https://github.com/silent-five-group/newsletter-acquisition-platform.git
cd newsletter-acquisition-platform
.\run.ps1
```

---

### AI Chatbot Project

```bash
# Install AI tools
./install.sh --tier essential,ai

# Create project
mkdir ai-chatbot && cd ai-chatbot
pip install langchain openai anthropic
ollama pull llama2

# Start coding
code .
```

---

## Selective Installation

### Just Database Tools

```powershell
# Edit tools.json to create custom tier, or install individually
pip install jupyter pandas numpy
brew install postgresql mongodb duckdb  # macOS
```

### Just Cloud CLIs

```powershell
# Windows
winget install --id Amazon.AWSCLI
winget install --id Google.CloudSDK
winget install --id Microsoft.AzureCLI

# macOS
brew install awscli google-cloud-sdk azure-cli
```

---

## Troubleshooting Examples

### Check What's Already Installed

```powershell
# Windows
.\install.ps1 -List

# Then compare with:
git --version
docker --version
python --version
node --version
```

### Reinstall Failed Tools

```powershell
# Check the log
cat install.log

# Force reinstall specific tier
.\install.ps1 -Tier AI -Force
```

---

## Integration with Existing Projects

### Add to Repository

Copy the installer to your project:

```bash
# In your project root
cp -r /path/to/dev-stack-installer ./scripts/setup

# Update README.md
echo "## Setup" >> README.md
echo "./scripts/setup/install.sh --tier essential,web" >> README.md
```

### CI/CD Integration

```yaml
# .github/workflows/setup.yml
name: Setup Development Environment

on: [push]

jobs:
  setup:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Install dev tools
        run: |
          cd scripts/setup
          ./install.sh --tier essential --quiet
```

---

## Customization Examples

### Add Your Own Tools

Edit `tools.json`:

```json
{
  "id": "my-custom-tool",
  "name": "My Tool",
  "description": "Custom tool for my team",
  "check": "mytool --version",
  "install": {
    "windows": "winget install --id MyCompany.MyTool",
    "macos": "brew install mytool",
    "linux": "sudo apt-get install mytool"
  }
}
```

### Create Custom Tier

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

## Quick Reference

| Command | Description |
|---------|-------------|
| `--tier essential` | Core dev tools |
| `--tier essential,ai,web` | Multiple tiers |
| `--all` | Install everything |
| `--list` | Show available tools |
| `--dry-run` | Preview without installing |
| `--force` | Reinstall everything |
| `--quiet` | No prompts |

---

## Platform-Specific Notes

### Windows (PowerShell)

```powershell
# Check PowerShell version
$PSVersionTable.PSVersion

# Run as Administrator if needed
Start-Process powershell -Verb runAs
```

### macOS

```bash
# Install Xcode Command Line Tools first
xcode-select --install

# Update Homebrew
brew update
```

### Linux

```bash
# Update package lists
sudo apt-get update  # Ubuntu/Debian
sudo dnf check-update  # Fedora

# Ensure you have sudo access
sudo -v
```

---

## Next Steps

After installation, check out:
- [README.md](README.md) - Full documentation
- [tools.json](tools.json) - Tool definitions
- Project logs: `install.log`

---

**Happy Building!** 🚀
