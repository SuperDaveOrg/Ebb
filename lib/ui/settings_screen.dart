import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:ebb/data/backup.dart';
import 'package:ebb/data/backup_service.dart';
import 'package:ebb/data/database.dart';
import 'package:ebb/data/profile_repository.dart';
import 'package:ebb/models/profile.dart';
import 'package:ebb/domain/dates.dart';
import 'package:ebb/domain/milestones.dart';
import 'package:ebb/domain/temperature.dart';
import 'package:ebb/services/app_info.dart';
import 'package:ebb/services/document_service.dart';
import 'package:ebb/services/links.dart';
import 'package:ebb/services/notification_service.dart';
import 'package:ebb/services/person_removal.dart';
import 'package:ebb/services/settings_service.dart';
import 'package:ebb/ui/about_screen.dart';
import 'package:ebb/ui/celebration.dart';
import 'package:ebb/ui/confirm.dart';
import 'package:ebb/ui/groups_screen.dart';
import 'package:ebb/ui/help_screen.dart';
import 'package:ebb/ui/language.dart';
import 'package:ebb/ui/layout.dart';
import 'package:ebb/ui/people.dart';
import 'package:ebb/ui/receive_screen.dart';
import 'package:ebb/ui/section.dart';
import 'package:ebb/ui/send_screen.dart';
import 'package:ebb/ui/wording.dart';

/// Something Settings hands back to the home screen to do once it closes.
sealed class SettingsAction {
  const SettingsAction();
}

/// Ask for a name and start tracking someone new.
class AddPersonAction extends SettingsAction {
  const AddPersonAction();
}

/// Switch to someone who was just added, e.g. received from another phone.
class ShowPersonAction extends SettingsAction {
  const ShowPersonAction(this.profileId);
  final int profileId;
}

class SettingsScreen extends StatefulWidget {
  SettingsScreen({
    super.key,
    required this.profile,
    required this.people,
    required this.settings,
    required this.notifications,
    BackupService? backups,
    DocumentService? documents,
  }) : backups = backups ?? BackupService(),
       documents = documents ?? DocumentService();

  /// Whose settings the per-person section shows.
  final Profile profile;
  final List<Profile> people;
  final SettingsService settings;
  final NotificationService notifications;
  final BackupService backups;
  final DocumentService documents;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _reminders = true;
  int _leadDays = 2;
  bool _fertileWindow = false;
  bool _moonPhases = false;
  bool _temperature = false;
  TemperatureUnit _unit = TemperatureUnit.celsius;
  bool _celebrations = true;
  bool _groups = false;
  bool _loading = true;
  String? _version;
  late String? _name = widget.profile.name;

  Who get _who => Who(widget.profile);
  bool get _hasPeople => widget.people.length > 1;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final reminders = await widget.settings.remindersEnabled();
    final lead = await widget.settings.leadDays();
    final fertile = await widget.settings.showFertileWindow();
    final moon = await widget.settings.showMoonPhases();
    final temperature = await widget.settings.tracksTemperature();
    final unit = await SettingsService.temperatureUnit();
    final celebrations = await widget.settings.celebrations();
    final groups = await SettingsService.groupsEnabled();
    final version = await installedVersion();
    if (!mounted) return;
    setState(() {
      _version = version;
      _reminders = reminders;
      _leadDays = lead;
      _fertileWindow = fertile;
      _moonPhases = moon;
      _temperature = temperature;
      _unit = unit;
      _celebrations = celebrations;
      _groups = groups;
      _loading = false;
    });
  }

  Future<void> _setReminders(bool value) async {
    if (value) {
      final granted = await widget.notifications.requestPermission();
      if (!granted) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l.settingsNotificationsOff)),
        );
        return;
      }
    }
    await widget.settings.setRemindersEnabled(value);
    setState(() => _reminders = value);
  }

  Future<void> _openLink(Uri uri) async {
    if (!await openInBrowser(uri) && mounted) {
      _say(context.l.settingsNoBrowser(websiteLabel));
    }
  }

  void _say(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _backUp() async {
    final backup = await widget.backups.snapshot();
    if (!mounted) return;
    if (backup.cycleCount == 0 && backup.dayCount == 0) {
      _say(context.l.settingsNothingToBackUp);
      return;
    }
    final bytes = utf8.encode(encodeBackup(backup));
    try {
      final saved = await widget.documents.save(
        'ebb-backup-${isoDate(today())}.json',
        bytes,
      );
      if (saved) {
        final first = await SettingsService.noteBackup(today());
        if (first && await widget.settings.celebrations() && mounted) {
          celebrate(context, Milestone.firstBackup, _who);
        } else if (mounted) {
          _say(context.l.settingsBackupSaved);
        }
      }
    } on PlatformException catch (e) {
      if (!mounted) return;
      _say(
        e.code == 'no_picker'
            ? context.l.settingsNoPicker
            : context.l.settingsBackupNotSaved,
      );
    }
  }

  Future<void> _restore() async {
    final Uint8List? bytes;
    try {
      bytes = await widget.documents.open();
    } on PlatformException catch (e) {
      if (!mounted) return;
      _say(switch (e.code) {
        'too_large' => context.l.settingsFileTooLarge,
        'no_picker' => context.l.settingsNoPicker,
        _ => context.l.settingsFileUnreadable,
      });
      return;
    }
    if (bytes == null || !mounted) return;

    final Backup backup;
    try {
      backup = decodeBackup(utf8.decode(bytes));
    } on BackupFormatException catch (e) {
      _say(e.message);
      return;
    } on FormatException {
      _say(context.l.settingsNotABackup);
      return;
    }
    await _confirmAndRestore(backup);
  }

  Future<void> _receive() async {
    final backup = await Navigator.of(context)
        .push<Backup>(MaterialPageRoute(builder: (_) => const ReceiveScreen()));
    if (backup != null) await _confirmAndRestore(backup);
  }

  Future<void> _send() async {
    final removed = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => SendScreen(
          people: widget.people,
          notifications: widget.notifications,
          backups: widget.backups,
        ),
      ),
    );
    // Someone was handed over and removed — possibly the person whose
    // settings these are.
    if (removed == true && mounted) Navigator.of(context).pop();
  }

  /// Shared by file restore and QR receive: same data, same choices.
  ///
  /// One person arriving on an empty phone becomes its owner — that's a
  /// child's history reaching their own phone. One person arriving where
  /// there's already history can be added alongside it. Anything else
  /// replaces everything, after confirmation.
  Future<void> _confirmAndRestore(Backup backup) async {
    final current = await widget.backups.snapshot();
    final phoneIsEmpty =
        current.people.length == 1 &&
        current.cycleCount == 0 &&
        current.dayCount == 0;
    if (!mounted) return;

    if (backup.people.length == 1 && !phoneIsEmpty) {
      final person = backup.people.single;
      // Someone already here, sent again: update her, never add her twice.
      final known = await widget.backups.personWithUid(person.profile.uid);
      if (!mounted) return;
      // Shared copies aren't made here: they belong to a group, and come in
      // through its "Import from their phone".
      final choice = known != null
          ? await _askUpdateOrReplace(backup, known)
          : await _askAddOrReplace(backup);
      switch (choice) {
        case _Incoming.add:
          await _addAsSomeoneNew(person);
        case _Incoming.update:
          await _update(known!, person, sentOn: backup.exportedOn);
        case _Incoming.replace:
          await _replaceWith(backup, current: current);
        case null:
          break;
      }
      return;
    }

    if (backup.people.length == 1 && phoneIsEmpty) {
      final ok = await confirm(
        context,
        title: context.l.settingsSetUpTitle,
        body: context.l.settingsSetUpBody(
          _periods(backup.cycleCount),
          DateFormat.yMMMd().format(backup.exportedOn),
        ),
        action: context.l.continueAction,
      );
      if (ok) await _replaceWith(backup, current: current);
      return;
    }

    await _replaceWith(backup, current: current, confirm: true);
  }

  Future<_Incoming?> _askUpdateOrReplace(Backup backup, Profile known) {
    final who = Who(known);
    final sent = DateFormat.yMMMd().format(backup.exportedOn);
    final periods = _periods(backup.cycleCount);
    return showDialog<_Incoming>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(ctx.l.settingsUpdateTitle(who.who, who.name)),
        actionsOverflowDirection: VerticalDirection.up,
        content: Text(
          known.isSharedCopy
              ? ctx.l.settingsUpdateSharedBody(who.who, who.name, sent, periods)
              : ctx.l.settingsUpdateBody(who.who, who.name, sent, periods),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(ctx.l.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(_Incoming.replace),
            child: Text(ctx.l.settingsReplaceEverything),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(_Incoming.update),
            child: Text(ctx.l.settingsUpdateAction(who.who, who.name)),
          ),
        ],
      ),
    );
  }

  Future<void> _update(
    Profile known,
    BackupPerson person, {
    required DateTime sentOn,
  }) async {
    await widget.backups.updatePerson(known.id!, person, sentOn: sentOn);
    if (mounted) _say(context.l.settingsPersonUpdated(Who.label(known)));
    if (mounted) Navigator.of(context).pop(ShowPersonAction(known.id!));
  }

  Future<_Incoming?> _askAddOrReplace(Backup backup) {
    final name = backup.people.single.profile.name;
    return showDialog<_Incoming>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          name == null
              ? ctx.l.settingsAddThisHistoryTitle
              : ctx.l.settingsAddNamedTitle(name),
        ),
        // Three buttons stack on a phone; keep the main one on top and
        // Cancel at the bottom, where a stacked list reads naturally.
        actionsOverflowDirection: VerticalDirection.up,
        content: Text(
          name == null
              ? ctx.l.settingsAddBody(_periods(backup.cycleCount))
              : ctx.l.settingsAddNamedBody(name, _periods(backup.cycleCount)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(ctx.l.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(_Incoming.replace),
            child: Text(ctx.l.settingsReplaceEverything),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(_Incoming.add),
            child: Text(ctx.l.settingsAddAsNew),
          ),
        ],
      ),
    );
  }

  Future<void> _addAsSomeoneNew(BackupPerson person) async {
    final name = await showNameDialog(
      context,
      title: context.l.settingsWhoIsThis,
      initial: person.profile.name,
      others: widget.people,
      hint: context.l.settingsWhoIsThisHint,
    );
    if (name == null || name.isEmpty) return;
    final id = await widget.backups.addPerson(person, name: name);
    if (mounted) _say(context.l.settingsPersonAdded(name));
    if (mounted) Navigator.of(context).pop(ShowPersonAction(id));
  }

  Future<void> _replaceWith(
    Backup backup, {
    required Backup current,
    bool confirm = false,
  }) async {
    if (confirm && !await _confirmReplace(backup, current)) return;
    await widget.backups.restore(backup);
    // People are renumbered, so nobody may inherit an old ID's preferences or
    // reminders; the home screen reschedules everyone's when Settings closes.
    await SettingsService.forgetOthers();
    await widget.notifications.cancelAll();
    // Groups came with the backup, so they were in use: show them.
    if (backup.groups.isNotEmpty) await SettingsService.setGroupsEnabled(true);
    if (mounted) _say(context.l.settingsRestored);
    // The person on screen may not exist in the restored data.
    if (mounted) Navigator.of(context).pop();
  }

  Future<bool> _confirmReplace(Backup backup, Backup current) => confirm(
    context,
    title: context.l.settingsReplaceTitle,
    body: [
      backup.people.length > 1
          ? context.l.settingsReplaceSavedPeople(
              backup.people.length,
              DateFormat.yMMMd().format(backup.exportedOn),
              _periods(backup.cycleCount),
            )
          : context.l.settingsReplaceSaved(
              DateFormat.yMMMd().format(backup.exportedOn),
              _periods(backup.cycleCount),
            ),
      if (current.cycleCount > 0 || current.dayCount > 0)
        context.l.settingsReplaceCurrent(_periods(current.cycleCount)),
    ].join('\n\n'),
    action: context.l.settingsReplace,
  );

  String _periods(int n) => context.l.settingsPeriodCount(n);

  Future<void> _eraseEverything() async {
    final confirmed = await confirm(
      context,
      title: context.l.settingsDeleteAllTitle,
      body: _hasPeople
          ? context.l.settingsDeleteAllBodyEveryone
          : context.l.settingsDeleteAllBody,
      action: context.l.settingsDeleteEverything,
    );
    if (!confirmed) return;

    await EbbDatabase.instance.deleteAllData();
    await SettingsService.forgetEveryone();
    await widget.notifications.cancelAll();
    if (mounted) _say(context.l.settingsAllDeleted);
    if (mounted) Navigator.of(context).pop();
  }

  Future<void> _rename() async {
    final name = await showNameDialog(
      context,
      title: _who.isOwner ? context.l.settingsYourName : context.l.settingsRename,
      initial: _name,
      others: widget.people.where((p) => p.id != widget.profile.id).toList(),
      // The owner is "You" until they choose otherwise; others need a name
      // to be told apart.
      optional: _who.isOwner,
      hint: _who.isOwner
          ? context.l.settingsYourNameHint
          : null,
    );
    if (name == null) return;
    final value = name.isEmpty ? null : name;
    await ProfileRepository().rename(widget.profile.id!, value);
    setState(() => _name = value);
  }

  Future<void> _removePerson() async {
    final label = Who.label(widget.profile);
    final confirmed = await confirm(
      context,
      title: context.l.settingsRemoveTitle(label),
      body: context.l.settingsRemoveBody(label),
      action: context.l.remove,
    );
    if (!confirmed) return;

    await removePerson(widget.profile.id!, widget.notifications);
    if (mounted) _say(context.l.settingsPersonRemoved(label));
    if (mounted) Navigator.of(context).pop();
  }

  /// The phone's language, or one of Ebb's by its own name. Phone-wide,
  /// whoever's settings these are.
  Future<void> _chooseLanguage() async {
    final current = chosenLanguage.value;
    final picked = await showDialog<(String?,)>(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(context.l.language),
        children: [
          for (final (code, name) in [
            (null, context.l.languagePhone),
            for (final MapEntry(:key, :value) in languageNames.entries)
              (key, value),
          ])
            ListTile(
              leading: Icon(
                code == current
                    ? Icons.radio_button_checked
                    : Icons.radio_button_off,
              ),
              title: Text(name),
              onTap: () => Navigator.pop(context, (code,)),
            ),
        ],
      ),
    );
    if (picked == null) return;
    chosenLanguage.value = picked.$1;
    await SettingsService.setLanguage(picked.$1);
  }

  @override
  Widget build(BuildContext context) {
    final error = Theme.of(context).colorScheme.error;
    final label = Who.label(widget.profile);
    void open(Widget screen) =>
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));

    return Scaffold(
      appBar: AppBar(title: Text(context.l.settingsTitle)),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: readablePadding(
                context,
                base: const EdgeInsets.only(bottom: 32),
              ),
              children: [
                Section(
                  title: !_hasPeople
                      ? context.l.settingsYourCycle
                      : _who.isOwner
                      ? context.l.settingsYourSettings
                      : context.l.settingsSettingsFor(label),
                  children: [
                    if (_hasPeople)
                      ListTile(
                        leading: const Icon(Icons.badge_outlined),
                        title: Text(
                          _who.isOwner
                              ? context.l.settingsYourName
                              : context.l.settingsName,
                        ),
                        subtitle: Text(_name ?? context.l.you),
                        onTap: _rename,
                      ),
                    // A shared copy's reminders are on her own phone.
                    if (!widget.profile.isSharedCopy) ...[
                      SwitchListTile(
                        secondary: const Icon(Icons.notifications_none),
                        title: Text(context.l.settingsReminders),
                        subtitle: Text(
                          context.l.settingsRemindersHint(_who.who, _who.name),
                        ),
                        value: _reminders,
                        onChanged: _setReminders,
                      ),
                      ListTile(
                        enabled: _reminders,
                        leading: const Icon(Icons.schedule),
                        title: Text(context.l.settingsRemindMe),
                        subtitle: Text(context.l.settingsDaysAhead(_leadDays)),
                        trailing: DropdownButton<int>(
                          value: _leadDays,
                          underline: const SizedBox.shrink(),
                          borderRadius: BorderRadius.circular(16),
                          onChanged: _reminders
                              ? (v) async {
                                  if (v == null) return;
                                  await widget.settings.setLeadDays(v);
                                  setState(() => _leadDays = v);
                                }
                              : null,
                          items: const [1, 2, 3, 5, 7]
                              .map(
                                (d) => DropdownMenuItem(
                                  value: d,
                                  child: Text(context.l.settingsDays(d)),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ],
                    // Only ever offered to the phone's owner: added people
                    // are often children.
                    if (widget.settings.offersFertileWindow)
                      SwitchListTile(
                        secondary: const Icon(Icons.eco_outlined),
                        title: Text(context.l.settingsFertile),
                        subtitle: Text(context.l.settingsFertileHint),
                        value: _fertileWindow,
                        onChanged: (v) async {
                          await widget.settings.setShowFertileWindow(v);
                          setState(() => _fertileWindow = v);
                        },
                      ),
                    SwitchListTile(
                      secondary: const Icon(Icons.dark_mode_outlined),
                      title: Text(context.l.settingsMoon),
                      subtitle: Text(context.l.settingsMoonHint),
                      value: _moonPhases,
                      onChanged: (v) async {
                        await widget.settings.setShowMoonPhases(v);
                        setState(() => _moonPhases = v);
                      },
                    ),
                    // A shared copy is logged on her own phone; its charts
                    // show whatever came with it.
                    if (!widget.profile.isSharedCopy) ...[
                      SwitchListTile(
                        secondary: const Icon(Icons.thermostat_outlined),
                        title: Text(context.l.settingsTemperature),
                        subtitle: Text(context.l.settingsTemperatureHint),
                        value: _temperature,
                        onChanged: (v) async {
                          await widget.settings.setTracksTemperature(v);
                          setState(() => _temperature = v);
                        },
                      ),
                      if (_temperature)
                        ListTile(
                          leading: const SizedBox.shrink(),
                          title: Text(context.l.settingsTemperatureIn),
                          trailing: SegmentedButton<TemperatureUnit>(
                            showSelectedIcon: false,
                            segments: [
                              for (final u in TemperatureUnit.values)
                                ButtonSegment(value: u, label: Text(u.symbol)),
                            ],
                            selected: {_unit},
                            onSelectionChanged: (u) async {
                              await SettingsService.setTemperatureUnit(
                                u.single,
                              );
                              setState(() => _unit = u.single);
                            },
                          ),
                        ),
                    ],
                    if (!widget.profile.isSharedCopy)
                      SwitchListTile(
                        secondary: const Icon(Icons.celebration_outlined),
                        title: Text(context.l.settingsCelebrate),
                        subtitle: Text(
                          context.l.settingsCelebrateHint(_who.who, _who.name),
                        ),
                        value: _celebrations,
                        onChanged: (v) async {
                          await widget.settings.setCelebrations(v);
                          setState(() => _celebrations = v);
                        },
                      ),
                    if (!_who.isOwner)
                      ListTile(
                        leading: const Icon(Icons.person_remove_outlined),
                        title: Text(context.l.settingsRemovePerson(label)),
                        onTap: _removePerson,
                      ),
                  ],
                ),
                Section(
                  title: context.l.settingsPeople,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.person_add_alt),
                      title: Text(
                        _hasPeople
                            ? context.l.settingsAddSomeone
                            : context.l.settingsTrackSomeoneElse,
                      ),
                      subtitle: _hasPeople
                          ? null
                          : Text(context.l.settingsTrackSomeoneElseHint),
                      onTap: () =>
                          Navigator.of(context).pop(const AddPersonAction()),
                    ),
                  ],
                ),
                Section(
                  title: context.l.settingsBackupSection,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.save_alt),
                      title: Text(context.l.settingsBackUp),
                      subtitle: Text(
                        _hasPeople
                            ? context.l.settingsBackUpHintEveryone
                            : context.l.settingsBackUpHint,
                      ),
                      onTap: _backUp,
                    ),
                    ListTile(
                      leading: const Icon(Icons.restore),
                      title: Text(context.l.settingsRestore),
                      subtitle: Text(context.l.settingsRestoreHint),
                      onTap: _restore,
                    ),
                    ListTile(
                      leading: const Icon(Icons.qr_code_2),
                      title: Text(context.l.settingsSend),
                      subtitle: Text(
                        _hasPeople
                            ? context.l.settingsSendHintEveryone
                            : context.l.settingsSendHint,
                      ),
                      onTap: _send,
                    ),
                    ListTile(
                      leading: const Icon(Icons.qr_code_scanner),
                      title: Text(context.l.settingsReceive),
                      subtitle: Text(context.l.settingsReceiveHint),
                      onTap: _receive,
                    ),
                  ],
                ),
                Section(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.translate),
                      title: Text(context.l.language),
                      subtitle: Text(
                        chosenLanguage.value == null
                            ? context.l.languagePhoneIs(
                                languageNames[context.l.localeName] ??
                                    context.l.localeName,
                              )
                            : languageNames[chosenLanguage.value] ??
                                  chosenLanguage.value!,
                      ),
                      onTap: _chooseLanguage,
                    ),
                  ],
                ),
                // Phone-wide and off by default: groups suit clubs and
                // circles, not the parent tracking a child that most
                // multi-person phones are.
                Section(
                  title: context.l.settingsAdvanced,
                  children: [
                    SwitchListTile(
                      secondary: const Icon(Icons.groups_outlined),
                      title: Text(context.l.settingsGroups),
                      subtitle: Text(context.l.settingsGroupsHint),
                      value: _groups,
                      onChanged: (v) async {
                        await SettingsService.setGroupsEnabled(v);
                        setState(() => _groups = v);
                      },
                    ),
                    if (_groups)
                      ListTile(
                        leading: const SizedBox(width: 24),
                        title: Text(context.l.settingsManageGroups),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => open(const GroupsScreen()),
                      ),
                  ],
                ),
                Section(
                  title: context.l.settingsAboutEbb,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.help_outline),
                      title: Text(context.l.settingsHowEbbWorks),
                      subtitle: Text(context.l.settingsHowEbbWorksHint),
                      onTap: () => open(const HelpScreen()),
                    ),
                    ListTile(
                      leading: const Icon(Icons.lock_outline),
                      title: Text(context.l.settingsYourData),
                      subtitle: Text(context.l.settingsYourDataHint),
                      onTap: () => open(const AboutScreen()),
                    ),
                    ListTile(
                      leading: const Icon(Icons.public),
                      title: Text(context.l.settingsWebsite),
                      subtitle: const Text(websiteLabel),
                      trailing: const Icon(Icons.open_in_new),
                      onTap: () => _openLink(websiteUri),
                    ),
                    ListTile(
                      leading: const Icon(Icons.feedback_outlined),
                      title: Text(context.l.settingsSendFeedback),
                      subtitle: Text(context.l.settingsSendFeedbackHint),
                      trailing: const Icon(Icons.open_in_new),
                      onTap: () => _openLink(feedbackUri),
                    ),
                  ],
                ),
                Section(
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.delete_forever_outlined,
                        color: error,
                      ),
                      title: Text(
                        context.l.settingsDeleteAll,
                        style: TextStyle(color: error),
                      ),
                      onTap: _eraseEverything,
                    ),
                  ],
                ),
                // Which build this is, for bug reports. Ebb has no crash
                // reporting, so this is how a problem gets pinned down.
                if (_version != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: Text(
                      context.l.settingsVersion(_version!),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
              ],
            ),
    );
  }
}

enum _Incoming { add, update, replace }
