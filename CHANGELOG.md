# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2024-11-11

### Added
- Initial release of Universal Dev Stack Installer
- Cross-platform support for Windows, macOS, and Linux
- 10 installation tiers with 100+ tools
- PowerShell installer for Windows (`install.ps1`)
- Bash installer for macOS/Linux (`install.sh`)
- Auto-detect OS launcher (`quick-start.sh`)
- Smart tool detection (skip already-installed tools)
- Dry-run mode for previewing installations
- Force reinstall option
- Quiet mode for automation
- Comprehensive logging to `install.log`
- Tool manifest system via `tools.json`
- Complete documentation (README, EXAMPLES, CONTRIBUTING)

### Installation Tiers
- **Essential:** Git, Docker, Python, Node.js, Go, PostgreSQL, VS Code, jq
- **AI:** Ollama, LM Studio, Cursor, Aider, LangChain, LlamaIndex, OpenAI CLI, Anthropic SDK
- **Web:** Postman, Insomnia, Bruno, Vite, Playwright, Cypress, Turbo
- **Data:** MongoDB, DuckDB, Jupyter, pandas, DBeaver
- **Automation:** n8n, Make, Just, Apache Airflow, Prefect
- **DevOps:** Terraform, kubectl, Helm, K9s, AWS CLI, Google Cloud SDK, ngrok
- **Testing:** pytest, K6, Selenium
- **Security:** 1Password CLI, Vault, Trivy
- **Design:** Figma, FFmpeg, ImageMagick, Blender
- **GameDev:** Unity Hub, Godot, Blender

### Platform Support
- Windows 10 (1809+) / Windows 11 with winget
- macOS 10.15+ with Homebrew
- Ubuntu 20.04+, Debian 11+, Fedora 35+ with apt/dnf/yum

---

## [Unreleased]

### Planned Features
- Uninstall script
- Version locking for tools
- Config file support for team standardization
- Backup/restore of configurations
- Integration with Docker for containerized development
- Support for additional package managers (Chocolatey, Scoop, etc.)
- Web UI for tool selection
- CI/CD integration examples
- Tool version verification and updates
- Profile system (save/load custom tier combinations)

---

## Version History

### [1.0.0] - 2024-11-11
First stable release with core functionality and comprehensive tool coverage.

---

## How to Update

### Windows
```powershell
git pull origin main
.\install.ps1 -List
```

### macOS/Linux
```bash
git pull origin main
./install.sh --list
```

---

## Migration Guide

### From Manual Setup
If you've been installing tools manually, you can use this installer to:
1. Run with `-DryRun` to see what would be installed
2. Review the list of tools
3. Run without `-DryRun` to fill in any gaps

The installer skips already-installed tools automatically.

---

## Support

For issues, questions, or feature requests:
- **GitHub Issues:** https://github.com/silent-five-group/dev-stack-installer/issues
- **Discussions:** https://github.com/silent-five-group/dev-stack-installer/discussions
