#!/usr/bin/env bash

set -euo pipefail

DOTPATH=${DOTPATH:-$HOME/dotfiles}
SETUPSPATH=${SETUPSPATH:-${DOTPATH}/setups/}
DOTFILES_REPO=${DOTFILES_REPO:-https://github.com/bkkkk/dotfiles.git}

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${BLUE}==>${NC} $1"
}

log_success() {
    echo -e "${GREEN}✓${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}!${NC} $1"
}

log_error() {
    echo -e "${RED}✗${NC} $1"
}

# Check if we're on macOS
if [[ "$(uname)" != "Darwin" ]]; then
    log_error "This script is only for macOS"
    exit 1
fi

echo ""
log_info "=============================="
log_info "Installing Dotfiles"
log_info "=============================="
echo ""
log_info "Pulling dotfiles from github into ${DOTPATH}"
echo ""

if [ ! -d "$DOTPATH" ]; then
  git clone "$DOTFILES_REPO" "$DOTPATH"
else
  echo "$DOTPATH already downloaded. Updating..."
  cd "$DOTPATH"
  stash_result=$(git stash)
  git checkout main
  git pull origin main
  [[ "$stash_result" != "No local changes to save" ]] && git stash pop
fi

cd "$DOTPATH"

log_info "== Welcome! Setting up standard Jacob environment =="
log_info "Installing Command Line Tools"
xcode-select -p &>/dev/null || xcode-select --install
log_success "Command-line tools have been installed"

source $SETUPSPATH/brew/brew.sh
source $SETUPSPATH/zsh/zsh.sh
source $SETUPSPATH/mise/mise.sh
source $SETUPSPATH/git/git.sh
source $SETUPSPATH/alfred/alfred.sh
source $SETUPSPATH/moom/moom.sh
source $SETUPSPATH/vscode/vscode.sh
source $SETUPSPATH/op/op.sh
source $SETUPSPATH/ghostty/ghostty.sh
source $SETUPSPATH/macos/macos.sh
source $SETUPSPATH/claude/claude.sh

ln -sf ${DOTPATH}/.config ${HOME}/.config
