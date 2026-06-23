# Run a setup script: just testrun brew | zsh | mise | macos
testrun setup:
    #!/usr/bin/env bash
    set -euo pipefail
    export DOTPATH="{{justfile_directory()}}"
    export SETUPSPATH="${DOTPATH}/setups"

    RED='\033[0;31m'
    GREEN='\033[0;32m'
    YELLOW='\033[1;33m'
    BLUE='\033[0;34m'
    NC='\033[0m'

    log_info()    { echo -e "${BLUE}==>${NC} $1"; }
    log_success() { echo -e "${GREEN}✓${NC} $1"; }
    log_warning() { echo -e "${YELLOW}!${NC} $1"; }
    log_error()   { echo -e "${RED}✗${NC} $1"; }

    if [[ ! -f "${SETUPSPATH}/{{setup}}/{{setup}}.sh" ]]; then
        log_error "Setup '{{setup}}' not found."
        echo ""
        echo "Available setups:"
        for dir in "${SETUPSPATH}"/*/; do
            name="$(basename "$dir")"
            [[ -f "${dir}${name}.sh" ]] && echo "  - ${name}"
        done
        exit 1
    fi

    source "${SETUPSPATH}/{{setup}}/{{setup}}.sh"
