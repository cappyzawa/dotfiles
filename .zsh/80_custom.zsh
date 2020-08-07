if has "kubectl"; then
  alias k='kubectl'
fi

if has 'tkn'; then
  if [[ ! -e '/usr/local/bin/kubectl-tkn' ]]; then
    ln -s `which tkn` /usr/local/bin/kubectl-tkn
  fi
fi

if has 'ko'; then
  export KO_DOCKER_REPO='docker.io/cappyzawa'
fi

export KREW_ROOT=${KREW_ROOT:-$HOME/.krew}
if [[ -d $KREW_ROOT ]]; then
  export PATH="${KREW_ROOT}/bin:$PATH"
fi

if (which jenv > /dev/null); then
  export JAVA_HOME="${ANYENV_ROOT}/envs/jenv/versions/`jenv version-name`"
fi

if has "jq"; then
  alias -g JQ='| jq -C .'
  alias -g JL='| jq -C . | less -R -X'
fi

if has "lazygit"; then
  alias lg='lazygit'

  if [[ "${PLATFORM}" == "osx" ]] && ! [[ -d ~/Library/Application\ Support/jesseduffield/lazygit ]]; then
    ln -s ~/.config/jesseduffield/lazygit ~/Library/Application\ Support/jesseduffield/lazygit
  fi
fi

if has "lazydocker"; then
  alias ld='lazydocker'
fi

if has "vault"; then
  complete -o nospace -C `which vault` vault
fi

if has "mc"; then
  complete -o nospace -C `which mc` mc
fi

if ! has "helm"; then
  curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
fi

if has "go"; then
  export GOPRIVATE="*.yahoo.co.jp"
fi

if has "exa"; then
  alias ls='exa'
fi

# TODO: until merging: https://github.com/cli/cli/pull/1445
if has "gh"; then
  alias gh="$GOPATH/bin/gh"
  gli() {
    local args="$@"
    local cmd="gh issue list ${args} | fzf --reverse --preview \"gh issue view {1}\""
    selected=`eval ${cmd}`
    gh issue view --web $(echo ${selected} | awk '{print $1}')
  }
fi

# TODO: remove
alias gofmt="find . -not -path './vendor/*' -and -name '*.go' | xargs gofmt -w"

alias lgtm="echo '![LGTM](//lgtmoon.herokuapp.com/images/23050)'|pbcopy"
