# Ebb — feature roadmap

A working list of what Ebb does, what it should probably do next, and what it
deliberately won't do. Feedback is welcome.

Priorities below are informed by published research on what users actually
complain about in existing trackers (sources at the bottom), but **none of this
is settled.** Anything marked 🟡 explicitly needs input from someone who
actually uses a period tracker.

---

## Built

| Feature | Notes |
|---|---|
| Log period start / end | One tap from the home screen, or back-dated with a date picker. |
| Cycle prediction | Shrinkage-weighted median of recent cycles. |
| Honest uncertainty | Shows a date *range* plus a stated confidence level. |
| Cycle history | List of past cycles with lengths; editable and deletable. Past periods can be added, so a new user isn't starting from zero. |
| Retroactive editing | Start and end dates can be corrected after the fact; overlaps and future dates are caught before saving. |
| "Don't count this cycle" | A cycle can be excluded from prediction while staying in history. Its start still bounds the cycle before it, so neighbours aren't merged into one long gap. |
| Backup and restore | User-initiated, through Android's own Save/Open pickers — no storage permission, no plugin. Plain JSON, [documented](backup-format.md). Restore validates the whole file first and replaces everything in one transaction. |
| Phone-to-phone transfer | **Settings → Send / Receive.** The backup, gzipped, split into a cycling series of QR codes (Base45, RFC 9285). Two years of daily notes for two people is 3 codes. Scanned in any order; restored with the same confirmation as a file. Scanner is zxing-cpp via `flutter_zxing` — open source, no Play services. Adds `CAMERA`, asked for only on Receive. |
| More than one person | Added from Settings; the home title becomes a switcher once there are two. Invisible with one person. See below. |
| Local reminders | Configurable lead time, fires with no network. |
| Fertile-window estimate | **Off by default.** Clearly labelled as not contraception. |
| Delete all data | Immediate and complete. |
| "Your data" explainer | Plain-language screen describing where data lives. |
| Calendar view | Added after v0.2.0 build. Provides good visualization and easy editing of past periods in a point-and-click UX |
| Day rating | Asked for by users. An optional "Rate your day, 1–5" on any past day, picked as a number with "Rough" and "Great" at the ends, and stored as the number so it can be charted later. Numbers rather than faces, so a face always means a feeling, on the sheet and on the calendar. No rating is not a 3; tapping the chosen number clears it. Added in backup format version 2, so an older Ebb refuses the file instead of dropping ratings. Not shown on the calendar. |
| "How did you feel?" | Asked for by users, separately from the day rating. One face per day. Ten named feelings first (happy, calm, loving, energetic, tired, sad, anxious, irritable, angry, confused), stored by name (`"anxious"`) since their meaning is shared. **More faces** opens a curated fifty — cats, an alien, a storm cloud, chocolate — stored as the emoji itself, because they mean whatever they mean to her. The chosen face shows tiny at the top right of the day on the calendar, mirroring the moon. The list can grow without a format change. Kinds of feeling rather than a scale, so never averaged. Worded as a feeling, never "mood". |
| Moon phases | Asked for by users. **Off by default** (Settings). New, first quarter, full and last quarter drawn in the corner of the day they fall on, locally; the day sheet gives the time. Computed on the phone (Meeus, ch. 49), accurate to under a minute. Display only: nothing suggests a link to the cycle, and nothing feeds the predictor. Drawn as seen from the northern hemisphere. |

---

## Near-term — the gaps that make it a real app

### 1. Daily logging beyond start/end

Flow, a note, a day rating and a feeling can be logged on any day from the
calendar, and users like it. Still to do: symptoms.

The calendar cell already carries a band, today's ring, a note dot and a
moon, and now a feeling; mock up a busy month before giving the rating a
mark there too.

**Design note:** symptoms are stored as free text rather than a fixed enum, on
purpose. A hardcoded list quietly tells the user which experiences count. A
suggested-but-editable vocabulary is probably the right compromise. 🟡

### 2. Calendar view - (added after v0.2.0)

The single most expected feature in this category and currently missing. A
month grid showing logged days, predicted days, and today.

---

## Worth considering

| Feature | Thinking |
|---|---|
| "Has your period ended?" nudge | A forgotten end date leaves a period open for weeks ("Day 34 of your period"). After ten or so days, ask gently rather than keep counting. Found while testing with sample data. |
| Charts over time | Cycle length and period length trends. Cheap to build, genuinely useful for spotting change. |
| Symptom patterns | "You often log headaches in the three days before." Needs care — pattern-spotting shades into medical claims fast. 🟡 |
| Predicted-vs-actual accuracy | Show how well Ebb has been doing. Builds trust, and makes the honesty structural. |
| Home screen widget | Day of cycle at a glance. Well-supported on Android. |
| Perimenopause support | Currently irregular cycles just widen the window. A dedicated mode might serve this better — it's a long, confusing transition badly served by most apps. 🟡 |
| Trying-to-conceive mode | Would change what's surfaced. Needs a real decision about whether Ebb serves this at all. 🟡 |
| Temperature / cervical mucus | The sympto-thermal method (what Drip uses) is substantially more accurate for ovulation than calendar math. Much bigger scope. 🟡 |
| Optional app lock | As an *option* for anyone who wants it — never a default. See the note below. |
| Multiple languages | Meaningful reach for very little ongoing cost. |

---

## Deliberately not doing

Worth being explicit about these.

| Not doing | Why |
|---|---|
| Accounts, cloud sync, "log in with Google" | The entire premise. Data that never leaves can't be sold or subpoenaed. |
| Analytics, crash reporting, ad SDKs | These are precisely how competitors leaked health data. |
| Premium tier, upsell prompts | Paywall nag is a top user complaint. |
| Feature creep beyond cycles | Users resent trackers that sprout calorie counting and unrelated wellness features. |
| Auto-logging a predicted period as actual | A specific, widely-reported bug in other apps: the app assumes the period arrived on schedule and corrupts the history. Ebb only records what the user tells it. |
| Pink-and-flowers styling | One of the most consistent complaints in the research. Ebb uses a muted, neutral palette. |
| Gendered assumptions in copy | Existing apps routinely assume the user is a woman and her partner is a man. Ebb's copy shouldn't assume either. |
| Duress PIN / disguised icon / decoy screens | Euki offers a duress PIN. It's a thoughtful feature for its threat model, but it's the wrong posture for Ebb — it frames the user's own body as something to hide. See [privacy.md](privacy.md). An ordinary optional app lock is fine; theatre isn't. |
| Medical advice or diagnosis | Ebb is a tracking tool. It can show patterns; it can't interpret them. |

---

## More than one person on a phone

A parent helping children learn their cycles is a real case, and retrofitting
it later would have meant changing the backup format after people had files in
it. So the storage is ready now and the UI isn't.

**Built:** every cycle and day log belongs to a profile. `CycleRepository`,
`SettingsService` and reminders are all scoped to one profile. The predictor
and validation rules never needed to know. There is always a primary profile
with no name, and while it's the only one the app looks and speaks exactly as
before ("your period"). A named profile's reminders say whose period it is.
The backup format holds a list of people from version 1.

**UI (built):** Settings → *Track someone else too* asks for a name only. With
two or more people the home title becomes a switcher; copy follows the
selected person by name, never by pronoun. The owner stays "You" (and is
addressed as "you") but may set a name. Decided:

- Fertile window: offered for the owner only, never for added people.
- Reminders: off by default for added people.
- Owner's name: optional, defaulting to "You".

**Handing over (built):** Send asks "Everyone" or one person. One person
received on an empty phone becomes its owner; on a phone with history, the
choice is "Add as someone new" (name pre-filled, clash-checked) or "Replace
everything". After sending someone, Done offers to remove them here — never
automatically. The same rules apply to restoring a one-person backup file.

**Not built:** backing up one person to a file (file backups are always
everyone), and merging several people into a phone that already has data.
Merging matters more once there's a desktop app: phone and laptop keep separate
histories, so today moving between them means replacing one with the other.

**Open questions:**

- **Age and tone.** Copy written for an adult may not suit a twelve-year-old
  with a parent reading along. Worth asking a parent who'd actually do this. 🟡

---

## Multi-device and desktop

Not near-term, but the shape is decided enough to write down.

### Desktop app

**Decided: Linux first, distributed through Flathub. Not started.** Windows
next if there's demand; macOS last (needs a Mac to build on and a paid Apple
Developer account for notarisation).

Flutter builds Linux, Windows and macOS from this same codebase. The predictor,
rules, backup format, QR encoding and nearly all of the UI port untouched. The
work, roughly two days for Linux:

| Piece | What it needs |
|---|---|
| Storage | `sqflite_common_ffi` on Linux/Windows (already a dev dependency for tests), SQLite bundled on Windows. The database must live somewhere that isn't synced — on Windows, not a OneDrive- or roaming-profile folder — or "it stays on this computer" quietly becomes false. The desktop equivalent of `allowBackup="false"`. |
| Layout | **Done for tablets**, and desktop reuses it: `lib/ui/layout.dart` keeps lists to a readable centred column, and the home screen goes two-column from 840 points wide. A third pane (History alongside) could come later. |
| Backup files | The Save/Open pickers are Android platform code. Desktop uses Flutter's own `file_selector` (FOSS). |
| Reminders | See below. |
| Packaging | Flatpak manifest for Flathub — with **no network permission** in the sandbox. |

**Privacy is harder to prove on desktop.** On Android the claim "Ebb *can't*
use the internet" is enforced by the OS and visible in the permission list.
Desktops mostly have no equivalent:

| Platform | Can "no network" be enforced? |
|---|---|
| Linux, Flatpak/Flathub | Yes — the sandbox gets no network, and Flathub shows that on the listing. The closest match to Android, which is why it's the chosen channel. |
| macOS, sandboxed | Yes — omit the network-client entitlement. |
| Windows | No meaningful equivalent for ordinary desktop apps. |
| Linux AppImage / .deb | No sandbox, no enforcement. |

The "Your data" screen and README must therefore say something
platform-accurate on desktop rather than reuse the Android wording. Where the
OS can't enforce it, the claim falls back to "open source — check the code",
and should say so.

### Background reminders on desktop

Reminders should fire whether or not the app is open, without a resident
process. `flutter_local_notifications` already schedules OS-held notifications
on **Windows and macOS**. On **Linux** it can only show notifications while the
app is running, so Linux needs its own mechanism:

- The app writes predicted reminder dates to a small local file.
- A `systemd --user` timer reads it and raises the notification.

Nothing resident, survives reboot, entirely local. Inside a Flatpak this needs
checking — the sandbox may have to use the Background portal instead of
installing a user timer directly.

### Getting data between devices

The constraint that decides this: **Android does not distinguish LAN from
internet.** Any socket — even phone-to-laptop over the user's own Wi-Fi —
requires the `INTERNET` permission, which would destroy the one claim no
competitor can match: that the permission list is empty and anyone can check it
in ten seconds.

So, in order of preference:

1. **QR handoff** *(built)* — one device displays a series of codes, the other
   reads them with its camera. Period dates alone are a few hundred bytes;
   with daily notes, two years is about 3 codes. Costs `CAMERA` on the
   scanning side only; never `INTERNET`. Laptop → phone already works (the
   laptop just shows the codes). Phone → laptop needs a webcam: fine on
   Windows/macOS, needs an extra camera plugin on Linux; otherwise it's a
   backup file.
2. **File export / import** — the baseline, now built.
   Zero new permissions. Clunky but completely honest, and the desktop app reads
   the same JSON.
3. **Local network sync** — rejected. Costs the `INTERNET` permission, and the
   verifiable-empty-permission-list property is worth more than the convenience.

### Explicitly not doing

Cloud sync, a hosted backend, or an account system — including the
"end-to-end encrypted blob store" variant where the server holds ciphertext it
cannot read. That design is legitimate and some good apps use it, but it would
trade a claim the user can verify themselves ("check the permissions") for one only
an expert can ("trust the cryptography"), and it means running paid
infrastructure forever. Revisit only with real evidence that users want
multi-device badly enough to pay that price.

---

## Open questions for review

1. **Is the fertile window useful or a liability?** Off by default today. Should
   it be more prominent, or removed entirely?
2. **What should the reminder actually say,** and how far ahead is useful?

---

## Sources

- [Experiences of users of period tracking apps (ScienceDirect, 2023)](https://www.sciencedirect.com/science/article/pii/S1472648323006983) — only 6.4% of users said their app always got the start date right; users reported anxiety and frustration when predictions missed.
- [Period-tracking apps get failing grade (STAT, 2017)](https://www.statnews.com/2017/05/02/period-tracking-apps-flaws/) and [the underlying UW study](https://washington.edu/news/2017/05/02/period-tracking-apps-failing-users-in-basic-ways-study-finds) — pink/floral design, gendered assumptions, no way to annotate an atypical cycle.
- [Period Tracking Apps: The Good and the Bad (Our Bodies Ourselves)](https://ourbodiesourselves.org/blog/period-tracking-apps-the-good-and-the-bad)
- [drip on F-Droid](https://f-droid.org/packages/com.drip/) — open-source, offline, sympto-thermal ovulation prediction.
- [Euki](https://eukiapp.org/) — local-only, no identifiers, duress PIN.
- [Privacy Guides: health and wellness apps](https://www.privacyguides.org/en/health-and-wellness/)
- [Flo vs Clue vs Stardust comparison (2026)](https://unstar.app/blog/flo-clue-stardust-apple-health-period-tracking-apps-ranked-2026) — Flo's FTC settlement and 2025 class action; Mozilla's July 2026 finding that Stardust's policy was revised twice in seven months, each time disclosing more ad-data sharing.
