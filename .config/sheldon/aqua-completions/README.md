# aqua-completions

A sheldon plugin that auto-generates zsh completions for aqua-managed CLI tools.

## How it works

- Runs `generate.sh` in background on shell startup (via zsh-defer)
- Executes only once per day, skips otherwise
- Uses `aqua which` to get binary path; regenerates completion if path changed
- After renovate updates aqua.yaml, completions are auto-regenerated on next shell startup

## File structure

```
aqua-completions/
├── generate.sh   # Completion generator script
├── init.zsh      # Entry point loaded by sheldon
└── README.md

~/.config/zsh/completions/   # Output directory (fpath added by sheldon)
├── _kubectl                 # Generated completion
├── _kubectl.path            # Version tracking cache
└── ...
```

## Adding a new CLI completion

Add a line to `generate.sh`:

```bash
gen <command> <completion args...>
```

Examples:

```bash
gen kubectl completion zsh
gen gh completion -s zsh
```

## Force regeneration

```bash
~/.config/sheldon/aqua-completions/generate.sh --force
```

## Clear cache

```bash
rm ~/.config/zsh/completions/.aqua-completions-last-run
rm ~/.config/zsh/completions/_*.path
```
