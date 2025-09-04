#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Terminal capabilities and color support
export TERM="xterm-256color"
export COLORTERM="truecolor"
[ -n "$TMUX" ] && export TERM="screen-256color"

# Development shortcuts
alias saas-dev="tmux new-session -A -s saas-dev"
alias tmux-dev="tmux new-session -A -s saas-dev"

# History settings
export HISTSIZE=10000
export HISTFILESIZE=20000
export HISTCONTROL=ignoreboth:erasedups
export HISTIGNORE="ls:ll:la:l:cd:pwd:exit:clear:c:h"
shopt -s histappend
shopt -s cmdhist

# Shell options
shopt -s checkwinsize
shopt -s cdspell
shopt -s nocaseglob
shopt -s dotglob

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

# Git aliases
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'
alias gd='git diff'
alias gb='git branch'
alias gco='git checkout'
# Better prompt with git branch
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Colored prompt with git info
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[01;33m\]$(parse_git_branch)\[\033[00m\]\$ '
export PATH=$HOME/.npm-global/bin:$PATH

# Rust configuration
if [ -f "$HOME/.cargo/env" ]; then
    source "$HOME/.cargo/env"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

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
fd() {
    find . -type d -name "*$1*"
}

# Show file sizes sorted
duf() {
    du -sh * | sort -h
}

# Directory navigation
# Keep track of visited directories
export CDPATH=".:~:~/Documents:~/Downloads"

# Better cd with history
cd() {
    builtin cd "$@" && ls
}

# Go back to previous directory
alias back='cd "$OLDPWD"'

# Create directory bookmarks
alias bm='echo "alias $(basename $(pwd))=\"cd $(pwd)\"" >> ~/.bashrc && source ~/.bashrc'

# Claude Code specific aliases and functions
# Quick access to Claude Code
alias cc='claude-code'

# Claude Code with common options
alias ccr='claude-code --resume'
alias ccp='claude-code --plan'
alias cch='claude-code --help'

# Open Claude Code memory file
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

# Environment variable for Claude Code settings
export CLAUDE_CODE_EDITOR="${EDITOR:-vim}"









# Enhanced color support for various commands
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

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

# Enhanced aliases for better productivity
# Docker aliases (if docker is available)
if command -v docker &> /dev/null; then
    alias d='docker'
    alias dc='docker-compose'
    alias dps='docker ps'
    alias di='docker images'
    alias dcl='docker-compose logs'
    alias dcu='docker-compose up -d'
    alias dcd='docker-compose down'
fi

# Python aliases (if python is available)
if command -v python &> /dev/null; then
    alias py='python'
    alias pip='python -m pip'
    alias venv='python -m venv'
fi

# Node.js aliases (if node is available)
if command -v node &> /dev/null; then
    alias n='npm'
    alias ni='npm install'
    alias ns='npm start'
    alias nt='npm test'
    alias nr='npm run'
fi

eval "$(starship init bash)"

. "$HOME/.local/bin/env"
