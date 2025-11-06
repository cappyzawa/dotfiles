# Vi key bindings base
fish_vi_key_bindings

# fifc configuration
set -g fifc_editor hx

function fish_user_key_bindings
    # ========================================================================
    # Helix integration functions
    # ========================================================================
    bind -M insert \cx edit-cmd-in-hx # Ctrl-x: edit commandline in hx
    bind -M insert \co hx-open-token # Ctrl-o: open token under cursor in hx

    # ========================================================================
    # Insert Mode - Helix-style
    # ========================================================================
    # jj to escape to normal mode
    bind -M insert jj "set fish_bind_mode default; commandline -f repaint-mode"

    # Keep useful insert mode bindings
    bind -M insert \cf forward-char
    bind -M insert \cb backward-char
    bind -M insert \ca beginning-of-line
    bind -M insert \ce end-of-line
    bind -M insert \ck kill-line

    # ========================================================================
    # Normal Mode - Helix-style navigation and operations
    # ========================================================================
    # Line movement (gh/gl for home/end - Helix style)
    bind -M default gh beginning-of-line
    bind -M default gl end-of-line

    # Word movement (w/b like Helix)
    bind -M default w forward-word
    bind -M default b backward-word
    bind -M default e forward-single-char

    # Document movement
    bind -M default gg beginning-of-buffer
    bind -M default G end-of-buffer

    # Selection mode
    bind -M default v begin-selection
    bind -M default x begin-selection repaint # Select line (approximation)

    # Deletion (Helix uses 'd' for deletion)
    bind -M default d delete-char
    bind -M default D kill-line # Delete to end of line

    # Change (delete and enter insert mode)
    bind -M default c "kill-whole-line; set fish_bind_mode insert; commandline -f repaint-mode"
    bind -M default C "kill-line; set fish_bind_mode insert; commandline -f repaint-mode"

    # Insert mode transitions
    bind -M default i "set fish_bind_mode insert; commandline -f repaint-mode"
    bind -M default I "beginning-of-line; set fish_bind_mode insert; commandline -f repaint-mode"
    bind -M default a "forward-char; set fish_bind_mode insert; commandline -f repaint-mode"
    bind -M default A "end-of-line; set fish_bind_mode insert; commandline -f repaint-mode"
    bind -M default o "end-of-line; set fish_bind_mode insert; commandline -f repaint-mode"

    # Undo/Redo
    bind -M default u undo
    bind -M default U redo

    # Yank (copy) and paste
    bind -M default y fish_clipboard_copy
    bind -M default p fish_clipboard_paste

    # History search
    # /: history search (fish default)
    # Ctrl+R: fzf.fish plugin history search (configured in config.fish)

    # Space accepts autosuggestion (useful in fish)
    bind -M default ' ' accept-autosuggestion

    # ========================================================================
    # Visual Mode (Selection) - Helix-style operations on selections
    # ========================================================================
    # Movement while selecting
    bind -M visual h backward-char
    bind -M visual l forward-char
    bind -M visual j down-line
    bind -M visual k up-line
    bind -M visual w forward-word
    bind -M visual b backward-word
    bind -M visual gh beginning-of-line
    bind -M visual gl end-of-line

    # Operations on selection
    bind -M visual d kill-selection end-selection repaint-mode
    bind -M visual c kill-selection end-selection repaint-mode
    bind -M visual y fish_clipboard_copy end-selection repaint-mode

    # Exit visual mode
    bind -M visual \e end-selection repaint-mode
    bind -M visual escape end-selection repaint-mode

    # ========================================================================
    # Completion and pager navigation
    # ========================================================================
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
