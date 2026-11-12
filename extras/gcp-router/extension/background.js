// Hosts to route. Docs (cloud.google.com/docs) are NOT included on purpose.
const HOSTS = ["console.cloud.google.com", "shell.cloud.google.com", "ssh.cloud.google.com"];

chrome.webNavigation.onBeforeNavigate.addListener(
  async ({ tabId, frameId, url }) => {
    if (frameId !== 0) return; // top-level navigations only
    chrome.runtime.sendNativeMessage("com.jacob.gcp_router", { url });
    // Leave the tab: go back if it has history, otherwise close it.
    try { await chrome.tabs.goBack(tabId); } catch { chrome.tabs.remove(tabId); }
  },
  { url: HOSTS.map((h) => ({ hostEquals: h, schemes: ["https"] })) }
);
