import 'dart:ui' show PlatformDispatcher;

import 'package:flutter/material.dart';

import 'package:ebb/data/cycle_repository.dart';
import 'package:ebb/data/database.dart';
import 'package:ebb/data/profile_repository.dart';
import 'package:ebb/l10n/app_localizations.dart';
import 'package:ebb/models/profile.dart';
import 'package:ebb/services/notification_service.dart';
import 'package:ebb/services/reminder_sync.dart';
import 'package:ebb/services/settings_service.dart';
import 'package:ebb/ui/home_screen.dart';
import 'package:ebb/ui/language.dart';
import 'package:ebb/ui/people.dart';
import 'package:ebb/ui/theme.dart';
import 'package:ebb/ui/wording.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  chosenLanguage.value = await SettingsService.language();
  await useLanguage(
    resolveLanguage(chosenLanguage.value, PlatformDispatcher.instance.locales),
  );
  final notifications = NotificationService();
  await notifications.init();

  final people = await ProfileRepository().all();
  final lastId = await SettingsService.lastActiveProfile();

  runApp(
    EbbApp(
      notifications: notifications,
      people: people,
      initial: people.firstWhere(
        (p) => p.id == lastId,
        orElse: () => people.first,
      ),
    ),
  );
}

/// Holds whose cycle is on screen. With one person — the usual case — that
/// never changes and nothing about people appears in the UI at all.
class EbbApp extends StatefulWidget {
  const EbbApp({
    super.key,
    required this.notifications,
    required this.people,
    required this.initial,
  });

  final NotificationService notifications;
  final List<Profile> people;
  final Profile initial;

  @override
  State<EbbApp> createState() => _EbbAppState();
}

class _EbbAppState extends State<EbbApp> {
  final _profiles = ProfileRepository();
  final _navigator = GlobalKey<NavigatorState>();

  late List<Profile> _people = widget.people;
  late Profile _current = widget.initial;

  void _switchTo(Profile profile) {
    setState(() => _current = profile);
    SettingsService.setLastActiveProfile(profile.id!);
  }

  /// Re-reads the people after anything that may have added, renamed or
  /// removed someone — including a restore or "delete all". Falls back to the
  /// owner if the person on screen no longer exists.
  Future<void> _reloadPeople({int? show}) async {
    final people = await _profiles.all();
    final current = people.firstWhere(
      (p) => p.id == (show ?? _current.id),
      orElse: () =>
          people.firstWhere((p) => p.id == EbbDatabase.primaryProfileId),
    );
    setState(() => _people = people);
    _switchTo(current);
  }

  Future<void> _addPerson() async {
    final context = _navigator.currentContext!;
    final name = await showNameDialog(
      context,
      title: context.l.peopleTrackSomeoneElse,
      others: _people,
      hint: context.l.peopleNameHint,
    );
    if (name == null || name.isEmpty) return;
    final id = await _profiles.add(Profile(name: name));
    await _reloadPeople();
    _switchTo(_people.firstWhere((p) => p.id == id));
  }

  /// Keeps the words outside the widgets — reminders, backups, labels — in
  /// the language on screen. Reminders say things, so a change reschedules
  /// them, after this frame.
  void _languageOnScreen(Locale locale) {
    if (locale.languageCode == strings.localeName) return;
    useLanguage(locale);
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => syncAllReminders(widget.notifications),
    );
  }

  @override
  Widget build(BuildContext context) {
    final id = _current.id!;
    return ValueListenableBuilder(
      valueListenable: chosenLanguage,
      builder: (context, chosen, _) => MaterialApp(
        title: 'Ebb',
        navigatorKey: _navigator,
        debugShowCheckedModeBanner: false,
        theme: EbbTheme.lightTheme(),
        darkTheme: EbbTheme.darkTheme(),
        // Null follows the phone, among the languages Ebb speaks.
        locale: chosen == null ? null : Locale(chosen),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        builder: (context, child) {
          _languageOnScreen(Localizations.localeOf(context));
          return child!;
        },
        home: HomeScreen(
          // A new key per person, so switching starts from a fresh screen
          // rather than carrying one person's state into another's.
          key: ValueKey(id),
          profile: _current,
          people: _people,
          repository: CycleRepository(profileId: id),
          settings: SettingsService(profileId: id),
          notifications: widget.notifications,
          onSwitch: _switchTo,
          onAddPerson: _addPerson,
          onPeopleChanged: _reloadPeople,
        ),
      ),
    );
  }
}
