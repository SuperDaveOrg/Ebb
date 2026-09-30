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
  "ebbBackup": 2,
  "exportedOn": "2026-09-26",
  "people": [
    {
      "name": null,
      "cycles": [
        { "start": "2026-03-01", "end": "2026-03-05" },
        { "start": "2026-03-29", "excluded": true, "notes": "flu" }
      ],
      "days": [
        { "date": "2026-03-02", "flow": "heavy", "symptoms": ["cramps"], "notes": "long day", "rating": 2, "feeling": "tired" }
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
| `ebbBackup` | integer, required | Format version. Currently `2`; see [Versions](#versions). |
| `exportedOn` | date, required | The day the backup was made. |
| `people` | array, required, non-empty | One entry per person tracked on the phone. |
| `groups` | array, optional | Named groups of people, from the advanced groups option. Absent when there are none. Version 2 and later. |

### Person

| Field | Type | Meaning |
|---|---|---|
| `name` | string or null | Null for the phone's owner. A name only appears when one phone tracks more than one person. 1–30 characters, no leading or trailing spaces, and no two people in a file may share one (ignoring case). |
| `cycles` | array, required | Recorded periods, oldest first. |
| `days` | array, optional | Daily notes, oldest first. |
| `id` | string, optional | A lasting id for the person, 1–64 letters, digits, `_` or `-`, unique within the file. Carried so that when the same person is sent again, the receiving phone can offer to update her rather than add her twice. Ebb makes one for everyone; a person without one is given a new one on restore. Version 2 and later. |
| `sharedOn` | date, optional | Present when this person is a read-only copy of someone's history from her own phone (the groups option): the day it was sent. Not after `exportedOn`. Ignored for the first person, who is the phone's owner and never a copy. Version 2 and later. |

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
| `rating` | integer, optional | How the day went, from `1` (rough) to `5` (great). Absent means not rated, which is not the same as `3`. Anything other than a whole number from 1 to 5 rejects the file. Version 2 and later. |
| `feeling` | string, optional | How the person felt. Either one of the named feelings — `happy`, `calm`, `loving`, `energetic`, `tired`, `sad`, `anxious`, `irritable`, `angry`, `confused` — written as the name, never as the emoji Ebb shows for it; or any other face, written as the emoji itself (`"👽"`), which means whatever it means to that person. A face is at most 16 UTF-16 code units, with no ASCII and no whitespace; it need not be one Ebb offers, so faces added to Ebb later still restore in older versions. Names are ASCII and faces never are, so the two can't be confused. Absent means none picked. Anything else rejects the file. Version 2 and later. |

### Group

| Field | Type | Meaning |
|---|---|---|
| `name` | string, required | 1–30 characters, no leading or trailing spaces. No two groups in a file may share one (ignoring case). |
| `members` | array of integers, required | The people in the group, each given by its place in `people` (0 for the first). Each must be a place that exists, at most once. May be empty. |

A group is only a label: a person can be in several, or in none. A backup
of one person, which is what Ebb sends to her own phone, never includes
groups; they're the arrangement on the sending phone, not part of her
history.

## Compatibility rules

- **Readers must reject the whole file** rather than import part of it. Ebb
  validates everything before changing anything, and restores in a single
  transaction.
- A reader that sees an `ebbBackup` version newer than it understands must
  refuse the file, not guess.
- A new field that older readers can safely ignore does **not** need a new
  version. Anything that changes the meaning of an existing field does, and
  so does a new field holding something the user recorded: ignoring it would
  lose it without a word.
- Nothing may be dated after `exportedOn`: a backup can't record a day that
  hadn't happened when it was made.
- Unknown values are errors, not defaults. For example, an unrecognised `flow`
  rejects the file instead of being quietly read as "none".

## Versions

| Version | Change |
|---|---|
| `1` | The first format. |
| `2` | Added a day's `rating` and `feeling`, `groups`, and a person's `id` and `sharedOn`. Older readers ignore fields they don't know, so an Ebb that only understood version 1 would have restored a file with either and silently dropped them. The version was raised so that it refuses the file instead. Ebb still reads version 1. |

## What a backup does not contain

Preferences such as reminder timing or the fertile-window setting are not
included. A backup holds the user's history; settings take seconds to redo on a new
phone.
