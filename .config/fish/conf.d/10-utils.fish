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

function docker_start
    if not has limactl
        echo "limactl command is missing"
        return 1
    end

    # Check if lima-docker instance exists and is not running
    set lima_check (limactl list --format json | jq '."hostname" == "lima-docker"' | grep 'true')
    if test -z "$lima_check"
        limactl start --name=docker template://docker
    else
        limactl start docker
    end

    # Check if lima-docker context exists
    set context_exists (docker context ls --format json | jq -s 'any(.[]; .Name == "lima-docker")')
    if test "$context_exists" = false
        docker context create lima-docker --docker "host=unix://$HOME/.lima/docker/sock/docker.sock"
    end

    # Switch to lima-docker context if not already active
    set current_context (docker context show)
    if test "$current_context" != lima-docker
        docker context use lima-docker >/dev/null
    end
    echo "Started docker context: $current_context"
end

function docker_stop
    if not has limactl
        echo "limactl command is missing"
        return 1
    end

    limactl stop docker
    echo "Stopped lima instance: docker"
end
