local install_by_anyenv() {
  local restart_flag=false
  target=('goenv' 'nodenv' 'rbenv' 'pyenv' 'scalaenv' 'luaenv')
  for t in ${target}; do
    if ! has ${t}; then
      anyenv install ${t}
      restart_flag=true
    fi
  done
  if (${restart_flag}); then
    exec $SHELL -l
  fi
}

if has 'anyenv'; then
  install_by_anyenv
fi

if has "goenv"; then
  local version="1.15.2"
  if ! [[ -d "${ANYENV_ROOT}/envs/goenv/versions/${version}" ]]; then
    goenv install ${version}
    goenv global ${version}
  fi
fi

if has "nodenv"; then
  local version="14.13.1"
  if ! [[ -d "${ANYENV_ROOT}/envs/nodenv/versions/${version}" ]]; then
    nodenv install ${version}
    nodenv global ${version}
  fi
fi

if has "rbenv"; then
  local version="2.6.5"
  if ! [[ -d "${ANYENV_ROOT}/envs/rbenv/versions/${version}" ]]; then
    rbenv install ${version}
    rbenv global ${version}
  fi
fi

if has "pyenv"; then
  local version="anaconda3-5.3.1"
  if ! [[ -d "${ANYENV_ROOT}/envs/pyenv/versions/${version}" ]]; then
    pyenv install ${version}
    pyenv global ${version}
  fi
fi

if has "scalaenv"; then
  local version="scala-2.13.2"
  if ! [[ -d "${ANYENV_ROOT}/envs/scalaenv/versions/${version}" ]]; then
    scalaenv install ${version}
    scalaenv global ${version}
  fi
fi

if has "luaenv"; then
  local version="5.4.0"
  if ! [[ -d "${ANYENV_ROOT}/envs/luaenv/versions/${version}" ]]; then
    luaenv install ${version}
    luaenv global ${version}
  fi
fi

# for node
npm_global_install(){
  pkg=$1
  echo "dotfile: Install ${pkg}"
  npm install -g ${pkg}
}

if has "npm" && has "nodenv" ; then
  if ! $(nodenv which elm > /dev/null); then
    npm_global_install elm
  fi

  if ! $(nodenv which elm-language-server > /dev/null); then
    npm_global_install "@elm-tooling/elm-language-serve"
  fi

  if ! $(nodenv which elm-test > /dev/null); then
    npm_global_install "elm-test"
  fi

  if ! $(nodenv which elm-format > /dev/null); then
    npm_global_install "elm-format"
  fi

  if ! $(nodenv which elm-analyse > /dev/null); then
    npm_global_install "elm-analyse"
  fi

  if ! $(nodenv which elm-live > /dev/null); then
    npm_global_install "elm-live"
  fi

  if ! $(nodenv which yarn > /dev/null); then
    npm_global_install "yarn"
  fi

  if ! $(nodenv which ng > /dev/null); then
    npm_global_install "@angular/cli"
  fi

  if ! $(nodenv which create-elm-app > /dev/null); then
    npm_global_install "create-elm-app"
  fi

  if ! $(nodenv which serve > /dev/null); then
    npm_global_install serve
  fi

  if ! $(nodenv which surge > /dev/null); then
    npm_global_install surge
  fi
fi

# for Ruby
gem_install(){
  pkg=$1
  echo "dotfile: Install ${pkg}"
  gem install ${pkg}
}

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

if has "luarocks"; then
  if ! has "luacheck"; then
    luarocks install luacheck
  fi
fi

if ! has "rustup"; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
fi
