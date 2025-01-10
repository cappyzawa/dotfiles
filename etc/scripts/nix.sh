#!/usr/bin/env bash

if command -v nix &>/dev/null; then
  echo "${0}: nix is already installed"
  exit 0
fi

/bin/bash -c "$(curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install --no-confirm)"
