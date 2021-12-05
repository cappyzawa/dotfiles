if has "kubectl"; then
  alias k='kubectl'
fi

export KREW_ROOT=${KREW_ROOT:-$HOME/.krew}
if [[ -d $KREW_ROOT ]]; then
  export PATH="${KREW_ROOT}/bin:$PATH"
fi

if (which jenv > /dev/null); then
  export JAVA_HOME="${ANYENV_ROOT}/envs/jenv/versions/`jenv version-name`"
fi

if has "lazygit"; then
  alias lg='lazygit'
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

if has "gh"; then
  gli() {
    local args="$@"
    local cmd="gh issue list ${args} | fzf --reverse --preview \"gh issue view {1}\""
    selected=`eval ${cmd}`
    gh issue view --web $(echo ${selected} | awk '{print $1}')
  }
fi

if has "consul"; then
  complete -o nospace -C `which consul` consul
fi

if has "nvim"; then
  export EDITOR=nvim
  export CVSEDITOR="${EDITOR}"
  export SVN_EDITOR="${EDITOR}"
  export GIT_EDITOR="${EDITOR}"
fi

# TODO: remove
alias gofmt="find . -not -path './vendor/*' -and -name '*.go' | xargs gofmt -w"

alias lgtm="echo '![LGTM](//lgtmoon.herokuapp.com/images/23050)'|pbcopy"

if [[ -d "/usr/local/Caskroom/google-cloud-sdk" ]]; then
  source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
  source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"
fi

if has "julia"; then
  export LD_LIBRARY_PATH=$HOME/.julia/conda/3/lib
fi

if has "terraform"; then
  complete -o nospace -C /usr/local/bin/terraform terraform
fi
