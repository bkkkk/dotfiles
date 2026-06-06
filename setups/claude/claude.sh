#!/usr/bin/env bash
THISPATH=${SETUPSPATH}/claude
CLAUDE_DIR=${HOME}/.claude

log_info "Setting up Claude configurations"

mkdir -p "${CLAUDE_DIR}"

backup_and_link() {
    local src="$1"
    local dest="$2"

    if [ -e "$dest" ] && [ ! -L "$dest" ]; then
        log_warning "Backing up existing $(basename "$dest") to ${dest}.bak"
        mv "$dest" "${dest}.bak"
    fi

    ln -sf "$src" "$dest"
}

backup_and_link "${THISPATH}/CLAUDE.md"      "${CLAUDE_DIR}/CLAUDE.md"
backup_and_link "${THISPATH}/settings.json"  "${CLAUDE_DIR}/settings.json"
backup_and_link "${THISPATH}/commands"       "${CLAUDE_DIR}/commands"
backup_and_link "${THISPATH}/agents"         "${CLAUDE_DIR}/agents"

log_success "Finished setting up Claude configurations"
