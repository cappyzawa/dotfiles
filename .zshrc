# bashcompinit は .zprofile で既に読み込まれている
# compinit も .zprofile で既に読み込まれている

autoload -Uz colors
colors

if ! command -v afx &> /dev/null; then
    curl -sL https://raw.githubusercontent.com/b4b4r07/afx/HEAD/hack/install | bash
fi

source <(afx init)

if command -v starship &> /dev/null; then
    eval "$(starship init zsh)"
fi

if [[ -f ~/.zshrc.local ]]; then
    source ~/.zshrc.local
fi
