# Contributing to Universal Dev Stack Installer

Thank you for your interest in contributing! This document provides guidelines and instructions for contributing to the project.

---

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How Can I Contribute?](#how-can-i-contribute)
- [Getting Started](#getting-started)
- [Development Workflow](#development-workflow)
- [Adding New Tools](#adding-new-tools)
- [Testing](#testing)
- [Pull Request Process](#pull-request-process)
- [Style Guidelines](#style-guidelines)

---

## Code of Conduct

This project follows a simple code of conduct:
- Be respectful and inclusive
- Provide constructive feedback
- Focus on what is best for the community
- Show empathy towards other contributors

---

## How Can I Contribute?

### 🔧 Add New Tools
Add tools to `tools.json` with proper installation commands for all platforms.

### 🐛 Report Bugs
Submit detailed bug reports with:
- OS and version
- Steps to reproduce
- Expected vs actual behavior
- Error messages or logs

### 📝 Improve Documentation
- Fix typos or unclear instructions
- Add examples or use cases
- Translate documentation
- Create video tutorials

### ✨ Suggest Features
Open an issue describing:
- The problem you're trying to solve
- Your proposed solution
- Alternative approaches considered

### 🧪 Test on Different Platforms
Test the installer on different:
- Operating systems (Windows, macOS, Linux distros)
- Shell environments
- Package manager versions

---

## Getting Started

### 1. Fork the Repository

Click the "Fork" button at the top right of the repository page.

### 2. Clone Your Fork

```bash
git clone https://github.com/YOUR_USERNAME/dev-stack-installer.git
cd dev-stack-installer
```

### 3. Add Upstream Remote

```bash
git remote add upstream https://github.com/silent-five-group/dev-stack-installer.git
```

### 4. Create a Branch

```bash
git checkout -b feature/your-feature-name
# or
git checkout -b fix/your-bug-fix
```

---

## Development Workflow

### 1. Keep Your Fork Updated

```bash
git fetch upstream
git checkout main
git merge upstream/main
git push origin main
```

### 2. Make Your Changes

Edit files in your feature branch.

### 3. Test Your Changes

```bash
# Windows
.\install.ps1 -Tier Essential -DryRun

# macOS/Linux
./install.sh --tier essential --dry-run
```

### 4. Commit Your Changes

```bash
git add .
git commit -m "Add feature: description of changes"
```

Follow the commit message format:
- `Add:` New feature or tool
- `Fix:` Bug fix
- `Update:` Update existing functionality
- `Docs:` Documentation changes
- `Test:` Add or update tests
- `Refactor:` Code refactoring

### 5. Push to Your Fork

```bash
git push origin feature/your-feature-name
```

### 6. Open a Pull Request

Go to your fork on GitHub and click "New Pull Request".

---

## Adding New Tools

### Tool Definition Format

Add tools to `tools.json` following this structure:

```json
{
  "id": "tool-id",
  "name": "Tool Name",
  "description": "Brief description of what the tool does",
  "check": "command --version",
  "install": {
    "windows": "winget install --id Package.ID",
    "macos": "brew install package-name",
    "linux": "sudo apt-get install -y package-name || sudo dnf install -y package-name"
  }
}
```

### Guidelines for Adding Tools

1. **Check Command:**
   - Should return exit code 0 if tool is installed
   - Usually `toolname --version` or `toolname version`

2. **Installation Commands:**
   - **Windows:** Use `winget` where possible
   - **macOS:** Use `brew` for most tools
   - **Linux:** Support multiple package managers with `||`

3. **Tool Selection Criteria:**
   - Widely used in development
   - Actively maintained
   - Available via package managers
   - Cross-platform (preferred)

4. **Where to Add:**
   - Choose appropriate tier based on tool category
   - If no tier fits, propose a new tier in your PR

### Example: Adding a New Tool

```json
{
  "id": "ripgrep",
  "name": "ripgrep",
  "description": "Fast grep alternative for searching code",
  "check": "rg --version",
  "install": {
    "windows": "winget install --id BurntSushi.ripgrep.MSVC",
    "macos": "brew install ripgrep",
    "linux": "sudo apt-get install -y ripgrep || sudo dnf install -y ripgrep || cargo install ripgrep"
  }
}
```

---

## Testing

### Manual Testing

Test your changes on your platform:

```bash
# Dry run (safe, no actual installation)
.\install.ps1 -Tier YourTier -DryRun

# List to verify tool appears
.\install.ps1 -List

# Actual installation (if you have the tool available)
.\install.ps1 -Tier YourTier
```

### Test Checklist

Before submitting a PR, verify:
- [ ] Tool appears in `-List` output
- [ ] Dry run shows correct installation command
- [ ] Installation command is correct for each OS
- [ ] Check command properly detects if tool is installed
- [ ] No syntax errors in JSON
- [ ] JSON is properly formatted (use a JSON validator)

### Validating JSON

```bash
# Using Python
python -m json.tool tools.json > /dev/null && echo "Valid JSON"

# Using jq
jq empty tools.json && echo "Valid JSON"

# Using Node.js
node -e "JSON.parse(require('fs').readFileSync('tools.json'))" && echo "Valid JSON"
```

---

## Pull Request Process

### Before Submitting

1. ✅ Test your changes
2. ✅ Validate JSON syntax
3. ✅ Update documentation if needed
4. ✅ Add yourself to acknowledgments (optional)

### PR Title Format

- `Add: [Tool Name] to [Tier] tier`
- `Fix: Installation command for [Tool Name] on [OS]`
- `Update: [Tool Name] package ID`
- `Docs: Improve installation instructions`

### PR Description Template

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] New tool addition
- [ ] Bug fix
- [ ] Documentation update
- [ ] Feature enhancement

## Testing
- [ ] Tested on Windows
- [ ] Tested on macOS
- [ ] Tested on Linux
- [ ] Validated JSON syntax

## Checklist
- [ ] My code follows the style guidelines
- [ ] I have tested my changes
- [ ] I have updated the documentation
- [ ] JSON is valid and properly formatted
```

### Review Process

1. Maintainers will review your PR
2. Address any feedback or requested changes
3. Once approved, your PR will be merged
4. Your contribution will be credited

---

## Style Guidelines

### JSON Formatting

- Use 2-space indentation
- Double quotes for strings
- No trailing commas
- Alphabetical order within tiers (optional but preferred)

### Documentation

- Use clear, concise language
- Include code examples where helpful
- Follow existing documentation structure
- Use proper markdown formatting

### Commit Messages

- Use present tense ("Add feature" not "Added feature")
- Start with capital letter
- Keep first line under 50 characters
- Add detailed description if needed (after blank line)

**Good examples:**
```
Add ripgrep to Essential tier
Fix Docker installation command on Windows
Update README with new tier information
```

**Bad examples:**
```
added tool
fix
Updated some stuff
```

---

## Platform-Specific Notes

### Windows (PowerShell)

- Test with PowerShell 5.1 and 7+
- Avoid using special characters in strings
- Use straight quotes, not smart quotes
- Test with and without Administrator privileges

### macOS

- Test on Intel and Apple Silicon if possible
- Verify Homebrew formulas exist
- Check `/usr/local/bin` vs `/opt/homebrew/bin` paths

### Linux

- Test on Ubuntu (apt) and Fedora (dnf) if possible
- Provide fallback installation methods
- Consider snap and flatpak alternatives

---

## Questions?

- **General questions:** Open a [Discussion](https://github.com/silent-five-group/dev-stack-installer/discussions)
- **Bug reports:** Open an [Issue](https://github.com/silent-five-group/dev-stack-installer/issues)
- **Feature requests:** Open an [Issue](https://github.com/silent-five-group/dev-stack-installer/issues)

---

## Recognition

Contributors will be recognized in:
- GitHub contributors page
- Release notes for significant contributions
- README acknowledgments section (for major contributions)

Thank you for contributing! 🎉
