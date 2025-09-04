#!/bin/bash
# Dotfiles management script using GNU Stow

STOW_DIR="$HOME/dotfiles"
BACKUP_DIR="$HOME/dotfiles_backup"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to backup existing files
backup_files() {
    echo -e "${YELLOW}Backing up existing dotfiles...${NC}"
    mkdir -p "$BACKUP_DIR"
    
    # List of files to backup
    files_to_backup=(
        ".bashrc" ".bash_profile" ".bash_logout"
        ".gitignore_global" ".gitmessage"
        ".tmux.conf"
        ".viminfo"
        ".p10k.zsh"
    )
    
    for file in "${files_to_backup[@]}"; do
        if [ -f "$HOME/$file" ] && [ ! -L "$HOME/$file" ]; then
            cp "$HOME/$file" "$BACKUP_DIR/"
            echo "Backed up: $file"
        fi
    done
}

# Function to stow packages
stow_packages() {
    echo -e "${GREEN}Stowing packages...${NC}"
    cd "$STOW_DIR"

    packages=("bash" "git" "tmux" "vim" "zsh")

    for package in "${packages[@]}"; do
        if [ -d "$package" ]; then
            echo "Stowing $package..."
            # Try to adopt existing files first, then fallback to regular stow
            if stow --adopt -v "$package" 2>/dev/null; then
                echo "Successfully adopted existing files for $package"
            else
                echo "Adopting failed, trying regular stow..."
                stow -v "$package"
            fi
        fi
    done
}

# Function to unstow packages
unstow_packages() {
    echo -e "${YELLOW}Unstowing packages...${NC}"
    cd "$STOW_DIR"
    
    packages=("bash" "git" "tmux" "vim" "zsh")
    
    for package in "${packages[@]}"; do
        if [ -d "$package" ]; then
            echo "Unstowing $package..."
            stow -D -v "$package"
        fi
    done
}

# Function to restore from backup
restore_backup() {
    echo -e "${YELLOW}Restoring from backup...${NC}"
    if [ -d "$BACKUP_DIR" ]; then
        for file in "$BACKUP_DIR"/*; do
            if [ -f "$file" ]; then
                filename=$(basename "$file")
                cp "$file" "$HOME/$filename"
                echo "Restored: $filename"
            fi
        done
    else
        echo -e "${RED}No backup directory found!${NC}"
    fi
}

# Main menu
case "$1" in
    "backup")
        backup_files
        ;;
    "stow")
        backup_files
        stow_packages
        ;;
    "unstow")
        unstow_packages
        ;;
    "restore")
        restore_backup
        ;;
    "status")
        echo -e "${GREEN}Current stow status:${NC}"
        cd "$STOW_DIR"
        stow -n -v bash git tmux vim zsh 2>/dev/null || echo "Some packages may not be stowed"
        ;;
    *)
        echo "Usage: $0 {backup|stow|unstow|restore|status}"
        echo ""
        echo "Commands:"
        echo "  backup  - Backup existing dotfiles"
        echo "  stow    - Backup and stow all packages"
        echo "  unstow  - Remove all stowed packages"
        echo "  restore - Restore from backup"
        echo "  status  - Show current stow status"
        ;;
esac
