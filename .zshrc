# .zshrc - Interactive shell configuration

# Add custom completions to fpath
fpath=(~/.config/zsh/completions $fpath)

# Completion system initialization (daily check for performance)
autoload -Uz compinit
if [[ "$(date +'%j')" != "$(stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)" ]]; then
    compinit
else
    compinit -C
fi

# Load sheldon plugins
eval "$(sheldon source)"

# Load local configuration (machine-specific, secrets)
# shellcheck source=/dev/null
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
