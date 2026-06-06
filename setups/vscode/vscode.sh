#!/usr/bin/env bash

log_info "Setting up Visual Studio Code extensions"

code --install-extension ms-python.python
code --install-extension alefragnani.project-manager
code --install-extension GitHub.vscode-pull-request-github
code --install-extension jdinhlife.gruvbox
code --install-extension wholroyd.jinja

log_success "Visual Studio Code extensions have been installed."
log_info "Please Restart VSC"
