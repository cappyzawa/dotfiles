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
# jonas/tig {{{
zinit ice wait"1" as"program" lucid \
    make"install prefix=$ZPFX" pick"$ZPFX/bin/tig"
zinit light jonas/tig
# }}}
# Rasukarusan/fzf-chrome-active-tab (as tl) {{{
zinit ice lucid wait"2" as"program" from"gh-r" \
    has"fzf" mv"chrome-tab-activate->tl"
zinit light Rasukarusan/fzf-chrome-active-tab
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
# dagger/dagger {{{
zinit ice wait'2' lucid as"program" from"gh-r" \
    atclone"./dagger completion zsh > ~/.zsh/Completion/_dagger" atpull"%atclone"
zinit light dagger/dagger
# }}}
# }}}

# golang {{{
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

# lua {{{
# Koihik/vscode-lua-format {{{
zinit ice wait'2' lucid as"program" \
    pick"bin/$(ostype)/lua-format"
zinit light Koihik/vscode-lua-format
# }}}
# }}}

# yaml {{{
# carvel-dev/ytt {{{
zinit ice wait'2' lucid as"program" from"gh-r" \
    mv"ytt-* -> ytt"
zinit light carvel-dev/ytt
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

# zig {{{
# zigtools/zls {{{
zinit ice wait'2' lucid as"program" from"gh-r" has"zig" \
    pick"bin/zls"
zinit light zigtools/zls
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
# ko-build/ko {{{
zinit ice wait'3' lucid as"program" from"gh-r" \
    atclone"./ko completion zsh > ~/.zsh/Completion/_ko" atpull"%atclone" \
    atload"export KO_DOCKER_REPO='docker.io/cappyzawa'"
zinit light ko-build/ko
# }}}
# operator-framework/operator-sdk {{{
zinit ice wait'2' lucid as"program" from:"gh-r" \
    bpick"operator-sdk_*" \
    mv"operator-sdk_*->operator-sdk"
zinit light operator-framework/operator-sdk
# }}}
# kubernetes-sigs/kubebuilder {{{
zinit ice wait'2' lucid as"program" from:"gh-r" \
    mv"kubebuilder_*->kubebuilder" \
    atclone"kubebuilder completion zsh > ~/.zsh/Completion/_kubebuilder" \
    atpull"%atclone"
zinit light kubernetes-sigs/kubebuilder
# }}}
# tektoncd/cli {{{
zinit ice wait'2' lucid as"program" from"gh-r" pick"tkn" \
    atclone"./tkn completion zsh > ~/.zsh/Completion/_tkn && ln -s $(which tkn) /usr/local/bin/kubectl-tkn" atpull"%atclone"
zinit light tektoncd/cli
# }}}
# okteto/okteto {{{
zinit ice wait'1' lucid as"program" from"gh-r" \
    mv"okteto-*->okteto"
zinit light okteto/okteto
# }}}
# kubernetes-sigs/controller-runtime#setup-envtest {{{
zinit ice wait'1' lucid as"program" \
    id-as"kubernetes-sigs/setup-envtest" \
    atclone"pushd tools/setup-envtest; go install ./...; popd" \
    atpull"%atclone"
zinit light kubernetes-sigs/controller-runtime
# }}}
# kubernetes-sigs/controller-tools#controller-gen {{{
zinit ice wait'1' lucid as"program" \
    id-as"kubernetes-sigs/controller-gen" \
    atclone"pushd cmd/controller-gen; go install; popd" \
    atpull"%atclone"
zinit light kubernetes-sigs/controller-tools
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
    atclone"./krew install krew && ./krew completion zsh > ~/.zsh/Completion/_krew" atpull"%atclone"
zinit light kubernetes-sigs/krew
# }}}
# FairwindsOps/pluto {{{
zinit ice wait'1' lucid as"program" from"gh-r" \
    atclone"./pluto completion zsh > ${HOME}/.zsh/Completion/_pluto" \
    atpull"%atclone"
zinit light FairwindsOps/pluto
# }}}
# tilt-dev/tilt {{{
zinit ice wait'2' lucid as"program" from"gh-r" \
    atclone"./tilt completion zsh > ${HOME}/.zsh/Completion/_tilt" \
    atpull"%atclone"
zinit light tilt-dev/tilt
# }}}
# tilt-dev/ctlptl {{{
zinit ice wait'2' lucid as"program" from"gh-r" \
    atclone"./ctlptl completion zsh > ${HOME}/.zsh/Completion/_ctlptl" \
    atpull"%atclone"
zinit light tilt-dev/ctlptl
# }}}
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

# protocolbuffers/protobuf {{{
zinit ice wait'2' lucid as"program" from:"gh-r" \
    if'[[ "$(ostype)" == "darwin" ]]' \
    bpick:"protoc-*-osx-*.zip" mv"bin/protoc->$ZPFX/bin/protoc"
zinit light protocolbuffers/protobuf
# }}}

zinit ice wait cdreplay -q
zinit creinstall -Q %HOME/.zsh/Completion 2>&1 >/dev/null
