# gh extensions list
# Format: "owner/repo@tag"
_GH_EXTENSIONS=(
  # renovate: depName=dlvhdr/gh-dash
  "dlvhdr/gh-dash@v4.21.0"
  # renovate: depName=cappyzawa/gh-ghq-cd
  "cappyzawa/gh-ghq-cd@v0.8.0"
)

# Sync gh extensions: install missing, upgrade outdated, remove unlisted
_sync_gh_extensions() {
  command -v gh &>/dev/null || return

  local -A installed_versions installed_names expected
  local -a installed_repos

  # Get installed extensions (tab-separated): "name\towner/repo\tversion"
  while IFS=$'\t' read -r name repo version; do
    [[ -z "$repo" ]] && continue
    installed_repos+=("$repo")
    installed_versions[$repo]="$version"
    installed_names[$repo]="$name"
  done < <(gh extension list 2>/dev/null)

  # Build expected set for O(1) lookup
  for entry in "${_GH_EXTENSIONS[@]}"; do
    expected[${entry%@*}]=1
  done

  # Install or upgrade extensions
  for entry in "${_GH_EXTENSIONS[@]}"; do
    local ext="${entry%@*}"
    local tag="${entry#*@}"
    local current="${installed_versions[$ext]}"

    if [[ -z "$current" || "$current" != "$tag" ]]; then
      gh extension install "$ext" --force --pin "$tag" &>/dev/null
    fi
  done

  # Remove unlisted extensions
  for repo in "${installed_repos[@]}"; do
    if [[ -z "${expected[$repo]-}" ]]; then
      local name="${installed_names[$repo]}"
      [[ -n "$name" ]] && gh extension remove "$name" &>/dev/null
    fi
  done
}

# Run sync in background (deferred by sheldon via *.defer.zsh pattern)
_sync_gh_extensions &!
