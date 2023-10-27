umask 022
limit coredumpsize 0
bindkey -d
autoload -U +X bashcompinit && bashcompinit

source ~/.zsh/10_utils.zsh

if ! has "aqua"; then
    curl -sSfL https://raw.githubusercontent.com/aquaproj/aqua-installer/v2.1.2/aqua-installer | bash
fi
if command -v aqua &> /dev/null; then source <(aqua completion zsh); fi

source "${ZINIT_HOME}/zinit.zsh"
source ~/.zsh/zinit.zsh

if has "starship"; then
    eval "$(starship init zsh)"
fi

for file in $(find "${XDG_DATA_HOME}/aquaproj-aqua/pkgs/github_archive/github.com/Aloxaf/fzf-tab" -type f -name 'fzf-tab.plugin.zsh' | head -n 1); do
    source ${file}
done

source ~/.zsh/20_keybinds.zsh
source ~/.zsh/30_aliases.zsh
source ~/.zsh/50_setopt.zsh
source ~/.zsh/60_lang.zsh
source ~/.zsh/80_custom.zsh

if [[ -f ~/.zshrc.local ]]; then
    source ~/.zshrc.local
fi
