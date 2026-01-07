# gh extensions list
# Format: "owner/repo@tag"
_GH_EXTENSIONS=(
  # renovate: depName=dlvhdr/gh-dash
  "dlvhdr/gh-dash@v4.20.1"
  # renovate: depName=cappyzawa/gh-ghq-cd
  "cappyzawa/gh-ghq-cd@v0.8.0"
)

# Install missing gh extensions in background
_install_gh_extensions() {
  command -v gh &>/dev/null || return

  local installed
  installed=$(gh extension list 2>/dev/null | awk '{print $3}')

  for entry in "${_GH_EXTENSIONS[@]}"; do
    local ext="${entry%@*}"
    local tag="${entry#*@}"
    if ! echo "$installed" | grep -q "^https://github.com/${ext}$"; then
      (gh extension install "$ext" --pin "$tag" &>/dev/null &)
    fi
  done
}

# Run installation (deferred by sheldon via *.defer.zsh pattern)
_install_gh_extensions
