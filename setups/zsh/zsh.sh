#!/usr/bin/env bash
THIS_DIR=${SETUPSPATH}/zsh

log_info "Installing Oh My ZSH"
RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
log_success "Finished installing Oh My ZSH"

log_info "Installing ZSH configuration"
ln -sf ${THIS_DIR}/.zshrc  ${HOME}/.zshrc
ln -sf ${THIS_DIR}/.zprofile  ${HOME}/.zprofile
ln -sf ${THIS_DIR}/.zshenv  ${HOME}/.zshenv
log_success "Finished installing ZSH configuration"
