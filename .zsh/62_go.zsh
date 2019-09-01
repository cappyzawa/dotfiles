if has "anyenv"; then
  if ! has "goenv"; then
    anyenv install goenv
  fi
  local go_version=`go version`
  if [[ -z "${go_version}" ]]; then
    goenv install 1.12.8
    goenv global 1.12.8
  fi
fi

go_get(){
  pkg=$1
  echo "dotfile: Install ${pkg}"
  go get -u ${pkg}
}

if has "go"; then

  if ! has "gopls"; then
    go_get "golang.org/x/tools/cmd/gopls"
  fi

fi
