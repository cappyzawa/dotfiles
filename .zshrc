umask 022
limit coredumpsize 0
bindkey -d
autoload -U +X bashcompinit && bashcompinit

if ! command -v afx &> /dev/null; then
    curl -sL https://raw.githubusercontent.com/b4b4r07/afx/HEAD/hack/install | bash
fi

source <(afx init)
source <(afx completion zsh)

if [[ -f ~/.zshrc.local ]]; then
    source ~/.zshrc.local
fi
