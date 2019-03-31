if zplug_installed bhilburn powerlevel9k; then
  export POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon vi_mode dir vcs)
  export POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status time battery)
  export POWERLEVEL9K_BATTERY_VERBOSE=false
  export POWERLEVEL9K_BATTERY_STAGES=($'\u2581 ' $'\u2582 ' $'\u2583 ' $'\u2584 ' $'\u2585 ' $'\u2586 ' $'\u2587 ' $'\u2588 ')
fi
