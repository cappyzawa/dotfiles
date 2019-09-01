if has 'anyenv'; then
  if ! has 'goenv'; then
    anyenv install goenv
    goenv install 1.12.8
    goenv global 1.12.8
  fi
  if ! has 'nodenv'; then
    anyenv install nodenv
    nodenv install 12.5.0
    nodenv global 12.5.0
  fi
fi

# for rust
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

# for node
npm_global_install(){
  pkg=$1
  echo "dotfile: Install ${pkg}"
  npm install -g ${pkg}
}

if has "npm"; then
  if ! has "elm"; then
    npm_global_install elm
  fi

  if ! has "elm-test"; then
    npm_global_install "elm-test"
  fi

  if ! has "elm-format"; then
    npm_global_install "elm-format"
  fi

  if ! has "elm-analyse"; then
    npm_global_install "elm-analyse"
  fi

  if ! has "elm-language-server"; then
    npm_global_install "@elm-tooling/elm-language-server"
  fi
fi
