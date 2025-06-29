#!/usr/bin/env bash
## switch to zsh (if exists)
if [ -n "$PS1" ]; then # interactive only
  for prog in /usr/bin/zsh /bin/zsh /usr/local/bin/zsh; do
    [ -x "$prog" ] && exec "$prog" "$@"
  done
fi

complete -C /usr/local/bin/vault vault

# shellcheck source=/dev/null
. "$HOME/.cargo/env"
