# Security and privacy reports

Ebb's core promise is simple: **your cycle history stays on your device.** It
has no account and no server, and release builds can't use the internet. If you
find something that breaks that promise, or any other security problem, please
tell us privately first.

## How to report

Use GitHub's private form: **[Report a vulnerability](https://github.com/SuperDaveOrg/Ebb/security/advisories/new)**
(Security tab → *Report a vulnerability*). Only the maintainers can see it.

Please don't open a public issue for these until there's a fix.

Helpful to include:

- the Ebb version (shown at the bottom of Settings) and your Android version;
- what you did, what you expected, and what happened;
- anything that shows the problem — ideally with made-up data, never your own
  history.

You'll get a reply within a week. Fixes ship as a new release, and the report
is credited in the release notes unless you'd rather it wasn't.

## What counts

Anything that could let cycle data leave the device, or be read by someone or
something it shouldn't, for example:

- a release build that can reach the network, or that asks for a permission
  beyond notifications, restarting after reboot, vibration and the camera;
- data ending up in Android's cloud backup or device-to-device transfer;
- another app being able to read Ebb's data;
- a crafted backup file or QR code that crashes Ebb, corrupts data, or does
  more than import the history it describes;
- a published APK that isn't signed by SuperDaveLab or doesn't match its
  published SHA-256.

Not in scope: someone who already has your unlocked phone opening the app.
Ebb is an ordinary app, not a vault — see [docs/privacy.md](docs/privacy.md)
for why.

## Supported versions

Only the latest release gets fixes. Download it from
[ebb.superdavelab.com](https://ebb.superdavelab.com/).
