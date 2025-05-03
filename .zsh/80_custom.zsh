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

export KREW_ROOT=${KREW_ROOT:-$HOME/.krew}
if [[ -d $KREW_ROOT ]]; then
    export PATH="${KREW_ROOT}/bin:$PATH"
fi

if has "julia"; then
    export LD_LIBRARY_PATH=$HOME/.julia/conda/3/lib
    if is_osx; then
        export JULIA_NUM_THREADS=`sysctl -n hw.physicalcpu`
    elif is_linux; then
        export JULIA_NUM_THREADS=`nproc`
    fi
fi

if has "rbenv"; then
    eval "$(rbenv init -)"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh" # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

if [[ -f "$HOME/.config/op/plugins.sh" ]]; then
    # shellcheck source=/dev/null
    source "$HOME/.config/op/plugins.sh"
fi
