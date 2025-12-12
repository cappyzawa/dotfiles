# Zsh options

# History configuration
HISTFILE="${HOME}/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000

setopt EXTENDED_HISTORY       # Write timestamps to history
setopt HIST_EXPIRE_DUPS_FIRST # Expire duplicates first when trimming history
setopt HIST_IGNORE_DUPS       # Don't record an entry that was just recorded
setopt HIST_IGNORE_ALL_DUPS   # Delete old recorded entry if new entry is a duplicate
setopt HIST_FIND_NO_DUPS      # Don't display a line previously found
setopt HIST_IGNORE_SPACE      # Don't record entries starting with a space
setopt HIST_SAVE_NO_DUPS      # Don't write duplicate entries in the history file
setopt HIST_REDUCE_BLANKS     # Remove superfluous blanks before recording
setopt SHARE_HISTORY          # Share history between all sessions
setopt INC_APPEND_HISTORY     # Write to history file immediately

# Directory navigation
setopt AUTO_CD                # cd into directory without typing cd
setopt AUTO_PUSHD             # Push the old directory onto the stack
setopt PUSHD_IGNORE_DUPS      # Don't push multiple copies
setopt PUSHD_SILENT           # Don't print the directory stack

# Completion
setopt COMPLETE_IN_WORD       # Complete from both ends of a word
setopt ALWAYS_TO_END          # Move cursor to end after completion
setopt PATH_DIRS              # Perform path search for /

# Globbing
setopt EXTENDED_GLOB          # Use extended globbing syntax
setopt NO_CASE_GLOB           # Case insensitive globbing

# Input/Output
setopt NO_FLOW_CONTROL        # Disable ^S/^Q flow control
setopt INTERACTIVE_COMMENTS   # Allow comments in interactive shell

# Job Control
setopt NO_BG_NICE             # Don't run background jobs at lower priority
setopt NO_HUP                 # Don't kill jobs on shell exit
setopt LONG_LIST_JOBS         # List jobs in long format

# Prompt
setopt PROMPT_SUBST           # Enable parameter expansion in prompt
