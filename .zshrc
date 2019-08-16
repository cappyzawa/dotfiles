umask 022
limit coredumpsize 0
bindkey -d

# Check if zplug is installed
if [[ ! -d ~/.zplug ]]; then
  git clone https://github.com/zplug/zplug ~/.zplug
fi

if [[ -f ~/.zplug/init.zsh ]]; then
  export ZPLUG_LOADFILE=~/.zsh/zplug.zsh
  source ~/.zplug/init.zsh

  # if ! zplug check --verbose; then
  #   printf "Install? [y/N]: "
  #   if read -q; then
  #     echo; zplug install
  #   fi
  #   echo
  # fi
  zplug load
fi

export PATH="$HOME/.anyenv/bin:$PATH"
if ! eval "$(anyenv init -)"; then
  anyenv install --force-init
fi

if has "direnv"; then
  eval "$(direnv hook zsh)"
fi

if has "starship"; then
  eval "$(starship init zsh)"
fi

if [[ -f ~/.zshrc.local ]]; then
  source ~/.zshrc.local
fi
