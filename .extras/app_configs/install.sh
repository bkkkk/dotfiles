#!/bin/zsh
EXTRA_DIR=$HOME/.extras

source $EXTRA_DIR/utils/colors.sh

BASEDIR=$(dirname "$0")

log_h1 "Setting up Application Configs"

log_info "Setting up Moom"
defaults import com.manytricks.Moom $BASEDIR/Moom.plist || wait_on_error "Failed to setup Moom."
log_success "Done with Moom!" 

log_info "Setting up Alfred"
defaults write com.runningwithcrayons.Alfred-Preferences syncfolder "~/.alfred"
log_success "Done with Alfred!"
