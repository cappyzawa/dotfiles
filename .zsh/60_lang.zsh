has_image() {
  local img=$1
  has docker && docker image ls --format "{{.Repository}}:{{.Tag}}" "${img}" | grep "${img}" > /dev/null
}

if has "nodenv"; then
  local version="14.13.1"
  if ! [[ -d "${ANYENV_ROOT}/envs/nodenv/versions/${version}" ]]; then
    nodenv install ${version}
    nodenv global ${version}
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
    npm_global_install "@elm-tooling/elm-language-server"
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
