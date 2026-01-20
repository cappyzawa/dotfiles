#!/usr/bin/env bash

if command -v aqua &>/dev/null; then
  echo "${0}: aqua is already installed"
  exit 0
fi

echo "Installing aqua..."
# Install specific version to avoid GitHub API rate limit
# renovate: depName=aquaproj/aqua-installer
AQUA_INSTALLER_VERSION="v4.0.4"
# renovate: depName=aquaproj/aqua
AQUA_VERSION="v2.56.3"
curl -sSfL "https://raw.githubusercontent.com/aquaproj/aqua-installer/${AQUA_INSTALLER_VERSION}/aqua-installer" | bash -s -- -v "${AQUA_VERSION}"
