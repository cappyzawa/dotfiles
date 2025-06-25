# Lazy loading hook for afx
# This file contains the hook setup for afx lazy loading

_lazy_load_afx() {
    eval "$(afx init)"
    unfunction _lazy_load_afx
}

# Register hook if afx is available
if command -v afx &> /dev/null; then
    function _afx_hook() {
        _lazy_load_afx
        unfunction _afx_hook
    }
    autoload -Uz add-zsh-hook
    add-zsh-hook precmd _afx_hook
fi