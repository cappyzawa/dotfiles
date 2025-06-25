# bashcompinit and compinit are already loaded in .zprofile

autoload -Uz colors
colors

# Load all lazy loading hooks
for hook in ~/.zsh/hooks/*.zsh(N); do
    source "$hook"
done

if [[ -f ~/.zshrc.local ]]; then
    source ~/.zshrc.local
fi
