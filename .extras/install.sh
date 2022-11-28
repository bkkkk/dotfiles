#!/bin/zsh
source utils/colors.sh

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
brew update & brew bundle || wait_on_error "Failed to install some Homebrew applications."
log_success "Homebrew applications have been installed"


log_info "Setting up Shell Config"
./zsh/install.sh || error_exit "Failed to configure ZSH"
log_success "ZSH config has been updated"


log_info "Setting up Python3"
./python/install.sh || error_exit "Failed to setup Python3 environment"
log_success "Python3 environment has been setup"


log_info "Setting up Applications"
./app_configs/install.sh || error_exit "Failed to configure applications"
log_success "Additional application configuration has been set"


log_info "Setting up MacOS defaults configuration"
./.macos || error_exit "Failed to setup some MacOS configuration"
log_success "MacOS configuration is finished"


log_h1 "All Done!"
