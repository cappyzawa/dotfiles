if has 'anyenv'; then
  if ! has 'goenv'; then
    anyenv install goenv && exec $SHELL -l
  fi
  if ! has 'nodenv'; then
    anyenv install nodenv && exec $SHELL -l
  fi
  if ! has 'rbenv'; then
    anyenv install rbenv && exec $SHELL -l
  fi
  if ! has 'pyenv'; then
    anyenv install pyenv && exec $SHELL -l
  fi
fi

if has "goenv"; then
  if ! [[ -d "${ANYENV_ROOT}/envs/goenv/versions/1.13.1" ]]; then
    goenv install "1.13.1"
    goenv global "1.13.1"
  fi
fi

if has "nodenv"; then
  if ! [[ -d "${ANYENV_ROOT}/envs/nodenv/versions/10.16.3" ]]; then
    nodenv install "10.16.3"
    nodenv global "10.16.3"
  fi
fi

if has "rbenv"; then
  if ! [[ -d "${ANYENV_ROOT}/envs/rbenv/versions/2.6.5" ]]; then
    rbenv install "2.6.5"
    rbenv global "2.6.5"
  fi
fi

if has "pyenv"; then
  if ! [[ -d "${ANYENV_ROOT}/envs/pyenv/versions/anaconda3-5.3.1" ]]; then
    pyenv install "anaconda3-5.3.1"
    pyenv global "anaconda3-5.3.1"
  fi
fi

# for rust
if ! has "rustup"; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
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

  if ! has "yarn"; then
    npm_global_install "yarn"
  fi

  if has "yarn"; then
    if ! has "vim-language-server"; then
      yarn global add vim-language-server
    fi
  fi
fi

# for Ruby
gem_install(){
  pkg=$1
  echo "dotfile: Install ${pkg}"
  gem install ${pkg}
}

# if has "gem"; then
#   if ! has "solargraph"; then
#     gem_install solargraph
#   fi
# fi

pip_instal() {
  pkg=$1
  echo "dotfile: Install ${pkg}"
  pip install ${pkg}
}

if has "pip"; then
  if ! has "vint"; then
    pip_instal vim-vint
  fi

  if ! has "nvr"; then
    pip_instal neovim-remote
  fi
fi
