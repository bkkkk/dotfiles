#!/usr/bin/env bash

THISPATH=${SETUPSPATH}/mise

log_info "Running mise"
mkdir -p "${HOME}/.config/mise"
ln -sf ${THISPATH}/mise.toml ${HOME}/.config/mise/config.toml
mise install
log_success "Running mise"
