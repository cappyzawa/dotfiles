# Helix integration functions for fish shell

function edit-cmd-in-hx
    set -l tmp (mktemp -t fish_cmd_XXXX)
    commandline > $tmp
    if type -q hx
        hx $tmp
    else if type -q $EDITOR
        $EDITOR $tmp
    else
        echo "hx/EDITOR not found" >&2
        rm -f $tmp
        return 1
    end
    commandline -r -- (string join '' < $tmp)
    rm -f $tmp
    commandline -f repaint
end

function hx-open-token
    set -l tok (commandline -t)             # token under cursor
    if test -z "$tok"
        hx .
        return
    end
    set -l path (string replace -r "^[\"']|[\"']\$" "" -- $tok)  # quote除去
    if test -d "$path"
        hx $path
    else if test -e "$path"
        hx $path
    else
        echo "not found: $path" >&2
    end
end

function hx-fzf
    if not type -q fzf
        echo "fzf not found" >&2
        return 1
    end
    # fd があれば速い
    if type -q fd
        set -l pick (fd --type f --hidden --follow --exclude .git | fzf --height 40% --reverse)
    else
        set -l pick (find . -type f 2>/dev/null | sed 's|^\./||' | fzf --height 40% --reverse)
    end
    test -n "$pick"; and hx $pick
end

function hx-git-changes
    if not type -q git
        echo "git not found" >&2
        return 1
    end
    set -l files (git -c color.ui=never status --porcelain | awk '{print $2}')
    if test -z "$files"
        echo "no changes" >&2
        return 1
    end
    if type -q fzf
        set -l pick (printf '%s\n' $files | fzf --height 40% --reverse --multi)
        test -n "$pick"; and hx $pick
    else
        hx $files
    end
end
