# dotfiles

[![BuildStatus](https://github.com/cappyzawa/dotfiles/workflows/CI/badge.svg)](https://github.com/cappyzawa/dotfiles/actions?query=workflow%3ACI)

dotfile for cappyzawa (using macOS with fish shell).

## Setup

```bash
$ xcode-select --install
$ git clone https://github.com/cappyzawa/dotfiles.git ~/.dotfiles
$ make all
```

## Key Features

### Fish Shell Configuration

This dotfiles uses fish shell with a consolidated configuration structure following fish best practices:

- **Main Configuration**: `.config/fish/config.fish` - Single consolidated configuration file
- **Local Overrides**: `.config/fish/config_local.fish` - Git-ignored local customizations
- **Plugin Management**: Fisher with `.config/fish/fish_plugins` for reproducible plugin setup
- **User Functions**: `.config/fish/conf.d/` - Custom functions and configurations (Git managed)
- **Lazy Loading**: `.config/fish/conf.d/hooks.fish` - Performance optimizations for heavy tools

Note: `functions/`, `completions/`, and `themes/` directories are Git-ignored as they contain plugin-generated files.

#### Fish Plugins

Managed via Fisher with `.config/fish/fish_plugins`.

### Performance Optimizations

- **Fast Startup**: Optimized fish configuration with lazy loading
- **Event-Based Loading**: Heavy tools (starship, direnv, AWS CLI) load on first prompt
- **Smart Conditionals**: Tools only initialize if installed
- **One-Time Setup**: Initialization functions self-destruct after first run

#### Lazy Loading Pattern

Heavy tools are loaded on first prompt using fish events:

```fish
function __init_tools --on-event fish_prompt
    if not set -q __tools_loaded
        # direnv hook
        if command -v direnv > /dev/null 2>&1
            direnv hook fish | source
        end
        # AWS CLI completion
        if command -v aws_completer > /dev/null 2>&1
            complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); aws_completer | sed \'s/ $//\'; end)'
        end
        set -g __tools_loaded 1
        functions -e __init_tools
    end
end
```

### Package Management Strategy

Simplified to two package managers for clarity:

- **Homebrew** (`Brewfile`): System tools, GUI applications, and system integration
- **Aqua** (`.config/aqua/aqua.yaml`): Development CLI tools with version management
- **Fisher** (`.config/fish/fish_plugins`): Fish shell plugins

### Architecture Support

Supports both ARM64 and x86_64 architectures:

- `arm`: Switch to ARM64 architecture
- `x64`: Switch to x86_64 architecture

Architecture-specific paths and tools are automatically configured.

### Key Bindings

- Vi-mode with Helix-style customizations
- FZF-based tab completion
- All bindings avoid tmux prefix conflicts
