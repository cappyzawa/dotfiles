# required for activatioin {{{
# junegunn/fzf-bin {{{
zinit ice lucid from"gh-r" as"program"
zinit light "junegunn/fzf-bin"
# }}}
# cappyzawa/enhancd (instead of https://github.com/b4b4r07/enhancd) {{{
zinit ice pick"init.sh" lucid \
  atload'export ENHANCD_FILTER="fzf --height 50% --reverse --ansi";export ENHANCD_DOT_SHOW_FULLPATH=1' \
  atclone"zinit cclear" atpull"%atclone"
zinit light "cappyzawa/enhancd"
# }}}
# starship/starship {{{
zinit ice lucid as"program" from"gh-r" bpick"starship-x86_64-*.tar.gz" \
  atclone'starship completions > ~/.zsh/Completion/_starship' atpull'%atclone' \
  atload'export STARSHIP_CONFIG=$XDG_CONFIG_HOME/starship/starship.toml'
zinit light starship/starship
# }}}
# ogham/exa (as ls) {{{
zinit ice lucid as"program" from"gh-r" \
  mv"exa-*->exa" \
  atload="alias ls='exa'"
zinit light ogham/exa
# }}}
# BurntSushi/ripgrep {{{
zinit ice lucid as"program" from"gh-r" \
  pick:"ripgrep-*/rg"
zinit light BurntSushi/ripgrep
# }}}
# anyenv/anyenv {{{
zinit ice as"program" pick:"bin/anyenv"
zinit light anyenv/anyenv
# }}}
# neovim/neovim {{{
zinit ice lucid as"program" pick"nvim*/bin/nvim" from:"gh-r" \
  ver"nightly"
zinit light neovim/neovim
# }}}
# }}}

# local snippets {{{
zinit ice wait"1" lucid
zinit snippet $HOME/.zsh/10_utils.zsh
zinit ice wait"1" lucid
zinit snippet $HOME/.zsh/20_keybinds.zsh
zinit ice wait"1" lucid
zinit snippet $HOME/.zsh/30_aliases.zsh
zinit ice wait"1" lucid
zinit snippet $HOME/.zsh/50_setopt.zsh
zinit ice wait"2" lucid
zinit snippet $HOME/.zsh/60_lang.zsh
zinit ice wait"4" lucid
zinit snippet $HOME/.zsh/80_custom.zsh
# }}}

# utils {{{
# stedolan/jq {{{
zinit ice wait"1" as"program" from"gh-r" lucid \
  mv"jq-* -> jq" pick"jq" \
  atload"alias -g JQ='| jq -C .' && alias -g JL='| jq -C . | less -R -X'"
zinit light stedolan/jq
# }}}
# jonas/tig {{{
zinit ice wait"1" as"program" lucid \
  make"install prefix=$ZPFX" pick"$ZPFX/bin/tig"
zinit light jonas/tig
# }}}
# x-motemen/ghq {{{
zinit ice wait"1" as"program" from"gh-r" pick"ghq_*/ghq" lucid
zinit light x-motemen/ghq
# }}}
# sharkdp/hyperfine {{{
zinit ice wait"1" as"program" from"gh-r" pick"hyperfine-*/hyperfine" lucid
zinit light sharkdp/hyperfine
# }}}
# cjbassi/gotop {{{
zinit ice wait"1" as"program" from"gh-r" pick"gotop" lucid
zinit light cjbassi/gotop
# }}}
# Rasukarusan/fzf-chrome-active-tab (as tl) {{{
zinit ice lucid wait"2" as"program" from"gh-r" \
  has"fzf" mv"chrome-tab-activate->tl"
zinit light Rasukarusan/fzf-chrome-active-tab
# }}}
# mikefarah/yq {{{
zinit ice wait'2' lucid as"program" from:"gh-r" \
  mv"yq* -> yq"
zinit light mikefarah/yq
# }}}
# mhinz/neovim-remote (as nvr) {{{
zinit ice wait'2' lucid as"program" has"pyenv" \
  atclone'python setup.py install && ln -s $(pyenv which nvr) ~/bin/nvr' atpull"%atclone"
zinit light mhinz/neovim-remote
# }}}
# direnv/direnv {{{
zinit ice wait"3" as"program" has"go" \
  make'!' atclone'./direnv hook zsh > zhook.zsh' atpull'%atclone' src"zhook.zsh" lucid
zinit light direnv/direnv
# }}}
# cli/cli (as gh) {{{
zinit ice wait'1' lucid as"program" from:"gh-r" \
  mv"gh*/bin/gh->gh" \
  atclone"gh completion --shell zsh > ~/.zsh/Completion/_gh" \
  atpull"%atclone"
zinit light "cli/cli"
# }}}
# sharkdp/bat {{{
zinit ice wait'3' lucid as"program" has:"cargo" \
  atclone"cargo build --bins" atpull"%atclone" \
  pick"target/debug/bat" \
  atload"alias cat='bat'"
zinit light sharkdp/bat
# }}}
# }}}

# docker {{{
# jesseduffield/lazydocker (as ld) {{{
zinit ice wait"1" as"program" from"gh-r" pick"lazydocker" lucid \
  atload"alias ld='lazydocker'"
zinit light jesseduffield/lazydocker
# }}}
# wagoodman/dive {{{
zinit ice wait'2' lucid as"program" from:"gh-r"
zinit light wagoodman/dive
# }}}
# buildpacks/pack {{{
zinit ice wait'2' lucid as"program" from"gh-r" \
  atclone'cp $(./pack completion --shell zsh) ~/.zsh/Completion/_pack' \
  atpull"%atclone"
zinit light "buildpacks/pack"
# }}}
# }}}

# golang {{{
# goreleaser/goreleaser {{{
zinit ice wait"3" as"program" from"gh-r" lucid \
  pick"goreleaser" has"go"
zinit light goreleaser/goreleaser
# }}}
# golangci/golangci-lint {{{
zinit ice wait"3" as"program" from"gh-r" pick"golangci-lint-*/golangci-lint" lucid \
  has"go" \
  atclone"golangci-lint completion zsh > ~/.zsh/Completion/_golangci-lint"
zinit light golangci/golangci-lint
# }}}
# go-delve/delve {{{
zinit ice wait'3' lucid as"program" pick"$ZPFX/bin/dlv" has"go" \
  atclone"go build -o $ZPFX/bin/dlv cmd/dlv/main.go" atpull"%atclone"
zinit light go-delve/delve
# }}}
# golang/dep {{{
zinit ice wait'3' lucid as"program" has"go" \
  atclone"./install.sh" atpull"%atclone"
zinit light golang/dep
# }}}
# }}}

# rust {{{
# rust-analyzer/rust-analyzer {{{
zinit ice wait'2' lucid as"program" from:"gh-r" \
  mv"rust-analyzer* -> rust-analyzer" has:"rustup"
zinit light rust-analyzer/rust-analyzer
# }}}
# }}}

# yaml {{{
# adrienverge/yamllint {{{
zinit ice wait'2' lucid atclone"python setup.py install" atpull"%atclone"
zinit light adrienverge/yamllint
# }}}
# k14s/ytt {{{
zinit ice wait'2' lucid as"program" from"gh-r" \
  mv"ytt-* -> ytt" pick"ytt"
zinit light "k14s/ytt"
# }}}
# }}}

# zsh {{{
zinit wait lucid for \
 atinit"ZINIT[COMPINIT_OPTS]=-C; zpcompinit; zpcdreplay" \
    zdharma/fast-syntax-highlighting \
 atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions \
 blockf \
    zsh-users/zsh-completions
# }}}

# lua {{{
# ninja-build/ninja {{{
if [[ `uname` == "Darwin" ]]; then
  zinit ice wait'2' lucid as"program" from"gh-r" bpick"ninja-mac*"
  zinit light "ninja-build/ninja"
fi
# }}}
# }}}

# for only vim plugins {{{
# Aloxaf/silicon {{{
zinit ice lucid wait"2" as"program" from"gh-r"
zinit light Aloxaf/silicon
# }}}
# github/hub {{{
zinit ice wait'2' lucid as"program" make"install prefix=$ZPFX" pick"$ZPFX/bin/hub"
zinit light github/hub
# }}}
# 110y/go-expr-completion {{{
zinit ice wait'3' lucid as"program" has"go" \
  atclone"GO111MODULE=on go install ./..."
zinit light 110y/go-expr-completion
# }}}
# }}}

# kubernetes {{{
# GoogleContainerTools/kpt {{{
zinit ice wait'3' lucid as"program" has"go" \
  atclone"GO111MODULE=on go install ./..."
zinit light GoogleContainerTools/kpt
# }}}
# k14s/kapp {{{
zinit ice wait'2' lucid as"program" from"gh-r" \
  mv"kapp-* -> kapp" pick"kapp"
zinit light "k14s/kapp"
# }}}
# k14s/kbld {{{
zinit ice wait'2' lucid as"program" from"gh-r" \
  mv"kbld-* -> kbld" pick"kbld"
zinit light "k14s/kbld"
# }}}
# zlabjp/kubernetes-scripts (as create-kubeconfig) {{{
zinit ice wait'2' lucid as"program" pick"create-kubeconfig"
zinit light zlabjp/kubernetes-scripts
# }}}
# kubernetes-sigs/kustomize {{{
zinit ice wait'2' lucid as"program" from"gh-r" \
  mv"kustomize* -> kustomize"
zinit light kubernetes-sigs/kustomize
# }}}
# wercker/stern {{{
zinit ice wait'2' lucid as"program" from"gh-r" \
  mv"stern* -> stern"
zinit light wercker/stern
# }}}
# ahmetb/kubectx {{{
zinit ice wait'2' lucid as"program" pick:"kubectx"
zinit light ahmetb/kubectx
# }}}
# google/ko {{{
zinit ice wait'3' lucid as"program" has"go" \
  atclone"go install ./cmd/ko && ko completion --zsh > ~/.zsh/Completion/_ko" atpull"%atclone" \
  atload"export KO_DOCKER_REPO='docker.io/cappyzawa'"
zinit light google/ko
# }}}
# operator-framework/operator-sdk {{{
zinit ice wait'2' lucid as"program" from:"gh-r" \
  mv"operator-sdk-v*-x86_64-*->operator-sdk"
zinit light operator-framework/operator-sdk
# }}}
# kubernetes-sigs/kubebuilder {{{
zinit ice wait'2' lucid as"program" from:"gh-r" \
  mv"kubebuilder*/bin/kubebuilder->$ZPFX/bin/kubebuilder"
zinit light kubernetes-sigs/kubebuilder
# }}}
# kubernetes-sigs/kind {{{
zinit ice wait'3' lucid as"program" from:"gh-r" \
  mv"kind-*->kind" \
  atclone"kind completion zsh > ~/.zsh/Completion/_kind" atpull"%atclone"
zinit light kubernetes-sigs/kind
# }}}
# tektoncd/cli {{{
zinit ice wait'2' lucid as"program" from:"gh-r" pick:"tkn" \
  atclone"./tkn completion zsh > ~/.zsh/Completion/_tkn && ln -s `which tkn` /usr/local/bin/kubectl-tkn" atpull"%atclone"
zinit light tektoncd/cli
# }}}
# }}}

# terraform {{{
# terraform-linters/tflint {{{
zinit ice wait'2' lucid as"program" from:"gh-r" has"terraform"
zinit light terraform-linters/tflint
# }}}
# hashicorp/terraform-ls {{{
zinit ice wait'2' lucid as"program" from:"gh-r" has"terraform"
zinit light hashicorp/terraform-ls
# }}}
# juliosueiras/terraform-lsp {{{
zinit ice wait'2' lucid as"program" from:"gh-r" has"terraform"
zinit light juliosueiras/terraform-lsp
# }}}
# terraform-docs/terraform-docs {{{
zinit ice wait'2' lucid as"program" from:"gh-r" has"terraform" \
  mv"terraform-docs-*->terraform-docs"
zinit light terraform-docs/terraform-docs
# }}}
# hashicorp/terraform-bundle {{{
zinit ice wait'3' lucid as"program" has"go" id-as"hashicorp/terraform-bundle"\
  atclone"go install ./tools/terraform-bundle" atpull"%atclone"
zinit light hashicorp/terraform
# }}}
# }}}

# smallstep/cli {{{
zinit ice wait'3' lucid as"program" from"gh-r" \
  mv"step_*/bin/step -> $ZPFX/bin/step"
zinit light smallstep/cli
# }}}

# cloudfoundry/bosh-cli {{{
zinit ice wait'2' lucid as"program" from"gh-r" \
  mv"bosh-cli* -> bosh"
zinit light cloudfoundry/bosh-cli
# }}}

# concourse/fly {{{
zinit ice wait'2' lucid as"program" from"gh-r" id-as"concourse/fly"\
  bpick"fly-*" atclone"./fly completion --shell=zsh > ~/.zsh/Completion/_fly" atpull"%atclone"
zinit light concourse/concourse
# }}}

# minio/mc {{{
zinit ice wait'3' lucid as"program" has"go" \
  atclone"GO111MODULE=on go install ." atpull"%atclone"
zinit light minio/mc
# }}}

# bazelbuild/bazel {{{
zinit ice wait'2' lucid as"program" from:"gh-r" \
  mv"bazel-*-*-x86_64*->bazel"
zinit light bazelbuild/bazel
# }}}

# screwdriver-cd/sd-local {{{
zinit ice wait'2' lucid as"program" from:"gh-r" \
  mv"sd-local_*->sd-local"
zinit light screwdriver-cd/sd-local
# }}}

# denoland/deno_install {{{
zinit ice wait'2' lucid as"program" \
  atclone"curl -fsSL https://deno.land/x/install/install.sh | DENO_INSTALL=$ZPFX sh && deno completions zsh > ~/.zsh/Completion/_deno" atpull"%atclone"
zinit light denoland/deno_install
# }}}

zinit cdreplay -q
