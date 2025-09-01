# Common navigation and listing aliases
alias ..='cd ..'
alias l='ls -l'
alias lla='ls -lAF'
alias ll='ls -lF'
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
if test (uname -s) = Darwin
    if type -q brew
        set -l brew_prefix (brew --prefix)
        alias ctags="$brew_prefix/bin/ctags"
    end
    alias flushdns='sudo killall -HUP mDNSResponder'
end

# Architecture switching (adapted for fish)
alias arm='exec arch -arch arm64 /opt/homebrew/bin/fish'
alias x64='exec arch -arch x86_64 /usr/local/bin/fish'

