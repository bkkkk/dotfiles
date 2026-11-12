#!/usr/bin/env bash
# Installs the GCP router native messaging host for Google Chrome on macOS.
#
# Usage:
#   ./install.sh --list-profiles
#   ./install.sh --profile "<Chrome profile name>" [--extension-id <ID>]
set -euo pipefail

HOST_NAME="com.jacob.gcp_router"
# Fixed by the "key" field in extension/manifest.json.
DEFAULT_EXT_ID="hcnhmfkeocefomogbomcmlchipofafen"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CHROME_DIR="${HOME}/Library/Application Support/Google/Chrome"
LOCAL_STATE="${CHROME_DIR}/Local State"
MANIFEST_DIR="${CHROME_DIR}/NativeMessagingHosts"
HOST_DEST="${HOME}/.local/bin/gcp_router.py"

# Prints usage and exits.
print_usage() {
  sed -n '2,6p' "$0" | sed 's/^# \{0,1\}//'
  exit 1
}

# Prints each Chrome profile as "<folder>: <display name>".
list_profiles() {
  /usr/bin/python3 - "$LOCAL_STATE" <<'PY'
import json, sys
cache = json.load(open(sys.argv[1]))["profile"]["info_cache"]
for folder, info in sorted(cache.items()):
    print(f"{folder}: {info.get('name', '')}")
PY
}

# Gets the profile folder (for example "Profile 6") for a profile display name.
get_profile_dir() {
  /usr/bin/python3 - "$LOCAL_STATE" "$1" <<'PY'
import json, sys
cache = json.load(open(sys.argv[1]))["profile"]["info_cache"]
matches = [f for f, i in cache.items() if i.get("name") == sys.argv[2] or f == sys.argv[2]]
if len(matches) != 1:
    sys.exit(f"No unique Chrome profile named '{sys.argv[2]}'. Use --list-profiles.")
print(matches[0])
PY
}

EXT_ID="$DEFAULT_EXT_ID"
PROFILE=""
while [[ $# -gt 0 ]]; do
  case "$1" in
    --list-profiles) list_profiles; exit 0 ;;
    --extension-id) EXT_ID="${2:-}"; shift 2 ;;
    --profile) PROFILE="${2:-}"; shift 2 ;;
    *) print_usage ;;
  esac
done
[[ -n "$PROFILE" ]] || print_usage
[[ "$EXT_ID" =~ ^[a-p]{32}$ ]] || { echo "Extension ID must be 32 letters a-p." >&2; exit 1; }
[[ -f "$LOCAL_STATE" ]] || { echo "Chrome data not found at ${CHROME_DIR}." >&2; exit 1; }

PROFILE_DIR="$(get_profile_dir "$PROFILE")"

# Copy the host with the target profile folder set.
mkdir -p "$(dirname "$HOST_DEST")"
sed "s|^PROFILE_DIR = .*|PROFILE_DIR = \"${PROFILE_DIR}\"|" \
  "${SCRIPT_DIR}/host/gcp_router.py" > "$HOST_DEST"
chmod 755 "$HOST_DEST"

# Register the host with Chrome. Only the given extension may call it.
mkdir -p "$MANIFEST_DIR"
cat > "${MANIFEST_DIR}/${HOST_NAME}.json" <<JSON
{
  "name": "${HOST_NAME}",
  "description": "GCP Profile Router",
  "path": "${HOST_DEST}",
  "type": "stdio",
  "allowed_origins": ["chrome-extension://${EXT_ID}/"]
}
JSON

echo "Installed host: ${HOST_DEST} (opens links in '${PROFILE_DIR}')"
echo "Registered:     ${MANIFEST_DIR}/${HOST_NAME}.json"
echo "Restart Chrome to apply."
