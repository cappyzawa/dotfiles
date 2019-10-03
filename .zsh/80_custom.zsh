if has "kubectl"; then
  alias k='kubectl'
fi

if has 'tkn'; then
  if [[ ! -e '/usr/local/bin/kubectl-tkn' ]]; then
    ln -s `which tkn` /usr/local/bin/kubectl-tkn
  fi
fi

if has 'ko'; then
  export KO_DOCKER_REPO='cappyzawa'
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

if has "nvim"; then
  alias vim='nvim'
fi

if has "lazygit"; then
  alias lg='lazygit'
fi

if has "lazydocker"; then
  alias ld='lazydocker'
fi

# TODO: remove
alias gofmt="find . -not -path './vendor/*' -and -name '*.go' | xargs gofmt -w"

alias lgtm="echo '![LGTM](//lgtmoon.herokuapp.com/images/23050)'|pbcopy"
