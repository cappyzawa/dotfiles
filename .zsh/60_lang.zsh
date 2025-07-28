# Language Server and Formatter Management for Helix
# Auto-install missing language servers and formatters via npm

# Check if npm package is installed globally
npm_package_installed() {
    local package="$1"
    npm list -g --depth=0 "$package" &>/dev/null
}

# Install npm package globally if not already installed
install_npm_package() {
    local package="$1"
    if ! npm_package_installed "$package"; then
        echo "Installing $package via npm..."
        npm install -g "$package"
    fi
}

# Auto-install language servers and formatters for Helix
install_helix_dependencies() {
    # Language servers
    install_npm_package "bash-language-server"
    install_npm_package "typescript-language-server"
    install_npm_package "vscode-langservers-extracted"  # json, html, css, eslint
    install_npm_package "yaml-language-server"

    # Formatters
    install_npm_package "prettier"
}

# Note: install_helix_dependencies is called from .config/afx/local.yaml
# after PATH is properly set up with aqua binaries
