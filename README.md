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

#### Option 1: Essential Development Setup
Perfect for new machines - installs core development tools:
```bash
git clone git@github.com:rclanan/dotfiles.git ~/dotfiles
cd ~/dotfiles
./setup/install.sh --essential
```

#### Option 2: Full System Replication
Installs ALL packages from your current system (237 total packages):
```bash
./setup/install.sh --full
```

#### Option 3: Selective Installation
```bash
./setup/install.sh --official    # Official packages only (214)
./setup/install.sh --aur         # AUR packages only (23)
./setup/install.sh --update      # Update system only
```

#### Option 4: Manual Dotfiles Only
If you already have packages installed:
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

**`--essential`** (Recommended for new machines)
- ✅ Core development tools (git, vim, zsh, tmux, docker, etc.)
- ✅ Node.js, Python, and build tools
- ✅ Yay (AUR helper) for future package management
- ✅ Post-install configuration (Docker, Zsh as default shell)
- ⚡ **Fast**: ~15-20 packages, quick installation

**`--full`** (Complete system replication)
- ✅ ALL 214 official repository packages
- ✅ ALL 23 AUR packages
- ✅ Everything from your current system
- ⚠️ **Slow**: Large download/installation, asks for confirmation
- 💡 **Use when**: You want exact replica of current setup

**`--official`** (Official packages only)
- ✅ 214 packages from official Arch repositories
- ❌ No AUR packages
- ⚡ **Faster**: No AUR compilation required

**`--aur`** (AUR packages only)
- ✅ 23 packages from AUR
- ✅ Requires Yay to be installed first
- ⚠️ **May fail**: Some AUR packages can be problematic

**`--update`** (System maintenance)
- ✅ Updates all system packages
- ✅ No new package installation
- ✅ Safe to run regularly

#### Package Lists Details

| File | Description | Count | Examples |
|------|-------------|-------|----------|
| `packages-essential.txt` | Core development tools | ~15 | git, vim, zsh, tmux, docker |
| `packages-official.txt` | Official Arch packages | 214 | alacritty, python, nodejs, rust |
| `packages-aur.txt` | AUR packages | 23 | yay, visual-studio-code-bin, etc. |

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

*Managed with ❤️ using GNU Stow and automated with custom scripts*
