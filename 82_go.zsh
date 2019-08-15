if has "go"; then

  if ! has "gopls"; then
    go get -u golang.org/x/tools/cmd/gopls
  fi

  if ! has "ginkgo"; then
    go get github.com/onsi/ginkgo/ginkgo
    go get github.com/onsi/gomega/...
  fi

fi

echo "hello"
