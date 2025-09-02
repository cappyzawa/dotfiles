#!/usr/bin/env bash

if command -v aqua &>/dev/null; then
  echo "${0}: aqua is already installed"
  exit 0
fi

echo "Installing aqua..."
# Install specific version to avoid GitHub API rate limit
curl -sSfL https://raw.githubusercontent.com/aquaproj/aqua-installer/v4.0.2/aqua-installer | bash -s -- -v v2.53.3
