# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git sudo archlinux systemd docker zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

# History settings
export HISTSIZE=10000
export SAVEHIST=20000
export HISTFILE=~/.zsh_history
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt SHARE_HISTORY
setopt APPEND_HISTORY

# Colorful aliases
alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Safety aliases
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Shortcuts
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'
alias c='clear'
alias h='history'
alias j='jobs -l'
alias vi='vim'
alias df='df -h'
alias du='du -h'
alias free='free -h'

# Git aliases (some might duplicate oh-my-zsh git plugin)
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'
alias gd='git diff'
alias gb='git branch'
alias gco='git checkout'

# Path additions
export PATH=$HOME/.local/bin:$HOME/.npm-global/bin:$PATH

# NVM configuration
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Useful functions
# Extract various archive formats
extract() {
    if [ -f $1 ]; then
        case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)     echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Create directory and cd into it
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Find files by name
ff() {
    find . -type f -name "*$1*"
}

# Find directories by name
fdir() {
    find . -type d -name "*$1*"
}

# Show file sizes sorted
duf() {
    du -sh * | sort -h
}

# Directory navigation
export CDPATH=".:~:~/Documents:~/Downloads"

# Better cd with history
cd() {
    builtin cd "$@" && ls
}

# Go back to previous directory
alias back='cd "$OLDPWD"'

# === PROJECT MANAGEMENT FUNCTIONS ===

# Create a new project with proper structure
mkproject() {
    if [ -z "$1" ]; then
        echo "Usage: mkproject <project-name> [type]"
        echo "Types: python, node, rust, go, web, general"
        return 1
    fi
    
    local name="$1"
    local type="${2:-general}"
    local base_dir="$HOME/dev/projects/personal"
    
    # Determine project directory based on type
    case $type in
        python|javascript|rust|go|java|cpp|web)
            base_dir="$base_dir/$type"
            ;;
    esac
    
    local project_dir="$base_dir/$name"
    
    # Create project directory
    mkdir -p "$project_dir"
    cd "$project_dir"
    
    # Initialize git
    git init
    
    # Create README
    echo "# $name" > README.md
    echo "" >> README.md
    echo "## Description" >> README.md
    echo "TODO: Add project description" >> README.md
    echo "" >> README.md
    echo "## Setup" >> README.md
    echo "TODO: Add setup instructions" >> README.md
    
    # Create appropriate .gitignore
    case $type in
        python)
            cp ~/dev/tools/templates/gitignore/python.gitignore .gitignore
            mkdir -p src tests docs
            touch src/__init__.py
            touch requirements.txt
            ;;
        node|javascript)
            cp ~/dev/tools/templates/gitignore/node.gitignore .gitignore
            mkdir -p src tests docs
            npm init -y
            ;;
        rust)
            cargo init --name "$name"
            ;;
        go)
            go mod init "$name"
            mkdir -p cmd pkg internal
            ;;
        web)
            cp ~/dev/tools/templates/gitignore/node.gitignore .gitignore
            mkdir -p src/{css,js,images} dist
            touch src/index.html
            ;;
        *)
            cp ~/dev/tools/templates/gitignore/general.gitignore .gitignore
            mkdir -p src tests docs
            ;;
    esac
    
    # Create CLAUDE.md for Claude Code context
    ccnew
    
    # Initial commit
    git add .
    git commit -m "Initial commit: $name project setup"
    
    echo "✅ Project '$name' created at $project_dir"
    echo "📁 Type: $type"
    ls -la
}

# Archive a project
archiveproject() {
    if [ -z "$1" ]; then
        echo "Usage: archiveproject <project-path>"
        return 1
    fi
    
    local project="$1"
    local archive_dir="$HOME/dev/archive/$(date +%Y)"
    local project_name=$(basename "$project")
    
    mkdir -p "$archive_dir"
    
    # Create archive with timestamp
    local archive_name="${project_name}_archived_$(date +%Y%m%d_%H%M%S)"
    
    # Move project to archive
    mv "$project" "$archive_dir/$archive_name"
    
    # Create a reference file
    echo "Project: $project_name" > "$archive_dir/$archive_name/ARCHIVED.txt"
    echo "Archived on: $(date)" >> "$archive_dir/$archive_name/ARCHIVED.txt"
    echo "Original location: $project" >> "$archive_dir/$archive_name/ARCHIVED.txt"
    
    echo "✅ Project archived to: $archive_dir/$archive_name"
}

# List all active projects
lsp() {
    echo "🚀 Active Projects:"
    echo "=================="
    for dir in ~/dev/projects/*/*/; do
        if [ -d "$dir/.git" ]; then
            echo -n "📁 "
            echo -n "$(basename $(dirname "$dir"))/$(basename "$dir")"
            # Show last commit date
            if cd "$dir" 2>/dev/null; then
                last_commit=$(git log -1 --format="%cr" 2>/dev/null)
                if [ -n "$last_commit" ]; then
                    echo " (last commit: $last_commit)"
                else
                    echo " (no commits yet)"
                fi
                cd - > /dev/null
            else
                echo ""
            fi
        fi
    done
}

# Quick sandbox creation
mksandbox() {
    local name="${1:-test-$(date +%Y%m%d-%H%M%S)}"
    local sandbox_dir="$HOME/dev/sandbox/quick-tests/$name"
    mkdir -p "$sandbox_dir"
    cd "$sandbox_dir"
    echo "📦 Sandbox created: $sandbox_dir"
}

# Find project by name
findproject() {
    find ~/dev/projects -type d -name "*$1*" -not -path "*/\.*" | head -10
}

# Quick cd to project
cdp() {
    local results=$(findproject "$1")
    local count=$(echo "$results" | wc -l)
    
    if [ -z "$results" ]; then
        echo "No projects found matching '$1'"
        return 1
    elif [ "$count" -eq 1 ]; then
        cd "$results"
    else
        echo "Multiple projects found:"
        echo "$results" | nl
        echo -n "Select project number: "
        read num
        cd $(echo "$results" | sed -n "${num}p")
    fi
}

# Claude Code specific aliases and functions
alias cc='claude-code'
alias ccr='claude-code --resume'
alias ccp='claude-code --plan'
alias cch='claude-code --help'
alias ccmem='vim CLAUDE.md'

# Create CLAUDE.md if it doesn't exist
ccnew() {
    if [ ! -f "CLAUDE.md" ]; then
        echo "# Project Context for Claude Code" > CLAUDE.md
        echo "" >> CLAUDE.md
        echo "## Project Overview" >> CLAUDE.md
        echo "" >> CLAUDE.md
        echo "## Key Files and Directories" >> CLAUDE.md
        echo "" >> CLAUDE.md
        echo "## Development Guidelines" >> CLAUDE.md
        echo "" >> CLAUDE.md
        echo "## Common Commands" >> CLAUDE.md
        echo "" >> CLAUDE.md
        echo "CLAUDE.md created successfully!"
    else
        echo "CLAUDE.md already exists"
    fi
}

# Quick function to add a note to CLAUDE.md
ccnote() {
    if [ -f "CLAUDE.md" ]; then
        echo "" >> CLAUDE.md
        echo "## Note: $(date '+%Y-%m-%d %H:%M')" >> CLAUDE.md
        echo "$*" >> CLAUDE.md
        echo "Note added to CLAUDE.md"
    else
        echo "CLAUDE.md not found. Run 'ccnew' to create it."
    fi
}

# Environment variables
export CLAUDE_CODE_EDITOR="${EDITOR:-vim}"
export EDITOR='vim'

# Set language environment
export LANG=en_US.UTF-8

# === RUSTDESK REMOTE ACCESS OPTIMIZATIONS ===
# Wayland/X11 compatibility for RustDesk
export QT_QPA_PLATFORM=wayland
export GDK_BACKEND=wayland
export MOZ_ENABLE_WAYLAND=1

# X11 fallback for RustDesk (since it requires X11 for full functionality)
export RUSTDESK_X11_FALLBACK=1

# Function to start RustDesk with optimal settings
start_rustdesk() {
    echo "Starting RustDesk with optimized settings..."
    
    # Check if RustDesk is already running
    if pgrep rustdesk > /dev/null; then
        echo "RustDesk is already running"
        return
    fi
    
    # Force X11 for RustDesk (better compatibility)
    XDG_SESSION_TYPE=x11 GDK_BACKEND=x11 QT_QPA_PLATFORM=xcb rustdesk &
    
    echo "RustDesk started with X11 compatibility mode"
}

# Function to switch to X11 session (when needed for RustDesk)
switch_to_x11() {
    echo "To switch to X11 for better RustDesk compatibility:"
    echo "1. Log out of current session"
    echo "2. At login screen, click the gear icon (session options)"
    echo "3. Select 'Plasma (X11)' instead of 'Plasma (Wayland)'"
    echo "4. Log in with X11 session"
    echo ""
    echo "Or use X11 apps in Wayland with: XDG_SESSION_TYPE=x11 <command>"
}

# Docker BuildKit optimizations for remote development
export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1

# Development session aliases - flexible for multiple projects
alias saas-dev='tmux attach-session -t saas-dev || tmux new-session -s saas-dev -c ~/dev/projects/work/saas-platform'
alias dev-session='saas-dev'
alias tdev='tmux attach-session -t saas-dev'

# Quick access to different projects
alias cd-saas='cd ~/dev/projects/work/saas-platform'
alias cd-apiary='cd ~/dev/projects/work/apiary-pro-saas'
alias cd-saasy='cd ~/dev/projects/work/saasy'
alias work='cd ~/dev/projects/work'

# RustDesk optimization aliases
alias rustdesk-opt='rustdesk-optimized'
alias rustdesk-start='start_rustdesk'

# Docker GUI aliases  
alias docker-gui='echo "Docker GUI Options:"; echo "• lazydocker - Terminal UI"; echo "• Portainer - http://localhost:9000"; echo "• docker ps - Command line"'
alias lzd='lazydocker'
alias portainer-url='echo "Portainer Web UI: http://localhost:9000"'

# === PYTHON SECURITY AUDIT TOOLS ===

# Python security audit tool aliases and functions
alias security-audit='echo "Python Security Audit Tools:"; echo "• pip-audit    - Vulnerability scanner for pip packages"; echo "• safety       - Vulnerability scanner with PyUp database"; echo "• bandit       - Static security analysis for Python code"'

# Quick security scans
audit-requirements() {
    local req_file="${1:-requirements.txt}"
    if [ ! -f "$req_file" ]; then
        echo "❌ Requirements file not found: $req_file"
        echo "Usage: audit-requirements [requirements-file]"
        return 1
    fi
    
    echo "🔍 Running security audit on $req_file..."
    echo ""
    
    echo "📋 Safety Vulnerability Scan:"
    echo "════════════════════════════════"
    safety scan --file "$req_file" || safety check --file "$req_file" 2>/dev/null || echo "⚠️  Safety scan failed"
    echo ""
}

# Audit Python source code for security issues
audit-code() {
    local target_dir="${1:-.}"
    
    echo "🔍 Running static security analysis on $target_dir..."
    echo ""
    
    echo "🔒 Bandit Security Analysis:"
    echo "════════════════════════════════"
    bandit -r "$target_dir" -f txt --severity-level medium --skip B101,B601 2>/dev/null || echo "⚠️  Bandit analysis failed"
    echo ""
}

# Comprehensive security audit for Python projects  
audit-project() {
    local project_dir="${1:-.}"
    
    echo "🛡️  Comprehensive Python Security Audit for: $project_dir"
    echo "═══════════════════════════════════════════════════════════"
    
    # Find and audit requirements files
    echo ""
    echo "📦 Scanning dependency files..."
    find "$project_dir" -name "*requirements*.txt" -o -name "pyproject.toml" -o -name "poetry.lock" | while read req_file; do
        if [[ "$req_file" == *.txt ]]; then
            echo "🔍 Found requirements file: $req_file"
            safety scan --file "$req_file" 2>/dev/null || safety check --file "$req_file" 2>/dev/null || echo "⚠️  Could not scan $req_file"
            echo ""
        fi
    done
    
    # Static code analysis
    echo "🔍 Static code analysis..."
    if [ -d "$project_dir" ]; then
        bandit -r "$project_dir" -f txt --severity-level medium --skip B101,B601 2>/dev/null | head -30 || echo "⚠️  Bandit analysis failed"
    fi
    
    echo ""
    echo "✅ Security audit completed for $project_dir"
}

# Quick aliases for common security tasks  
alias audit-deps='audit-requirements'
alias audit-src='audit-code'
alias audit-all='audit-project'
alias security-help='echo "Security Audit Commands:"; echo "• audit-requirements [file] - Scan requirements file"; echo "• audit-code [directory]    - Static security analysis"; echo "• audit-project [directory] - Comprehensive project audit"; echo "• security-audit           - Show available tools"'

# === ZSH BEST PRACTICES AND OPTIMIZATIONS ===

# Performance optimizations
# Compile completion dump for faster startup
autoload -Uz compinit
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
    compinit
else
    compinit -C
fi

# Enable better completion system
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

# Useful Zsh options
setopt AUTO_CD              # cd into directory by typing its name
setopt AUTO_PUSHD           # Make cd push old directory onto stack
setopt PUSHD_IGNORE_DUPS    # Don't push duplicates
setopt CDABLE_VARS          # cd into variable values
setopt EXTENDED_GLOB        # Extended globbing
setopt GLOB_DOTS            # Include dotfiles in globbing
setopt INTERACTIVE_COMMENTS # Allow comments in interactive mode
setopt NO_BEEP              # No beeping
setopt CORRECT              # Command correction
setopt CORRECT_ALL          # Argument correction
setopt LOCAL_OPTIONS        # Allow functions to have local options
setopt LOCAL_TRAPS          # Allow functions to have local traps
setopt PROMPT_SUBST         # Parameter expansion in prompts

# Directory navigation improvements
setopt AUTO_NAME_DIRS       # Auto add variable-stored paths to hash list
setopt PUSHD_MINUS          # Exchange + and - for pushd/popd

# Directory shortcuts (hash -d)
hash -d dev=~/dev
hash -d proj=~/dev/projects
hash -d personal=~/dev/projects/personal
hash -d work=~/dev/projects/work
hash -d sandbox=~/dev/sandbox
hash -d dl=~/Downloads
hash -d docs=~/Documents
hash -d config=~/.config

# Global aliases (use with caution)
alias -g L='| less'
alias -g G='| grep'
alias -g H='| head'
alias -g T='| tail'
alias -g NE='2> /dev/null'
alias -g NUL='> /dev/null 2>&1'

# Suffix aliases (auto-open files)
alias -s {txt,md,markdown}=vim
alias -s {jpg,jpeg,png,gif}=xdg-open
alias -s {pdf,PDF}=xdg-open
alias -s {mp4,avi,mkv}=xdg-open

# Better directory navigation
alias d='dirs -v | head -10'
alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'

# Smart case-insensitive path completion
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'

# Faster key timeout (for vi mode if you use it)
export KEYTIMEOUT=1

# Enable edit command line in editor with Ctrl-x-e
autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

# Better history search
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Source env file safely to prevent tilde corruption
if [ -f "$HOME/.local/bin/env" ]; then
    . "$HOME/.local/bin/env" 2>/dev/null || true
fi

# bun completions
[ -s "/home/rclanan/.bun/_bun" ] && source "/home/rclanan/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="$HOME/.dotnet/tools:$PATH"

# Added by get-aspire-cli.sh
export PATH="$HOME/.aspire/bin:$PATH"
export PATH="$HOME/.aspire/bin:$PATH"
export PATH="$HOME/.dotnet:$PATH"
export PATH="$(npm config get prefix 2>/dev/null || echo ~/.npm-global)/bin:$PATH"
export PATH=~/.npm-global/bin:$PATH


# Enhanced terminal experience for Zsh

# Better less behavior with color support
export LESS='-R --use-color -Dd+r$Du+b$'
export LESS_TERMCAP_md=$'\e[1;34m'     # bold mode
export LESS_TERMCAP_me=$'\e[0m'       # end bold mode
export LESS_TERMCAP_se=$'\e[0m'       # end standout mode
export LESS_TERMCAP_so=$'\e[01;31m'   # standout mode
export LESS_TERMCAP_ue=$'\e[0m'       # end underline mode
export LESS_TERMCAP_us=$'\e[1;32m'    # underline mode

# FZF configurations (if installed)
if command -v fzf &> /dev/null; then
    export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND="fd --type d --hidden --follow --exclude .git"
fi

# Enhanced Docker aliases (beyond the existing ones)
if command -v docker &> /dev/null; then
    alias d='docker'
    alias dc='docker-compose'
    alias dps='docker ps'
    alias di='docker images'
    alias dcl='docker-compose logs'
    alias dcu='docker-compose up -d'
    alias dcd='docker-compose down'
    alias dex='docker exec -it'
    alias dlog='docker logs'
    alias drm='docker rm'
    alias drmi='docker rmi'
fi

# Python aliases and enhancements
if command -v python &> /dev/null; then
    alias py='python'
    alias pip='python -m pip'
    alias venv='python -m venv'
    alias py3='python3'
    alias pip3='python3 -m pip'
fi

# Node.js aliases and enhancements
if command -v node &> /dev/null; then
    alias n='npm'
    alias ni='npm install'
    alias ns='npm start'
    alias nt='npm test'
    alias nr='npm run'
    alias nrd='npm run dev'
    alias nrb='npm run build'
    alias nrl='npm run lint'
fi

# Enhanced directory colors
if command -v dircolors &> /dev/null; then
    if [ -r ~/.dircolors ]; then
        eval "$(dircolors -b ~/.dircolors)"
    else
        eval "$(dircolors -b)"
    fi
fi

# pnpm
export PNPM_HOME="/home/rclanan/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
