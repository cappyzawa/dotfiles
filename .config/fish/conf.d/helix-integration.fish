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
        if test -n "$pick"
            hx $pick
        end
    else
        hx $files
    end
end
