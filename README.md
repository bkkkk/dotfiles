# 🏠 Jacob's Dotfiles

> *"A developer's dotfiles are a living autobiography of every tool they've rage-quit and every shortcut they've obsessed over."*

Welcome to my personal dotfiles — lovingly cobbled together, ruthlessly refined, and perpetually a work in progress. This repo is the single source of truth for my entire macOS dev environment. Clone it, symlink it, and be productive in minutes.

---

## ✨ What's Inside

| Category | Tool | What it does for you |
|---|---|---|
| 🍺 **Package Management** | Homebrew + Brewfile | Every app and CLI tool, declaratively |
| 🐚 **Shell** | Zsh + Oh My Zsh | A shell config that actually sparks joy |
| ⭐ **Prompt** | Starship | A blazing-fast, informative prompt |
| 🔧 **Runtime Management** | mise | One tool to rule all language versions |
| 🍎 **macOS Defaults** | macos.sh | Sane system settings, applied automatically |
| 🤖 **AI** | Claude Code | CLI config, commands, and agents baked in |
| 👻 **Terminal** | Ghostty | Config for the best terminal emulator |
| 🔑 **Secrets** | 1Password CLI (`op`) | Secrets management without the nightmares |
| 🎨 **Editor** | VS Code | Settings and extensions sorted |
| 🔍 **Launcher** | Alfred | Workflows for the productivity addicts |
| 📐 **Window Management** | Moom | Because tiling windows manually is a crime |
| 🐍 **Python** | ruff.toml | Lint fast, stay sane |
| 🐙 **Git** | .gitconfig + aliases | Speed through your commits |

---

## 🚀 One-Command Bootstrap

Fresh Mac? One command and you're basically done:

```sh
./install.sh
```

This script runs the full setup sequence end-to-end:

```
install.sh
├── 🍺 setups/brew/brew.sh        → Homebrew + all Brewfile packages
├── 🐚 setups/zsh/zsh.sh          → Oh My Zsh + zsh config symlinks
├── 🔧 setups/mise/mise.sh        → mise config + installs all tool versions
├── 🍎 setups/macos/macos.sh      → macOS system defaults (idempotent)
└── 🤖 setups/claude/claude.sh    → Claude Code config into ~/.claude/
```

---

## 🗂️ Repository Layout

```
dotfiles/
├── install.sh            # 🚀 Full bootstrap entrypoint
├── justfile              # 🧪 Dev tasks (testrun, etc.)
├── setups/
│   ├── brew/             # Brewfile + install script
│   ├── zsh/              # .zshrc, .zprofile, .zshenv
│   ├── mise/             # mise.toml (global tool versions)
│   ├── macos/            # macOS defaults scripts
│   ├── claude/           # Claude Code config, commands, agents
│   ├── git/              # .gitconfig + helpers
│   ├── alfred/           # Alfred workflows
│   ├── vscode/           # VS Code settings
│   └── moom/             # Window management config
└── .config/
    ├── ghostty/          # Terminal config
    ├── starship.toml     # Prompt config
    ├── gh/               # GitHub CLI config
    ├── op/               # 1Password CLI config
    └── ruff/             # Python linter config
```

---

## 🧪 Testing a Single Setup

Don't want to run everything? Test one setup in isolation:

```sh
just testrun <NAME_OF_SETUP>

# Examples:
just testrun zsh
just testrun brew
just testrun claude
```

---

## 🐚 Shell Config Highlights

The shell config is split into focused files, all sourced from `.zshrc`:

| File | Purpose |
|---|---|
| `.aliases` | Shortcuts for everything you type too often |
| `.exports` | Environment variables |
| `.functions` | Custom shell functions |
| `~/.local_aliases` | Machine-local overrides (not committed) |
| `~/.local_exports` | Machine-local env vars (not committed) |

---

## 🔧 Tool Version Management

Runtime versions are managed by **mise** (the fast `asdf` alternative). All global versions live in `setups/mise/mise.toml` and are symlinked to `~/.config/mise/config.toml`.

```sh
mise install   # installs everything defined in mise.toml
mise ls        # see what's installed
```

---

## 🍎 macOS Defaults

System preferences are scripted and applied once (guarded by `~/.macos-defaults-applied`). To re-apply after making changes:

```sh
rm ~/.macos-defaults-applied && ./setups/macos/macos.sh
```

---

## 🤖 Claude Code Config

The `setups/claude/` directory contains Claude Code CLI config (CLAUDE.md, settings.json, custom commands and agents) symlinked into `~/.claude/`. AI-first development, batteries included.

---

## 💡 Philosophy

- **Clone-and-symlink** — files live here, symlinks point to them everywhere else
- **Idempotent** — safe to run setup scripts multiple times
- **Modular** — each tool lives under `setups/<tool>/`, easy to add or remove
- **Local overrides** — machine-specific stuff stays untracked and out of git

---

*Built for macOS. Tested on coffee and stubbornness.* ☕
