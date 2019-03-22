zplug "zplug/zplug", hook-build:'zplug --self-manage'

zplug "~/.zsh", from:local, use:"<->_*.zsh"

zplug "zsh-users/zsh-completions"

zplug "stedolan/jq", \
  from:gh-r, \
  as:command, \
  rename-to:jq

zplug "b4b4r07/emoji-cli", \
  on:"stedolan/jq"

zplug "cappyzawa/get-op", \
  as:command, \
  hook-build:"./init", \
  use:"op"

zplug "cappyzawa/op-kv", \
  from:gh-r, \
  as:command, \
  rename-to:op-kv, \
  on:"stedolan/jq", \
  on:"cappyzawa/get-op"

zplug "mrowa44/emojify", as:command

zplug "junegunn/fzf-bin", \
  as:command, \
  from:gh-r, \
  rename-to:"fzf", \
  frozen:1

zplug "b4b4r07/enhancd", \
  use:init.sh, \
  on:"junegunn/fzf-bin"
if zplug check "b4b4r07/enhancd"; then
  export ENHANCD_FILTER="fzf --height 50% --reverse --ansi"
  export ENHANCD_DOT_SHOW_FULLPATH=1
fi

zplug "motemen/ghq", \
  as:command, \
  from:gh-r, \
  rename-to:"ghq"

zplug "b4b4r07/zsh-vimode-visual", \
  defer:3

zplug "peco/peco", \
  as:command, \
  from:gh-r, \
  frozen:1

zplug 'b4b4r07/zplug-doctor', lazy:yes

zplug "b4b4r07/ssh-keyreg", as:command, use:bin

zplug "b4b4r07/stein", \
  as:command, \
  from:gh-r

zplug "motemen/gobump", \
  as:command, \
  hook-build:"go get -d && go build cmd/gobump/..."

zplug "goreleaser/goreleaser", \
  as:command, \
  rename-to:"goreleaser", \
  hook-build:"go get -d && go mod download && go build"

zplug "b4b4r07/release-go", \
  as:command, \
  rename-to:"release-go", \
  use:"./release-go.sh", \
  on:"goreleaser/goreleaser", \
  on:"motemen/gobump"

zplug "zsh-users/zsh-syntax-highlighting", \
  defer:2

zplug "kislyuk/yq", \
  as:command, \
  rename-to:"yq", \
  hook-build:"pip install yq"

zplug "Kuniwak/vint", \
  as:command, \
  rename-to:"vint", \
  hook-build:"pip install vim-vint"

zplug "adrienverge/yamllint", \
  as:command, \
  rename-to:"yamllint", \
  hook-build:"python setup.py install"

zplug "github/hub", \
  as:command, \
  rename-to:"hub", \
  hook-build:"go get -d && make install"

zplug "skanehira/docui", \
  as:command, \
  rename-to:"docui", \
  hook-build:"go get -d && GO111MODULE=on go install"

zplug "hairyhenderson/gomplate", \
  as:command, \
  from:"gh-r", \
  rename-to:"gomplate"

zplug "k14s/ytt", \
  as:command, \
  from:"gh-r", \
  rename-to:"ytt"

zplug 'dracula/zsh', as:theme

export ZSH_HISTORY_AUTO_SYNC=false
