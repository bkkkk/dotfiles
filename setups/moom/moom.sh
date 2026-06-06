#!/usr/bin/env bash

log_info "Setting up Moom"
killall Moom 2>/dev/null || true
if ! defaults import com.manytricks.Moom "${SETUPSPATH}/moom/Moom.plist"; then
    log_error "Failed to setup Moom."
    exit 1
fi
killall cfprefsd 2>/dev/null || true
log_success "Done with Moom!"
