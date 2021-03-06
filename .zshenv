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
    ~/.julia/conda/3/bin(N-/) \
    ~/.nimble/bin(N-/) \
    ~/Library/ApplicationSupport/Coursier/bin(N-/) \
    /usr/local/opt/libpq/bin(N-/) \
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
if (command -v nvim > /dev/null); then
  export EDITOR=nvim
fi

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
export XDG_DATA_HOME="$HOME/.local/share"
export ANYENV_ROOT="${XDG_CONFIG_HOME}/anyenv"

# FZF
## gruvbox
# export FZF_DEFAULT_OPTS='--color=fg:#928374,bg:#282828,hl:#79740e --color=fg+:#928374,bg+:#282828,hl+:#b8bb26 --color=info:#98971a,prompt:#fabd2f,pointer:#fabd2f --color=marker:#83a598,spinner:#fabd2f,header:#928374 --extended --ansi --multi'

## tokyonight
# export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS' --color=fg:#a9b1d6,bg:#1a1b26,hl:#7aa2f7 --color=fg+:#a9b1d6,bg+:#1a1b26,hl+:#4abaaf --color=info:#e0af68,prompt:#f7768e,pointer:#a9b1d6 --color=marker:#9ece6a,spinner:#9a7ecc,header:#acb0d0'

## zephyr
# export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS' --color=fg:#bbc2cf,bg:#282c34,hl:#2e323c --color=fg+:#5b6268,bg+:#504945,hl+:#b3deef --color=info:#ecbe7b,prompt:#ff6c6b,pointer:#1abc9c --color=marker:#98be65,spinner:#a9a1e1,header:#98be65'

# available $INTERACTIVE_FILTER
export INTERACTIVE_FILTER="fzf:peco:percol:gof:pick"

export DOTPATH=${0:A:h}
export TERM="screen-256color"
export ZDOTDIR=${HOME}
