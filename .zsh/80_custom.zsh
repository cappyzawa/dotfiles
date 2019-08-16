if zplug_installed romkatv powerlevel10k; then
  if [[ -n $VIMRUNTIME ]]; then
    prompt_powerlevel9k_teardown
    PROMPT='$ '
  else
    # for prompt
    export POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(vi_mode dir vcs)
    export POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()

    # for dir
    export POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
    export POWERLEVEL9K_SHORTEN_DELIMITER="…"
    export POWERLEVEL9K_SHORTEN_STRATEGY="truncate_middle"
  fi
fi
if zplug_installed git-duet git-duet; then
  export GIT_DUET_AUTHORS_FILE=$HOME/.git-authours
fi

if has 'kubectl'; then
  source <(kubectl completion zsh)
fi

if has 'tkn'; then
  source <(tkn completion zsh)
  if [[ ! -e '/usr/local/bin/kubectl-tkn' ]]; then
    ln -s `which tkn` /usr/local/bin/kubectl-tkn
  fi
fi

if has 'ko'; then
  source <(ko completion --zsh)
  export KO_DOCKER_REPO='cappyzawa'
fi

export KREW_ROOT=${KREW_ROOT:-$HOME/.krew}
if [[ -d $KREW_ROOT ]]; then
  export PATH="${KREW_ROOT}/bin:$PATH"
fi

which jenv > /dev/null
if [[ $? == 0 ]]; then
  export JAVA_HOME="$HOME/.anyenv/envs/jenv/versions/`jenv version-name`"
fi

