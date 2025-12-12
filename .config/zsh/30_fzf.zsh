# fzf configuration

# FZF default options (append to rose-pine theme from sheldon)
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --height 40% --reverse --border"

# fzf-tab configuration
zstyle ':fzf-tab:*' fzf-flags --height=40% --reverse --border

# Preview commands for fzf-tab
if command -v bat &>/dev/null; then
    zstyle ':fzf-tab:complete:*:*' fzf-preview 'bat --style=numbers --color=always --line-range :200 $realpath 2>/dev/null || ls -la $realpath 2>/dev/null || echo $word'
fi

# Directory preview with eza/exa
if command -v eza &>/dev/null; then
    zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --all --color=always $realpath'
elif command -v exa &>/dev/null; then
    zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa --all --color=always $realpath'
fi

# Git diff highlighter with delta
if command -v delta &>/dev/null; then
    zstyle ':fzf-tab:complete:git-(add|diff|restore):*' fzf-preview 'git diff $word | delta --paging=never --width=20'
fi

# Process preview for kill/ps
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview \
    '[[ $group == "[process ID]" ]] && ps -p $word -o pid,user,%cpu,%mem,command --no-headers -w -w'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags --preview-window=down:3:wrap

# fzf-fzf-history-search configuration
export ZSH_FZF_HISTORY_SEARCH_REMOVE_DUPLICATES=1
export ZSH_FZF_HISTORY_SEARCH_DATES_IN_SEARCH=1

# fd options for fzf (if using fzf default command)
if command -v fd &>/dev/null; then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --exclude node_modules --exclude target'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi
