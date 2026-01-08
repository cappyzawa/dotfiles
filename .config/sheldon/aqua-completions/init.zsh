# Run completion generator in background (disown to suppress job notification)
"${0:A:h}/generate.sh" &>/dev/null &!
