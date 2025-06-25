# Lazy loading hook for starship
# This file contains the hook setup for starship lazy loading

_lazy_load_starship() {
    eval "$(starship init zsh)"
    unfunction _lazy_load_starship
}

# Register hook if starship is available
if command -v starship &> /dev/null; then
    function _starship_hook() {
        _lazy_load_starship
        unfunction _starship_hook
    }
    autoload -Uz add-zsh-hook
    add-zsh-hook precmd _starship_hook
fi
