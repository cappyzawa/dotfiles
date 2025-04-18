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
