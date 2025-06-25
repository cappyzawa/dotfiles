# autoload
autoload -Uz run-help
autoload -Uz add-zsh-hook
autoload -Uz colors && colors
autoload -Uz compinit && compinit -u
autoload -Uz is-at-least
autoload -U +X bashcompinit && bashcompinit

# Initialize PATH with unique flag
typeset -gx -U path

# Use dynamic PATH management for better flexibility
# Note: Order matters - first added = highest priority
path_add ~/bin
path_add /opt/homebrew/bin
path_add ~/.local/share/aquaproj-aqua/bin
path_add ~/ghq/bin
path_add /usr/local/bin
path_add /usr/sbin
path_add ~/.local/bin
path_add ~/.tmux/bin
path_add '$NPM_CONFIG_PREFIX/bin'
path_add /usr/local/opt/libpq/bin
path_add /usr/local/opt/llvm/bin
path_add /opt/homebrew/opt/openjdk@17/bin
path_add '$HOME/.krew/bin'
path_add '~/Library/Application Support/Coursier/bin'
path_add ~/.cargo/bin
path_add ~/.tmux/plugins/tpm/bin


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
