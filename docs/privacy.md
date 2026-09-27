# What "private" means in Ebb

This document exists because the word "privacy" pulls in two very different
directions, and Ebb only means one of them. Read this before writing code,
copy, or UI for this project.

## What we mean

**The data belongs to the user. We never receive it, so we cannot sell it,
share it, hand it over, lose it in a breach, or look at it ourselves.**

That is the whole claim. It is a statement about *our* obligations and *our*
architecture. It is deliberately boring.

Concretely:

- Everything logged is written to a SQLite database on the device and nowhere
  else.
- There is no account, no login, no server, no sync, and no telemetry.
- The release build ships without the `INTERNET` permission, so Android itself
  prevents the app from sending anything anywhere. The promise is enforced by
  the operating system, not by our good intentions.
- The app is MIT-licensed and open source, so the claim is auditable by anyone
  who cares to check.

## What we do NOT mean

**Ebb is not secret software. It is not a vault, a decoy, or something to be
hidden from the people around her.**

Menstruation is a normal biological process experienced by roughly half the
population. An app that treats it as a secret — that whispers, obfuscates,
disguises its own icon, or defaults to a lock screen — is not protecting the
user. It is telling her that her own body is something shameful, and it is
importing a stigma that we have no business adding to a utility app.

So Ebb does not:

- Disguise its name, icon, or notification text.
- Default to requiring a PIN or biometric unlock.
- Use euphemism in its copy where a plain word will do.
- Frame the user as being under threat, surveilled, or in danger.
- Market itself on fear.

### The failure mode to watch for

The specific drift to guard against is reasoning that starts with a
seizure/surveillance threat model — "what if someone takes her phone", "what if
a bystander glances at her home screen" — and then lets that threat model drive
naming, iconography, notification copy, or default security posture.

That reasoning produces a worse product *and* a more insulting one. It is not
the brief. If a design decision only makes sense under the assumption that the
user is hiding from someone, it is the wrong decision for Ebb.

## Where the line actually falls

Some choices look like secrecy but are really about keeping the core promise
literally true. These are fine:

| Choice | Why it's in scope |
|---|---|
| No `INTERNET` permission | The data genuinely cannot leave. |
| `allowBackup="false"` + data extraction rules | Otherwise Android silently copies the database to the user's cloud backup, which would make "it stays on this phone" false. |
| No analytics or crash reporting SDKs | Those are exactly the channels that leak health data to third parties. |
| Local-only notifications | Push would require a server that knows her cycle dates. |
| Explicit user-initiated export | She can move her own data; we just never do it for her. Backups go through Android's own Save picker, so she chooses where. |
| QR phone-to-phone transfer | Moves history without a network: one screen, one camera. Costs `CAMERA`, requested only when she taps Receive; frames are read and discarded. |
| Unused plugin permissions stripped | Camera and image plugins merge in audio, storage and network-state permissions Ebb never uses. They're removed in the manifest so the list reads as exactly what the app does. |

And these are out of scope unless a real user asks for them:

| Choice | Why it's out |
|---|---|
| App lock / PIN by default | Implies shame. Offer it as an *option* if users ask; never a default. |
| Generic app name or icon | Same. |
| Contentless notifications | Same. A reminder can say what it is. |
| Encrypted-at-rest database by default | Adds a passphrase prompt that says "this is dangerous". Revisit only if users ask. |

## Tone guide for user-facing copy

- Plain, warm, unembarrassed. "Your period is expected today," not "your event
  is approaching."
- Matter-of-fact about uncertainty. Cycles vary; say so rather than projecting
  false confidence.
- Never assume why she is tracking. Trying to conceive, trying to avoid it,
  managing symptoms, watching for perimenopause, or plain curiosity are all
  equally valid, and the app should not guess.
- The privacy message is a *reassurance*, not a warning. Compare:
  - Good: "Your cycle is your business. Ebb keeps it on your phone."
  - Bad: "Protect yourself. Don't let them track your cycle."

## The honest trade-off

Local-only has a real cost, and we state it plainly rather than burying it:
**if she loses her phone, she loses her history.** There is no cloud backup to
restore from, because a cloud backup is exactly the thing we promised not to
build. The mitigation is an easy, obvious, user-initiated export — not a
silent one: a backup file she saves where she likes, or a transfer to another
phone she holds in her hand.
