#!/bin/bash

if command -v rustup &>/dev/null; then
  echo "${0}: rustup is already installed"
  exit 0
fi

curl https://sh.rustup.rs -sSf | sh
