umask 022
limit coredumpsize 0
bindkey -d
autoload -U +X bashcompinit && bashcompinit

source "${ZINIT_HOME}/zinit.zsh"
source ~/.zsh/zinit.zsh

if (command -v starship > /dev/null) then
  eval "$(starship init zsh)"
fi

if [[ -f ~/.zshrc.local ]]; then
  source ~/.zshrc.local
fi
