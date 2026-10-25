import 'dart:ui' show Locale;

import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'package:ebb/data/database.dart';
import 'package:ebb/l10n/app_localizations.dart';
import 'package:ebb/models/profile.dart';

/// The app's words, in the language on screen, for code that has no
/// BuildContext: reminders, backups, model labels. The app sets it with
/// [useLanguage] as the language on screen changes. English until then, as
/// in tests.
AppLocalizations strings = lookupAppLocalizations(const Locale('en'));

/// Switches [strings], and the way dates are written, to [locale], which
/// must be one of [AppLocalizations.supportedLocales].
Future<void> useLanguage(Locale locale) async {
  strings = lookupAppLocalizations(locale);
  Intl.defaultLocale = strings.localeName;
  await initializeDateFormatting(strings.localeName);
}

/// A name from a list, for use mid-sentence: "felt anxious". Lower case,
/// except in German, where a noun keeps its capital.
String midSentence(String name) =>
    strings.localeName == 'de' ? name : name.toLowerCase();

/// How the app refers to the person whose cycle is on screen.
///
/// The phone's owner is always "you", even after setting a name — the name
/// only labels them in the people switcher. Anyone else is called by name,
/// never by a pronoun: the app doesn't know their pronouns and shouldn't
/// guess.
///
/// A message that names the person takes [who] and [name], and chooses
/// between its two forms with `{who, select, you{…} other{…{name}…}}`, so
/// each language words both whole.
class Who {
  Who(Profile profile)
    : isOwner = profile.id == EbbDatabase.primaryProfileId,
      _name = profile.name;

  final bool isOwner;
  final String? _name;

  /// For the switcher: the owner's chosen name, or "You".
  static String label(Profile p) =>
      p.name ?? (p.id == EbbDatabase.primaryProfileId ? strings.you : '');

  /// The select value: "you" for the owner, "other" for anyone else.
  String get who => isOwner ? 'you' : 'other';

  /// Their name, for the "other" form. Empty for the owner, whose form
  /// never uses it.
  String get name => _name ?? '';
}
