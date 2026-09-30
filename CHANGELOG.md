# Changelog

What changed in each release of Ebb, newest first. The format follows
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and versions follow
the rules in [docs/RELEASING.md](docs/RELEASING.md).

New entries go under **Unreleased** as work lands; `tool/bump_version.sh`
turns that section into the release's own when it's cut.

## [Unreleased]

## [0.6.0] - 2026-09-29

### Added
- Moon phases on the calendar, if you want them: turn on Settings → Show
  moon phases. New, first quarter, full and last quarter moons are marked
  on the day they fall, and tapping the day shows the time. They're worked
  out on the phone, like everything else.
- Rate how a day went, from 1 (rough) to 5 (great): tap a day on the
  calendar and pick a number under "Rate your day, 1–5". Tap it again to
  clear it.
- Pick how you felt, too: one face under "How did you feel?", separate
  from how the day went. A rough day can still be a calm one. Ten are
  named, and More faces has fifty others — cats, an alien, a rain cloud —
  for whatever they mean to you. The face you pick shows on the calendar,
  tiny, at the top right of the day.
- Charts, from the chart icon on the home screen: each day's rating over
  whatever dates you choose, as bars or a line, with periods shaded; and
  which feelings you picked during periods, in the days before one, and on
  other days.
- With moon phases turned on, the charts show them too: moons above the
  day ratings, and feelings around full and new moons.
- Groups, for circles and clubs that track together: turn on Settings →
  Advanced → Groups, then gather people under a name. Someone can be in
  more than one group, and deleting a group never deletes anyone. With
  groups on, the people switcher lists everyone under their groups, and
  "See … together" shows a group side by side: a lane each, periods as
  bars over the dates you choose, with the moon along the top and lines
  down from each full and new moon. Off by default, and nothing changes for
  anyone who doesn't turn it on.
- Receiving someone who's already on the phone now offers to update them
  instead of adding them twice.
- A group's members can be added (tracked on this phone, and logged for
  here) or imported from their own phone: read-only here, with no
  reminders, still theirs, and brought up to date when they send it
  again.
- Sending one person to another phone now asks how much: everything, the
  last year, 6 or 3 months, or just the latest period; with daily notes,
  ratings and feelings, or periods only. Everything is still the default.

### Changed
- Backups now include day ratings, feelings and groups, so they're written
  in a new version of the backup format. An older Ebb will ask to be
  updated before it restores one, rather than quietly dropping them. Older
  backups still restore as before.
- On the calendar, a pencil under the date now means the day has a note,
  and a dot means it's rated. A day with neither is one still to rate.
- The calendar reaches back a month before the earliest thing you've
  logged, so a history can be filled in month by month.
- The actions on a calendar day read as things to do: "Mark as the day your
  period started" rather than "My period started this day", which looked
  like a record of what happened.

### Fixed
- Tapping a day just before a logged period and choosing that the period
  started there added a second, day-long period. It now offers "Make this
  the first day of the period", which moves the start back instead.

## [0.5.1] - 2026-09-29

### Changed
- Smaller downloads from F-Droid: it now offers an APK built for your phone's
  processor, about a third of the size of the one that runs on any phone.
  The website still offers that universal APK, and each release's APKs are
  all on its GitHub release page.

## [0.5.0] - 2026-09-29

### Added
- Settings → About has links to Ebb's website and its feedback form. They
  open in your browser; Ebb itself still has no internet permission.

## [0.4.0] - 2026-09-28

### Changed
- Ebb is now licensed under the GNU General Public License, version 3 or
  later. Versions up to and including 0.3.0 remain available under the MIT
  licence.

## [0.3.0] - 2026-09-27

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
