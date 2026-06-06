# CLAUDE.md

## What this repo is

A macOS dotfiles repository that uses a **clone-and-symlink** approach. Config files live in `~/dotfiles/` and are symlinked or sourced into their expected locations.

## Setup / Installation

Full bootstrap (run once on a new machine):

```sh
./install.sh
```

This calls the three setup scripts in order:

| Script | What it does |
|---|---|
| `setups/brew/brew.sh` | Installs Homebrew, then runs `setups/brew/Brewfile` via `brew bundle` |
| `setups/zsh/zsh.sh` | Installs Oh My Zsh; symlinks `.zshrc`, `.zprofile`, `.zshenv` into `$HOME` |
| `setups/mise/mise.sh` | Symlinks `setups/mise/mise.toml` → `~/.config/mise/config.toml`; runs `mise install` |

macOS system defaults (`setups/macos/macos.sh`) are applied separately and guarded by the sentinel file `~/.macos-defaults-applied` — delete it to re-apply.

## Repository structure

Setups for individual tools are semi-modularized under "setups/<NAME_OF_TOOL>". Exception: Tools are installed either in Homebrew or mise, but the configuration for the tool is in the `setups` folder.

Note that some apps use `.config` to store their configurations all of these are kept together in the `./.config` folder in the root for ease of symlinking.

```
setups/
  brew/       Brewfile + install script
  zsh/        .zshrc, .zprofile, .zshenv + install script
  mise/       mise.toml (global tool versions) + install script
  macos/      macOS defaults scripts
  python/     ruff.toml
.config/      starship.toml, ghostty config, gh config, etc.
```

## Tool version management

* Using mise for CLI tool installation.
* Homebrew for GUI and Apple Store app installation.

## Shell configuration

* Done via `.zshrc`
* `.zshrc` sources `.aliases`, `.exports`, and `.functions` from `~/dotfiles`. Machine-local overrides go in `~/.local_aliases` and `~/.local_exports` (not committed).
