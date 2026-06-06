#!/usr/bin/env bash

log_info "Setting up Moom"
defaults import com.manytricks.Moom ${SETUPSPATH}/moom/Moom.plist || wait_on_error "Failed to setup Moom."
log_success "Done with Moom!" 
