#!/bin/zsh
source utils/colors.sh

BASEDIR=$(dirname "$0")

log_h1 "Setting up Application Configs"

log_info "Setting up Moom"
defaults import com.manytricks.Moom $BASEDIR/Moom.plist || wait_on_error "Failed to setup Moom."
log_success "Done with Moom!" 

log_info "Setting up Alfred"
defaults write com.runningwithcrayons.Alfred-Preferences syncfolder "~/.alfred"
log_success "Done with Alfred!"

log_info "Setting up Visual Studio Code extensions"

code --install-extension alefragnani.project-manager
code --install-extension GitHub.vscode-pull-request-github
code --install-extension jdinhlife.gruvbox
code --install-extension ms-python.isort
code --install-extension ms-python.python
code --install-extension ms-python.vscode-pylance
code --install-extension wholroyd.jinja

log_success "Visual Studio Code extensions have been installed."
log_info "Please Restart VSC"
