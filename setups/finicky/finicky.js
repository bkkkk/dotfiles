export default {
  logRequests: false,
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
        "*.composer.googleusercontent.com/*"
      ],
      browser: {
        name: "Google Chrome",
        profile: "GCP",
      },
    },
  ],
};
