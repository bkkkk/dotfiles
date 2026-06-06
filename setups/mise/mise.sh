#!/usr/bin/env bash

log_info "Running mise"
mkdir -p "${HOME}/.config/mise"
ln -sf ${DOTPATH}/mise/mise.toml ${HOME}/.config/mise/config.toml
mise install
log_success "Running mise"
