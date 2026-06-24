#!/usr/bin/env bash
THISPATH=${SETUPSPATH}/claude
CLAUDEPATH=${HOME}/.claude

log_info "Setting up Claude configurations"

mkdir -p "${CLAUDEPATH}"

backup_and_link() {
    local src="$1"
    local dest="$2"

    if [ -e "$dest" ] && [ ! -L "$dest" ]; then
        log_warning "Backing up existing $(basename "$dest") to ${dest}.bak"
        mv "$dest" "${dest}.bak"
    fi

    ln -sfn "$src" "$dest"
}

# TODO Add support of personal handmade Skills, right now we rely
# on the automatic installation of skills from the marketplace.
# but merging the two types is tricky so we're not doing that now
backup_and_link "${THISPATH}/CLAUDE.md"      "${CLAUDEPATH}/CLAUDE.md"
backup_and_link "${THISPATH}/settings.json"  "${CLAUDEPATH}/settings.json"
backup_and_link "${THISPATH}/commands"       "${CLAUDEPATH}/commands"
backup_and_link "${THISPATH}/agents"         "${CLAUDEPATH}/agents"
backup_and_link "${THISPATH}/memory"         "${CLAUDEPATH}/memory"

log_success "Finished setting up Claude configurations"
