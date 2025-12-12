# PATH management
# Priority: High priority paths are prepended, low priority are appended

typeset -U path  # Remove duplicates

# High priority: GNU tools (override macOS defaults)
[[ -d /opt/homebrew/opt/gnu-sed/libexec/gnubin ]] && path=(/opt/homebrew/opt/gnu-sed/libexec/gnubin $path)

# High priority: User bin, Aqua, and Cargo
[[ -d "${HOME}/bin" ]] && path=("${HOME}/bin" $path)
[[ -d "${HOME}/.local/share/aquaproj-aqua/bin" ]] && path=("${HOME}/.local/share/aquaproj-aqua/bin" $path)
[[ -d "${CARGO_HOME}/bin" ]] && path=("${CARGO_HOME}/bin" $path)

# Standard priority: Common development tools
[[ -d "${HOME}/.local/bin" ]] && path+=("${HOME}/.local/bin")
[[ -d "${HOME}/.tmux/bin" ]] && path+=("${HOME}/.tmux/bin")
[[ -d "${HOME}/ghq/bin" ]] && path+=("${HOME}/ghq/bin")

# Standard priority: Language package managers
[[ -n "${NPM_CONFIG_PREFIX}" && -d "${NPM_CONFIG_PREFIX}/bin" ]] && path+=("${NPM_CONFIG_PREFIX}/bin")
[[ -d "${HOME}/.krew/bin" ]] && path+=("${HOME}/.krew/bin")
[[ -d "${HOME}/Library/Application Support/Coursier/bin" ]] && path+=("${HOME}/Library/Application Support/Coursier/bin")

# Low priority: Optional/specialized tools
[[ -d /usr/local/opt/libpq/bin ]] && path+=(/usr/local/opt/libpq/bin)
[[ -d /usr/local/opt/llvm/bin ]] && path+=(/usr/local/opt/llvm/bin)
[[ -d /opt/homebrew/opt/openjdk@17/bin ]] && path+=(/opt/homebrew/opt/openjdk@17/bin)
[[ -d "${HOME}/.tmux/plugins/tpm/bin" ]] && path+=("${HOME}/.tmux/plugins/tpm/bin")

# Update EDITOR based on available commands
if command -v hx &>/dev/null; then
    export EDITOR="hx"
elif command -v nvim &>/dev/null; then
    export EDITOR="nvim"
fi
export CVSEDITOR="${EDITOR}"
export SVN_EDITOR="${EDITOR}"
export GIT_EDITOR="${EDITOR}"
