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
  export JAVA_HOME="$HOME/.anyenv/envs/jenv/versions/`jenv version-name`"
fi
