#!/usr/bin/env bash

set -euo pipefail

DOTPATH=${DOTPATH:-$HOME/dotfiles}
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
  git stash
  git checkout main
  git pull origin main
fi

cd "$DOTPATH"

$DOTPATH/setups/brew/brew.sh
$DOTPATH/setups/zsh/zsh.sh
$DOTPATH/setups/mise/mise.sh

source $EXTRA_DIR/utils/colors.sh

log_h1 "== Welcome! Setting up standard Jacob environment =="

log_info "Installing Command Line Tools"
xcode-select --install
log_success "Command-line tools have been installed"

log_info "Setting up Shell Config"
$EXTRA_DIR/zsh/install.sh || error_exit "Failed to configure ZSH"
log_success "ZSH config has been updated"


log_info "Setting up Applications"
$EXTRA_DIR/app_configs/install.sh || error_exit "Failed to configure applications"
log_success "Additional application configuration has been set"


log_info "Setting up MacOS defaults configuration"
$EXTRA_DIR/.macos || error_exit "Failed to setup some MacOS configuration"
log_success "MacOS configuration is finished"


log_h1 "All Done!"
