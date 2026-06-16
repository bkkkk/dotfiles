#!/usr/bin/env bash
THISPATH=${SETUPSPATH}/ghostty
TARGETPATH=${HOME}/.config/ghostty/

log_info "Setting up ghostty configurations"
mkdir -p ${TARGETPATH}
ln -sf ${THISPATH}/config.ghostty ${HOME}/.config/ghostty/config.ghostty
log_success "Finished setting up ghostty configurations"
