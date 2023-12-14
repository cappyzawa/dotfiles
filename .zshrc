autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit
compinit

autoload -Uz colors
colors

if ! command -v afx &> /dev/null; then
    curl -sL https://raw.githubusercontent.com/b4b4r07/afx/HEAD/hack/install | bash
fi

source <(afx init)
# word split: `-`, `_`, `.`, `=`
export WORDCHARS='*?[]~&;!#$%^(){}<>'

if [[ -f ~/.zshrc.local ]]; then
    source ~/.zshrc.local
fi
