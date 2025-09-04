# Dotfiles - Managed with GNU Stow

A collection of my personal dotfiles, managed and deployed using GNU Stow for easy cross-machine synchronization.

## 🚀 Quick Start

### Option 1: One-Line Bootstrap (Recommended)
```bash
# Download and run the bootstrap script
curl -fsSL https://raw.githubusercontent.com/rclanan/dotfiles/main/bootstrap.sh | bash
```

### Option 2: Manual Setup
```bash
# Clone the repository
git clone git@github.com:rclanan/dotfiles.git ~/dotfiles

# Go to the dotfiles directory
cd ~/dotfiles

# Install all dotfiles (backup existing files first)
./manage.sh stow

# Or install individual packages
stow bash
stow git
stow tmux
stow vim
stow zsh
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

### System Setup Scripts
The repository includes automated setup scripts for Arch Linux systems:

```bash
# Essential development setup (recommended for new machines)
./setup/install.sh --essential

# Full system setup (all 214 official + 23 AUR packages)
./setup/install.sh --full

# Update system packages only
./setup/install.sh --update

# Install only official packages
./setup/install.sh --official

# Install only AUR packages
./setup/install.sh --aur
```

**Package Lists:**
- `setup/packages-essential.txt` - Core development tools
- `setup/packages-official.txt` - All official repository packages (214 packages)
- `setup/packages-aur.txt` - All AUR packages (23 packages)

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

```bash
# On a new machine
git clone git@github.com:rclanan/dotfiles.git ~/dotfiles
cd ~/dotfiles && ./manage.sh stow
```

## ⚠️ Important Notes

- **Backup first**: Always backup existing dotfiles before stowing
- **Security**: Never store private SSH keys, passwords, or API tokens in git
- **SSH keys**: `.ssh/` directory is intentionally excluded (contains private keys like `id_rsa`, `id_ed25519`)
- **Sensitive files**: Avoid committing `.env` files, credential files, or any file containing passwords/secrets
- **Machine-specific**: Some files may need customization for different machines
- **Dependencies**: Ensure required software is installed (zsh, tmux, vim, etc.)

## 🎨 Features Included

- **Zsh with Powerlevel10k**: Beautiful prompt with git status, time, etc.
- **Custom aliases**: Shortcuts for common commands
- **Git configuration**: Global ignore patterns and commit message templates
- **Tmux configuration**: Terminal multiplexing setup
- **Development tools**: Python security audit, Docker, RustDesk optimizations

---

*Managed with ❤️ using GNU Stow*
