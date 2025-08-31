# Automatic fisher plugin synchronization
# Only runs when fish_plugins file changes
if status --is-interactive
    set -l manifest ~/.config/fish/fish_plugins
    set -l stamp ~/.local/share/fish/fish_plugins.last

    if test -f $manifest
        mkdir -p (dirname $stamp)

        # 変更があった時だけ update（cmp -s は同一なら 0, 異なると 1）
        if not test -f $stamp; or not cmp -s $manifest $stamp
            # fisher が未導入なら導入
            if not functions -q fisher
                curl -fsSL https://git.io/fisher | source
                fisher install jorgebucaran/fisher
            end

            fisher update
            command cp $manifest $stamp
        end
    end
end
