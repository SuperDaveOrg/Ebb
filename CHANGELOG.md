# Changelog

What changed in each release of Ebb, newest first. The format follows
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and versions follow
the rules in [docs/RELEASING.md](docs/RELEASING.md).

New entries go under **Unreleased** as work lands; `tool/bump_version.sh`
turns that section into the release's own when it's cut.

## [Unreleased]

### Added
- A calendar, from the icon beside History. Logged periods, the likely
  window for the next one, and today, month by month. Tap any past day to
  log a period starting or ending there, its flow, or a note.

## [0.2.0] - 2026-09-27

### Added
- A note on any period, shown in History. Handy for recording why a cycle
  isn't counted in predictions.
- When nothing has been logged for nearly two cycles, the estimate moves on
  instead of counting ever more days late, and says it has assumed a period
  went unlogged. History points out gaps long enough to hide a missed period.

### Changed
- A period with no end logged stops counting as "in progress" after two
  weeks; the home screen offers to add the end instead.
- Reminders are rescheduled whenever Ebb comes back to the screen, and in the
  phone's current time zone, so they follow you when you travel.
- Restoring a backup checks it more strictly: overlapping periods, anything
  dated after the backup was made, and blank, overlong or duplicate names are
  refused.
- "How Ebb works" explains when reminders are set and what can delay them.
- "My period started today" is checked like a back-dated start, so it can't
  overlap a period that ended today.

### Fixed
- Restoring a backup with an unnamed second person no longer crashes; they
  arrive as "Person 2".
- After a restore or "Delete all data", a newly numbered person no longer
  inherits an earlier person's reminder settings. "Delete all data" now
  clears every preference too.
- Backups include day logs whatever their date.
- Backup and restore report a clear error on phones with no file picker,
  instead of reporting "busy" on every later attempt.
- A misread QR frame can no longer freeze the Receive screen.

## [0.1.0] - 2026-09-20

### Added
- Log a period with one tap, or on an earlier day; add and correct past
  periods in History.
- Next-period estimate shown as a range with a stated confidence, from a
  shrinkage-weighted median of recent cycles.
- Mark a cycle as not counted in predictions (illness, medication, a
  pregnancy loss) while keeping it in history.
- Local reminders before a period is expected; no network involved.
- Optional fertile-window estimate, off by default, clearly not
  contraception.
- Back up to and restore from a plain, documented JSON file.
- Move history to another phone as a series of QR codes.
- Track more than one person on a phone, and hand someone's history over to
  their own phone.
- "How Ebb works" help and a "Your data" explainer, both in the app.
- Cycle ring on the home screen, light and dark themes, logo and launcher
  icon.
- Tablet layouts: a readable centred column on every screen, and a
  two-column home screen (ring beside the estimate) on wide screens.
- The installed version and a SuperDaveLab credit at the bottom of Settings,
  for bug reports.

### Privacy
- Release builds have no `INTERNET` permission. The full list is
  notifications, restarting reminders after a reboot, vibration, and the
  camera (only while receiving from another phone).
- Excluded from Android cloud backup and device-to-device transfer.
