typeset -gx -U path
path=( \
        ~/bin(N-/) \
        /opt/homebrew/bin(N-/) \
        ~/.local/share/aquaproj-aqua/bin(N-/) \
        ~/ghq/bin(N-/) \
        /usr/local/bin(N-/) \
        /usr/sbin(N-/) \
        ~/.local/bin(N-/) \
        ~/.tmux/bin(N-/) \
        ~/.nimble/bin(N-/) \
        ~/.yarn/bin(N-/) \
        ~/.julia/conda/3/bin(N-/) \
        ~/.nimble/bin(N-/) \
        ~/.deno/bin(N-/) \
        ~/Library/ApplicationSupport/Coursier/bin(N-/) \
        /usr/local/opt/libpq/bin(N-/) \
        /usr/local/opt/llvm/bin(N-/) \
        ~/.gem/ruby/2.6.0/bin(N-/) \
        ~/Library/Python/3.9/bin(N-/) \
        /opt/homebrew/opt/openjdk@17/bin(N-/) \
        $HOME/.krew/bin(N-/) \
        ~/.luarocks/bin(N-/) \
        ~/Library/Application\ Support/Coursier/bin(N-/) \
        ~/.cargo/bin(N-/) \
        ~/.rd/bin(N-/) \
        ~/.tmux/plugins/tpm/bin(N-/) \
        "$path[@]" \
    )


typeset -gx -U fpath
fpath=( \
        ~/.zsh/Completion(N-/) \
        ~/.zsh/functions(N-/) \
        ~/.zsh/plugins/zsh-completions(N-/) \
        /usr/local/share/zsh/site-functions(N-/) \
        $fpath \
    )

# History
# History file
export HISTFILE=~/.zsh_history
# History size in memory
export HISTSIZE=10000
# The number of histsize
export SAVEHIST=1000000
# The size of asking history
export LISTMAX=50
# Do not add in root
if [[ $UID == 0 ]]; then
    unset HISTFILE
    export SAVEHIST=0
fi

# Config
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
. "$HOME/.cargo/env"
