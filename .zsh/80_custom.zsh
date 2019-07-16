if zplug_installed bhilburn powerlevel9k; then
  if [[ -n $VIMRUNTIME ]]; then
    prompt_powerlevel9k_teardown
    PROMPT='$ '
  else
    # for prompt
    export POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(vi_mode kubecontext)
    export POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()
  fi
fi

if zplug_installed git-duet git-duet; then
  export GIT_DUET_AUTHORS_FILE=$HOME/.git-authours
fi
