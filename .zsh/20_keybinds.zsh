# Vim-like keybind as default
bindkey -v
# Vim-like escaping jj keybind
bindkey -M viins 'jj' vi-cmd-mode
bindkey -M viins '^A'  beginning-of-line
bindkey -M viins '^E'  end-of-line

# vicmd mode
bindkey -M vicmd ' h'  beginning-of-line
bindkey -M vicmd ' l'  end-of-line
bindkey -M vicmd 'y'  yank
bindkey -M vicmd '^W'  backward-kill-word
bindkey -M vicmd 'q' push-line

if [[ $- == *i* ]]; then

  # CTRL-T - Paste the selected file path(s) into the command line
  __fsel() {
    local cmd="${FZF_CTRL_T_COMMAND:-"command find -L . -mindepth 1 \\( -path '*/\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \\) -prune \
      -o -type f -print \
      -o -type d -print \
      -o -type l -print 2> /dev/null | cut -b3-"}"
    setopt localoptions pipefail 2> /dev/null
    eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse $FZF_DEFAULT_OPTS $FZF_CTRL_T_OPTS" $(__fzfcmd) -m "$@" | while read item; do
      echo -n "${(q)item} "
    done
    local ret=$?
    echo
    return $ret
  }

  __fzf_use_tmux__() {
    [ -n "$TMUX_PANE" ] && [ "${FZF_TMUX:-0}" != 0 ] && [ ${LINES:-40} -gt 15 ]
  }

  __fzfcmd() {
    __fzf_use_tmux__ &&
      echo "fzf-tmux -d${FZF_TMUX_HEIGHT:-40%}" || echo "fzf"
  }

  fzf-file-widget() {
    LBUFFER="${LBUFFER}$(__fsel)"
    local ret=$?
    zle reset-prompt
    return $ret
  }
  zle     -N   fzf-file-widget
  bindkey '^T' fzf-file-widget

  # Ensure precmds are run after cd
  fzf-redraw-prompt() {
    local precmd
    for precmd in $precmd_functions; do
      $precmd
    done
    zle reset-prompt
  }
  zle -N fzf-redraw-prompt

  # CTRL-R - Paste the selected command from history into the command line
  fzf-history-widget() {
    local selected num
    setopt localoptions noglobsubst noposixbuiltins pipefail 2> /dev/null
    selected=( $(fc -rl 1 |
      FZF_DEFAULT_OPTS="--reverse --height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS -n2..,.. --tiebreak=index --bind=ctrl-r:toggle-sort $FZF_CTRL_R_OPTS --query=${(qqq)LBUFFER} +m" $(__fzfcmd)) )
    local ret=$?
    if [ -n "$selected" ]; then
      num=$selected[1]
      if [ -n "$num" ]; then
        zle vi-fetch-history -n $num
      fi
    fi
    zle reset-prompt
    return $ret
  }
  zle     -N   fzf-history-widget
  bindkey '^R' fzf-history-widget

fi
