# autoload
autoload -Uz run-help
autoload -Uz add-zsh-hook
autoload -Uz colors && colors
autoload -Uz compinit && compinit -u
autoload -Uz is-at-least
autoload -U +X bashcompinit && bashcompinit

typeset -gx -U path
path=( \
        ~/.nix-profile/bin(N-/) \
        ~/bin(N-/) \
        /opt/homebrew/bin(N-/) \
        /opt/homebrew/opt/ruby/bin(N-/) \
        $(gem environment gemdir)/bin(N-/) \
        ~/.local/share/aquaproj-aqua/bin(N-/) \
        ~/ghq/bin(N-/) \
        /usr/local/bin(N-/) \
        /usr/sbin(N-/) \
        ~/.local/bin(N-/) \
        ~/.tmux/bin(N-/) \
        ~/.nimble/bin(N-/) \
        ~/.yarn/bin(N-/) \
        ~/.julia/conda/3/bin(N-/) \
        ~/.nimble/bin(N-/) \
        ~/.deno/bin(N-/) \
        ~/Library/ApplicationSupport/Coursier/bin(N-/) \
        /usr/local/opt/libpq/bin(N-/) \
        /usr/local/opt/llvm/bin(N-/) \
        ~/.gem/ruby/2.6.0/bin(N-/) \
        ~/Library/Python/3.9/bin(N-/) \
        /opt/homebrew/opt/openjdk@17/bin(N-/) \
        $HOME/.krew/bin(N-/) \
        ~/.luarocks/bin(N-/) \
        ~/Library/Application\ Support/Coursier/bin(N-/) \
        ~/.cargo/bin(N-/) \
        ~/.rd/bin(N-/) \
        ~/.tmux/plugins/tpm/bin(N-/) \
        "$path[@]" \
    )


typeset -gx -U fpath
fpath=( \
        ~/.zsh/Completion(N-/) \
        ~/.zsh/functions(N-/) \
        ~/.zsh/plugins/zsh-completions(N-/) \
        /usr/local/share/zsh/site-functions(N-/) \
        $fpath \
    )


# LANGUAGE must be set by en_US
export LANGUAGE="en_US.UTF-8"
export LANG="${LANGUAGE}"
export LC_ALL="${LANGUAGE}"
export LC_CTYPE="${LANGUAGE}"

# Editor
export EDITOR=vim
if (type nvim > /dev/null); then
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

# ls command colors
export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

# declare the environment variables
export CORRECT_IGNORE='_*'
export CORRECT_IGNORE_FILE='.*'

#export WORDCHARS='*?[]~&;!#$%^(){}<>'
#export WORDCHARS='*?.[]~&;!#$%^(){}<>'
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# History file and its size
export HISTFILE=~/.zsh_history
export HISTSIZE=1000000
export SAVEHIST=1000000
# The size of asking history
export LISTMAX=50
# Do not add in root
if [[ $UID == 0 ]]; then
    unset HISTFILE
    export SAVEHIST=0
fi

ARCH=$(uname -m)
if [[ $ARCH == arm64 ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ $ARCH == x86_64 ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi
export ARCH
export LDFLAGS="-L$HOMEBREW_PREFIX/lib"

if [[ ! -e "$HOME/Dropbox" ]] && [[ -e "$HOME/Library/CloudStorage/Dropbox" ]]; then
    ln -s "$HOME/Library/CloudStorage/Dropbox" "$HOME/Dropbox"
fi
