# QR transfer fixtures

Entirely fictional data — no real history appears in these files.

| File | What it is |
|---|---|
| `sample-backup.json` | Output of `dart run tool/sample_history.dart`: two years for the phone's owner (with daily notes and one excluded cycle), eight irregular months for a second person, "Sam". |
| `sam-only-1-of-1.png` | **Send → Just Sam** from the same data: one person, one code. Received on an empty phone it offers "Set up with this history?" (8 periods) and Sam becomes the owner; on a phone with data it offers "Add as someone new" or "Replace everything". |
| `code-N-of-3.png` | Screen captures of **Settings → Send to another phone** on a Pixel 9 emulator (1080×2424) after restoring that file. One send session, so the three belong together. |

The codes carry a random per-send ID, so re-capturing produces different
images with the same content.

## Using them

- **Emulator, via the gallery:** push the PNGs to `/sdcard/Pictures/`, rescan
  media (`adb shell content call --method scan_volume --uri content://media
  --arg external_primary`), then **Receive from another phone** → gallery
  button, and pick each image in any order.
- **Real phone, via the camera:** open the PNGs full-screen on a monitor and
  point the phone at them one at a time.

Either way, the confirmation should offer **32 periods for 2 people**.
`test/backup_test.dart` checks that `sample-backup.json` still decodes, so a
format change that breaks old files fails the tests.
