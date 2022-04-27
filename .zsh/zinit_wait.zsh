# local snippets {{{
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
# neovim/neovim {{{
zinit ice wait"1" lucid as"program" pick"nvim*/bin/nvim" from:"gh-r" \
  if'is_mac' \
  bpick"nvim-macos.tar.gz" ver"nightly"
zinit light neovim/neovim
# }}}
# b4b4r07/enhancd {{{
zinit ice wait pick"init.sh" lucid \
  atload'export ENHANCD_FILTER="fzf --height 50% --reverse --ansi";export ENHANCD_DOT_SHOW_FULLPATH=1' \
  atclone"zinit cclear" atpull"%atclone"
zinit light "b4b4r07/enhancd"
# }}}
# tree-sitter/tree-sitter {{{
zinit ice wait lucid as"program" from"gh-r" \
  mv"tree-sitter-* -> tree-sitter"
zinit light tree-sitter/tree-sitter
# }}}
# starship/starship {{{
zinit ice wait lucid as"command" from"gh-r" \
  bpick'*.tar.gz' \
  atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
  atpull"%atclone" src"init.zsh" \
  atload"export STARSHIP_CONFIG=$XDG_CONFIG_HOME/starship/starship.toml"
zinit light starship/starship
# }}}
# ogham/exa (as ls) {{{
zinit ice wait lucid as"program" from"gh-r" \
  pick"bin/exa" \
  atload="alias ls='exa'"
zinit light ogham/exa
# }}}
# BurntSushi/ripgrep {{{
zinit ice wait lucid as"program" from"gh-r" \
  pick"ripgrep-*/rg"
zinit light BurntSushi/ripgrep
# }}}
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
# jesseduffield/lazygit {{{
zinit ice wait"1" as"program" from:"gh-r" lucid
zinit light jesseduffield/lazygit
# }}}
# x-motemen/ghq {{{
zinit ice wait as"program" from"gh-r" pick"ghq_*/ghq" lucid
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
# cli/cli (as gh) {{{
zinit ice wait'1' lucid as"program" from:"gh-r" \
  mv"gh*/bin/gh->gh" \
  atclone"gh completion --shell zsh > ~/.zsh/Completion/_gh" \
  atpull"%atclone"
zinit light "cli/cli"
# }}}
# sharkdp/bat {{{
zinit ice wait'1' lucid as"program" from"gh-r" \
  pick"bat-v*/bat" \
  atload"compdef _gnu_generic bat"
zinit light sharkdp/bat
# }}}
# sharkdp/fd {{{
zinit ice wait'1' lucid as"program" from"gh-r" \
  pick"fd-*/fd" \
  atload"compdef _gnu_generic fd"
zinit light sharkdp/fd
# }}}
# sharkdp/diskus {{{
zinit ice wait'1' lucid as"program" from"gh-r" \
  pick"diskus-*/diskus" \
  atload"compdef _gnu_generic diskus"
zinit light sharkdp/diskus
# }}}
# dandavison/delta {{{
zinit ice wait'1' lucid as"program" from"gh-r" \
  pick"delta-*/delta" \
  atload"compdef _gnu_generic delta"
zinit light dandavison/delta
# }}}
# o2sh/onefetch {{{
zinit ice wait'1' lucid as"program" from:"gh-r"
zinit light o2sh/onefetch
# }}}
# google/starlark-go {{{
zinit ice wait'3' lucid as"program" has"go" \
  atclone"go install ./cmd/starlark/..." atpull"%atclone"
zinit light google/starlark-go
# }}}
# open-policy-agent/conftest {{{
zinit ice wait'2' lucid as"program" from"gh-r"
zinit light open-policy-agent/conftest
# }}}
# open-policy-agent/opa {{{
zinit ice wait'2' lucid as"program" from"gh-r" \
  mv"opa* -> opa"
zinit light open-policy-agent/opa
# }}}
# smallstep/cli {{{
zinit ice wait'3' lucid as"program" from"gh-r" \
  mv"step_*/bin/step -> $ZPFX/bin/step"
zinit light smallstep/cli
# }}}
# smallstep/certificates {{{
zinit ice wait'3' lucid as"program" from"gh-r" \
  pick"step-ca*/bin/step-ca"
zinit light smallstep/certificates
# }}}

# mike-engel/jwt-cli {{{
zinit ice wait'2' lucid as"program" from"gh-r"
zinit light mike-engel/jwt-cli
# }}}
# cheat/cheat {{{
zinit ice wait'2' lucid as"program" from"gh-r" \
  mv"cheat-*->cheat"
zinit light cheat/cheat
# }}}
# Aloxaf/fzf-tab {{{
zinit ice wait'2' lucid as"program" \
  atload"source ./fzf-tab.plugin.zsh"
zinit light Aloxaf/fzf-tab
# }}}
# alacritty/alacritty {{{
zinit ice wait'2' lucid as"program" \
  if'[[ "$(ostype)" == "darwin" ]]' \
  make!"app" \
  atclone"cp -r target/release/${PLATFORM}/Alacritty.app /Applications" \
  atpull"%atclone" \
  has"cargo"
zinit light alacritty/alacritty
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
# dominikh/go-tools (id-as"golang/staticcheck") {{{
zinit ice wait"1" lucid as"program" from"gh-r" id-as"golang/staticcheck" \
  pick"staticcheck/staticcheck"
zinit light dominikh/go-tools
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

# lua {{{
# Koihik/vscode-lua-format {{{
zinit ice wait'2' lucid as"program" \
  pick"bin/$(ostype)/lua-format"
zinit light Koihik/vscode-lua-format
# }}}
# }}}

# yaml {{{
# adrienverge/yamllint {{{
zinit ice wait'2' lucid atclone"python setup.py install" atpull"%atclone"
zinit light adrienverge/yamllint
# }}}
# vmware-tanzu/carvel-ytt {{{
zinit ice wait'2' lucid as"program" from"gh-r" \
  mv"ytt-* -> ytt" pick"ytt"
zinit light "vmware-tanzu/carvel-ytt"
# }}}
# }}}

# zsh {{{
zinit wait lucid for \
 atinit"ZINIT[COMPINIT_OPTS]=-C; zpcompinit; zpcdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
 atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions \
 blockf \
    zsh-users/zsh-completions
# }}}

# java {{{
zinit ice lucid wait"2" as"program" has"mvn" \
  if'is_mac' \
  atclone"mvn package -DskipTests" \
  atpull"%atclone"
zinit light georgewfraser/java-language-server
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
# }}}

# kubernetes {{{
# GoogleContainerTools/kpt {{{
zinit ice wait'3' lucid as"program" has"go" \
  atclone"GO111MODULE=on go install ./..."
zinit light GoogleContainerTools/kpt
# }}}
# zlabjp/kubernetes-scripts (as create-kubeconfig) {{{
zinit ice wait'2' lucid as"program" pick"create-kubeconfig"
zinit light zlabjp/kubernetes-scripts
# }}}
# kubernetes-sigs/kustomize {{{
zinit ice wait'2' lucid as"program" from"gh-r" \
  mv"kustomize* -> kustomize" \
  atclone"./kustomize completion zsh > ~/.zsh/Completion/_kustomize" \
  atpull"%atclone"
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
zinit ice wait'3' lucid as"program" from"gh-r" \
  atclone"ko completion --zsh > ~/.zsh/Completion/_ko" atpull"%atclone" \
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
  mv"kubebuilder_*->kubebuilder" \
  atclone"kubebuilder completion zsh > ~/.zsh/Completion/_kubebuilder" \
  atpull"%atclone"
zinit light kubernetes-sigs/kubebuilder
# }}}
# kubernetes-sigs/kind {{{
zinit ice wait'3' lucid as"program" from:"gh-r" \
  mv"kind-*->kind" \
  atclone"kind completion zsh > ~/.zsh/Completion/_kind" atpull"%atclone"
zinit light kubernetes-sigs/kind
# }}}
# tektoncd/cli {{{
zinit ice wait'2' lucid as"program" from"gh-r" pick"tkn" \
  atclone"./tkn completion zsh > ~/.zsh/Completion/_tkn && ln -s `which tkn` /usr/local/bin/kubectl-tkn" atpull"%atclone"
zinit light tektoncd/cli
# }}}
# okteto/okteto {{{
zinit ice wait'1' lucid as"program" from"gh-r" \
  mv"okteto-*->okteto" \
  atload"export KUBECONFIG=$HOME/.kube/config:$HOME/.config/okteto/okteto-kube.config"
zinit light okteto/okteto
# }}}
# kubernetes-sigs/controller-runtime#setup-envtest {{{
zinit ice wait'1' lucid as"program" \
  id-as"kubernetes-sigs/setup-envtest" \
  atclone"pushd tools/setup-envtest; go install; popd" \
  atpull"%atclone"
zinit light kubernetes-sigs/controller-runtime
# }}}
# sh0rez/kubectl-neat-diff {{{
zinit ice wait'1' lucid as"program" from"gh-r" \
  mv"kubectl-neat-diff-* -> kubectl-neat-diff" \
  atload"export KUBECTL_EXTERNAL_DIFF=kubectl-neat-diff"
zinit light sh0rez/kubectl-neat-diff
# }}}
# kubernetes-sigs/krew {{{
zinit ice wait'1' lucid as"program" from"gh-r" \
  mv"krew-*->krew" \
  atclone"./krew install krew" atpull"%atclone"
zinit light kubernetes-sigs/krew
# }}}
# FairwindsOps/pluto {{{
zinit ice wait'1' lucid as"program" from"gh-r" \
  atclone"./pluto completion zsh > ${HOME}/.zsh/Completion/_pluto" \
  atpull"%atclone"
zinit light FairwindsOps/pluto
# }}}
# }}}

# hashicorp tools {{{
# terraform {{{
# terraform-linters/tflint {{{
zinit ice wait'2' lucid as"program" from:"gh-r" has"terraform"
zinit light terraform-linters/tflint
# }}}
# hashicorp/terraform-ls {{{
zinit ice wait'2' lucid as"program" from"gh-r" has"terraform"
zinit light hashicorp/terraform-ls
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
# cappyzawa/tfswitch {{{
zinit ice wait'1' lucid as"program" from"gh-r"
zinit light cappyzawa/tfswitch
# }}}
# im2nguyen/rover {{{
zinit ice wait'1' lucid as"program" from"gh-r" \
  mv"rover_* -> rover"
zinit light im2nguyen/rover
# }}}
# }}}
# }}}

# tonsky/FiraCode {{{
zinit ice wait'1' lucid as"program" from:"gh-r" \
  if'[[ "$(ostype)" == "darwin" ]]' \
  atclone"cp ttf/FiraCode*.ttf ~/Library/Fonts"
zinit light tonsky/FiraCode
# }}}

# cloudfoundry/bosh-cli {{{
zinit ice wait'2' lucid as"program" from"gh-r" \
  mv"bosh-cli* -> bosh"
zinit light cloudfoundry/bosh-cli
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

# protocolbuffers/protobuf {{{
zinit ice wait'2' lucid as"program" from:"gh-r" \
  if'[[ "$(ostype)" == "darwin" ]]' \
  bpick:"protoc-*-osx-*.zip" mv"bin/protoc->$ZPFX/bin/protoc"
zinit light protocolbuffers/protobuf
# }}}

zinit ice wait cdreplay -q
zinit creinstall -Q %HOME/.zsh/Completion
