if has "fzf"; then
    export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
      --highlight-line \
      --info=inline-right \
      --ansi \
      --layout=reverse \
      --border=none \
      --color=bg+:#283457 \
      --color=bg:#16161e \
      --color=border:#27a1b9 \
      --color=fg:#c0caf5 \
      --color=gutter:#16161e \
      --color=header:#ff9e64 \
      --color=hl+:#2ac3de \
      --color=hl:#2ac3de \
      --color=info:#545c7e \
      --color=marker:#ff007c \
      --color=pointer:#ff007c \
      --color=prompt:#2ac3de \
      --color=query:#c0caf5:regular \
      --color=scrollbar:#27a1b9 \
      --color=separator:#ff9e64 \
      --color=spinner:#ff007c \
    "
fi

if has "op"; then
    #shellcheck disable=SC1091
    source "$XDG_CONFIG_HOME/op/plugins.sh"
fi

# Set KREW_ROOT and add to PATH dynamically
export KREW_ROOT=${KREW_ROOT:-$HOME/.krew}

# Use dynamic PATH management - this will override the static path in .zprofile
# and ensure the current KREW_ROOT value is used
path_add '$KREW_ROOT/bin'
