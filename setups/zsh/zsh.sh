#!/usr/bin/env bash
THIS_DIR=${SETUPSPATH}/zsh

if [ -d "${HOME}/.oh-my-zsh" ]; then
  log_info "Oh My Zsh already installed, updating"
  git -C "${HOME}/.oh-my-zsh" pull --rebase
  log_success "Finished updating Oh My ZSH"
else
  log_info "Installing Oh My ZSH"
  RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  log_success "Finished installing Oh My ZSH"
fi

log_info "Installing ZSH configuration"
ln -sf ${THIS_DIR}/.zshrc  ${HOME}/.zshrc
ln -sf ${THIS_DIR}/.zprofile  ${HOME}/.zprofile
ln -sf ${THIS_DIR}/.zshenv  ${HOME}/.zshenv
log_success "Finished installing ZSH configuration"
