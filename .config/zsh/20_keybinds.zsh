# Vi mode keybindings

# Enable vi mode
bindkey -v

# jj to escape to normal mode
bindkey -M viins 'jj' vi-cmd-mode

# Reduce key timeout for faster mode switching
export KEYTIMEOUT=20

# Helix-style navigation in normal mode (g prefix)
bindkey -M vicmd 'gh' beginning-of-line
bindkey -M vicmd 'gl' end-of-line
bindkey -M vicmd 'gs' vi-first-non-blank

# Helix-style delete in normal mode
bindkey -M vicmd 'd' vi-delete-char

# Emacs-style bindings in insert mode
bindkey -M viins '^A' beginning-of-line
bindkey -M viins '^E' end-of-line
bindkey -M viins '^K' kill-line
bindkey -M viins '^F' forward-char
bindkey -M viins '^B' backward-char

# History navigation
bindkey -M viins '^N' down-history
bindkey -M viins '^P' up-history
