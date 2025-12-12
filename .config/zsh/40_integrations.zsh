# Tool integrations

# direnv hook
if command -v direnv &>/dev/null; then
    eval "$(direnv hook zsh)"
fi

# AWS CLI completion
if command -v aws_completer &>/dev/null; then
    autoload -Uz bashcompinit && bashcompinit
    complete -C aws_completer aws
fi

# Starship prompt
if command -v starship &>/dev/null; then
    eval "$(starship init zsh)"
fi

# Dropbox link compatibility
# Create compatibility symlink for Dropbox (new path -> old path)
if [[ ! -e "${HOME}/Dropbox" && -e "${HOME}/Library/CloudStorage/Dropbox" ]]; then
    ln -s "${HOME}/Library/CloudStorage/Dropbox" "${HOME}/Dropbox"
fi
