# gh extensions list
# Format: "owner/repo@tag"
_GH_EXTENSIONS=(
  # renovate: depName=dlvhdr/gh-dash
  "dlvhdr/gh-dash@v4.20.1"
  # renovate: depName=cappyzawa/gh-ghq-cd
  "cappyzawa/gh-ghq-cd@v0.8.0"
)

# Sync gh extensions: install missing, upgrade outdated, remove unlisted
_sync_gh_extensions() {
  command -v gh &>/dev/null || return

  # Get installed extensions (tab-separated): "name\towner/repo\tversion"
  local -A installed_versions
  local -a installed_repos
  while IFS=$'\t' read -r name repo version; do
    [[ -z "$repo" ]] && continue
    installed_repos+=("$repo")
    installed_versions[$repo]="$version"
  done < <(gh extension list 2>/dev/null)

  # Build list of expected extensions
  local -a expected_repos
  for entry in "${_GH_EXTENSIONS[@]}"; do
    expected_repos+=("${entry%@*}")
  done

  # Install or upgrade extensions
  for entry in "${_GH_EXTENSIONS[@]}"; do
    local ext="${entry%@*}"
    local tag="${entry#*@}"
    local name="${ext##*/}"
    local current="${installed_versions[$ext]}"

    if [[ -z "$current" ]]; then
      # Not installed
      (gh extension install "$ext" --pin "$tag" &>/dev/null &)
    elif [[ "$current" != "$tag" ]]; then
      # Version mismatch: reinstall with correct pin
      (gh extension remove "$name" &>/dev/null && \
       gh extension install "$ext" --pin "$tag" &>/dev/null &)
    fi
  done

  # Remove unlisted extensions
  for repo in "${installed_repos[@]}"; do
    local name="${repo##*/}"
    if ! printf '%s\n' "${expected_repos[@]}" | grep -qx "$repo"; then
      (gh extension remove "$name" &>/dev/null &)
    fi
  done
}

# Run sync (deferred by sheldon via *.defer.zsh pattern)
_sync_gh_extensions
