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

## Adding a language

1. Copy `lib/l10n/app_en.arb` to `app_<code>.arb`, set `"@@locale"`, delete
   the `@` entries (only the template needs them), and translate every
   message.
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
| German | First draft, written with an AI assistant. **Needs review by a native speaker before release**, like every language below. |
| Spanish | The same. |
| French | The same. |
| Italian | The same. |
| Portuguese (Portugal) | The same. The file is plain `pt`, so Brazilian phones get it too; Brazilian Portuguese would be its own `app_pt_BR.arb`. |
| Russian | The same. |

Testers find the current preview at ebb.superdavelab.com/beta/; see
"Previews" in [RELEASING.md](RELEASING.md).
