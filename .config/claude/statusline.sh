#!/bin/bash
# Claude Code statusline script using Starship
# Reads JSON from Claude Code and renders statusline with Starship

set -euo pipefail

# Read JSON input from stdin
input=$(cat)

# Parse model info
export CLAUDE_MODEL
CLAUDE_MODEL=$(echo "$input" | jq -r '.model.display_name // "Claude"')

# Parse context window info
CONTEXT_SIZE=$(echo "$input" | jq -r '.context_window.context_window_size // 200000')
USAGE=$(echo "$input" | jq '.context_window.current_usage // null')

if [ "$USAGE" != "null" ]; then
  # Calculate total tokens used
  INPUT_TOKENS=$(echo "$USAGE" | jq '.input_tokens // 0')
  CACHE_CREATE=$(echo "$USAGE" | jq '.cache_creation_input_tokens // 0')
  CACHE_READ=$(echo "$USAGE" | jq '.cache_read_input_tokens // 0')
  CURRENT_TOKENS=$((INPUT_TOKENS + CACHE_CREATE + CACHE_READ))

  # Calculate remaining percentage
  if [ "$CONTEXT_SIZE" -gt 0 ]; then
    USED_PCT=$((CURRENT_TOKENS * 100 / CONTEXT_SIZE))
    export CLAUDE_PCT=$((100 - USED_PCT))
  else
    export CLAUDE_PCT=100
  fi

  # Create gauge visualization (filled = remaining)
  FILLED=$((CLAUDE_PCT / 10))
  EMPTY=$((10 - FILLED))
  GAUGE=""
  for _ in $(seq 1 "$FILLED" 2>/dev/null || true); do GAUGE+="▓"; done
  for _ in $(seq 1 "$EMPTY" 2>/dev/null || true); do GAUGE+="░"; done
  export CLAUDE_GAUGE="$GAUGE"
else
  export CLAUDE_PCT=100
  export CLAUDE_GAUGE="▓▓▓▓▓▓▓▓▓▓"
fi

# Get current directory from JSON for starship
CURRENT_DIR=$(echo "$input" | jq -r '.workspace.current_dir // "."')
cd "$CURRENT_DIR" 2>/dev/null || true

# Render with starship using custom config
# STARSHIP_SHELL=sh to avoid shell-specific escapes (statusline is not a shell prompt)
STARSHIP_SHELL=sh \
  STARSHIP_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/starship/starship-claude.toml" \
  starship prompt 2>/dev/null
