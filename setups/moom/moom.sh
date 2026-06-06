#!/usr/bin/env bash

BASEDIR=$(dirname "$0")

log_info "Setting up Moom"
defaults import com.manytricks.Moom $BASEDIR/Moom.plist || wait_on_error "Failed to setup Moom."
log_success "Done with Moom!" 
