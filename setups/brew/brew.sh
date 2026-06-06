DOTPATH=${HOME}/dotfiles

# Install Homebrew
if ! command -v brew &> /dev/null; then
    log_info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH for Apple Silicon
    if [[ $(uname -m) == 'arm64' ]]; then
        # Only add if not already present
        if ! grep -q "/opt/homebrew/bin/brew shellenv" ~/.zprofile 2>/dev/null; then
            echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        fi
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
    log_success "Homebrew installed"
else
    log_success "Homebrew already installed"
fi

# Install mas (Mac App Store CLI) first if not present
if ! command -v mas &> /dev/null; then
    log_info "Installing mas (Mac App Store CLI)..."
    brew install mas
    log_success "mas installed"
else
    log_success "mas already installed"
fi

# Verify App Store sign-in (mas account can be unreliable)
if ! mas account &> /dev/null; then
    log_warning "Cannot verify Mac App Store sign-in"
    echo ""
    log_info "Some apps require App Store authentication:"
    log_info "  - Things 3 (task manager)"
    log_info "  - Amphetamine (prevent sleep)"
    log_info "  - Bear, Fantastical, etc."
    echo ""
    log_info "To sign in: System Settings > Media & Purchases > Sign In"
    echo ""
    read -p "Are you signed into the App Store? (y/N) " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        log_warning "App Store apps will be skipped (install manually later)"
        log_info "You can re-run bootstrap after signing in to retry"
    else
        log_success "Proceeding with App Store apps"
    fi
    echo ""
fi

BREWFILEPATH="${DOTPATH}/setups/brew/Brewfile"

# Install from Brewfile
if [ -f "${BREWFILEPATH}" ]; then
    log_info "Checking which apps are already installed..."

    # Create temporary filtered Brewfile excluding manually-installed casks
    TEMP_BREWFILE=$(mktemp)

    # Copy Brewfile, filtering out casks where app already exists
    while IFS= read -r line; do
        # Check if line is a cask declaration
        if [[ "$line" =~ ^cask[[:space:]]+\"([^\"]+)\" ]]; then
            cask_name="${BASH_REMATCH[1]}"

            # Map cask name to app name (what appears in /Applications)
            case "$cask_name" in
                docker) app_name="Docker" ;;
                cursor) app_name="Cursor" ;;
                visual-studio-code) app_name="Visual Studio Code" ;;
                claude-code) app_name="Claude Code" ;;
                claude) app_name="Claude" ;;
                chatgpt) app_name="ChatGPT" ;;
                slack) app_name="Slack" ;;
                discord) app_name="Discord" ;;
                notion) app_name="Notion" ;;
                raycast) app_name="Raycast" ;;
                alfred) app_name="Alfred 5" ;;
                fantastical) app_name="Fantastical" ;;
                whatsapp) app_name="WhatsApp" ;;
                1password) app_name="1Password" ;;
                the-unarchiver) app_name="The Unarchiver" ;;
                spotify) app_name="Spotify" ;;
                iterm2) app_name="iTerm" ;;
                *) app_name="" ;;
            esac

            # Check if app already exists in /Applications
            if [ -n "$app_name" ]; then
                if [ -d "/Applications/${app_name}.app" ]; then
                    log_warning "Skipping $cask_name (already installed)"
                    echo "# Skipped: $line" >> "$TEMP_BREWFILE"
                    continue
                fi
            fi
        fi
        echo "$line" >> "$TEMP_BREWFILE"
    done < "${BREWFILEPATH}"

    # Count total items to install
    total_items=$(grep -E '^(brew|cask|mas|vscode)' "$TEMP_BREWFILE" | wc -l | xargs)

    log_info "Installing apps and tools from Brewfile"
    log_info "Queued: $total_items packages/apps to install"
    log_info "Starting Homebrew installations"
    echo ""

    # Use --no-upgrade to skip already-installed apps, --verbose to show progress immediately
    # Note: brew bundle can hang on parallel downloads. If stuck for >5min, Ctrl+C and re-run
    brew bundle --file="$TEMP_BREWFILE" --no-upgrade --verbose

    # Clean up
    rm -f "$TEMP_BREWFILE"

    echo ""
    log_success "Brewfile installed"
else
    log_warning "Brewfile not found, skipping..."
fi
