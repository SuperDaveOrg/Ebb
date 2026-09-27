# Ebb backup format

A backup is one UTF-8 JSON file. It is meant to be readable in a text editor
and importable by any other tool, so nobody is locked into Ebb. This document
is the contract; [`lib/data/backup.dart`](../lib/data/backup.dart) is one
implementation of it.

Ebb never writes a backup on its own. The user chooses **Settings → Back up to a
file**, and Android's own Save picker decides where it goes.

## Example

```json
{
  "ebbBackup": 1,
  "exportedOn": "2026-09-26",
  "people": [
    {
      "name": null,
      "cycles": [
        { "start": "2026-03-01", "end": "2026-03-05" },
        { "start": "2026-03-29", "excluded": true, "notes": "flu" }
      ],
      "days": [
        { "date": "2026-03-02", "flow": "heavy", "symptoms": ["cramps"], "notes": "long day" }
      ]
    }
  ]
}
```

## Fields

All dates are calendar days written as `YYYY-MM-DD`, with no time or time zone.
A cycle is a day in someone's life, not an instant.

### Top level

| Field | Type | Meaning |
|---|---|---|
| `ebbBackup` | integer, required | Format version. Currently `1`. |
| `exportedOn` | date, required | The day the backup was made. |
| `people` | array, required, non-empty | One entry per person tracked on the phone. |

### Person

| Field | Type | Meaning |
|---|---|---|
| `name` | string or null | Null for the phone's owner. A name only appears when one phone tracks more than one person. 1–30 characters, no leading or trailing spaces, and no two people in a file may share one (ignoring case). |
| `cycles` | array, required | Recorded periods, oldest first. |
| `days` | array, optional | Daily notes, oldest first. |

The first person is the phone's owner and becomes the person the app shows
after a restore. Anyone after the first is always called by name in Ebb, so
one whose `name` is null (Ebb never writes this, but the format allows it) is
restored as "Person 2", "Person 3" and so on, skipping names already in the
file. It can be renamed in their settings.

### Cycle

| Field | Type | Meaning |
|---|---|---|
| `start` | date, required | First day of bleeding. Unique per person. |
| `end` | date, optional | Last day of bleeding. Absent if it wasn't recorded, or the period is ongoing. Never before `start`. |
| `excluded` | boolean, optional | `true` if the cycle is left out of predictions (illness, a medication change, a pregnancy loss). Absent means `false`. |
| `notes` | string, optional | Free text. |

Periods may not overlap: each `start` must come after the previous period's
`end`, when that is recorded.

Cycle *length* is not stored. It is always derived as the number of days from
one `start` to the next.

### Day

| Field | Type | Meaning |
|---|---|---|
| `date` | date, required | Unique per person. |
| `flow` | string, optional | One of `spotting`, `light`, `medium`, `heavy`. Absent means none. |
| `symptoms` | array of strings, optional | Free text, in the user's own words. Each must be non-empty and contain no tab character. |
| `notes` | string, optional | Free text. |

## Compatibility rules

- **Readers must reject the whole file** rather than import part of it. Ebb
  validates everything before changing anything, and restores in a single
  transaction.
- A reader that sees an `ebbBackup` version newer than it understands must
  refuse the file, not guess.
- A new field that older readers can safely ignore does **not** need a new
  version. Anything that changes the meaning of an existing field does.
- Nothing may be dated after `exportedOn`: a backup can't record a day that
  hadn't happened when it was made.
- Unknown values are errors, not defaults. For example, an unrecognised `flow`
  rejects the file instead of being quietly read as "none".

## What a backup does not contain

Preferences such as reminder timing or the fertile-window setting are not
included. A backup holds the user's history; settings take seconds to redo on a new
phone.
