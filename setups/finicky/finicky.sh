#!/usr/bin/env bash
THISPATH=${SETUPSPATH}/finicky
TARGETPATH=${HOME}/.config/finicky/

log_info "Setting up finicky configurations"
mkdir -p ${TARGETPATH}
ln -sf ${THISPATH}/finicky.js ${TARGETPATH}/finicky.js
log_success "Finished setting up finicky configurations"
