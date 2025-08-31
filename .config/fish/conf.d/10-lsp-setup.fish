# Automatic Language Server installation for Helix
# Ensures required language servers are available on system startup

if status --is-interactive
    # Check if npm is available
    if command -v npm >/dev/null 2>&1
        # Define required language servers
        set -l required_lsps \
            bash-language-server \
            typescript-language-server \
            yaml-language-server \
            vscode-langservers-extracted \
            prettier \
            fish-lsp

        # Check and install missing language servers
        for lsp in $required_lsps
            # Check if the command exists (some packages install multiple commands)
            switch $lsp
                case vscode-langservers-extracted
                    # This package installs multiple servers
                    if not command -v vscode-json-language-server >/dev/null 2>&1
                        echo "Installing $lsp..."
                        npm install -g $lsp >/dev/null 2>&1
                    end
                case prettier
                    if not command -v prettier >/dev/null 2>&1
                        echo "Installing $lsp..."
                        npm install -g $lsp >/dev/null 2>&1
                    end
                case '*'
                    if not command -v $lsp >/dev/null 2>&1
                        echo "Installing $lsp..."
                        npm install -g $lsp >/dev/null 2>&1
                    end
            end
        end
    else
        echo "Warning: npm not found. Language servers cannot be auto-installed."
    end
end
