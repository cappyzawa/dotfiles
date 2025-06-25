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
export NPM_CONFIG_PREFIX="$XDG_DATA_HOME/npm-global"
. "$HOME/.cargo/env"

export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"
export CLAUDE_CONFIG_DIR="$XDG_CONFIG_HOME/claude"
