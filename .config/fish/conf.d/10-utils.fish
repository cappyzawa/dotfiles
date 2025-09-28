# Command existence cache (global variable)
set -g _has_cache

function has
    if test (count $argv) -eq 0
        echo "has: too few arguments" >&2
        return 1
    end

    set cmd $argv[1]

    # Check cache first
    if contains "$cmd" $_has_cache
        return 0
    end

    # Check command existence and cache result
    if command -v "$cmd" >/dev/null 2>&1
        set -ga _has_cache "$cmd"
        return 0
    else
        return 1
    end
end
