#!/usr/bin/python3
"""Chrome native messaging host. Opens allowed GCP URLs in the GCP profile."""
import json, struct, subprocess, sys
from urllib.parse import urlparse

PROFILE_DIR = "Profile 6"  # folder name of your GCP profile (see README)
ALLOWED = {
    "console.cloud.google.com",
    "shell.cloud.google.com",
    "ssh.cloud.google.com",
    "ad7cd9f33f564fb5b3a81aad7ad909ef-dot-asia-northeast1.composer.googleusercontent.com"
}

def main():
    raw = sys.stdin.buffer.read(4)
    if len(raw) < 4:
        return
    msg = json.loads(sys.stdin.buffer.read(struct.unpack("<I", raw)[0]))
    url = str(msg.get("url", ""))
    p = urlparse(url)
    # Validate again here: the host never trusts the extension.
    ok = p.scheme == "https" and p.hostname in ALLOWED
    if ok:
        subprocess.run(["/usr/bin/open", "-na", "Google Chrome", "--args",
                        f"--profile-directory={PROFILE_DIR}", url], check=False)
    out = json.dumps({"ok": ok}).encode()
    sys.stdout.buffer.write(struct.pack("<I", len(out)) + out)
    sys.stdout.buffer.flush()

if __name__ == "__main__":
    main()
