# Quick Start Guide

Get up and running with Universal Dev Stack Installer in 60 seconds.

---

## 🚀 Installation

### Step 1: Get the Code

```bash
# Clone the repository
git clone https://github.com/silent-five-group/dev-stack-installer.git
cd dev-stack-installer
```

### Step 2: Run the Installer

**Windows (PowerShell):**
```powershell
.\install.ps1
```

**macOS/Linux (Bash):**
```bash
chmod +x install.sh
./install.sh
```

That's it! The **Essential** tier will be installed (Git, Docker, Python, Node.js, VS Code, PostgreSQL, etc.).

---

## 📋 Common Commands

### See What's Available
```powershell
# Windows
.\install.ps1 -List

# macOS/Linux
./install.sh --list
```

### Preview Before Installing
```powershell
# Windows
.\install.ps1 -Tier Essential -DryRun

# macOS/Linux
./install.sh --tier essential --dry-run
```

### Install Multiple Tiers
```powershell
# Windows
.\install.ps1 -Tier Essential,AI,Web

# macOS/Linux
./install.sh --tier essential,ai,web
```

### Install Everything
```powershell
# Windows
.\install.ps1 -All

# macOS/Linux
./install.sh --all
```

---

## 🎯 Popular Setups

### Full-Stack Developer
```powershell
.\install.ps1 -Tier Essential,Web,Data,DevOps
```
Installs: Git, Docker, Python, Node.js, Postman, MongoDB, PostgreSQL, Terraform, kubectl

### AI/ML Engineer
```powershell
.\install.ps1 -Tier Essential,AI,Data
```
Installs: Python, Ollama, LangChain, Jupyter, pandas, TensorFlow, PyTorch

### DevOps Engineer
```powershell
.\install.ps1 -Tier Essential,DevOps,Testing,Security
```
Installs: Docker, Terraform, kubectl, Helm, AWS CLI, pytest, K6, Vault

---

## 💡 Pro Tips

### Already Have Some Tools?
The installer automatically skips tools that are already installed.

### Want to Reinstall?
```powershell
.\install.ps1 -Tier Essential -Force
```

### Need No Prompts? (CI/CD)
```powershell
.\install.ps1 -Tier Essential -Quiet
```

### Check Installation Logs
```bash
cat install.log
```

---

## 🆘 Troubleshooting

### Windows: "winget not found"
Update Windows to the latest version. Winget is built-in.

### Windows: "Installation failed"
Some tools need Administrator privileges:
```powershell
# Run as Administrator
Start-Process powershell -Verb runAs
```

### macOS: "Homebrew not found"
The installer will offer to install it automatically.

### Linux: "Permission denied"
```bash
sudo ./install.sh --tier essential
```

---

## 📚 Learn More

- **Detailed Examples:** [EXAMPLES.md](EXAMPLES.md)
- **Full Documentation:** [README.md](README.md)
- **Contributing:** [CONTRIBUTING.md](CONTRIBUTING.md)
- **Issues/Support:** [GitHub Issues](https://github.com/silent-five-group/dev-stack-installer/issues)

---

## ⭐ What's Next?

After installation:

1. **Verify installations:**
   ```bash
   git --version
   docker --version
   python --version
   node --version
   ```

2. **Configure tools:**
   - Set up Git: `git config --global user.name "Your Name"`
   - Add API keys for AI tools (OpenAI, Anthropic)
   - Connect to cloud providers (AWS, GCP, Azure)

3. **Start building!** 🚀

---

<div align="center">

**Questions?** Open an [issue](https://github.com/silent-five-group/dev-stack-installer/issues) or [discussion](https://github.com/silent-five-group/dev-stack-installer/discussions)

Made with ❤️ by [Silent Five Group](https://github.com/silent-five-group)

</div>
