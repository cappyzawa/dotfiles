# History
# History file
export HISTFILE=~/.zsh_history
# History size in memory
export HISTSIZE=1000000
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

# Tool configurations
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"
export CLAUDE_CONFIG_DIR="$XDG_CONFIG_HOME/claude"

# Language settings
export LANGUAGE="en_US.UTF-8"
export LANG="${LANGUAGE}"
export LC_ALL="${LANGUAGE}"
export LC_CTYPE="${LANGUAGE}"

# Editor
export EDITOR=vim
if command -v nvim >/dev/null 2>&1; then
    export EDITOR=nvim
fi
export CVSEDITOR="${EDITOR}"
export SVN_EDITOR="${EDITOR}"
export GIT_EDITOR="${EDITOR}"

# Pager
export PAGER=less
export LESS='-R -f -X -i -P ?f%f:(stdin). ?lb%lb?L/%L.. [?eEOF:?pb%pb\%..]'
export LESSCHARSET='utf-8'

# Less man page colors
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[00;44;37m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# Directory colors
export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

# Word chars for movement
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# Default prompt (overridden by starship when loaded)
export PS1='%n@%m:%~$ '

# Essential PATH initialization (required for afx in .zprofile)
# Initialize PATH with unique flag
typeset -gx -U path

# Add essential directories that are needed before afx loads
if [[ -d ~/bin ]]; then
    path=(~/bin $path)
fi

# Add aqua path (required for direnv and other aqua-managed tools in afx snippets)
if [[ -d ~/.local/share/aquaproj-aqua/bin ]]; then
    path=(~/.local/share/aquaproj-aqua/bin $path)
fi
