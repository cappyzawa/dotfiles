if has 'anyenv'; then
  if ! has 'goenv'; then
    anyenv install goenv
  fi
  if ! has 'nodenv'; then
    anyenv install nodenv
  fi
  if ! has 'rbenv'; then
    anyenv install rbenv
  fi
  if ! has 'pyenv'; then
    anyenv install pyenv
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

  if ! has "rg"; then
    cargo_install "ripgrep"
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

  if ! has "bash-language-server"; then
    npm_global_install "bash-language-server"
  fi

  if ! has "docker-langserver"; then
    npm_global_install "dockerfile-language-server-nodejs"
  fi
fi

# for Ruby
gem_install(){
  pkg=$1
  echo "dotfile: Install ${pkg}"
  gem install ${pkg}
}

if has "gem"; then
  if ! has "solargraph"; then
    gem_install solargraph
  fi
fi

pip_instal() {
  pkg=$1
  echo "dotfile: Install ${pkg}"
  pip install ${pkg}
}

if has "pip"; then
  if ! has "vint"; then
    pip_instal vim-vint
  fi
fi
