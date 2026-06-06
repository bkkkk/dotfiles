# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

A macOS dotfiles repository that uses a **clone-and-symlink** approach (not a bare git repo, despite what the README describes — the README is outdated). Config files live in `~/dotfiles/` and are symlinked or sourced into their expected locations.

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

```
setups/
  brew/       Brewfile + install script
  zsh/        .zshrc, .zprofile, .zshenv + install script
  mise/       mise.toml (global tool versions) + install script
  macos/      macOS defaults scripts
  python/     ruff.toml
.aliases      Sourced by .zshrc — shell aliases
.exports      Sourced by .zshrc — environment variables
.functions    Sourced by .zshrc — shell functions
.gitconfig    Git config with aliases and SSH signing via 1Password
.config/      starship.toml, ghostty config, gh config, etc.
app_configs/  App-specific configs (Moom, Alfred, iTerm) + install.sh
.alfred/      Alfred preferences (synced via Alfred's sync folder)
```

## Tool version management

`setups/mise/mise.toml` is the source of truth for global tool versions. Tools default to `"latest"` intentionally — per-project pinning is done via `.mise.toml` files in individual project roots. Edit `setups/mise/mise.toml`, not `~/.config/mise/config.toml` (which is a symlink).

## ZSH config loading order

`.zshenv` → `.zprofile` → `.zshrc`

`.zshrc` sources `.aliases`, `.exports`, and `.functions` from `$DOTFILES_DIR` (`~/dotfiles`). Machine-local overrides go in `~/.local_aliases` and `~/.local_exports` (not committed).

## Git signing

Commits are signed with SSH via 1Password (`/Applications/1Password.app/Contents/MacOS/op-ssh-sign`). GPG signing is always required — never bypass it.

## Git aliases (from .gitconfig)

Branch workflow aliases: `git feature <name>`, `git fix <name>`, `git change <name>` — each pulls, creates a `jeb/<type>/<timestamp>/<name>` branch, and pushes. `git finish` — switches back to main, pulls, and prunes merged branches.
