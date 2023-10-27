# zsh {{{
zinit wait lucid for \
    atinit"ZINIT[COMPINIT_OPTS]=-C; zpcompinit; zpcdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
    atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions \
    blockf \
    zsh-users/zsh-completions
# }}}

zinit ice wait cdreplay -q
zinit creinstall -Q %HOME/.zsh/Completion 2>&1 >/dev/null
