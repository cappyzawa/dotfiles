# Fish configuration file
# All-in-one configuration following fish best practices

# ============================================================================
# Environment Variables
# ============================================================================

# XDG Base Directory
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_DATA_HOME "$HOME/.local/share"
set -gx NPM_CONFIG_PREFIX "$XDG_DATA_HOME/npm-global"

# Tool configurations
set -gx STARSHIP_CONFIG "$XDG_CONFIG_HOME/starship/starship.toml"
set -gx CLAUDE_CONFIG_DIR "$XDG_CONFIG_HOME/claude"

# Aqua configuration
set -gx AQUA_GLOBAL_CONFIG "$XDG_CONFIG_HOME/aqua/aqua.yaml"
set -gx AQUA_PROGRESS_BAR "true"
set -gx AQUA_POLICY_CONFIG "$XDG_CONFIG_HOME/aqua/aqua-policy.yaml"
set -gx LIMA_TEMPLATES_DIR "$XDG_CONFIG_HOME/lima/templates:/usr/local/share/lima/templates"
set -gx GOPATH "$HOME/ghq"

# Language settings
set -gx LANGUAGE "en_US.UTF-8"
set -gx LANG $LANGUAGE
set -gx LC_ALL $LANGUAGE
set -gx LC_CTYPE $LANGUAGE

# Editor (will be updated after PATH is initialized)
set -gx EDITOR vim
set -gx PAGER less
set -gx LESS '-R -f -X -i -P ?f%f:(stdin). ?lb%lb?L/%L.. [?eEOF:?pb%pb\%..]'
set -gx LESSCHARSET 'utf-8'

# Less man page colors (printf でエスケープを確実に)
set -gx LESS_TERMCAP_mb (printf '\e[01;31m')
set -gx LESS_TERMCAP_md (printf '\e[01;31m')
set -gx LESS_TERMCAP_me (printf '\e[0m')
set -gx LESS_TERMCAP_se (printf '\e[0m')
set -gx LESS_TERMCAP_so (printf '\e[00;44;37m')
set -gx LESS_TERMCAP_ue (printf '\e[0m')
set -gx LESS_TERMCAP_us (printf '\e[01;32m')

# Directory colors
set -gx LSCOLORS exfxcxdxbxegedabagacad
set -gx LS_COLORS 'di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

# Architecture-specific settings / Homebrew
set -l arch (uname -m)
set -gx ARCH $arch
if test "$arch" = "arm64" -a -x /opt/homebrew/bin/brew
    eval (/opt/homebrew/bin/brew shellenv)
else if test "$arch" = "x86_64" -a -x /usr/local/bin/brew
    eval (/usr/local/bin/brew shellenv)
end
set -gx LDFLAGS "-L$HOMEBREW_PREFIX/lib"

# Cargo environment
set -gx CARGO_HOME "$HOME/.cargo"
if test -d "$CARGO_HOME/bin"
    fish_add_path -p "$CARGO_HOME/bin"
end

# 起動メッセージは消す（未設定/空でない場合のみ一度設定）
if test -n "$fish_greeting"
    set -U fish_greeting ""
end

# ============================================================================
# PATH Management
# ============================================================================

# Essential directories (highest priority first)
if test -d "$HOME/bin"
    fish_add_path -p "$HOME/bin"
end
if test -d "$HOME/.local/share/aquaproj-aqua/bin"
    fish_add_path -p "$HOME/.local/share/aquaproj-aqua/bin"
end

# Development tools
if test -d "$HOME/.local/bin"
    fish_add_path -a "$HOME/.local/bin"
end
if test -d "$HOME/.tmux/bin"
    fish_add_path -a "$HOME/.tmux/bin"
end
if test -d "$HOME/ghq/bin"
    fish_add_path -a "$HOME/ghq/bin"
end

# NPM global path
if test -n "$NPM_CONFIG_PREFIX" && test -d "$NPM_CONFIG_PREFIX/bin"
    fish_add_path -a "$NPM_CONFIG_PREFIX/bin"
end

# Krew kubectl plugin manager
if test -d "$HOME/.krew/bin"
    fish_add_path -a "$HOME/.krew/bin"
end

# Coursier (Scala)
if test -d "$HOME/Library/Application Support/Coursier/bin"
    fish_add_path -a "$HOME/Library/Application Support/Coursier/bin"
end

# Optional tools
if test -d "/usr/local/opt/libpq/bin"
    fish_add_path -a "/usr/local/opt/libpq/bin"
end
if test -d "/usr/local/opt/llvm/bin"
    fish_add_path -a "/usr/local/opt/llvm/bin"
end
if test -d "/opt/homebrew/opt/openjdk@17/bin"
    fish_add_path -a "/opt/homebrew/opt/openjdk@17/bin"
end
if test -d "$HOME/.tmux/plugins/tpm/bin"
    fish_add_path -a "$HOME/.tmux/plugins/tpm/bin"
end

# ============================================================================
# Editor Configuration (after PATH is set)
# ============================================================================

if type -q hx
    set -gx EDITOR hx
    alias vim='hx'
else if type -q nvim
    set -gx EDITOR nvim
    alias vim='nvim'
end
set -gx CVSEDITOR $EDITOR
set -gx SVN_EDITOR $EDITOR
set -gx GIT_EDITOR $EDITOR

# ============================================================================
# Aliases
# ============================================================================

# Git aliases
if type -q git
    alias gst='git status'
end

# 1Password integration
if type -q op
    alias aqua='env GITHUB_TOKEN=(op read -f "op://Private/GitHub Personal Access Token/token") aqua'
end

# Development tool aliases
if type -q kubectl
    alias k='kubectl'
end
if type -q eza
    alias ls='eza'
else if type -q exa
    alias ls='exa'
end
if type -q lazygit
    alias lg='lazygit'
end
if type -q lazydocker
    alias ld='lazydocker'
end

# Common navigation and listing aliases
alias ..='cd ..'
alias l='ls -l'
alias lla='ls -lAF'
alias ll='ls -lF'
alias la='ls -AF'
alias lx='ls -lXB'
alias lk='ls -lSr'
alias lc='ls -ltcr'
alias lu='ls -ltur'
alias lt='ls -ltr'
alias lr='ls -lR'

# System utilities
alias du='du -h'
alias job='jobs -l'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# macOS specific
if test (uname -s) = "Darwin"
    if type -q brew
        set -l brew_prefix (brew --prefix)
        alias ctags="$brew_prefix/bin/ctags"
    end
    alias flushdns='sudo killall -HUP mDNSResponder'
end

# Architecture switching (adapted for fish)
alias arm='exec arch -arch arm64 /opt/homebrew/bin/fish'
alias x64='exec arch -arch x86_64 /usr/local/bin/fish'

# Claude CLI alias
alias claude="$HOME/.config/claude/local/claude"


# ============================================================================
# Vi Mode and Key Bindings
# ============================================================================

# Vi mode keybindings
fish_vi_key_bindings

function fish_user_key_bindings
    # jj to escape from insert mode to normal mode
    bind -M insert -m default jj backward-char force-repaint

    # Emacs-like bindings in insert mode
    bind -M insert \ca beginning-of-line
    bind -M insert \ce end-of-line

    # Vi mode specific (意図通りならこのまま)
    bind -M default ' h' beginning-of-line
    bind -M default ' l' end-of-line

    # Helix integration
    bind -M insert \cx edit-cmd-in-hx         # Ctrl-x: edit commandline in hx (zsh-like)
    bind -M insert \co hx-open-token          # Ctrl-o: open token under cursor in hx
end


# Cursor styles
set fish_cursor_default block
set fish_cursor_insert  line
set fish_cursor_replace_one underscore
set fish_cursor_visual  block

# ============================================================================
# Dropbox link compatibility
# ============================================================================

# Create compatibility symlink for Dropbox (new path -> old path)
if not test -e "$HOME/Dropbox" && test -e "$HOME/Library/CloudStorage/Dropbox"
    ln -s "$HOME/Library/CloudStorage/Dropbox" "$HOME/Dropbox"
end

# ============================================================================
# FZF.fish Plugin Configuration
# ============================================================================

if status --is-interactive
    # FZF default options
    set -gx FZF_DEFAULT_OPTS '--height 40% --reverse --border'

    # Configure fzf.fish key bindings to avoid tmux prefix conflict
    if functions -q fzf_configure_bindings
        fzf_configure_bindings --directory=\cf --git_log=\el --git_status=\es --history=\cr --processes=\ep --variables=\cv
    end

    # FZF preview commands
    if type -q bat
        set -g fzf_preview_file_cmd bat --style=numbers --color=always --line-range :200
    end

    if type -q eza
        set -g fzf_preview_dir_cmd eza --all --color=always
    else if type -q exa
        set -g fzf_preview_dir_cmd exa --all --color=always
    end

    # FZF fd options for directory search
    if type -q fd
        set -g fzf_fd_opts --hidden --max-depth 10 --exclude .git --exclude node_modules --exclude target
    end

    # Git diff highlighter
    if type -q delta
        set -g fzf_diff_highlighter delta --paging=never --width=20
    end

    # Custom fzf directory search with Helix integration
    set -g fzf_directory_opts --bind='ctrl-o:execute(hx {})+abort'

    # Git status search with Helix integration
    set -g fzf_git_status_opts --bind='ctrl-o:execute(hx {})+abort'
end

# ============================================================================
# Prompt / Starship (optional)
# ============================================================================

if type -q starship
    starship init fish | source
end

# ============================================================================
# Local Configuration
# ============================================================================

# Load local fish configuration if it exists (machine-specific)
if test -f ~/.config/fish/config_local.fish
    source ~/.config/fish/config_local.fish
end
