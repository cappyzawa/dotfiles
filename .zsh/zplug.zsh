zplug "zplug/zplug", hook-build:'zplug --self-manage'

zplug "~/.zsh", from:local, use:"<->_*.zsh"

zplug "zsh-users/zsh-completions"

zplug "stedolan/jq", \
  from:gh-r, \
  as:command, \
  rename-to:jq

zplug "b4b4r07/emoji-cli", \
  on:"stedolan/jq"

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

zplug "b4b4r07/stein", \
  as:command, \
  from:gh-r

zplug "goreleaser/goreleaser", \
  as:command, \
  from:"gh-r", \
  rename-to:"goreleaser", \
  use:"*Darwin_x86_64.tar.gz", \
  defer: 3, \
  if:"[[ $OSTYPE == *darwin* ]]"

zplug "jesseduffield/lazygit", \
  as:command, \
  from:"gh-r", \
  rename-to:"lazygit", \
  use:"*Darwin_x86_64.tar.gz", \
  defer: 3, \
  if:"[[ $OSTYPE == *darwin* ]]"


zplug "cjbassi/gotop", \
  as:command, \
  from:"gh-r", \
  rename-to:"gotop"

zplug "go-delve/delve", \
  as:command, \
  rename-to:"dlv", \
  hook-build:"go get -d && go build cmd/dlv/..."

zplug "zsh-users/zsh-syntax-highlighting", \
  defer:2

zplug "kislyuk/yq", \
  as:command, \
  rename-to:"yq", \
  hook-build:"pip install yq"

zplug "Kuniwak/vint", \
  as:command, \
  rename-to:"vint", \
  hook-build:"pip install vim-vint --user"

zplug "adrienverge/yamllint", \
  as:command, \
  rename-to:"yamllint", \
  hook-build:"python setup.py install"

zplug "github/hub", \
  as:command, \
  rename-to:"hub", \
  hook-build:"make install prefix=/usr/local"

zplug "k14s/ytt", \
  as:command, \
  from:"gh-r", \
  rename-to:"ytt"

zplug "zlabjp/kubernetes-scripts", \
  as:command, \
  use:"create-kubeconfig" \
  rename-to:"create-kubeconfig"

zplug "git-duet/git-duet", \
  hook-build:"GO111MODULE=on GOVENDOREXPERIMENT=1 go get ./..."

zplug "wercker/stern", \
  as:command, \
  from:"gh-r", \
  rename-to:"stern"

export ZSH_HISTORY_AUTO_SYNC=false
