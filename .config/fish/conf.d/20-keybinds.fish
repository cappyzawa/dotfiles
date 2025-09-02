# Vi key bindings base
fish_vi_key_bindings

# fifc configuration
set -g fifc_editor hx

function fish_user_key_bindings
    # Helix integration functions
    bind -M insert \cx edit-cmd-in-hx # Ctrl-x: edit commandline in hx
    bind -M insert \co hx-open-token # Ctrl-o: open token under cursor in hx

    # Helix-style key bindings
    # Insert mode: jj to escape to normal mode
    bind -M insert jj "set fish_bind_mode default; commandline -f repaint-mode"

    # Normal mode: gh/gl for line start/end (Helix-style)
    bind -M default gh beginning-of-line
    bind -M default gl end-of-line

    # Unbind x (use d for deletion like Helix)
    bind -M default x ''

    # d for character deletion (Helix-style)
    bind -M default d delete-char

    # Tab completion navigation with Ctrl-n/Ctrl-p
    bind -M default \cn down-or-search
    bind -M default \cp up-or-search
    bind -M insert \cn down-or-search
    bind -M insert \cp up-or-search

    # Completion pager navigation with Ctrl-n/Ctrl-p
    bind -M pager \cn forward-char
    bind -M pager \cp backward-char

    # Shift-Tab for traditional fish completion (escape from fzf)
    bind \e\[Z 'commandline -f complete'

end
