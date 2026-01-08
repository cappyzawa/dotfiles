#!/bin/bash
#
# Aqua Completions Generator
# Generates zsh completions for aqua-managed CLI tools.
# See README.md for usage.
#

set -euo pipefail

COMP_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh/completions"
LAST_RUN="$COMP_DIR/.aqua-completions-last-run"
INTERVAL=86400 # 24 hours

# Skip if run within INTERVAL (unless --force)
if [[ "${1:-}" != "--force" && -f "$LAST_RUN" ]]; then
  last=$(cat "$LAST_RUN")
  now=$(date +%s)
  ((now - last < INTERVAL)) && exit 0
fi

mkdir -p "$COMP_DIR"

gen() {
  local cmd=$1
  shift
  local current_path cached_path

  current_path=$(aqua which "$cmd" 2>/dev/null) || return 0
  cached_path=$(cat "$COMP_DIR/_${cmd}.path" 2>/dev/null || echo "")

  # Skip if version unchanged (unless --force)
  if [[ "$current_path" == "$cached_path" && "${1:-}" != "--force" ]]; then
    return 0
  fi

  if "$cmd" "$@" >"$COMP_DIR/_$cmd" 2>/dev/null; then
    echo "$current_path" >"$COMP_DIR/_${cmd}.path"
  fi
}

# Add your CLI tools here
# Format: gen <command> <completion args...>

gen kubectl completion zsh
gen helm completion zsh
gen gh completion -s zsh
gen kind completion zsh
gen goreleaser completion zsh
gen cosign completion zsh

date +%s >"$LAST_RUN"
