umask 022
limit coredumpsize 0
bindkey -d

# Check if zplugin is installed
if [[ ! -d ~/.zplugin ]]; then
  git clone https://github.com/zdharma/zplugin.git ~/.zplugin/bin
fi

if [[ -f ~/.zplugin/bin/zplugin.zsh ]]; then
  source ~/.zplugin/bin/zplugin.zsh
  autoload -Uz _zplugin
  if [[ "${+_comps}" == 1 ]]; then
    _comps[zplugin]=_zplugin
  fi

  source ~/.zsh/zplugin.zsh
fi

if (which starship > /dev/null) then
  eval "$(starship init zsh)"
fi

if [[ -f ~/.zshrc.local ]]; then
  source ~/.zshrc.local
fi
