# Dotfiles Release Fixes

Outstanding bugs and warnings found during a review of the repository. Items marked with checkboxes are pending resolution.

---

## Bugs (will break on fresh install)

- [x] **`install.sh` — calls `setups/python/python.sh` which does not exist**
  Created `setups/python/python.sh`; moved `ruff.toml` to `.config/ruff/ruff.toml` (picked up by the top-level `.config` symlink in `install.sh`).
  File: `install.sh`

- [x] **`moom.sh` — `wait_on_error` is undefined**
  Replaced with a proper `if/exit 1` error handler. Also added `killall Moom` before import and `killall cfprefsd` after, per Many Tricks' recommended restore procedure.
  File: `setups/moom/moom.sh:4`

- [x] **`alfred.sh` and `vscode.sh` — missing shebangs**
  Added `#!/usr/bin/env bash` to both files.
  Files: `setups/alfred/alfred.sh:1`, `setups/vscode/vscode.sh:1`

- [x] **`Brewfile` — `brew "cask"` is not a valid formula**
  `cask` is a Homebrew subcommand, not an installable package. Remove the line `brew "cask"` from the Brewfile.
  File: `setups/brew/Brewfile`

- [x] **`install.sh` — `ln -s` for `~/.config` will fail if directory exists**
  Changed to `ln -sf`.
  File: `install.sh` (last line)

- [x] **`install.sh` — `xcode-select --install` aborts with exit code 1 if tools already installed**
  Guarded with `xcode-select -p &>/dev/null || xcode-select --install`.
  File: `install.sh`

---

## Warnings (silent degradation)

- [x] **`.gitconfig` — `excludesFile` hardcodes username**
  Changed to `~/.gitignore`.
  File: `setups/git/.gitconfig`

- [x] **`.gitconfig` — stale `maintenance` repo path with wrong username**
  Removed the `[maintenance]` section entirely.
  File: `setups/git/.gitconfig`

- [x] **`.gitconfig` — duplicate `lg` alias**
  Removed the first `lg = !"git lg1"` definition (kept `lg = lg1`).
  File: `setups/git/.gitconfig`

- [x] **`exports.sh` — Intel Homebrew path for `PKG_CONFIG_PATH`**
  Changed to `$(brew --prefix libxml2)/lib/pkgconfig`.
  File: `setups/zsh/exports.sh:1`

- [x] **`aliases.sh` — stale bare-git `config` alias**
  Removed `alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'`.
  File: `setups/zsh/aliases.sh`

- [x] **`Brewfile` — OmniFocus installed twice**
  Removed `cask "omnifocus"` line; kept the `mas` entry.
  File: `setups/brew/Brewfile`

- [x] **`install.sh` — `git stash` on update path is never popped**
  Added `git stash pop` after `git pull origin main`.
  File: `install.sh` (update branch)

- [x] **`functions.sh` — `mpass` uses MD5**
  Function removed entirely as it is no longer needed.
  File: `setups/zsh/functions.sh`
