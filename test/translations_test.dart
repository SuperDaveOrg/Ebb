import 'dart:convert';
import 'dart:io';
import 'dart:ui' show Locale;

import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:ebb/data/database.dart';
import 'package:ebb/l10n/app_localizations.dart';
import 'package:ebb/models/profile.dart';
import 'package:ebb/ui/language.dart';
import 'package:ebb/ui/wording.dart';

/// Every language says everything English does, with the same blanks to
/// fill, and is offered everywhere Ebb lists its languages.
void main() {
  Map<String, dynamic> arb(String code) =>
      jsonDecode(File('lib/l10n/app_$code.arb').readAsStringSync())
          as Map<String, dynamic>;
  final english = arb('en');
  final keys = {for (final k in english.keys) if (!k.startsWith('@')) k};
  final codes = [
    for (final l in AppLocalizations.supportedLocales) l.languageCode,
  ];

  /// The names filled in, as the English declares them: "count" for
  /// "{count}" or "{count, plural, ...}". Not the text of a select's
  /// branches, which can look like one ("dry{dry}").
  Set<String> blanks(String key, String message) => {
    for (final name
        in ((english['@$key'] as Map?)?['placeholders'] as Map?)?.keys ??
            const <String>[])
      if (RegExp('\\{$name[,}]').hasMatch(message)) name as String,
  };

  for (final code in codes.where((c) => c != 'en')) {
    group(code, () {
      final translated = arb(code);

      test('has every message, and nothing English lacks', () {
        final theirs = {
          for (final k in translated.keys) if (!k.startsWith('@')) k,
        };
        expect(keys.difference(theirs), isEmpty, reason: 'untranslated');
        expect(theirs.difference(keys), isEmpty, reason: 'not in English');
      });

      test('fills in the same blanks', () {
        for (final k in keys) {
          expect(blanks(k, translated[k] as String),
              blanks(k, english[k] as String),
              reason: k);
        }
      });
    });
  }

  // Each language's plural rule decides which form a count gets, and they
  // differ: French puts 0 with 1, Russian puts 21 with 1. A form written
  // for exactly one ("1 dose left", "its only dose") would then say the
  // wrong number, so any count but 1 must show its own number.
  test('every plural shows the right number, in every language', () {
    const counts = [0, 1, 2, 3, 5, 11, 21, 22, 25, 101];
    final wrong = <String>[];
    for (final code in codes) {
      final messages = arb(code);
      for (final k in keys) {
        final plural = _plural(messages[k] as String);
        if (plural == null) continue;
        final (name, forms) = plural;
        for (final n in counts.where((n) => n != 1)) {
          // As the generated code picks: "=1" and "one" are the same slot,
          // the later one written winning.
          final form = Intl.pluralLogic(n,
              zero: forms['=0'] ?? forms['zero'],
              one: forms['one'] ?? forms['=1'],
              two: forms['=2'] ?? forms['two'],
              few: forms['few'],
              many: forms['many'],
              other: forms['other']!,
              locale: code);
          if (!form.contains('{$name}')) wrong.add('$code $k($n): $form');
        }
      }
    }
    expect(wrong, isEmpty);
  });

  test('each language is named in Settings and offered to Android', () {
    expect(languageNames.keys.toSet(), codes.toSet());
    final config = File('android/app/src/main/res/xml/locales_config.xml')
        .readAsStringSync();
    // By language: Android lists Portuguese as pt-PT, which is what it is.
    final offered = {
      for (final m in RegExp(r'android:name="([\w-]+)"').allMatches(config))
        m[1]!.split('-').first,
    };
    expect(offered, codes.toSet());
  });

  test('the phone\'s language if Ebb speaks it, else English', () {
    expect(resolveLanguage(null, const [Locale('es', 'MX')]), const Locale('es'));
    expect(resolveLanguage(null, const [Locale('ja'), Locale('ru')]),
        const Locale('ru'));
    expect(resolveLanguage(null, const [Locale('ja')]), const Locale('en'));
    expect(resolveLanguage(null, const [Locale('pt', 'BR')]), const Locale('pt'));
    expect(resolveLanguage('es', const [Locale('en')]), const Locale('es'));
  });

  group('in Spanish', () {
    setUp(() => useLanguage(const Locale('es')));
    tearDown(() => useLanguage(const Locale('en')));

    test('reminders name the person, or speak to you', () {
      final you = Who(const Profile(id: EbbDatabase.primaryProfileId));
      final sam = Who(const Profile(id: 2, name: 'Sam'));
      expect(strings.notifTodayTitle(you.who, you.name), isNot(contains('Sam')));
      expect(strings.notifTodayTitle(sam.who, sam.name), contains('Sam'));
      expect(strings.notifUpcomingInDays(sam.who, sam.name, 3), contains('3'));
    });

    test('dates are written in Spanish', () {
      expect(DateFormat.MMMMd().format(DateTime(2026, 6, 10)), '10 de junio');
    });
  });
}

/// A message that is one plural, "{count, plural, =1{…} other{…}}", as its
/// count's name and each form by selector. Null for anything else.
(String, Map<String, String>)? _plural(String message) {
  final head = RegExp(r'^\{(\w+), plural,').firstMatch(message);
  if (head == null || !message.endsWith('}')) return null;
  final forms = <String, String>{};
  final body = message.substring(head.end, message.length - 1);
  var i = 0;
  while (i < body.length) {
    final selector = RegExp(r'\s*(=\d+|\w+)\{').matchAsPrefix(body, i);
    if (selector == null) break;
    var depth = 1, j = selector.end;
    for (; depth > 0; j++) {
      if (body[j] == '{') depth++;
      if (body[j] == '}') depth--;
    }
    forms[selector[1]!] = body.substring(selector.end, j - 1);
    i = j;
  }
  return (head[1]!, forms);
}
