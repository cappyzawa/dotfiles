# required for activatioin {{{
# junegunn/fzf {{{
zinit ice lucid from"gh-r" as"program"
zinit light "junegunn/fzf"
# }}}
# direnv/direnv {{{
zinit ice from"gh-r" as"program" mv"direnv* -> direnv" \
    atclone'./direnv hook zsh > zhook.zsh' atpull'%atclone' \
    src"zhook.zsh"
zinit light direnv/direnv
# }}}
# anyenv/anyenv {{{
zinit ice lucid as"program" pick:"bin/anyenv"
zinit light anyenv/anyenv
# }}}
zinit ice lucid
zinit snippet $HOME/.zsh/10_utils.zsh
# }}}

zinit wait lucid light-mode as'null' \
    atinit'. "$HOME/.zsh/zinit_wait.zsh"' \
    for 'zdharma-continuum/null'
