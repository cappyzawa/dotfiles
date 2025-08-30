# Lazy loading system for fish using events

# Direct tools initialization (replaces afx)
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

# Function to initialize starship lazily
function __init_starship --on-event fish_prompt
    if not set -q __starship_loaded
        if command -v starship > /dev/null 2>&1
            starship init fish | source
            set -g __starship_loaded 1
        end

        # Remove the event handler after first run
        functions -e __init_starship
    end
end
