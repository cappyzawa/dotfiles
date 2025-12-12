# .zshenv - Environment variables loaded for all zsh sessions

# XDG Base Directory
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"
export NPM_CONFIG_PREFIX="${XDG_DATA_HOME}/npm-global"

# Tool configurations
export STARSHIP_CONFIG="${XDG_CONFIG_HOME}/starship/starship.toml"
export CLAUDE_CONFIG_DIR="${XDG_CONFIG_HOME}/claude"

# Aqua configuration
export AQUA_GLOBAL_CONFIG="${XDG_CONFIG_HOME}/aqua/aqua.yaml"
export AQUA_PROGRESS_BAR=true
export AQUA_POLICY_CONFIG="${XDG_CONFIG_HOME}/aqua/aqua-policy.yaml"

# Lima
export LIMA_TEMPLATES_DIR="${XDG_CONFIG_HOME}/lima/templates:/usr/local/share/lima/templates"

# Go
export GOPATH="${HOME}/ghq"

# Cargo
export CARGO_HOME="${HOME}/.cargo"

# Language settings
export LANGUAGE="en_US.UTF-8"
export LANG="${LANGUAGE}"
export LC_ALL="${LANGUAGE}"
export LC_CTYPE="${LANGUAGE}"

# Editor (default, will be updated in PATH configuration)
export EDITOR="vim"
export CVSEDITOR="${EDITOR}"
export SVN_EDITOR="${EDITOR}"
export GIT_EDITOR="${EDITOR}"

# Pager
export PAGER="less"
export LESS='-R -f -X -i -P ?f%f:(stdin). ?lb%lb?L/%L.. [?eEOF:?pb%pb\%..]'
export LESSCHARSET="utf-8"

# Less man page colors
export LESS_TERMCAP_mb=$'\e[01;31m'
export LESS_TERMCAP_md=$'\e[01;31m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[00;44;37m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[01;32m'

# Directory colors
export LSCOLORS="exfxcxdxbxegedabagacad"
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

# 1Password SSH agent (if available)
if [[ -S "${HOME}/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock" ]]; then
  export SSH_AUTH_SOCK="${HOME}/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
fi
