if has 'kubectl'; then
  source <(kubectl completion zsh)
fi

if has 'tkn'; then
  source <(tkn completion zsh)
fi

if has 'ko'; then
  source <(ko completion --zsh)
fi

if has 'fly'; then
  source <(fly completion zsh)
fi
