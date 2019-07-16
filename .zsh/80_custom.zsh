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
