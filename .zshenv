typeset -gx -U path
path=( \
    /usr/local/bin(N-/) \
    ~/bin(N-/) \
    /usr/sbin(N-/) \
    ~/.config/anyenv/bin(N-/) \
    ~/.local/bin(N-/) \
    ~/.tmux/bin(N-/) \
    ~/.nimble/bin(N-/) \
    ~/.yarn/bin(N-/) \
    "$path[@]" \
    )

# autoload
autoload -Uz run-help
autoload -Uz add-zsh-hook
autoload -Uz colors && colors
autoload -Uz compinit && compinit -u
autoload -Uz is-at-least
autoload -U +X bashcompinit && bashcompinit


# LANGUAGE must be set by en_US
export LANGUAGE="en_US.UTF-8"
export LANG="${LANGUAGE}"
export LC_ALL="${LANGUAGE}"
export LC_CTYPE="${LANGUAGE}"

# Editor
export EDITOR=vim
export CVSEDITOR="${EDITOR}"
export SVN_EDITOR="${EDITOR}"
export GIT_EDITOR="${EDITOR}"

# Pager
export PAGER=less
# Less status line
export LESS='-R -f -X -i -P ?f%f:(stdin). ?lb%lb?L/%L.. [?eEOF:?pb%pb\%..]'
export LESSCHARSET='utf-8'

# LESS man page colors (makes Man pages more readable).
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[00;44;37m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

setopt no_global_rcs
# Add ~/bin to PATH
export PATH=~/bin:"$PATH"

# Settings for golang
if ! [ -d $HOME/ghq ]; then
  mkdir $HOME/ghq
fi
export GOPATH="$HOME/ghq"
export GOBIN="$GOPATH/bin"
export PATH="$GOBIN:$PATH"
export GOENV_DISABLE_GOPATH=1
export GOPRIVATE="*.yahoo.co.jp"

# Setting for rust
export PATH=$PATH:$HOME/.cargo/bin

# declare the environment variables
export CORRECT_IGNORE='_*'
export CORRECT_IGNORE_FILE='.*'

export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
export WORDCHARS='*?.[]~&;!#$%^(){}<>'

# fzf - command-line fuzzy finder (https://github.com/junegunn/fzf)
export FZF_DEFAULT_OPTS="--extended --ansi --multi"

# Cask
#export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# History
# History file
export HISTFILE=~/.zsh_history
# History size in memory
export HISTSIZE=10000
# The number of histsize
export SAVEHIST=1000000
# The size of asking history
export LISTMAX=50
# Do not add in root
if [[ $UID == 0 ]]; then
    unset HISTFILE
    export SAVEHIST=0
fi

# Config
export XDG_CONFIG_HOME="$HOME/.config"
export ANYENV_ROOT="${XDG_CONFIG_HOME}/anyenv"

# available $INTERACTIVE_FILTER
export INTERACTIVE_FILTER="fzf:peco:percol:gof:pick"

export DOTPATH=${0:A:h}
export TERM="xterm-256color"
