has() {
    type "${1:?too few arguments}" &>/dev/null
}

# is_login_shell returns true if current shell is first shell
is_login_shell() {
    [[ $SHLVL == 1 ]]
}

# is_git_repo returns true if cwd is in git repository
is_git_repo() {
    git rev-parse --is-inside-work-tree &>/dev/null
    return $status
}

# is_screen_running returns true if GNU screen is running
is_screen_running() {
    [[ -n $STY ]]
}

# is_tmux_runnning returns true if tmux is running
is_tmux_runnning() {
    [[ -n $TMUX ]]
}

# is_screen_or_tmux_running returns true if GNU screen or tmux is running
is_screen_or_tmux_running() {
    is_screen_running || is_tmux_runnning
}

# shell_has_started_interactively returns true if the current shell is
# running from command line
shell_has_started_interactively() {
    [[ -n $PS1 ]]
}

# is_ssh_running returns true if the ssh deamon is available
is_ssh_running() {
    [[ -n $SSH_CLIENT ]]
}

# ostype returns the lowercase OS name
os() {
    echo $(uname | tr '[:upper:]' '[:lower:]')
}

alias ostype=os

arch() {
    echo "$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')"
}

# os_detect export the PLATFORM variable as you see fit
os_detect() {
    export PLATFORM
    case "$(ostype)" in
        *'linux'*)  PLATFORM='linux'   ;;
        *'darwin'*) PLATFORM='osx'     ;;
        *'bsd'*)    PLATFORM='bsd'     ;;
        *)          PLATFORM='unknown' ;;
    esac
}

# is_osx returns true if running OS is Macintosh
is_osx() {
    os_detect
    if [[ $PLATFORM == "osx" ]]; then
        return 0
    else
        return 1
    fi
}
alias is_mac=is_osx

# is_linux returns true if running OS is GNU/Linux
is_linux() {
    os_detect
    if [[ $PLATFORM == "linux" ]]; then
        return 0
    else
        return 1
    fi
}

# is_bsd returns true if running OS is FreeBSD
is_bsd() {
    os_detect
    if [[ $PLATFORM == "bsd" ]]; then
        return 0
    else
        return 1
    fi
}

# get_os returns OS name of the platform that is running
get_os() {
    local os
    for os in osx linux bsd; do
        if is_$os; then
            echo $os
        fi
    done
}

gitlocal() {
    git config --local user.name "Shu Kutsuzawa"
    git config --local user.email "cappyzawa@gmail.com"
    git config --local hub.host "github.com"
    git config --local gpg.program gpg
    git config --local user.signingkey 95FACBF514EBED07EFF2461812D20A0BDD2B2A46
    echo 'export GITHUB_TOKEN=${GITHUB_COM_TOKEN}' >> .envrc
}

kind_start() {
    if ! has "kind"; then
        echo "kind command is missing"
        exit 1
    fi

    if ! has "docker"; then
        echo "docker command is missing"
        exit 1
    fi

    set -x
    kind get nodes | while read n; do
        docker start $n
    done
    set +x
}

gcd() {
    local repo_path=`ghq list --full-path | fzf --reverse --preview "bat {1}/README.md"`
    \cd ${repo_path}
}

if has 'anyenv'; then
    eval "$(anyenv init -)"
fi
