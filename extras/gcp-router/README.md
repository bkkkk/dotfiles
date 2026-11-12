# GCP Profile Router

Opens Google Cloud links in one dedicated Chrome profile, from any other profile.

## How it works

1. The **extension** watches top-level navigations to GCP hosts (Console, Cloud Shell, SSH, Composer QA).
2. It sends the URL to a **native messaging host**: a small Python script Chrome starts on demand.
3. The host checks the URL against its own allow-list, then runs `open -na "Google Chrome" --args --profile-directory=<GCP profile> <url>`.
4. If the host opens the URL, the extension closes the empty tab or returns it to its previous page. If the host fails, the page loads in the current profile.

Chrome only lets an extension talk to a host when the host manifest names that extension's ID. Setup connects the two.

## Requirements

* macOS with Google Chrome.
* `/usr/bin/python3` (install with `xcode-select --install` if missing).

## Setup

### 1. Load the extension

Do this in each profile that must **send** links (not in the GCP profile itself).

1. Open `chrome://extensions`.
2. Turn on **Developer mode**.
3. Click **Load unpacked** and select the `extension/` folder.
4. Check the extension **ID** is `hcnhmfkeocefomogbomcmlchipofafen`.

The `key` field in `extension/manifest.json` fixes the ID on every machine. It is a public key, so it is safe to commit. Chrome loads only one extension per ID: do not load a second copy of this folder.

### 2. Find the GCP profile

```sh
./install.sh --list-profiles
```

Output shows `<folder>: <display name>`, for example `Profile 6: Work GCP`.

### 3. Install the host

```sh
./install.sh --profile "Work GCP"
```

`--profile` accepts the display name or the folder name. `--extension-id <ID>` is optional: use it only for a copy of the extension without the `key` field. The script:

* Copies `host/gcp_router.py` to `~/.local/bin/gcp_router.py` with `PROFILE_DIR` set to the chosen profile.
* Writes `~/Library/Application Support/Google/Chrome/NativeMessagingHosts/com.jacob.gcp_router.json`, which allows only your extension ID.

### 4. Restart Chrome

Quit Chrome fully (Cmd+Q) and open it again.

## Test

Open `https://console.cloud.google.com` in a non-GCP profile. It must open in the GCP profile.

If it loads in the current profile, the host failed. Open `chrome://extensions`, click **service worker** under the extension, and read the console error:

* `Specified native messaging host not found` - the manifest is missing or Chrome was not restarted.
* `Access to the specified native messaging host is forbidden` - extension ID mismatch. Check the ID in `chrome://extensions`, then run step 3 again.
* `Native host has exited` - the host script failed. Check `/usr/bin/python3` exists and the script is executable.

## Add a host

Add the hostname in 2 places, then re-run `install.sh` and reload the extension:

* `HOSTS` in `extension/background.js`
* `ALLOWED` in `host/gcp_router.py`

Google Cloud docs (`cloud.google.com/docs`) are not routed on purpose.

## Uninstall

```sh
rm ~/.local/bin/gcp_router.py \
   ~/Library/Application\ Support/Google/Chrome/NativeMessagingHosts/com.jacob.gcp_router.json
```

Then remove the extension from `chrome://extensions`.
