zplug "zplug/zplug", hook-build:'zplug --self-manage'

zplug "~/.zsh", from:local, use:"<->_*.zsh"

zplug "zsh-users/zsh-completions"

zplug "stedolan/jq", \
    from:gh-r, \
    as:command, \
    rename-to:jq
zplug "b4b4r07/emoji-cli", \
    on:"stedolan/jq"

zplug "cappyzawa/op-kv", \
    from:gh-r, \
    as:command, \
    rename-to:op-kv, \
    on:"stedolan/jq"

zplug "mrowa44/emojify", as:command

zplug "junegunn/fzf-bin", \
    as:command, \
    from:gh-r, \
    rename-to:"fzf", \
    frozen:1

zplug "b4b4r07/enhancd", \
    use:init.sh, \
    on:"junegunn/fzf-bin"
if zplug check "b4b4r07/enhancd"; then
    export ENHANCD_FILTER="fzf --height 50% --reverse --ansi"
    export ENHANCD_DOT_SHOW_FULLPATH=1
fi

zplug "motemen/ghq", \
    as:command, \
    from:gh-r, \
    rename-to:ghq

zplug "peco/peco", \
    as:command, \
    from:gh-r, \
    frozen:1

zplug "b4b4r07/zsh-gomi", \
    as:command, \
    use:bin/gomi

zplug 'b4b4r07/zplug-doctor', lazy:yes

zplug "b4b4r07/ssh-keyreg", as:command, use:bin

zplug "zsh-users/zsh-syntax-highlighting", \
    defer:2

zplug "kislyuk/yq", \
    as:command, \
    hook-build:"pip install yq --user", \
    on:"stedolan/jq"


zplug 'dracula/zsh', as:theme

export ZSH_HISTORY_AUTO_SYNC=false
