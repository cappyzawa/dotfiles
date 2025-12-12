# .zshrc - Interactive shell configuration

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
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
