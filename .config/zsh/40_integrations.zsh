# Tool integrations

# AWS CLI completion
if command -v aws_completer &>/dev/null; then
    autoload -Uz bashcompinit && bashcompinit
    complete -C aws_completer aws
fi

# Dropbox link compatibility
# Create compatibility symlink for Dropbox (new path -> old path)
if [[ ! -e "${HOME}/Dropbox" && -e "${HOME}/Library/CloudStorage/Dropbox" ]]; then
    ln -s "${HOME}/Library/CloudStorage/Dropbox" "${HOME}/Dropbox"
fi
