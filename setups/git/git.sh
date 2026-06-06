#!/usr/bin/env bash
THISPATH=${SETUPSPATH}/git

log_info "Setting up git configurations"
ln -sf ${THISPATH}/.gitconfig ${HOME}/.gitconfig
ln -sf ${THISPATH}/.gitignore ${HOME}/.gitignore
log_success "Finished setting up git configurations"
