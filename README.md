<p align="center">
  <img width="343" height="76" alt="GoogleFixIcon" src="https://github.com/user-attachments/assets/540ddebe-a0a6-4410-82b8-ee8b8da2fa41" />
</p>
<p align="center">
  An iOS tweak that fixes Google on iOS 6+.
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

4. **Open Safari and search something with Google**


## Changelog

### v2.0.1
- Added a package Icon.
- Fixed the depiction URL.

### v2
- GoogleFix works again! Google now runs a JavaScript check before showing results, and Safari on iOS 6 couldn't run it. GoogleFix now adds the missing JavaScript features so the check passes on old devices.
- New settings page.
- Classic Layout switch: shows Google's simple desktop layout instead of the current mobile one.
- GoogleFix now only loads into Safari.
- The custom User Agent is now only used for Google. All other websites see Safari's real UA again.

### v1.0.2
- Fixes UserDefault key leftovers when removing the Tweak.
- Uses a new, less invasive method for fixing Google.

### v1.0.1
- Fixed an issue where the Tweak didn't work on some iOS Versions

### v1.0.0
- Initial release


## Author

Made with ❤️ by Victor Lobe

## License

MIT License – Free to use, share, and modify.
