if zplug_installed bhilburn powerlevel9k; then
  # for prompt
  export POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon vi_mode dir vcs)
  export POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status time battery)

  # for battery
  export POWERLEVEL9K_BATTERY_VERBOSE=false
  export POWERLEVEL9K_BATTERY_STAGES=($'\u2581 ' $'\u2582 ' $'\u2583 ' $'\u2584 ' $'\u2585 ' $'\u2586 ' $'\u2587 ' $'\u2588 ')

  # for dir
  export POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
  export POWERLEVEL9K_SHORTEN_DELIMITER="…"
  export POWERLEVEL9K_SHORTEN_STRATEGY="truncate_middle"
fi

if zplug_installed git-duet git-duet; then
  export GIT_DUET_AUTHORS_FILE=$HOME/.git-authours
fi
