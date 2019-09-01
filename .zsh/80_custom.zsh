if has 'kubectl'; then
  source <(kubectl completion zsh)
fi

if has 'tkn'; then
  source <(tkn completion zsh)
  if [[ ! -e '/usr/local/bin/kubectl-tkn' ]]; then
    ln -s `which tkn` /usr/local/bin/kubectl-tkn
  fi
fi

if has 'ko'; then
  source <(ko completion --zsh)
  export KO_DOCKER_REPO='cappyzawa'
fi

export KREW_ROOT=${KREW_ROOT:-$HOME/.krew}
if [[ -d $KREW_ROOT ]]; then
  export PATH="${KREW_ROOT}/bin:$PATH"
fi

which jenv > /dev/null
if [[ $? == 0 ]]; then
  export JAVA_HOME="$HOME/.anyenv/envs/jenv/versions/`jenv version-name`"
fi
