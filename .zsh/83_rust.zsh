if ! has "rustup"; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

if has "cargo"; then
  if ! has "silicon"; then
    cargo install silicon
  fi

  if ! has "starship"; then
    cargo install starship
  fi
fi
