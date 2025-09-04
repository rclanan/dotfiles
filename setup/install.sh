#!/bin/bash
# Universal Development Environment Setup Script
# Works on Arch Linux systems with pacman

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
DOTFILES_DIR="$HOME/dotfiles"
SETUP_DIR="$DOTFILES_DIR/setup"
OFFICIAL_PACKAGES="$SETUP_DIR/packages-official.txt"
AUR_PACKAGES="$SETUP_DIR/packages-aur.txt"
ESSENTIAL_PACKAGES="$SETUP_DIR/packages-essential.txt"

# Logging function
log() {
    echo -e "${GREEN}[$(date +'%Y-%m-%d %H:%M:%S')] $1${NC}"
}

error() {
    echo -e "${RED}[ERROR] $1${NC}" >&2
}

warn() {
    echo -e "${YELLOW}[WARNING] $1${NC}"
}

info() {
    echo -e "${BLUE}[INFO] $1${NC}"
}

# Check if running on Arch Linux
check_system() {
    if ! command -v pacman &> /dev/null; then
        error "This script is designed for Arch Linux systems with pacman."
        error "Current system detected: $(uname -s)"
        exit 1
    fi
    
    log "Arch Linux system detected ✓"
}

# Update system
update_system() {
    log "Updating system packages..."
    sudo pacman -Syu --noconfirm
}

# Install Yay (AUR helper)
install_yay() {
    if ! command -v yay &> /dev/null; then
        log "Installing Yay (AUR helper)..."
        
        # Install dependencies
        sudo pacman -S --needed --noconfirm git base-devel
        
        # Clone and build yay
        temp_dir=$(mktemp -d)
        cd "$temp_dir"
        git clone https://aur.archlinux.org/yay.git
        cd yay
        makepkg -si --noconfirm
        
        cd "$HOME"
        rm -rf "$temp_dir"
        
        log "Yay installed successfully ✓"
    else
        log "Yay already installed ✓"
    fi
}

# Install official repository packages
install_official_packages() {
    local package_file="$1"
    
    if [ ! -f "$package_file" ]; then
        warn "Package file not found: $package_file"
        return 1
    fi
    
    log "Installing official packages from $package_file..."
    
    # Filter out comments and empty lines
    local packages=$(grep -v '^#' "$package_file" | grep -v '^$' | tr '\n' ' ')
    
    if [ -z "$packages" ]; then
        warn "No packages found in $package_file"
        return 1
    fi
    
    info "Packages to install: $packages"
    
    # Install packages (continue on errors)
    echo "$packages" | xargs sudo pacman -S --needed --noconfirm || {
        warn "Some official packages failed to install. Continuing..."
    }
}

# Install AUR packages
install_aur_packages() {
    local package_file="$1"
    
    if [ ! -f "$package_file" ]; then
        warn "AUR package file not found: $package_file"
        return 1
    fi
    
    log "Installing AUR packages from $package_file..."
    
    # Filter out comments and empty lines
    local packages=$(grep -v '^#' "$package_file" | grep -v '^$' | tr '\n' ' ')
    
    if [ -z "$packages" ]; then
        warn "No AUR packages found in $package_file"
        return 1
    fi
    
    info "AUR packages to install: $packages"
    
    # Install AUR packages (continue on errors)
    echo "$packages" | xargs yay -S --needed --noconfirm || {
        warn "Some AUR packages failed to install. This is normal for some packages."
        warn "You may need to install them manually or check for updates."
    }
}

# Setup dotfiles
setup_dotfiles() {
    if [ -f "$DOTFILES_DIR/manage.sh" ]; then
        log "Setting up dotfiles..."
        cd "$DOTFILES_DIR"
        ./manage.sh stow
        log "Dotfiles setup complete ✓"
    else
        warn "Dotfiles management script not found. Skipping dotfiles setup."
    fi
}

# Post-installation setup
post_install_setup() {
    log "Running post-installation setup..."
    
    # Enable and start Docker service
    if command -v docker &> /dev/null; then
        log "Setting up Docker..."
        sudo systemctl enable docker
        sudo systemctl start docker
        sudo usermod -aG docker "$USER"
        info "Docker setup complete. You may need to log out and back in for group changes to take effect."
    fi
    
    # Setup Zsh as default shell if available
    if command -v zsh &> /dev/null && [ "$SHELL" != "/usr/bin/zsh" ]; then
        log "Setting Zsh as default shell..."
        chsh -s /usr/bin/zsh
        info "Zsh set as default shell. Restart your terminal for changes to take effect."
    fi
}

# Verify installations
verify_installations() {
    log "Verifying installations..."
    echo ""

    # Python
    if command -v python &> /dev/null; then
        echo "✓ Python $(python --version 2>&1)"
    else
        echo "✗ Python not found"
    fi

    # Node.js
    if command -v node &> /dev/null; then
        echo "✓ Node.js $(node --version)"
    fi

    # Docker
    if command -v docker &> /dev/null; then
        echo "✓ Docker $(docker --version 2>&1)"
    fi

    # Git
    if command -v git &> /dev/null; then
        echo "✓ Git $(git --version)"
    fi

    # Rust
    if command -v rustc &> /dev/null; then
        echo "✓ Rust $(rustc --version 2>&1 | head -1)"
    fi

    # PostgreSQL
    if command -v psql &> /dev/null; then
        echo "✓ PostgreSQL $(postgres --version 2>&1)"
    fi

    # Zsh
    if command -v zsh &> /dev/null; then
        echo "✓ Zsh $(zsh --version)"
    fi

    echo ""
    log "Verification complete!"
}

# Show usage information
usage() {
    echo "Universal Development Environment Setup Script"
    echo ""
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  --essential          Install essential development packages"
    echo "  --essential-opt      Install essential packages (optimized, no redundancies)"
    echo "  --minimal            Install minimal development setup (fastest)"
    echo "  --full               Install all packages (official + AUR)"
    echo "  --official           Install only official repository packages"
    echo "  --official-opt       Install official packages (optimized)"
    echo "  --aur                Install only AUR packages"
    echo "  --aur-opt            Install AUR packages (optimized, no debug packages)"
    echo "  --postgresql         Install and setup PostgreSQL"
    echo "  --power-mgmt         Configure KDE power management (no sleep, screen sleep)"
    echo "  --update             Update system packages only"
    echo "  --help               Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 --minimal           # Fastest setup (9 packages)"
    echo "  $0 --essential-opt     # Optimized development setup (14 packages)"
    echo "  $0 --official-opt      # Core packages without KDE (62 packages)"
    echo "  $0 --full              # Everything (214 official + 23 AUR packages)"
    echo "  $0 --update            # Just update system"
    echo ""
    echo "Note: This script is designed for Arch Linux systems."
}

# Main function
main() {
    local install_mode=""
    
    # Parse command line arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
                --essential)
        install_mode="essential"
        shift
        ;;
    --essential-optimized|--essential-opt)
        install_mode="essential-optimized"
        shift
        ;;
    --minimal)
        install_mode="minimal"
        shift
        ;;
    --full)
        install_mode="full"
        shift
        ;;
    --official)
        install_mode="official"
        shift
        ;;
    --official-optimized|--official-opt)
        install_mode="official-optimized"
        shift
        ;;
    --aur)
        install_mode="aur"
        shift
        ;;
    --aur-optimized|--aur-opt)
        install_mode="aur-optimized"
        shift
        ;;
    --postgresql)
        install_mode="postgresql"
        shift
        ;;
    --power-mgmt|--power-management)
        install_mode="power-management"
        shift
        ;;
    --update)
        install_mode="update"
        shift
        ;;
            --help|-h)
                usage
                exit 0
                ;;
            *)
                error "Unknown option: $1"
                usage
                exit 1
                ;;
        esac
    done
    
    # Default to essential if no mode specified
    if [ -z "$install_mode" ]; then
        install_mode="essential"
    fi
    
    # Run setup based on mode
    case $install_mode in
        "essential")
            log "Starting Essential Development Setup"
            log "===================================="
            check_system
            update_system
            install_official_packages "$ESSENTIAL_PACKAGES"
            setup_dotfiles
            post_install_setup
            verify_installations
            log "Essential setup complete! 🎉"
            ;;
        "essential-optimized")
            log "Starting Essential Development Setup (Optimized)"
            log "==============================================="
            check_system
            update_system
            install_official_packages "$SETUP_DIR/packages-essential-optimized.txt"
            setup_dotfiles
            post_install_setup
            verify_installations
            log "Essential optimized setup complete! 🎉"
            ;;
        "minimal")
            log "Starting Minimal Development Setup"
            log "=================================="
            check_system
            update_system
            install_official_packages "$SETUP_DIR/packages-minimal.txt"
            setup_dotfiles
            post_install_setup
            verify_installations
            log "Minimal setup complete! 🎉"
            ;;
        "full")
            log "Starting Full System Setup (All Packages)"
            log "=========================================="
            warn "This will install 214 official packages and 23 AUR packages."
            warn "This may take a very long time and use significant disk space."
            read -p "Continue? (y/N): " -n 1 -r
            echo
            if [[ ! $REPLY =~ ^[Yy]$ ]]; then
                log "Setup cancelled by user."
                exit 0
            fi
            check_system
            update_system
            install_yay
            install_official_packages "$OFFICIAL_PACKAGES"
            install_aur_packages "$AUR_PACKAGES"
            setup_dotfiles
            post_install_setup
            verify_installations
            log "Full setup complete! 🎉"
            ;;
        "official")
            log "Installing Official Repository Packages Only"
            check_system
            update_system
            install_official_packages "$OFFICIAL_PACKAGES"
            setup_dotfiles
            post_install_setup
            verify_installations
            ;;
        "official-optimized")
            log "Installing Official Repository Packages (Optimized)"
            check_system
            update_system
            install_official_packages "$SETUP_DIR/packages-official-optimized.txt"
            setup_dotfiles
            post_install_setup
            verify_installations
            ;;
        "aur")
            log "Installing AUR Packages Only"
            check_system
            install_yay
            install_aur_packages "$AUR_PACKAGES"
            ;;
        "aur-optimized")
            log "Installing AUR Packages (Optimized)"
            check_system
            install_yay
            install_aur_packages "$SETUP_DIR/packages-aur-optimized.txt"
            ;;
        "postgresql")
            log "Setting up PostgreSQL"
            log "===================="
            check_system
            update_system
            "$SETUP_DIR/setup-postgresql.sh"
            ;;
        "power-management")
            log "Setting up KDE Power Management"
            log "==============================="
            check_system
            "$SETUP_DIR/setup-power-management.sh"
            ;;
        "update")
            log "Updating System Packages"
            check_system
            update_system
            log "System update complete! ✓"
            ;;
    esac
}

# Run main function with all arguments
main "$@"
