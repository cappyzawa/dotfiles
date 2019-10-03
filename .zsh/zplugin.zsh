zplugin ice from"gh-r" as"program" lucid
zplugin light "junegunn/fzf-bin"

zplugin ice pick"init.sh" lucid \
  atload'export ENHANCD_FILTER="fzf --height 50% --reverse --ansi";export ENHANCD_DOT_SHOW_FULLPATH=1'
zplugin light "b4b4r07/enhancd"

# compinit
zplugin cdreplay -q

# local snippets
zplugin ice wait "1" lucid
zplugin snippet $HOME/.zsh/10_utils.zsh
zplugin ice wait"1" lucid
zplugin snippet $HOME/.zsh/20_keybinds.zsh
zplugin ice wait"1" lucid
zplugin snippet $HOME/.zsh/30_aliases.zsh
zplugin ice wait"1" lucid
zplugin snippet $HOME/.zsh/50_setopt.zsh
zplugin ice wait"2" lucid
zplugin snippet $HOME/.zsh/60_lang.zsh

zplugin ice wait'3' lucid
zplugin snippet $HOME/.zsh/80_custom.zsh

zplugin ice wait"2" as"program" from"gh-r" \
  mv"jq-* -> jq" pick"jq" lucid
zplugin light stedolan/jq

zplugin ice wait"3" as"program" has"go" \
  make'!' atclone'./direnv hook zsh > zhook.zsh' atpull'%atclone' src"zhook.zsh" lucid
zplugin light direnv/direnv

zplugin ice wait"2" as"program" from"gh-r" pick"ghq_*/ghq" lucid
zplugin light motemen/ghq

zplugin ice wait"2" as"program" from"gh-r" pick"goreleaser" lucid
zplugin light goreleaser/goreleaser

zplugin ice wait"2" as"program" from"gh-r" pick"lazygit" lucid
zplugin light jesseduffield/lazygit

zplugin ice wait"2" as"program" from"gh-r" pick"gotop" lucid
zplugin light cjbassi/gotop

zplugin ice wait'2' lucid
zplugin light zsh-users/zsh-completions

zplugin ice wait'3' lucid
zplugin light zdharma/fast-syntax-highlighting

zplugin ice wait'3' lucid
zplugin light zsh-users/zsh-autosuggestions

zplugin ice wait'2' lucid atclone"pip install yq" atpull"pip update yq"
zplugin light kislyuk/yq

zplugin ice wait'2' lucid \
  atclone"pip install vint" atpull"%atclone"
zplugin light Kuniwak/vint

zplugin ice wait'2' lucid atclone"python setup.py install" atpull"%atclone"
zplugin light adrienverge/yamllint

zplugin ice wait'2' lucid as"program" make"install prefix=$ZPFX" pick"$ZPFX/bin/hub"
zplugin light github/hub

zplugin ice wait'3' lucid as"program" pick"$ZPFX/bin/dlv" has"go" \
  atclone"go build -o $ZPFX/bin/dlv cmd/dlv/main.go" atpull"%atclone"
zplugin light go-delve/delve

zplugin ice wait'2' lucid as"program" from"gh-r" \
  mv"ytt-* -> ytt" pick"ytt"
zplugin light "k14s/ytt"

zplugin ice wait'2' lucid as"program" pick"create-kubeconfig"
zplugin light zlabjp/kubernetes-scripts

zplugin ice wait'2' lucid as"program" from"gh-r" \
  mv"stern* -> stern"
zplugin light wercker/stern

zplugin ice wait'2' lucid as"program" from"gh-r" \
  mv"bosh-cli* -> bosh"
zplugin light cloudfoundry/bosh-cli

zplugin ice wait'2' lucid as"program" from"gh-r"
zplugin light cappyzawa/vf

zplugin ice wait'2' lucid as"program" from"gh-r" \
  has"op"
zplugin light cappyzawa/op-kv

zplugin ice wait'2' lucid as"program" from"gh-r" ver"v5.5.1" id-as"concourse/fly"\
  bpick"fly-*" atclone"./fly completion --shell=zsh > ~/.zsh/Completion/_fly" atpull"%atclone"
zplugin light concourse/concourse

zplugin ice wait'3' lucid as"program" has"go" \
  atclone"go install ./..." atpull"%atclone"
zplugin light golang/tools

zplugin ice wait'3' lucid as"program" has"go" \
  atclone"./install.sh" atpull"%atclone"
zplugin light golang/dep

zplugin ice wait'3' lucid as"program" has"go" \
  atclone"go install ./cmd/ko && ko completion --zsh > ~/.zsh/Completion/_ko" atpull"%atclone"
zplugin light google/ko

zplugin ice wait'3' lucid as"program" has"go" \
  atclone"go install ./cmd/jira && jira --completion-script-zsh > ~/.zsh/Completion/_jira" atpull"%atclone"
zplugin light go-jira/jira

zplugin ice wait'3' lucid as"program" has"go" \
  atclone"go install ." atpull"%atclone"
zplugin light timakin/md2mid

zplugin ice wait'2' lucid as"program" from:"gh-r" pick:"tkn" \
  atclone"./tkn completion zsh > ~/.zsh/Completion/_tkn" atpull"%atclone"
zplugin light tektoncd/cli

zplugin ice wait'1' lucid as"program" pick"nvim*/bin/nvim" from:"gh-r"
zplugin light neovim/neovim

if ! (${COMPLETION_LOADED:-false}); then
  zplugin creinstall %HOME/.zsh/Completion &>/dev/null
  export COMPLETION_LOADED=true
fi
