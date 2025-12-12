# zsh-syntax-highlighting configuration
# Color scheme: Rosé Pine (https://rosepinetheme.com/palette/ingredients/)

# Declare the associative array
typeset -A ZSH_HIGHLIGHT_STYLES

# Rosé Pine palette
_love='#eb6f92'
_gold='#f6c177'
_rose='#ebbcba'
_pine='#31748f'
_foam='#9ccfd8'
_iris='#c4a7e7'
_text='#e0def4'
_subtle='#908caa'
_muted='#6e6a86'

# Commands
ZSH_HIGHLIGHT_STYLES[command]="fg=$_rose,bold"
ZSH_HIGHLIGHT_STYLES[builtin]="fg=$_rose,bold"
ZSH_HIGHLIGHT_STYLES[alias]="fg=$_iris,bold"
ZSH_HIGHLIGHT_STYLES[function]="fg=$_rose,bold"

# Errors and unknown
ZSH_HIGHLIGHT_STYLES[unknown - token]="fg=$_love,bold"
ZSH_HIGHLIGHT_STYLES[reserved - word]="fg=$_pine"

# Paths and files
ZSH_HIGHLIGHT_STYLES[path]="fg=$_gold,underline"
ZSH_HIGHLIGHT_STYLES[path_pathseparator]="fg=$_gold"
ZSH_HIGHLIGHT_STYLES[globbing]="fg=$_iris"

# Strings and quotes
ZSH_HIGHLIGHT_STYLES[single - quoted - argument]="fg=$_gold"
ZSH_HIGHLIGHT_STYLES[double - quoted - argument]="fg=$_gold"
ZSH_HIGHLIGHT_STYLES[dollar - quoted - argument]="fg=$_gold"

# Variables and substitutions
ZSH_HIGHLIGHT_STYLES[assign]="fg=$_text"
ZSH_HIGHLIGHT_STYLES[named - fd]="fg=$_foam"
ZSH_HIGHLIGHT_STYLES[command - substitution]="fg=$_iris"
ZSH_HIGHLIGHT_STYLES[command - substitution - delimiter]="fg=$_subtle"
ZSH_HIGHLIGHT_STYLES[process - substitution]="fg=$_iris"
ZSH_HIGHLIGHT_STYLES[process - substitution - delimiter]="fg=$_subtle"

# Options and arguments
ZSH_HIGHLIGHT_STYLES[single - hyphen - option]="fg=$_rose"
ZSH_HIGHLIGHT_STYLES[double - hyphen - option]="fg=$_rose"

# Redirections
ZSH_HIGHLIGHT_STYLES[redirection]="fg=$_pine"

# Comments
ZSH_HIGHLIGHT_STYLES[comment]="fg=$_muted"

# Default
ZSH_HIGHLIGHT_STYLES[default]="fg=$_text"

# zsh-autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=$_muted"

# Cleanup temporary variables
unset _love _gold _rose _pine _foam _iris _text _subtle _muted
