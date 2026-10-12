eval "$(/opt/homebrew/bin/brew shellenv)"

# Loads keys whose passphrase is saved in Keychain (the Claude agent signing key) into the macOS ssh-agent
ssh-add --apple-load-keychain -q
