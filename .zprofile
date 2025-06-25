# autoload
autoload -Uz run-help
autoload -Uz add-zsh-hook
autoload -Uz colors && colors
autoload -Uz compinit && compinit -u
autoload -Uz is-at-least
autoload -U +X bashcompinit && bashcompinit

typeset -gx -U path
path=( \
        ~/bin(N-/) \
        /opt/homebrew/bin(N-/) \
        ~/.local/share/aquaproj-aqua/bin(N-/) \
        ~/ghq/bin(N-/) \
        /usr/local/bin(N-/) \
        /usr/sbin(N-/) \
        ~/.local/bin(N-/) \
        ~/.tmux/bin(N-/) \
        $NPM_CONFIG_PREFIX/bin(N-/) \
        /usr/local/opt/libpq/bin(N-/) \
        /usr/local/opt/llvm/bin(N-/) \
        /opt/homebrew/opt/openjdk@17/bin(N-/) \
        $HOME/.krew/bin(N-/) \
        ~/Library/Application\ Support/Coursier/bin(N-/) \
        ~/.cargo/bin(N-/) \
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
