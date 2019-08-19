local go_get(){
  pkg=$1
  echo "dotfile: Install ${pkg}"
  go get -u ${pkg}
}

if has "go"; then

  if ! has "gopls"; then
    go_get "golang.org/x/tools/cmd/gopls"
  fi

  if ! has "ginkgo"; then
    go_get "github.com/onsi/ginkgo/ginkgo"
    go_get "github.com/onsi/gomega/..."
  fi

fi
