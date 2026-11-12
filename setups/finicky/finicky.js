export default {
  defaultBrowser: {
    name: "Google Chrome",
    profile: "Work",
  },
  handlers: [
    {
      // GCP console and related Google Cloud links
      match: [
        "console.cloud.google.com/*",
        "*.cloud.google.com/*",
        "shell.cloud.google.com/*",
      ],
      browser: {
        name: "Google Chrome",
        profile: "Jacobo (panacloud.net)",
      },
    },
  ],
};
