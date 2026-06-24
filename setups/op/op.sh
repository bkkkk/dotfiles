#!/usr/bin/env bash
THISPATH=${SETUPSPATH}/op
TARGETPATH=${HOME}/.config/op/

log_info "Setting up op configurations"
mkdir -p ${TARGETPATH}
# op doesn't support reading symlinked config files
# copy instead.
cp ${THISPATH}/config ${HOME}/.config/op/config
log_success "Finished setting up op configurations"
