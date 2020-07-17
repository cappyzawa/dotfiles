# zinit annexes {{{
zinit light zinit-zsh/z-a-rust
# }}}

zinit ice lucid from"gh-r" as"program"
zinit light "junegunn/fzf-bin"

zinit ice pick"init.sh" lucid \
  atload'export ENHANCD_FILTER="fzf --height 50% --reverse --ansi";export ENHANCD_DOT_SHOW_FULLPATH=1'
zinit light "b4b4r07/enhancd"

zinit ice lucid as"program" from"gh-r" bpick"starship-x86_64-*.tar.gz" \
  atclone'starship completions > ~/.zsh/Completion/_starship' atpull'%atclone' \
  atload'export STARSHIP_CONFIG=$XDG_CONFIG_HOME/starship/starship.toml'
zinit light starship/starship

zinit ice lucid as"program" from"gh-r" \
  mv"exa-*->exa"
zinit light ogham/exa

zinit ice as"program" pick:"bin/anyenv"
zinit light anyenv/anyenv

# compinit
zinit cdreplay -q

# local snippets
zinit ice lucid
zinit snippet $HOME/.zsh/10_utils.zsh
zinit ice lucid
zinit snippet $HOME/.zsh/20_keybinds.zsh
zinit ice lucid
zinit snippet $HOME/.zsh/30_aliases.zsh
zinit ice lucid
zinit snippet $HOME/.zsh/50_setopt.zsh
zinit ice lucid
zinit snippet $HOME/.zsh/60_lang.zsh

zinit ice lucid
zinit snippet $HOME/.zsh/80_custom.zsh

zinit ice wait"2" as"program" from"gh-r" \
  mv"jq-* -> jq" pick"jq" lucid
zinit light stedolan/jq

zinit ice wait"2" as"program" lucid \
  make"install prefix=$ZPFX" pick"$ZPFX/bin/tig"
zinit light jonas/tig

zinit ice wait"3" as"program" has"go" \
  make'!' atclone'./direnv hook zsh > zhook.zsh' atpull'%atclone' src"zhook.zsh" lucid
zinit light direnv/direnv

zinit ice wait"2" as"program" from"gh-r" pick"ghq_*/ghq" lucid
zinit light x-motemen/ghq

zinit ice wait"2" as"program" from"gh-r" pick"goreleaser" lucid
zinit light goreleaser/goreleaser

zinit ice wait"2" as"program" from"gh-r" pick"lazygit" lucid
zinit light jesseduffield/lazygit

zinit ice wait"2" as"program" from"gh-r" pick"lazydocker" lucid
zinit light jesseduffield/lazydocker

zinit ice wait'2' as"program" from"gh-r" pick"hyperfine-*/hyperfine" lucid
zinit light sharkdp/hyperfine

zinit ice wait'2' as"program" from"gh-r" pick"golangci-lint-*/golangci-lint" lucid
zinit light golangci/golangci-lint

zinit ice wait"2" as"program" from"gh-r" pick"gotop" lucid
zinit light cjbassi/gotop

zinit ice wait"2" as"program" from"gh-r" pick"*/ccat" lucid
zinit light jingweno/ccat

zinit wait lucid for \
 atinit"ZINIT[COMPINIT_OPTS]=-C; zpcompinit; zpcdreplay" \
    zdharma/fast-syntax-highlighting \
 atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions \
 blockf \
    zsh-users/zsh-completions

zinit ice wait'2' lucid as"program" from:"gh-r" \
  mv"yq* -> yq"
zinit light mikefarah/yq

zinit ice wait'2' lucid as"program" from:"gh-r"
zinit light wagoodman/dive

zinit ice wait'2' lucid as"program" from:"gh-r"
zinit light nektos/act

zinit ice wait"2" lucid as"program" from"gh-r"
zinit light charmbracelet/glow

zinit ice wait'2' lucid atclone"python setup.py install" atpull"%atclone"
zinit light adrienverge/yamllint

zinit ice wait'2' lucid as"program" make"install prefix=$ZPFX" pick"$ZPFX/bin/hub"
zinit light github/hub

zinit ice wait'3' lucid as"program" pick"$ZPFX/bin/dlv" has"go" \
  atclone"go build -o $ZPFX/bin/dlv cmd/dlv/main.go" atpull"%atclone"
zinit light go-delve/delve

zinit ice wait'3' lucid as"program" has"go" \
  atclone"GO111MODULE=on go install ./..."
zinit light GoogleContainerTools/kpt

zinit ice wait'2' lucid as"program" from"gh-r" \
  mv"ytt-* -> ytt" pick"ytt"
zinit light "k14s/ytt"

zinit ice wait'2' lucid as"program" from"gh-r" \
  mv"kapp-* -> kapp" pick"kapp"
zinit light "k14s/kapp"

zinit ice wait'2' lucid as"program" from"gh-r" \
  mv"kbld-* -> kbld" pick"kbld"
zinit light "k14s/kbld"

zinit ice wait'2' lucid as"program" from"gh-r" \
  atclone'cp $(./pack completion --shell zsh) ~/.zsh/Completion/_pack' \
  atpull"%atclone"
zinit light "buildpacks/pack"

zinit ice wait'3' lucid as"program" from"gh-r" \
  mv"gh*/bin/gh -> gh"
zinit light "cli/cli"

if [[ `uname` == "Darwin" ]]; then
  zinit ice wait'2' lucid as"program" from"gh-r" bpick"ninja-mac*"
  zinit light "ninja-build/ninja"

  zinit ice wait'2' lucid has"git" \
    atclone"git submodule update --init --recursive && cd 3rd/luamake && ninja -f ninja/macos.ninja && cd ../../ && 3rd/luamake rebuild" atpull"%atclone"
  zinit light "sumneko/lua-language-server"
fi


zinit ice wait'2' lucid as"program" pick"create-kubeconfig"
zinit light zlabjp/kubernetes-scripts

zinit ice wait'2' lucid as"program" from"gh-r" \
  mv"kustomize* -> kustomize"
zinit light kubernetes-sigs/kustomize

zinit ice wait'2' lucid as"program" from"gh-r" \
  mv"stern* -> stern"
zinit light wercker/stern

zinit ice wait'2' lucid as"program" from"gh-r" \
  mv"bosh-cli* -> bosh"
zinit light cloudfoundry/bosh-cli

zinit ice wait'2' lucid as"program" from"gh-r"
zinit light cappyzawa/vf

zinit ice wait'2' lucid as"program" from"gh-r" \
  has"op"
zinit light cappyzawa/op-kv

zinit ice wait'2' lucid as"program" from"gh-r" \
  pick"jqlb"
zinit light cappyzawa/jql-builder

zinit ice wait'2' lucid as"program" pick:"kubectx"
zinit light ahmetb/kubectx

zinit ice wait'2' lucid as"program" from"gh-r" id-as"concourse/fly"\
  bpick"fly-*" atclone"./fly completion --shell=zsh > ~/.zsh/Completion/_fly" atpull"%atclone"
zinit light concourse/concourse

zinit ice wait'3' lucid as"program" id-as"golang/lsp" has"go" \
  atclone"GO111MODULE=on go build -o $ZPFX/bin/gopls ./gopls/main.go" atpull"%atclone"
zinit light golang/tools

zinit ice wait'3' lucid as"program" has"go" \
  atclone"./install.sh" atpull"%atclone"
zinit light golang/dep

zinit ice wait'3' lucid as"program" has"go" \
  atclone"go install ./cmd/ko && ko completion --zsh > ~/.zsh/Completion/_ko" atpull"%atclone"
zinit light google/ko

zinit ice wait'3' lucid as"program" has"go" \
  atclone"go install ./cmd/jira && jira --completion-script-zsh > ~/.zsh/Completion/_jira" atpull"%atclone"
zinit light go-jira/jira

zinit ice wait'3' lucid as"program" has"go" \
  atclone"go install ." atpull"%atclone"
zinit light timakin/md2mid

zinit ice wait'3' lucid as"program" has"go" \
  atclone"go install ." atpull"%atclone"
zinit light skanehira/gtran

zinit ice wait'3' lucid as"program" from:"gh-r" \
  mv"kind-*->kind" \
  atclone"kind completion zsh > ~/.zsh/Completion/_kind" atpull"%atclone"
zinit light kubernetes-sigs/kind

zinit ice wait'3' lucid as"program" has"go" \
  atclone"GO111MODULE=on go install ." atpull"%atclone"
zinit light minio/mc

zinit ice wait'2' lucid as"program" from:"gh-r" pick:"tkn" \
  atclone"./tkn completion zsh > ~/.zsh/Completion/_tkn" atpull"%atclone"
zinit light tektoncd/cli

zinit ice wait'2' lucid as"program" from:"gh-r" \
  mv"kubebuilder*/bin/kubebuilder->$ZPFX/bin/kubebuilder"
zinit light kubernetes-sigs/kubebuilder

zinit ice wait'2' lucid as"program" from:"gh-r" \
  mv"operator-sdk-v*-x86_64-*->operator-sdk"
zinit light operator-framework/operator-sdk

zinit ice wait'2' lucid as"program" from:"gh-r" has"terraform"
zinit light terraform-linters/tflint

# zinit ice wait'2' lucid as"program" from:"gh-r" has"terraform"
# zinit light hashicorp/terraform-ls

zinit ice wait'2' lucid as"program" from:"gh-r" has"terraform"
zinit light juliosueiras/terraform-lsp

zinit ice wait'2' lucid as"program" from:"gh-r" \
  mv"bazel-*-*-x86_64*->bazel"
zinit light bazelbuild/bazel

zinit ice wait'2' lucid as"program" from:"gh-r" \
  mv"sd-local_*->sd-local"
zinit light screwdriver-cd/sd-local

zinit ice wait'1' lucid as"program" pick"nvim*/bin/nvim" from:"gh-r"
zinit light neovim/neovim

zinit ice wait'2' lucid as"program" \
  atclone"curl -fsSL https://deno.land/x/install/install.sh | DENO_INSTALL=$ZPFX sh && deno completions zsh > ~/.zsh/Completion/_deno" atpull"%atclone"
zinit light denoland/deno_install

zinit ice wait'3' lucid rustup cargo'!silicon'
zinit light zdharma/null

zinit ice wait'3' lucid rustup cargo'!ripgrep'
zinit light zdharma/null

zinit ice wait'3' lucid rustup cargo'!rls'
zinit light zdharma/null

zinit ice wait'3' lucid rustup cargo'!rust-analysis'
zinit light zdharma/null

zinit ice wait'3' lucid rustup cargo'!rust-src'
zinit light zdharma/null

if [[ -z ${INSTALLED_COMPS} ]]; then
  zinit creinstall -q $HOME/.zsh/Completion
fi
