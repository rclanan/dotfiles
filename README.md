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
./setup/install.sh --postgresql    # PostgreSQL database setup
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

## 🖥️ **Tmux Terminal Multiplexer**

Your tmux configuration provides a powerful development environment with 9 pre-configured windows for the saas-platform project.

### 🚀 **Getting Started with Tmux**

**Start your development session:**
```bash
# Launch the pre-configured saas-platform session
saas-dev

# Or start tmux manually
tmux new -s my-session
```

### ⌨️ **Essential Tmux Navigation**

#### **Prefix Key Concept**
- **Prefix**: `Ctrl-b` (press and release, then press the command key)
- Example: `Ctrl-b` then `n` (next window)

#### **Window Management**
```bash
# Basic window navigation
Ctrl-b n          # Next window
Ctrl-b p          # Previous window
Ctrl-b 0-9        # Jump to window 0-9
Ctrl-b w          # Interactive window list (arrow keys + Enter)
Ctrl-b ,          # Rename current window
Ctrl-b c          # Create new window
Ctrl-b &          # Close current window

# Your custom configuration windows:
# 0: main      - Project root
# 1: backend   - Backend services
# 2: frontend  - Frontend application
# 3: ai        - AI components
# 4: gateway   - Platform gateway
# 5: tools     - Development tools
# 6: docker    - Docker infrastructure
# 7: e2e       - E2E tests
# 8: unified   - Unified components
```

#### **Pane Management**
```bash
# Split panes
Ctrl-b %          # Split vertically (left/right)
Ctrl-b "          # Split horizontally (top/bottom)

# Navigate panes
Ctrl-b →←↑↓      # Switch panes (arrow keys)
Alt-→←↑↓         # Switch panes (Alt + arrows, no prefix!)
Ctrl-b q          # Show pane numbers (then press number)

# Pane operations
Ctrl-b x          # Close current pane
Ctrl-b z          # Zoom/unzoom pane (fullscreen)
Ctrl-b {          # Move pane left
Ctrl-b }          # Move pane right
```

#### **Session Management**
```bash
# Session commands
Ctrl-b d          # Detach from session (keeps it running)
Ctrl-b :          # Command mode (type commands)
Ctrl-b ?          # Show all keybindings

# Outside tmux (terminal commands)
tmux ls           # List all sessions
tmux attach       # Attach to last session
tmux attach -t session-name  # Attach to specific session
```

### 🎯 **Your Optimized Tmux Setup**

**Pre-configured for saas-platform development:**
- **9 windows** covering all project components
- **Vim-style navigation** (h,j,k,l keys)
- **Mouse support** enabled
- **256-color support** for modern terminals
- **Automatic window renumbering**
- **Tmux Plugin Manager (TPM)** installed with useful plugins

**Quick commands:**
```bash
saas-dev          # Start saas-platform development session
tdev              # Reattach to saas-dev session
tmux kill-session # End session completely
```

### 💡 **Tmux Tips for Beginners**

1. **Detach safely**: `Ctrl-b d` - Your work keeps running!
2. **Multiple terminals**: One tmux session = many "virtual terminals"
3. **Organization**: Use windows for different tasks, panes for related work
4. **Persistence**: Sessions survive logout, network issues, etc.
5. **Mouse mode**: Click windows/panes, scroll with mouse wheel

### 🔧 **Tmux Plugins (Auto-installed)**

Your setup includes:
- **tpm**: Plugin manager
- **tmux-sensible**: Sensible defaults
- **tmux-yank**: Better copy/paste
- **tmux-resurrect**: Save/restore sessions
- **tmux-continuum**: Auto-save sessions
- **vim-tmux-navigator**: Seamless vim/tmux navigation

**Install plugins:** `Ctrl-b I` (capital I)

---

## 🚀 **Enhanced Git Configuration**

Your dotfiles include a comprehensive Git setup with best practices and productivity tools:

### 📝 **Commit Message Template**
- **Conventional commits** format enforced
- **Structured template** with type/scope/subject/body/footer
- **Auto-loaded** for all commits (`commit.template = ~/.gitmessage`)

### 🗂️ **Global Gitignore**
- **OS files**: `.DS_Store`, `Thumbs.db`, `.directory`
- **Editor files**: `.vscode/`, `.idea/`, `*.swp`, `*.swo`
- **Temp files**: `*.tmp`, `*.temp`, `*.log`, `tmp/`, `temp/`
- **Environment files**: `.env*`, `.env.local`
- **Auto-applied** to all repositories (`core.excludesfile = ~/.gitignore_global`)

### 🎨 **Advanced Git Features**

#### **Enhanced Diffs**
- **Histogram algorithm** for better diff accuracy
- **Color moved lines** with zebra striping
- **Delta integration** (optional - install `git-delta` for syntax-highlighted diffs)

#### **Smart Workflow Settings**
- **Auto-setup remotes** for new branches
- **Rebase on pull** to maintain clean history
- **Auto-squash fixup commits**
- **Auto-stash during rebase**
- **Default to `main` branch** for new repos

#### **Productivity Aliases**
```bash
# Quick status
git st           # Short status
git staged       # Show staged changes
git unstaged     # Show unstaged changes
git untracked    # Show untracked files

# Branch management
git cob feature  # Create and checkout branch
git del branch   # Delete branch safely
git branches     # List all branches by last commit

# Advanced logging
git graph        # Visual branch graph (last 20)
git changes      # Commits from last week
git who          # Contributors by commit count
git standup      # Your commits since yesterday

# Remote operations
git up           # Fetch and rebase current branch
git pushup       # Push current branch
git track        # Track remote branch

# Cleanup
git cleanup      # Remove merged local branches
git cleanup-remote  # Remove merged remote branches
```

#### **Optional Delta Setup**
If you install `git-delta`:
```bash
# Uncomment delta section in ~/.gitconfig
# Or run: git config --global core.pager delta
```

---

## 🏗️ **Development Workflow Setup**

Your dotfiles include a complete development environment setup with organized directory structure, documentation, and productivity tools:

### 📁 **Directory Structure**
```bash
~/dev/
├── projects/          # Main development work
│   ├── personal/      # Personal projects by language
│   ├── work/          # Work-related projects
│   ├── learning/      # Educational projects
│   └── experiments/   # Experimental code
├── sandbox/           # Temporary/test code
├── forks/            # Forked repositories
├── archive/          # Archived projects
├── tools/            # Development tools & templates
└── scripts/          # Global utility scripts
```

### 🚀 **Quick Setup Commands**
```bash
# Set up directory structure
./setup/setup-dev-dirs.sh

# Create documentation
./setup/setup-dev-docs.sh

# Create gitignore templates
./setup/setup-gitignore-templates.sh

# Add helpful shell aliases
./setup/setup-dev-aliases.sh
```

### 🛠️ **Shell Aliases (after setup)**
```bash
# Directory navigation
dev              # cd ~/dev
projects         # cd ~/dev/projects
work             # cd ~/dev/projects/work
personal         # cd ~/dev/projects/personal
learning         # cd ~/dev/projects/learning
sandbox          # cd ~/dev/sandbox
tools            # cd ~/dev/tools

# Project management
mkproject <name>        # Create new project with git init
archiveproject <name>   # Move project to archive
lsp                     # List all projects

# Gitignore templates
gitignore-py            # Copy Python gitignore
gitignore-node          # Copy Node.js gitignore
gitignore-go            # Copy Go gitignore
gitignore-general       # Copy general gitignore

# Quick git commands
gs, ga, gc, gp, gl, gb, gco

# Development servers
pyserver                # Start Python HTTP server
jsserver                # Start Node.js HTTP server
killport <port>         # Kill process on port
```

### 📋 **Gitignore Templates Available**
Located in `~/dev/tools/templates/gitignore/`:
- **python.gitignore** - Python-specific patterns
- **node.gitignore** - Node.js/npm/yarn patterns
- **rust.gitignore** - Rust/Cargo patterns
- **go.gitignore** - Go-specific patterns
- **general.gitignore** - Cross-platform patterns

### 📖 **Best Practices Included**
1. **Project Naming**: Use kebab-case (my-project-name)
2. **Version Control**: Initialize git for all projects
3. **Documentation**: Every project should have a README.md
4. **Archive**: Move inactive projects to `archive/`
5. **Forks**: Keep forks separate from original work

### 🔄 **Integration with Existing Setup**
- **Tmux sessions** can be created for any project in `~/dev/projects/`
- **Git configuration** applies to all projects automatically
- **Shell aliases** work alongside your existing Zsh/Bash setup
- **Docker** can be used for any project development

---

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

## 🐘 **PostgreSQL Database Setup**

PostgreSQL setup is now included as a dedicated installation option:

```bash
./setup/install.sh --postgresql
```

### What gets installed:
- **PostgreSQL server** with automatic service management
- **Database initialization** and user creation
- **User permissions** setup for your username
- **Service enablement** and startup

### PostgreSQL Usage:
```bash
# Connect to PostgreSQL
psql -U $USER -d postgres

# Check service status
sudo systemctl status postgresql.service

# Restart service
sudo systemctl restart postgresql.service

# View logs
sudo journalctl -u postgresql.service -f
```

### Database Management:
```bash
# Create a new database
createdb myproject

# List all databases
psql -U $USER -l

# Connect to specific database
psql -U $USER -d myproject
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
