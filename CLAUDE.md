# CLAUDE.md

## What this repo is

A macOS dotfiles repository that uses a **clone-and-symlink** approach. Config files live in `~/dotfiles/` and are symlinked or sourced into their expected locations.

## Setup / Installation

Full bootstrap (run once on a new machine):

```sh
./install.sh
```

## Repository structure

There are 3 kinds of installations and configuration types:

* Homebrew for GUI and Apple Store app installation.
* mise for CLI tool installation.
* `setups/` - Tools that are configured globally through a dedicated script in  (symlink).
* `extras/` - Extra stuff that isn't always installed like ruff configs for projects.

Setups for individual tools are semi-modularized under "setups/<NAME_OF_TOOL>". Exception: Tools are installed either in Homebrew or mise, but the configuration for the tool is in the `setups` folder.

## Testing individual setups

To test a single setup script in isolation:

```sh
just testrun <NAME_OF_SETUP>
```
