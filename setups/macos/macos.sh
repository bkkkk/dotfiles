#!/usr/bin/env bash

if [ -f ${HOME}/.macos-defaults-applied ]; then
    log_success "macOS defaults already applied"
    log_info "(Delete ~/.macos-defaults-applied to re-apply)"
else
    echo ""
    log_warning "macOS System Defaults Configuration"
    log_info "This will change:"
    log_info "  ✓ Finder: show hidden files, extensions, path bar"
    log_info "  ✓ Dock: auto-hide, faster animations, smaller icons"
    log_info "  ✓ Screenshots: save to ~/Screenshots as PNG"
    log_info "  ✓ Keyboard: faster key repeat, disable autocorrect"
    log_info "  ✓ Trackpad: tap to click enabled"
    echo ""
    log_warning "Some changes require restart to take effect"
    echo ""
    read -rk1 "REPLY?Apply MacOS Default Config? (y/N) "
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        bash "${SETUPSPATH}/macos/defaults.sh"
        touch ~/.macos-defaults-applied
        log_success "macOS defaults configured"
    else
        log_info "Skipped macOS defaults configuration"
    fi
fi