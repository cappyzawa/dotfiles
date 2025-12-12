# dotfiles

[![BuildStatus](https://github.com/cappyzawa/dotfiles/workflows/CI/badge.svg)](https://github.com/cappyzawa/dotfiles/actions?query=workflow%3ACI)

dotfiles for cappyzawa (macOS with zsh).

## Setup

```bash
$ xcode-select --install
$ git clone https://github.com/cappyzawa/dotfiles.git ~/.dotfiles
$ make all
$ sheldon lock
$ chsh -s /opt/homebrew/bin/zsh
```

## Key Features

### Zsh Configuration

This dotfiles uses zsh with sheldon plugin manager:

- **Environment Variables**: `.zshenv` - XDG paths, language settings, 1Password SSH agent
- **Login Shell**: `.zprofile` - Homebrew initialization
- **Interactive Shell**: `.zshrc` - compinit, sheldon source
- **Local Overrides**: `.zshrc.local` - Git-ignored local customizations (secrets)
- **Plugin Management**: Sheldon with `.config/sheldon/plugins.toml`
- **Modular Config**: `.config/zsh/*.zsh` - PATH, aliases, keybinds, fzf, integrations, options

### Package Management Strategy

- **Homebrew** (`Brewfile`): System tools, GUI applications, and system integration
- **Aqua** (`.config/aqua/aqua.yaml`): Development CLI tools with version management
- **Sheldon** (`.config/sheldon/plugins.toml`): Zsh plugins

### Architecture Support

Supports both ARM64 and x86_64 architectures:

- `arm`: Switch to ARM64 architecture
- `x64`: Switch to x86_64 architecture

Architecture-specific paths and tools are automatically configured.
