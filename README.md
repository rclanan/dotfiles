# Dotfiles - Managed with GNU Stow

A collection of my personal dotfiles, managed and deployed using GNU Stow for easy cross-machine synchronization.

## 🚀 Quick Start

### 🔥 One-Line Bootstrap (Fastest - Recommended)
Get a fully configured development environment in one command:
```bash
# Download and run the bootstrap script
curl -fsSL https://raw.githubusercontent.com/rclanan/dotfiles/main/bootstrap.sh | bash
```

**What it does:**
- ✅ Detects Arch Linux system
- ✅ Installs git if needed
- ✅ Clones this repository
- ✅ Runs essential setup (recommended)
- ✅ Configures dotfiles automatically

### 🛠️ Advanced Setup Options

#### 🚀 Quick Setup Options

**Ultra-Fast (9 packages):**
```bash
./setup/install.sh --minimal
# base-devel, git, vim, zsh, curl, python, nodejs, docker, yay
```

**Optimized Essentials (14 packages):**
```bash
./setup/install.sh --essential-opt
# Core development tools without redundancies
```

**Core Packages (62 packages):**
```bash
./setup/install.sh --official-opt
# Official packages without KDE/Plasma desktop environment
```

#### 📦 Full Setup Options

**Complete System Replication:**
```bash
./setup/install.sh --full
# All 237 packages from your current system (asks for confirmation)
```

**Original Package Lists:**
```bash
./setup/install.sh --essential     # Original essentials (16 packages)
./setup/install.sh --official      # All official packages (214)
./setup/install.sh --aur           # All AUR packages (23)
./setup/install.sh --aur-opt       # Essential AUR only (5 packages)
```

**Recommended Options:**
```bash
./setup/install.sh --minimal       # Ultra-fast (9 packages)
./setup/install.sh --essential-opt # Recommended essentials (14 packages)
./setup/install.sh --official-opt  # Core development (62 packages)
```

#### 🔧 Maintenance & Manual Setup

**System Updates Only:**
```bash
./setup/install.sh --update
```

**Dotfiles Only (if packages already installed):**
```bash
cd ~/dotfiles
./manage.sh stow
```

## 📦 Available Packages

| Package | Description | Files |
|---------|-------------|-------|
| **bash** | Bash shell configuration | `.bashrc`, `.bash_profile`, `.bash_logout` |
| **git** | Git version control config | `.gitconfig`, `.gitignore_global`, `.gitmessage` |
| **zsh** | Zsh shell with Powerlevel10k | `.zshrc`, `.p10k.zsh` |
| **tmux** | Terminal multiplexer config | `.tmux.conf` |
| **vim** | Vim/Neovim configuration | `.viminfo` |

## 🛠️ Management Scripts

### Dotfiles Management
```bash
./manage.sh stow     # Install all packages (adopts existing files)
./manage.sh unstow   # Remove all symlinks
./manage.sh backup   # Backup existing dotfiles
./manage.sh restore  # Restore from backup
./manage.sh status   # Show current stow status
```

### 🎯 System Setup Scripts
Comprehensive package installation for Arch Linux systems:

#### Setup Modes Explained

**`--minimal`** (Ultra-fast development setup)
- ✅ Essential development tools only (9 packages)
- ✅ base-devel, git, vim, zsh, python, nodejs, docker
- ✅ Perfect for servers or minimal environments
- ⚡ **Fastest**: Minimal installation time and disk usage

**`--essential-opt`** (Optimized essentials)
- ✅ Core development tools without redundancies (14 packages)
- ✅ Removed redundant python-pip, npm (included with python/nodejs)
- ✅ Includes tmux, docker-compose, build tools
- ⚡ **Fast**: Streamlined package list

**`--official-opt`** (Core packages optimized)
- ✅ 62 essential official packages
- ✅ Removed KDE/Plasma desktop environment packages
- ✅ Removed non-essential applications (Discord, games, etc.)
- ✅ Includes all development tools, languages, and system utilities
- 💡 **Balanced**: Full development environment without desktop bloat

**`--essential`** (Original essentials - 16 packages)
- ✅ Original essential list with some redundancies
- ✅ Includes python-pip, npm separately
- ✅ Good for compatibility with existing workflows

**`--full`** (Complete system replication)
- ✅ ALL 214 official repository packages
- ✅ ALL 23 AUR packages including debug variants
- ✅ Everything from your current system
- ⚠️ **Slow**: Large download/installation, asks for confirmation
- 💡 **Use when**: You want exact replica of current setup

**`--official`** (All official packages - 214 packages)
- ✅ Every official package from your system
- ✅ Includes KDE/Plasma, all applications
- ❌ No AUR packages
- ⚡ **Faster**: No AUR compilation required

**`--aur-opt`** (Essential AUR only - 5 packages)
- ✅ Only essential AUR packages
- ✅ Removed all debug packages and specific tools
- ✅ google-chrome, google-cloud-cli, rustdesk, teams, yay
- ✅ Much faster and more reliable than full AUR

**`--aur`** (All AUR packages - 23 packages)
- ✅ All AUR packages including debug variants
- ✅ Includes specific tools (pgadmin4, sql-workbench, etc.)
- ⚠️ **May fail**: Some AUR packages can be problematic

**`--update`** (System maintenance)
- ✅ Updates all system packages
- ✅ No new package installation
- ✅ Safe to run regularly

#### Package Lists Details

| File | Description | Count | Examples |
|------|-------------|-------|----------|
| `packages-minimal.txt` | **Ultra-fast setup** | 9 | git, vim, zsh, python, nodejs, docker |
| `packages-essential-optimized.txt` | **Optimized essentials** (recommended) | 14 | git, vim, zsh, tmux, docker, python, nodejs |
| `packages-essential.txt` | Original essentials | 16 | git, vim, zsh, tmux, docker (+ python-pip, npm) |
| `packages-official-optimized.txt` | **Core packages** (no desktop) | 62 | alacritty, code, git, python, rust, tmux, vim |
| `packages-official.txt` | All official packages | 214 | alacritty, python, nodejs, rust (+ KDE/Plasma) |
| `packages-aur-optimized.txt` | **Essential AUR only** | 5 | chrome, cloud-cli, rustdesk, teams, yay |
| `packages-aur.txt` | All AUR packages | 23 | yay, chrome (+ debug packages, pgadmin4, etc.) |

**Legend:**
- **Bold** = Recommended for most users
- **+** = Additional packages included
- **Recommended progression:** `--minimal` → `--essential-opt` → `--official-opt`

#### Updating Package Lists
To capture new packages you've installed:
```bash
# Update official packages list
pacman -Qe | cut -d' ' -f1 > setup/packages-official.txt

# Update AUR packages list
pacman -Qm | cut -d' ' -f1 > setup/packages-aur.txt

# Commit changes
git add setup/ && git commit -m "Update package lists"
```

## 📝 Manual Stow Usage

```bash
# Install specific package
stow zsh

# Install with adoption (moves existing files)
stow --adopt zsh

# Remove package
stow -D zsh

# Simulate installation (dry run)
stow -n -v zsh
```

## 🔄 Syncing Across Machines

### 🚀 Bootstrap Method (Recommended)
One command sets up everything:
```bash
curl -fsSL https://raw.githubusercontent.com/rclanan/dotfiles/main/bootstrap.sh | bash
```

### 🛠️ Manual Method
```bash
# Clone and setup
git clone git@github.com:rclanan/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Choose your setup method
./setup/install.sh --essential  # Recommended for most users
# OR
./manage.sh stow               # Dotfiles only
```

### 💻 What Gets Configured
- ✅ All dotfiles (zsh, git, tmux, vim, bash)
- ✅ Package installation (based on chosen method)
- ✅ System services (Docker, etc.)
- ✅ Default shell configuration
- ✅ Development environment ready

## ⚠️ Important Notes

- **Backup first**: Always backup existing dotfiles before stowing
- **Security**: Never store private SSH keys, passwords, or API tokens in git
- **SSH keys**: `.ssh/` directory is intentionally excluded (contains private keys like `id_rsa`, `id_ed25519`)
- **Sensitive files**: Avoid committing `.env` files, credential files, or any file containing passwords/secrets
- **Machine-specific**: Some files may need customization for different machines
- **Dependencies**: Ensure required software is installed (zsh, tmux, vim, etc.)

## 🐛 Troubleshooting

### Common Issues

**"Permission denied" during setup:**
```bash
# Run with sudo for system-wide installations
sudo ./setup/install.sh --essential
```

**Yay/AUR installation fails:**
```bash
# Install yay manually first
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay && makepkg -si
```

**Package conflicts:**
```bash
# Remove conflicting packages first
sudo pacman -R package-name
# Then re-run setup
./setup/install.sh --essential
```

**Docker permission issues:**
```bash
# Add user to docker group and restart
sudo usermod -aG docker $USER
# Log out and back in, or run:
newgrp docker
```

**Zsh not set as default shell:**
```bash
# Set manually
chsh -s /usr/bin/zsh
# Restart terminal
```

### Getting Help
```bash
# Check setup script help
./setup/install.sh --help

# Check dotfiles management help
./manage.sh
```

## 🎨 Features Included

### 🖥️ System Setup Automation
- **One-line bootstrap**: Complete environment setup in one command
- **Multiple installation modes**: Essential, full, selective package installation
- **Arch Linux optimized**: Automatic Yay installation, AUR package support
- **Post-install configuration**: Docker setup, shell configuration, system services

### 🛠️ Development Environment
- **Zsh with Powerlevel10k**: Beautiful prompt with git status, time, etc.
- **Custom aliases**: Shortcuts for common commands
- **Git configuration**: Global ignore patterns and commit message templates
- **Tmux configuration**: Terminal multiplexing setup
- **Development tools**: Python security audit, Docker, RustDesk optimizations

### 📦 Package Management
- **237 total packages**: 214 official + 23 AUR packages captured
- **Essential packages list**: Core development tools for quick setup
- **Automatic updates**: Package list maintenance and updates
- **Selective installation**: Choose what to install based on needs

### 🔧 Dotfiles Management
- **GNU Stow integration**: Clean symlink management
- **Backup/restore**: Automatic backup of existing files
- **Status checking**: Visual confirmation of stow status
- **Cross-platform**: Works on any Unix-like system with Stow

---

## 🎯 **Which Option Should You Choose?**

| Scenario | Recommended Option | Why |
|----------|-------------------|-----|
| **Fresh server/minimal VM** | `--minimal` | Fastest, minimal resource usage |
| **Personal development machine** | `--essential-opt` | Perfect balance of tools and speed |
| **Full development workstation** | `--official-opt` | All tools without desktop bloat |
| **Exact replica of your setup** | `--full` | Everything from your current system |
| **Testing/debugging** | `--update` | Just update existing packages |

### 💡 **Quick Decision Guide:**

- 🚀 **Speed matters**: `--minimal` or `--essential-opt`
- 🛠️ **Need all development tools**: `--official-opt`
- 📦 **Want exact replica**: `--full`
- 🔧 **Already have packages**: Use `./manage.sh stow` for dotfiles only

### ⚡ **Performance Comparison:**

- `--minimal`: ~2 minutes, ~500MB disk
- `--essential-opt`: ~5 minutes, ~2GB disk
- `--official-opt`: ~15 minutes, ~8GB disk
- `--full`: ~45+ minutes, ~15GB+ disk

---

*Managed with ❤️ using GNU Stow and automated with custom scripts*
