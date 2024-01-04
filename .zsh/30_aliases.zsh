alias p="print -l"

if has 'git'; then
  alias gst='git status'
fi

if has 'nvim'; then
  alias vim='nvim'
fi

# Common aliases
alias ..='cd ..'
alias l="ls -l"
alias lla='ls -lAF'    # Show hidden all files
alias ll='ls -lF'      # Show long file information
alias la='ls -AF'      # Show hidden files
alias lx='ls -lXB'     # Sort by extension
alias lk='ls -lSr'     # Sort by size, biggest last
alias lc='ls -ltcr'    # Sort by and show change time, most recent last
alias lu='ls -ltur'    # Sort by and show access time, most recent last
alias lt='ls -ltr'     # Sort by date, most recent last
alias lr='ls -lR'      # Recursive ls

alias du='du -h'
alias job='jobs -l'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias flushdns='sudo killall -HUP mDNSResponder'

if is_osx; then
  alias ctags="`brew --prefix`/bin/ctags"
fi

alias -g vy="| vim '+set filetype=yaml buftype=nofile'"

alias arm="exec arch -arch arm64 /bin/zsh --login"
alias x64="exec arch -arch x86_64 /bin/zsh --login"
