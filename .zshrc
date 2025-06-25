# bashcompinit and compinit are already loaded in .zprofile

autoload -Uz colors
colors

if [[ -f ~/.zshrc.local ]]; then
    source ~/.zshrc.local
fi
