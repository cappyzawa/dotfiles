# bashcompinit and compinit are already loaded in .zprofile

autoload -Uz colors
colors

# Lazy load heavy initializations
_lazy_load_afx() {
    if ! command -v afx &> /dev/null; then
        curl -sL https://raw.githubusercontent.com/b4b4r07/afx/HEAD/hack/install | bash
    fi
    eval "$(afx init)"
    unfunction _lazy_load_afx
}

_lazy_load_starship() {
    if command -v starship &> /dev/null; then
        eval "$(starship init zsh)"
        unfunction _lazy_load_starship
    fi
}

# Set up lazy loading
if command -v afx &> /dev/null; then
    # Setup minimal prompt first, then lazy load
    export PS1='%n@%m:%~$ '
    
    # Hook into first command execution
    function _first_command_hook() {
        _lazy_load_afx
        _lazy_load_starship
        unfunction _first_command_hook
    }
    
    # Use precmd to trigger lazy loading
    autoload -Uz add-zsh-hook
    add-zsh-hook precmd _first_command_hook
else
    # If afx not available, setup minimal environment
    export PS1='%n@%m:%~$ '
    _lazy_load_starship
fi

if [[ -f ~/.zshrc.local ]]; then
    source ~/.zshrc.local
fi
