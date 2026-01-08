# .zprofile - Login shell initialization

# Homebrew initialization (cached for performance)
# Regenerate cache: rm ~/.cache/zsh/brew-shellenv-*
() {
  local cache="${HOME}/.cache/zsh/brew-shellenv-$(uname -m)"
  if [[ ! -f "$cache" ]]; then
    local brew="/opt/homebrew/bin/brew"
    [[ -x "$brew" ]] || brew="/usr/local/bin/brew"
    [[ -x "$brew" ]] && { mkdir -p "${cache:h}"; "$brew" shellenv > "$cache"; }
  fi
  [[ -f "$cache" ]] && source "$cache"
}

# Set LDFLAGS for Homebrew
[[ -n "${HOMEBREW_PREFIX}" ]] && export LDFLAGS="-L${HOMEBREW_PREFIX}/lib"
