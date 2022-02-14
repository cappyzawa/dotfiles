# required for activatioin {{{
# junegunn/fzf {{{
zinit ice lucid from"gh-r" as"program"
zinit light "junegunn/fzf"
# }}}
# direnv/direnv {{{
zinit ice lucid as"program" make'!' \
  atclone'./direnv hook zsh > zhook.zsh' atpull'%atclone' \
  src"zhook.zsh" has"go"
zinit light direnv/direnv
# }}}
zinit ice lucid
zinit snippet $HOME/.zsh/10_utils.zsh
# }}}

zinit wait lucid light-mode as'null' \
    atinit'. "$HOME/.zsh/zinit_wait.zsh"' \
    for 'zdharma-continuum/null'
