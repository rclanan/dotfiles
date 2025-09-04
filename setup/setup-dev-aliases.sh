#!/bin/bash
# Add helpful development aliases to shell configuration

echo "Adding development workflow aliases..."

# Check which shell is being used and add to appropriate config
if [[ "$SHELL" == *"zsh"* ]]; then
    CONFIG_FILE="$HOME/.zshrc"
elif [[ "$SHELL" == *"bash"* ]]; then
    CONFIG_FILE="$HOME/.bashrc"
else
    echo "Unsupported shell: $SHELL"
    echo "Please manually add the aliases to your shell configuration file."
    exit 1
fi

# Add development aliases
cat >> "$CONFIG_FILE" << 'EOF'

# === Development Workflow Aliases ===
# Directory navigation
alias dev='cd ~/dev'
alias projects='cd ~/dev/projects'
alias work='cd ~/dev/projects/work'
alias personal='cd ~/dev/projects/personal'
alias learning='cd ~/dev/projects/learning'
alias sandbox='cd ~/dev/sandbox'
alias tools='cd ~/dev/tools'

# Project management
alias mkproject='function _mkproject() { mkdir -p "$1" && cd "$1" && git init && echo "# $1" > README.md; }; _mkproject'
alias archiveproject='function _archiveproject() { mv "$1" ~/dev/archive/ 2>/dev/null && echo "Archived: $1" || echo "Project not found: $1"; }; _archiveproject'
alias lsp='find ~/dev/projects -maxdepth 2 -type d | sort'

# Git workflow for projects
alias gitignore-py='cp ~/dev/tools/templates/gitignore/python.gitignore .gitignore'
alias gitignore-node='cp ~/dev/tools/templates/gitignore/node.gitignore .gitignore'
alias gitignore-go='cp ~/dev/tools/templates/gitignore/go.gitignore .gitignore'
alias gitignore-general='cp ~/dev/tools/templates/gitignore/general.gitignore .gitignore'

# Quick git operations
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'
alias gb='git branch'
alias gco='git checkout'

# Development server shortcuts
alias pyserver='python -m http.server'
alias jsserver='npx http-server'
alias killport='function _killport() { lsof -ti:$1 | xargs kill -9 2>/dev/null && echo "Killed processes on port $1" || echo "No processes found on port $1"; }; _killport'
EOF

echo "Development aliases added to $CONFIG_FILE"
echo ""
echo "New aliases available after restarting your shell:"
echo ""
echo "Directory Navigation:"
echo "  dev         - Go to ~/dev"
echo "  projects    - Go to ~/dev/projects"
echo "  work        - Go to work projects"
echo "  personal    - Go to personal projects"
echo "  learning    - Go to learning projects"
echo "  sandbox     - Go to sandbox"
echo "  tools       - Go to tools directory"
echo ""
echo "Project Management:"
echo "  mkproject <name>    - Create new project with git init"
echo "  archiveproject <name> - Move project to archive"
echo "  lsp                 - List all projects"
echo ""
echo "Gitignore Templates:"
echo "  gitignore-py        - Copy Python gitignore"
echo "  gitignore-node      - Copy Node.js gitignore"
echo "  gitignore-go        - Copy Go gitignore"
echo "  gitignore-general   - Copy general gitignore"
echo ""
echo "Git Shortcuts:"
echo "  gs, ga, gc, gp, gl, gb, gco"
echo ""
echo "Development Servers:"
echo "  pyserver    - Start Python HTTP server"
echo "  jsserver    - Start Node.js HTTP server"
echo "  killport <port> - Kill process on specified port"
