#!/usr/bin/env bash

if command -v aqua &>/dev/null; then
  echo "${0}: aqua is already installed"
  exit 0
fi

echo "Installing aqua..."
# Skip update-aqua to avoid GitHub API rate limit in CI
export AQUA_INSTALLER_SKIP_UPDATE=true
curl -sSfL https://raw.githubusercontent.com/aquaproj/aqua-installer/v4.0.2/aqua-installer | bash
