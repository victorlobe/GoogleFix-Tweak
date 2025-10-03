<p align="center">
  <img width="343" height="76" alt="GoogleFix" src="http://storage.server.victorlobe.me/Cydia/packageIcons/GoogleFixIcon.png" />
</p>
<p align="center">
  An iOS tweak that fixes Google on iOS 6+ by bypassing browser detection.
</p>

<p align="center">
  <a href="https://github.com/victorlobe/GoogleFix/releases/latest">
    <img alt="Download" src="https://img.shields.io/badge/download-latest-blue?logo=apple" />
  </a>
  <img alt="License" src="https://img.shields.io/badge/license-MIT-green">
  <img alt="Platform" src="https://img.shields.io/badge/platform-iOS%206+-007AFF">
</p>

---

## Features

- Removes "update your browser" message on Google
- Compatible with iOS 6 and newer
- Minimal code - only hooks Google domains

## Requirements

- iOS 6.0 or newer
- MobileSubstrate
- Jailbroken device

## Installation

1. **Add the repo** `repo.victorlobe.me` to Cydia

2. **Install GoogleFix**

3. **Respring your device**

4. **Open Google** - it should now work without browser warnings!

## Behind the Scenes

The tweak hooks into `UIWebView` and modifies the User Agent string for Google domains only. It sets the User Agent to iOS 7.0 Safari, which Google accepts, eliminating the "update your browser" message. I will update this tweak and add some settings for more User Agend options like iOS 8.

## Author

Made with ❤️ by Victor Lobe

## License

MIT License – Free to use, share, and modify.