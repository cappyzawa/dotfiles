#!/usr/bin/env bash

if command -v aqua &>/dev/null; then
  echo "${0}: aqua is already installed"
  exit 0
fi

echo "Installing aqua..."
curl -sSfL https://raw.githubusercontent.com/aquaproj/aqua-installer/v4.0.2/aqua-installer | bash
