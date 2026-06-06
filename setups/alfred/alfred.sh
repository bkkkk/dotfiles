BASEDIR=$(dirname "$0")

log_info "Setting up Alfred"
defaults write com.runningwithcrayons.Alfred-Preferences syncfolder "${SETUPSPATH}/alfred/.alfred"
log_success "Done with Alfred!"
