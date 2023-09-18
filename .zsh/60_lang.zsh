has_image() {
    local img=$1
    has docker && docker image ls --format "{{.Repository}}:{{.Tag}}" "${img}" | grep "${img}" >/dev/null
}

# for Ruby
gem_install() {
    pkg=$1
    echo "dotfile: Install ${pkg}"
    gem install ${pkg}
}

pip_instal() {
    pkg=$1
    echo "dotfile: Install ${pkg}"
    pip install ${pkg}
}

if has "fnm"; then
    eval "$(fnm env)"
fi

if has "pip"; then
    if ! has "vint"; then
        pip_instal vim-vint
    fi
fi

if has "luarocks"; then
    if ! has "luacheck"; then
        luarocks install luacheck
    fi
fi

if ! has "rustup"; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
fi
