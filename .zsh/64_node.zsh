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
