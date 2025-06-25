# dotfiles

[![BuildStatus](https://github.com/cappyzawa/dotfiles/workflows/CI/badge.svg)](https://github.com/cappyzawa/dotfiles/actions?query=workflow%3ACI)

dotfile for cappyzawa (using macOS).

## Setup

```bash
$ xcode-select --install
$ git clone https://github.com/cappyzawa/dotfiles.git ~/.dotfiles
$ make all
```

## Key Features

### Dynamic PATH Management

This dotfiles includes a flexible PATH management system (`.zsh/05_path_manager.zsh`) that solves common issues with shell configuration:

#### Basic Usage

```bash
# Add directory to PATH (highest priority)
path_add /path/to/bin

# Add directory with lower priority
path_add /path/to/bin append

# Add paths with variables (supports dynamic resolution)
path_add '$CUSTOM_ROOT/bin'

# Remove from PATH
path_remove /path/to/bin

# Debug current PATH state (shows managed vs system paths)
path_debug
```

#### Benefits

- **Flexibility**: Variables are resolved dynamically, so changing `$CUSTOM_ROOT` works correctly
- **Priority Control**: Later additions override earlier ones properly
- **Automatic Deduplication**: No duplicate entries in PATH
- **Existence Checking**: Only existing directories are added
- **Debug Support**: Visual debugging with `path_debug` command (✓ = managed paths)

#### Adding New Tools

When adding new development tools, use this pattern:

```bash
# In your custom zsh files (e.g., .zsh/80_custom.zsh)
export TOOL_ROOT=${TOOL_ROOT:-$HOME/.tool}
path_add '$TOOL_ROOT/bin'
```

This ensures the tool's PATH works correctly even if `TOOL_ROOT` is changed later.

### Performance Optimizations

- **Fast Startup**: ~14ms shell startup time with lazy loading (95% improvement from 250ms)
- **Command Caching**: Repeated command existence checks are cached
- **Lazy Loading System**: Heavy tools (afx, starship) load on first command execution

#### Lazy Loading Hook Pattern

New tools can be easily added to the lazy loading system by creating hook files in `.zsh/hooks/`:

```bash
# .zsh/hooks/newtool.zsh
_lazy_load_newtool() {
    eval "$(newtool init)"
    unfunction _lazy_load_newtool
}

if command -v newtool &> /dev/null; then
    function _newtool_hook() {
        _lazy_load_newtool
        unfunction _newtool_hook
    }
    autoload -Uz add-zsh-hook
    add-zsh-hook precmd _newtool_hook
fi
```

Files placed in `.zsh/hooks/` are automatically loaded by `.zshrc`. This pattern:

- Only registers hooks for available commands
- Removes hooks after first execution
- Provides significant startup performance improvements

### Package Management Strategy

- **Homebrew**: System tools and GUI applications
- **Aqua**: Development CLI tools with version management
- **afx**: Zsh plugins and GitHub CLI extensions
