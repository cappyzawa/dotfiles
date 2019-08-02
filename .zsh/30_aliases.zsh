alias p="print -l"

if has 'git'; then
  alias gst='git status'
fi

if (( $+commands[gls] )); then
  alias ls='gls -F --color --group-directories-first'
elif (( $+commands[ls] )); then
  if is_osx; then
    alias ls='ls -GF'
  else
  alias ls='ls -F --color'
  fi
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

# Use if colordiff exists
if has 'colordiff'; then
  alias diff='colordiff -u'
else
  alias diff='diff -u'
fi

if has "emojify"; then
  alias -g E='| emojify'
fi

if has "jq"; then
  alias -g JQ='| jq -C .'
  alias -g JL='| jq -C . | less -R -X'
fi

if has "nvim"; then
  alias vim='nvim'
fi

if has "lazygit"; then
  alias lg='lazygit'
fi

if has "lazydocker"; then
  alias ld='lazydocker'
fi

if is_osx; then
  alias -g CP='| pbcopy'
  alias -g CC='| tee /dev/tty | pbcopy'
fi

if is_osx; then
  alias ctags="`brew --prefix`/bin/ctags"
fi

if has "kubectl"; then
  alias k='kubectl'
fi

# TODO: remove
alias gofmt="find . -not -path './vendor/*' -and -name '*.go' | xargs gofmt -w"

alias lgtm="echo '![LGTM](//lgtmoon.herokuapp.com/images/23050)'|pbcopy"
