# Dynamic PATH Management System
# This provides a flexible way to manage PATH additions with proper ordering

# Global array to track PATH additions
typeset -gUa _dynamic_paths

# Add path to beginning of PATH (highest priority)
path_prepend() {
    local dir="$1"
    [[ -z "$dir" ]] && return 1
    
    # Expand variables and tildes
    dir="${(e)dir}"
    
    # Only add if directory exists
    [[ -d "$dir" ]] || return 1
    
    # Remove from current PATH if exists
    path=("${(@)path:#$dir}")
    
    # Add to beginning
    path=("$dir" "${(@)path}")
    
    # Track this addition
    _dynamic_paths=("$dir" "${(@)_dynamic_paths:#$dir}")
}

# Add path to end of PATH (lowest priority)
path_append() {
    local dir="$1"
    [[ -z "$dir" ]] && return 1
    
    # Expand variables and tildes
    dir="${(e)dir}"
    
    # Only add if directory exists
    [[ -d "$dir" ]] || return 1
    
    # Remove from current PATH if exists
    path=("${(@)path:#$dir}")
    
    # Add to end
    path=("${(@)path}" "$dir")
    
    # Track this addition
    _dynamic_paths=("${(@)_dynamic_paths:#$dir}" "$dir")
}

# Add path with conditional check (smart default behavior)
path_add() {
    local dir="$1"
    local mode="${2:-prepend}"  # prepend or append
    
    [[ -z "$dir" ]] && return 1
    
    case "$mode" in
        prepend|pre) path_prepend "$dir" ;;
        append|app)  path_append "$dir" ;;
        *) path_prepend "$dir" ;;
    esac
}

# Remove path from PATH
path_remove() {
    local dir="$1"
    [[ -z "$dir" ]] && return 1
    
    # Expand variables and tildes
    dir="${(e)dir}"
    
    # Remove from PATH
    path=("${(@)path:#$dir}")
    
    # Remove from tracking
    _dynamic_paths=("${(@)_dynamic_paths:#$dir}")
}

# List managed paths
path_list() {
    printf "%s\n" "${_dynamic_paths[@]}"
}

# Refresh all dynamic paths (useful when environment variables change)
path_refresh() {
    local saved_paths=("${_dynamic_paths[@]}")
    _dynamic_paths=()
    
    for dir in "${saved_paths[@]}"; do
        path_add "$dir"
    done
}

# Debug: Show current PATH with numbers
path_debug() {
    local i=1
    printf "Current PATH (priority order):\n"
    for dir in "${path[@]}"; do
        local managed="  "
        if [[ "${_dynamic_paths[(I)$dir]}" -gt 0 ]]; then
            managed="✓ "
        fi
        printf "%2d. %s%s\n" "$i" "$managed" "$dir"
        ((i++))
    done
    printf "\nManaged paths: %d\n" "${#_dynamic_paths[@]}"
}