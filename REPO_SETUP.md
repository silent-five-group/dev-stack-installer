# Repository Setup Instructions

Run these commands after creating the `dev-stack-installer` repository under `silent-five-group`:

## Step 1: Create the Repository

1. Go to https://github.com/organizations/silent-five-group/repositories/new
2. Repository name: `dev-stack-installer`
3. Description: `Cross-platform development environment installer - Automate installation of 100+ dev tools`
4. Visibility: **Public** (so others can benefit)
5. **DO NOT** initialize with README, .gitignore, or license (we already have them)
6. Click "Create repository"

## Step 2: Add Collaborator

1. Go to Settings → Collaborators
2. Add `jeremiahchronister` with **Write** access
3. Accept the invitation

## Step 3: Initialize Git and Push

```powershell
# Navigate to the directory
cd C:\Users\jchro\dev-stack-installer

# Initialize git
git init

# Configure git (if not already done)
git config user.name "Jeremiah Chronister"
git config user.email "jeremiahchronister@gmail.com"

# Add all files
git add .

# Create initial commit
git commit -m "$(cat <<'EOF'
Initial release: Universal Dev Stack Installer v1.0.0

Complete cross-platform development environment installer supporting
Windows, macOS, and Linux.

Features:
- 100+ tools across 10 specialized tiers
- Smart detection (skip already-installed tools)
- Dry-run mode for previewing
- Comprehensive logging
- Fully customizable via tools.json

Installation Tiers:
- Essential: Git, Docker, Python, Node.js, Go, PostgreSQL, VS Code
- AI: Ollama, LM Studio, LangChain, LlamaIndex, OpenAI, Anthropic
- Web: Postman, Vite, Playwright, Cypress, Turbo
- Data: MongoDB, Jupyter, pandas, DuckDB, DBeaver
- Automation: n8n, Airflow, Prefect, Make, Selenium
- DevOps: Terraform, kubectl, Helm, K9s, AWS CLI, ngrok
- Testing: pytest, K6, Selenium
- Security: Vault, Trivy, 1Password CLI
- Design: Figma, FFmpeg, ImageMagick, Blender
- GameDev: Unity, Godot, Blender

Documentation:
- Complete README with badges and examples
- Detailed EXAMPLES.md with use cases
- CONTRIBUTING.md guidelines
- QUICK_START.md for rapid onboarding
- CHANGELOG.md for version tracking
- GitHub issue and PR templates

Platform Support:
- Windows 10/11 with winget
- macOS 10.15+ with Homebrew
- Ubuntu/Debian/Fedora with apt/dnf/yum

🤖 Generated with Claude Code (https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>
EOF
)"

# Add remote
git remote add origin https://github.com/silent-five-group/dev-stack-installer.git

# Push to GitHub
git branch -M main
git push -u origin main
```

## Step 4: Configure Repository Settings

### Enable Discussions
1. Go to Settings → General
2. Scroll to "Features"
3. Check "Discussions"

### Add Topics
1. Go to main repository page
2. Click the gear icon next to "About"
3. Add topics: `developer-tools`, `installer`, `automation`, `windows`, `macos`, `linux`, `winget`, `homebrew`, `powershell`, `bash`
4. Update description: `Cross-platform development environment installer - Automate installation of 100+ dev tools`
5. Add website: `https://github.com/silent-five-group/dev-stack-installer`

### Protect Main Branch (Optional)
1. Go to Settings → Branches
2. Add rule for `main`
3. Enable:
   - Require pull request reviews before merging
   - Require status checks to pass
   - Include administrators (optional)

## Step 5: Create Initial Release

1. Go to Releases → Draft a new release
2. Tag: `v1.0.0`
3. Title: `v1.0.0 - Initial Release`
4. Description:
   ```markdown
   # Universal Dev Stack Installer v1.0.0

   First stable release! 🎉

   ## What's New
   - Cross-platform installer for Windows, macOS, and Linux
   - 100+ development tools across 10 specialized tiers
   - Smart detection and skipping of already-installed tools
   - Dry-run mode for previewing installations
   - Comprehensive logging and error handling

   ## Installation

   **Windows (PowerShell):**
   ```powershell
   git clone https://github.com/silent-five-group/dev-stack-installer.git
   cd dev-stack-installer
   .\install.ps1
   ```

   **macOS/Linux (Bash):**
   ```bash
   git clone https://github.com/silent-five-group/dev-stack-installer.git
   cd dev-stack-installer
   chmod +x install.sh
   ./install.sh
   ```

   ## Quick Links
   - [Documentation](README.md)
   - [Examples](EXAMPLES.md)
   - [Quick Start](QUICK_START.md)
   - [Contributing](CONTRIBUTING.md)

   ## Supported Platforms
   - ✅ Windows 10/11 (winget)
   - ✅ macOS 10.15+ (Homebrew)
   - ✅ Ubuntu 20.04+, Debian 11+, Fedora 35+ (apt/dnf/yum)

   ## Available Tiers
   Essential • AI • Web • Data • Automation • DevOps • Testing • Security • Design • GameDev

   See the [README](README.md) for complete list of tools in each tier.
   ```
5. Click "Publish release"

## Step 6: Update README Badges (After First Release)

The badges in README.md will work automatically once the repo is public and has a release.

## Done! 🎉

Your repository is now fully set up and ready for contributions!

### Next Steps:
- Share the repo with your team
- Tweet about it / share on social media
- Consider submitting to awesome lists
- Monitor issues and discussions
- Accept contributions via PRs

### Maintenance:
- Update tools.json as new tools become available
- Keep installation commands up to date
- Review and merge PRs
- Release new versions with changelog updates
