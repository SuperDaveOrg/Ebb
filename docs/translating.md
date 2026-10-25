# Translating Ebb

Ebb speaks English, German, Spanish, French, Italian, Portuguese (Portugal)
and Russian, the same languages as Nexpill. This is how the words are kept,
how to add a language, and what a translation has to get right.

## Where the words are

Every word the app shows is in `lib/l10n/app_<language>.arb`: plain JSON,
one message per key. `app_en.arb` is the template; each other file
translates every one of its keys. Flutter's `gen-l10n` (set up in
`l10n.yaml`, run by any `flutter` build or `flutter gen-l10n`) turns them
into `AppLocalizations` in `lib/l10n/`. The generated `.dart` files are
committed, so a fresh checkout analyzes without a build first.

Two ways in, both the same words:

- **Screens** use `context.l` (from `lib/ui/language.dart`), so they rebuild
  when the language changes.
- **Everything outside the widgets** — reminders, backup errors, labels
  read outside a screen — uses the `strings` global in `lib/ui/wording.dart`.
  The app sets it, and the language dates are written in, as the language
  on screen changes. Reminders contain words, so a language change
  reschedules them.

`domain/` and `models/` hold no words at all: they return values, and the UI
says them.

The language follows the phone unless one is picked in Settings → Language.
On Android 13 and later it can also be set per app in the phone's settings,
from `android/app/src/main/res/xml/locales_config.xml`.

Not translated, on purpose: the brand name, the backup file's field names
(they're the public format), file names, the emoji faces, and anything the
user typed — names and notes.

## Translating on Weblate

The easiest way to help is [Hosted Weblate](https://hosted.weblate.org/projects/ebb/),
a web editor that needs no Git or Flutter. Sign in, pick a language, and
fix what reads wrongly. Under most strings a note says which screen it's
on and what it must mean; the `description` entries in `app_en.arb` are
those notes, so add one whenever a new string could be misread. Weblate
checks placeholders, `select` and plural forms as you type (ICU
MessageFormat), and translators can comment on a string, or on the English.

| Component | Files | What it is |
|---|---|---|
| App | `lib/l10n/app_*.arb` | Every word in the app. |
| Store listing | `fastlane/metadata/android/*/` | The title and descriptions F-Droid shows. |

**How changes come back.** Weblate commits each translator's work under
their own name and opens a pull request against `main` (one per
component, updated until it's merged). To merge one:

1. CI runs the usual checks; `flutter test test/translations_test.dart`
   is the one that matters here.
2. If it adds a language, do steps 2 and 3 below first; the test fails
   until the language is in both lists. Merge a new language once it's
   complete: `gen-l10n` quietly fills gaps with English, which is exactly
   what the test is there to refuse.
3. Merge with a merge commit, not a squash. Weblate matches its commits
   against `main`, and a squash leaves it to rebase.
4. Run `flutter gen-l10n`, which rewrites the generated `.dart` files in
   `lib/l10n/`, and commit them.

Don't edit a translated `.arb` on `main` while Weblate has unmerged
changes; lock the component on Weblate first (Manage → Repository
maintenance), or the two conflict. The English still changes here, in
`app_en.arb`: Weblate picks it up on the next push to `main` and marks the
affected translations for attention.

**Weblate settings**, should they ever need recreating: the same as
Nexpill's, recorded in its `docs/translating.md`. Project `ebb`, licence
GPL-3.0-or-later, source language English, repository
`https://github.com/SuperDaveOrg/Ebb.git` on `main` through the Hosted
Weblate GitHub app. App component: ARB file, mask `lib/l10n/app_*.arb`,
base `lib/l10n/app_en.arb`, JSON indent 2, base file not editable. Store
listing: App store metadata files, mask `fastlane/metadata/android/*`,
base and new-translation template `fastlane/metadata/android/en-US`, BCP
language codes with hyphen, key filter `^(?!changelogs/)`.

## Adding a language

1. On Weblate, open the App component and choose *Start new translation*.
   It creates `lib/l10n/app_<code>.arb` and the usual pull request. (By
   hand instead: copy `app_en.arb` to `app_<code>.arb`, set `"@@locale"`,
   delete the `@` entries, and translate every message.)
2. Add the language, by its own name, to `languageNames` in
   `lib/ui/language.dart`.
3. Add it to `android/app/src/main/res/xml/locales_config.xml`.
4. `flutter test test/translations_test.dart`: it fails if a message is
   missing, has a placeholder the English doesn't, or the language is
   missing from either list.
5. Have a native speaker check it in the running app before it ships (see
   below), and say so in the CHANGELOG.

## Getting it right

**Ebb never claims to know more than it does.** A translation that turns
"expected" into "will start", or a range into a date, changes what the app
promises. The words that must keep their meaning:

| English | Means |
|---|---|
| period | the days of bleeding — the plain everyday word, never a euphemism |
| cycle | first day of one period to the first day of the next |
| expected / likely between | an estimate, never a promise; Ebb gives a range and says how sure it is |
| late | not started by when it was expected; a plain fact, never alarming |
| fertile window estimate | rough, from timing alone; must never read as reliable contraception |
| spotting | light bleeding, apart from a period's flow |
| cervical mucus, and its categories | the usual terms in that language, as a doctor or a fertility-awareness guide would say them |

Other rules:

- **Plain and calm**, as in [privacy.md](privacy.md). Menstruation is
  ordinary: no euphemisms, no clinical distance, nothing that sounds
  embarrassed or secretive. No medical advice, in any language.
- **Whole sentences.** Each message is a complete phrase with placeholders
  (`{date}`, `{name}`), never pieces glued together, because word order
  differs. Keep every placeholder.
- **You, or someone by name.** A message about the person on screen has two
  forms, chosen by `{who, select, you{…} other{…}}`: one for the phone's
  owner ("your period") and one naming someone else they track ("Sam's
  period"). Write both whole. Never use a pronoun for the other person — Ebb
  doesn't know their pronouns — and in a language with cases (Russian), use
  constructions that don't inflect the name: names are typed by the user.
- **Plurals** use ICU syntax: `{count, plural, =1{…} other{…}}`. Languages
  with more forms add them (`one`, `few`, `many`; Russian needs all three).
- **"You" the way phone apps say it** in that language, consistently:
  *tú* in Spanish, *tu* in Italian, *vous* in French, *вы* in Russian, the
  impersonal style usual in European Portuguese, and in German whatever
  Android's own German uses.
- **Dates** are written by `intl` in the language's own way; a message gets
  them already formatted.

## Status

| Language | State |
|---|---|
| English | The source. |
| German | First draft, written with an AI assistant. **Needs review by a native speaker before release**, like every language below; the place to do it is [Weblate](https://hosted.weblate.org/projects/ebb/). |
| Spanish | The same. |
| French | The same. |
| Italian | The same. |
| Portuguese (Portugal) | The same. The file is plain `pt`, so Brazilian phones get it too; Brazilian Portuguese would be its own `app_pt_BR.arb`. |
| Russian | The same. |

Testers find the current preview at ebb.superdavelab.com/beta/; see
"Previews" in [RELEASING.md](RELEASING.md). Checking in the running app and
fixing on Weblate go together: the preview shows the words in place, Weblate
is where the fix goes.
