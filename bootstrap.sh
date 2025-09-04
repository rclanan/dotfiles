#!/bin/bash
# Bootstrap script to set up development environment from dotfiles

set -e

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${GREEN}🚀 Development Environment Bootstrap${NC}"
echo "===================================="

# Check if on Arch Linux
if ! command -v pacman &> /dev/null; then
    echo -e "${RED}❌ This bootstrap script is designed for Arch Linux${NC}"
    exit 1
fi

# Install git if not available
if ! command -v git &> /dev/null; then
    echo -e "${YELLOW}📦 Installing git...${NC}"
    sudo pacman -S --noconfirm git
fi

# Clone dotfiles if not already cloned
if [ ! -d "$HOME/dotfiles" ]; then
    echo -e "${GREEN}📥 Cloning dotfiles repository...${NC}"
    git clone https://github.com/rclanan/dotfiles.git "$HOME/dotfiles"
fi

# Run the setup script
echo -e "${GREEN}⚙️  Running setup script...${NC}"
cd "$HOME/dotfiles/setup"
./install.sh "$@"

echo -e "${GREEN}✅ Bootstrap complete!${NC}"
echo -e "${YELLOW}💡 You may need to log out and back in for some changes to take effect.${NC}"
