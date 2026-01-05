# .zprofile - Login shell initialization

# Homebrew initialization (architecture-specific)
if [[ "$(uname -m)" == "arm64" ]] && [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ "$(uname -m)" == "x86_64" ]] && [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# Set LDFLAGS for Homebrew
if [[ -n "${HOMEBREW_PREFIX}" ]]; then
  export LDFLAGS="-L${HOMEBREW_PREFIX}/lib"
fi
