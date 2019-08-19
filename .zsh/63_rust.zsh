cargo_install() {
  pkg=$1
  echo "dotfile: Install ${pkg}"
  cargo install "${pkg}"
}

if ! has "rustup"; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

if has "cargo"; then
  if [[ "${PLATFORM}" == "osx" ]]; then
    if ! has "silicon"; then
      cargo_install "silicon"
    fi
  fi

  if ! has "starship"; then
    cargo_install "starship"
  fi
fi

if ! has "rls"; then
  echo "Install rls, rust-analysis, rust-src"
  rustup component add rls rust-analysis rust-src
fi
