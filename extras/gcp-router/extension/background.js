// Hosts to route. Docs (cloud.google.com/docs) are NOT included on purpose.
const HOSTS = [
  "console.cloud.google.com",
  "shell.cloud.google.com",
  "ssh.cloud.google.com",
  // Composer QA
  "ad7cd9f33f564fb5b3a81aad7ad909ef-dot-asia-northeast1.composer.googleusercontent.com"
];

const HOST_NAME = "com.jacob.gcp_router";
const EMPTY_TAB_URLS = new Set(["", "about:blank", "chrome://newtab/"]);

// Sends the URL to the native host. Returns true if the host opened it.
async function send_to_gcp_profile(url) {
  try {
    const reply = await chrome.runtime.sendNativeMessage(HOST_NAME, { url });
    return reply?.ok === true;
  } catch (err) {
    console.error("GCP router: native host failed:", err.message);
    return false;
  }
}

// Removes a tab that holds nothing else, or returns it to its last committed page.
async function release_tab(tabId) {
  const tab = await chrome.tabs.get(tabId);
  if (EMPTY_TAB_URLS.has(tab.url ?? "")) {
    await chrome.tabs.remove(tabId);
  } else {
    // Navigating to the committed URL cancels the pending GCP navigation.
    await chrome.tabs.update(tabId, { url: tab.url });
  }
}

chrome.webNavigation.onBeforeNavigate.addListener(
  async ({ tabId, frameId, url }) => {
    if (frameId !== 0) return; // top-level navigations only
    // On failure, let the page load in this profile instead of losing it.
    if (!(await send_to_gcp_profile(url))) return;
    await release_tab(tabId);
  },
  { url: HOSTS.map((h) => ({ hostEquals: h, schemes: ["https"] })) }
);
