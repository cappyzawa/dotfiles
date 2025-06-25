# autoload
autoload -Uz run-help
autoload -Uz add-zsh-hook
autoload -Uz colors && colors
autoload -Uz compinit && compinit -u
autoload -Uz is-at-least
autoload -U +X bashcompinit && bashcompinit

# afx Package Manager Setup (lazy loaded)
# Essential PATH (~/bin, aqua) are already set in .zshenv
# afx manages local scripts via .config/afx/local.yaml
# Heavy initializations (starship) are loaded via .zsh/hooks/

# Install afx if not available
if ! command -v afx &> /dev/null; then
    curl -sL https://raw.githubusercontent.com/b4b4r07/afx/HEAD/hack/install | bash
fi

# Lazy load afx on first command execution (precmd hook)
# This keeps shell startup fast (~15ms) while maintaining functionality
_lazy_load_afx() {
    source <(afx init)
    unfunction _lazy_load_afx
}

# Register precmd hook to trigger afx initialization
function _afx_hook() {
    _lazy_load_afx
    unfunction _afx_hook
}
autoload -Uz add-zsh-hook
add-zsh-hook precmd _afx_hook

# Configure fpath for completions
typeset -gx -U fpath
fpath=( \
        ~/.zsh/Completion(N-/) \
        ~/.zsh/functions(N-/) \
        ~/.zsh/plugins/zsh-completions(N-/) \
        /usr/local/share/zsh/site-functions(N-/) \
        $fpath \
    )

# Architecture-specific Homebrew setup
ARCH=$(uname -m)
if [[ $ARCH == arm64 ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ $ARCH == x86_64 ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi
export ARCH
export LDFLAGS="-L$HOMEBREW_PREFIX/lib"

# Create Dropbox symlink if needed
if [[ ! -e "$HOME/Dropbox" ]] && [[ -e "$HOME/Library/CloudStorage/Dropbox" ]]; then
    ln -s "$HOME/Library/CloudStorage/Dropbox" "$HOME/Dropbox"
fi
