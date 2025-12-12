# Aliases

# Navigation and listing
alias ..='cd ..'
alias l='ls -l'
alias ll='ls -lF'
alias lla='ls -lAF'
alias la='ls -AF'
alias lx='ls -lXB'
alias lk='ls -lSr'
alias lc='ls -ltcr'
alias lu='ls -ltur'
alias lt='ls -ltr'
alias lr='ls -lR'

# System utilities
alias du='du -h'
alias job='jobs -l'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# macOS specific
if [[ "$(uname -s)" == "Darwin" ]]; then
    if command -v brew &>/dev/null; then
        alias ctags="$(brew --prefix)/bin/ctags"
    fi
    alias flushdns='sudo killall -HUP mDNSResponder'
fi

# Architecture switching
alias arm='exec arch -arch arm64 /opt/homebrew/bin/zsh'
alias x64='exec arch -arch x86_64 /usr/local/bin/zsh'

# Git
if command -v git &>/dev/null; then
    alias gst='git status'
fi

# 1Password integration for aqua
if command -v op &>/dev/null; then
    alias aqua='GITHUB_TOKEN=$(op read -f "op://Private/GitHub Personal Access Token/token") aqua'
fi

# Development tools
if command -v kubectl &>/dev/null; then
    alias k='kubectl'
fi

if command -v eza &>/dev/null; then
    alias ls='eza'
elif command -v exa &>/dev/null; then
    alias ls='exa'
fi

if command -v lazygit &>/dev/null; then
    alias lg='lazygit'
fi

if command -v lazydocker &>/dev/null; then
    alias ld='lazydocker'
fi

# Editor alias
if command -v hx &>/dev/null; then
    alias vim='hx'
elif command -v nvim &>/dev/null; then
    alias vim='nvim'
fi
