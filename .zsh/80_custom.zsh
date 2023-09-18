if has "kubectl"; then
    alias k='kubectl'

    if (kubectl krew info neat > /dev/null); then
        alias -g kvy="| kubectl neat | vim '+set filetype=yaml buftype=nofile'"
    fi
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

# TODO: remove
alias gofmt="find . -not -path './vendor/*' -and -name '*.go' | xargs gofmt -w"

alias lgtm="echo '![LGTM](//lgtmoon.herokuapp.com/images/23050)'|pbcopy"

if [[ -d "/usr/local/Caskroom/google-cloud-sdk" ]]; then
    source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
    source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"
fi

if has "julia"; then
    export LD_LIBRARY_PATH=$HOME/.julia/conda/3/lib
    if is_osx; then
        export JULIA_NUM_THREADS=`sysctl -n hw.physicalcpu`
    elif is_linux; then
        export JULIA_NUM_THREADS=`nproc`
    fi
fi

if has "terraform"; then
    complete -o nospace -C /usr/local/bin/terraform terraform
fi

if has "rga"; then
    rga-fzf() {
        RG_PREFIX="rga --files-with-matches"
        local file
        file="$(
            FZF_DEFAULT_COMMAND="$RG_PREFIX '$1'" \
                fzf --sort --preview="[[ ! -z {} ]] && rga --pretty --context 5 {q} {}" \
                --phony -q "$1" \
                --bind "change:reload:$RG_PREFIX {q}" \
                --preview-window="70%:wrap"
        )" &&
        echo "opening $file" &&

        if [[ `basename "${file}"` =~ ".gz" ]]; then
            gzip -dc ${file} | vim -
        else
            vim ${file}
        fi
    }
fi

if has "setup-envtest"; then
    k8s_version="1.25.x"
    source <(setup-envtest use -i -p env ${k8s_version})
fi

if has 'nvim'; then
    alias vim='nvim'
fi
