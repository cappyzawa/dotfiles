umask 022
limit coredumpsize 0
bindkey -d
autoload -U +X bashcompinit && bashcompinit

source ~/.zsh/10_utils.zsh

if ! has "aqua"; then
    curl -sSfL https://raw.githubusercontent.com/aquaproj/aqua-installer/v2.1.2/aqua-installer | bash
fi

source "${ZINIT_HOME}/zinit.zsh"
source ~/.zsh/zinit.zsh

if has "starship"; then
    eval "$(starship init zsh)"
fi

if [[ -f ~/.zshrc.local ]]; then
    source ~/.zshrc.local
fi
