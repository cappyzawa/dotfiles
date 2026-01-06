# gh extensions list
_GH_EXTENSIONS=(
  "mislav/gh-branch"
  "dlvhdr/gh-dash"
  "cappyzawa/gh-ghq-cd"
)

# Install missing gh extensions in background
_install_gh_extensions() {
  command -v gh &>/dev/null || return

  local installed
  installed=$(gh extension list 2>/dev/null | awk '{print $3}')

  for ext in "${_GH_EXTENSIONS[@]}"; do
    if ! echo "$installed" | grep -q "^https://github.com/${ext}$"; then
      (gh extension install "$ext" &>/dev/null &)
    fi
  done
}

# Run installation (deferred by sheldon via *.defer.zsh pattern)
_install_gh_extensions
