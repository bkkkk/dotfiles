#!/usr/bin/env bash

set -euo pipefail

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


DOTPATH=${DOTPATH:-$HOME/dotfiles}
DOTFILES_REPO=${DOTFILES_REPO:-https://github.com/bkkkk/dotfiles.git}

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

$DOTPATH/setups/brew.sh

log_info "Updating Homebrew (this may take a minute)..."
brew update --quiet 2>&1 | grep -v "^Already up-to-date" || log_success "Homebrew updated"


EXTRA_DIR=$HOME/.extras

source $EXTRA_DIR/utils/colors.sh

log_h1 "== Welcome! Setting up standard Jacob environment =="

log_info "Installing Command Line Tools"
xcode-select --install
log_success "Command-line tools have been installed"


log_info "Installing Homebrew"
if ! which brew > /dev/null; then
 # Install Homebrew 
 /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi;
log_success "Homebrew has been installed"


log_info "Installing applications in Brewfile"
brew update & brew bundle --file $EXTRA_DIR || wait_on_error "Failed to install some Homebrew applications."
log_success "Homebrew applications have been installed"


log_info "Setting up Shell Config"
$EXTRA_DIR/zsh/install.sh || error_exit "Failed to configure ZSH"
log_success "ZSH config has been updated"


log_info "Setting up Python3"
uv python install 3.14 || error_exit "Failed to setup Python3 environment"
uv python update-shell || error_exit "Failed to setup Python3 environment"
log_success "Python3 environment has been setup"


log_info "Setting up Applications"
$EXTRA_DIR/app_configs/install.sh || error_exit "Failed to configure applications"
log_success "Additional application configuration has been set"


log_info "Setting up MacOS defaults configuration"
$EXTRA_DIR/.macos || error_exit "Failed to setup some MacOS configuration"
log_success "MacOS configuration is finished"


log_h1 "All Done!"
