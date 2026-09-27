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
import 'package:ebb/services/app_info.dart';
import 'package:ebb/services/document_service.dart';
import 'package:ebb/services/notification_service.dart';
import 'package:ebb/services/person_removal.dart';
import 'package:ebb/services/settings_service.dart';
import 'package:ebb/ui/about_screen.dart';
import 'package:ebb/ui/help_screen.dart';
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
  })  : backups = backups ?? BackupService(),
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
    final version = await installedVersion();
    if (!mounted) return;
    setState(() {
      _version = version;
      _reminders = reminders;
      _leadDays = lead;
      _fertileWindow = fertile;
      _loading = false;
    });
  }

  Future<void> _setReminders(bool value) async {
    if (value) {
      final granted = await widget.notifications.requestPermission();
      if (!granted) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Notifications are turned off for Ebb in system '
              'settings.'),
        ));
        return;
      }
    }
    await widget.settings.setRemindersEnabled(value);
    setState(() => _reminders = value);
  }

  void _say(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _backUp() async {
    final backup = await widget.backups.snapshot();
    if (backup.cycleCount == 0 && backup.dayCount == 0) {
      _say('Nothing to back up yet.');
      return;
    }
    final bytes = utf8.encode(encodeBackup(backup));
    try {
      final saved = await widget.documents
          .save('ebb-backup-${isoDate(today())}.json', bytes);
      if (saved) {
        _say('Backup saved. Keep a copy somewhere other than this phone.');
      }
    } on PlatformException catch (e) {
      _say(e.code == 'no_picker'
          ? _noPicker
          : "The backup couldn't be saved there. Try another location.");
    }
  }

  static const _noPicker =
      'This phone has no file picker for Ebb to use. Sending to another '
      'phone works without one.';

  Future<void> _restore() async {
    final Uint8List? bytes;
    try {
      bytes = await widget.documents.open();
    } on PlatformException catch (e) {
      _say(switch (e.code) {
        'too_large' => "That file is too large to be an Ebb backup.",
        'no_picker' => _noPicker,
        _ => "That file couldn't be read.",
      });
      return;
    }
    if (bytes == null) return;

    final Backup backup;
    try {
      backup = decodeBackup(utf8.decode(bytes));
    } on BackupFormatException catch (e) {
      _say(e.message);
      return;
    } on FormatException {
      _say("This file isn't an Ebb backup.");
      return;
    }
    await _confirmAndRestore(backup);
  }

  Future<void> _receive() async {
    final backup = await Navigator.of(context).push<Backup>(
      MaterialPageRoute(builder: (_) => const ReceiveScreen()),
    );
    if (backup != null) await _confirmAndRestore(backup);
  }

  Future<void> _send() async {
    final removed = await Navigator.of(context).push<bool>(MaterialPageRoute(
      builder: (_) => SendScreen(
        people: widget.people,
        notifications: widget.notifications,
        backups: widget.backups,
      ),
    ));
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
    final phoneIsEmpty = current.people.length == 1 &&
        current.cycleCount == 0 &&
        current.dayCount == 0;
    if (!mounted) return;

    if (backup.people.length == 1 && !phoneIsEmpty) {
      switch (await _askAddOrReplace(backup)) {
        case _Incoming.add:
          await _addAsSomeoneNew(backup.people.single);
        case _Incoming.replace:
          await _replaceWith(backup, current: current);
        case null:
          break;
      }
      return;
    }

    if (backup.people.length == 1 && phoneIsEmpty) {
      final ok = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Set up with this history?'),
          content: Text(
            '${_periods(backup.cycleCount)}, sent '
            '${DateFormat.yMMMd().format(backup.exportedOn)}. On this phone '
            'it becomes your history.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: const Text('Continue'),
            ),
          ],
        ),
      );
      if (ok == true) await _replaceWith(backup, current: current);
      return;
    }

    await _replaceWith(backup, current: current, confirm: true);
  }

  Future<_Incoming?> _askAddOrReplace(Backup backup) {
    final name = backup.people.single.profile.name;
    return showDialog<_Incoming>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(name == null ? 'Add this history?' : 'Add $name?'),
        // Three buttons stack on a phone; keep the main one on top and
        // Cancel at the bottom, where a stacked list reads naturally.
        actionsOverflowDirection: VerticalDirection.up,
        content: Text(
          '${name == null ? 'It has' : '$name’s history has'} '
          '${_periods(backup.cycleCount)}. You can add it alongside what’s '
          'already here, or replace everything on this phone with it.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(_Incoming.replace),
            child: const Text('Replace everything'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(_Incoming.add),
            child: const Text('Add as someone new'),
          ),
        ],
      ),
    );
  }

  Future<void> _addAsSomeoneNew(BackupPerson person) async {
    final name = await showNameDialog(
      context,
      title: 'Who is this?',
      initial: person.profile.name,
      others: widget.people,
      hint: 'A name to tell them apart on this phone.',
    );
    if (name == null || name.isEmpty) return;
    final id = await widget.backups.addPerson(person, name: name);
    _say('$name added.');
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
    _say('Done. Ebb has been updated.');
    // The person on screen may not exist in the restored data.
    if (mounted) Navigator.of(context).pop();
  }

  Future<bool> _confirmReplace(Backup backup, Backup current) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Replace what’s in Ebb?'),
        content: Text([
          'Saved ${DateFormat.yMMMd().format(backup.exportedOn)}, with '
              '${_periods(backup.cycleCount)}'
              '${backup.people.length > 1 ? ' for ${backup.people.length} people' : ''}.',
          if (current.cycleCount > 0 || current.dayCount > 0)
            'It replaces everything in Ebb now, including '
                '${_periods(current.cycleCount)} on this phone.',
        ].join('\n\n')),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Replace'),
          ),
        ],
      ),
    );
    return confirmed == true;
  }

  static String _periods(int n) => n == 1 ? '1 period' : '$n periods';

  Future<void> _eraseEverything() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete all data?'),
        content: Text(
          'Every cycle and note${_hasPeople ? ', for everyone on this phone,' : ''} '
          'will be permanently erased. Ebb keeps no other copy, so this '
          'cannot be undone unless you have saved a backup file.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Delete everything'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    await EbbDatabase.instance.deleteAllData();
    await SettingsService.forgetEveryone();
    await widget.notifications.cancelAll();
    _say('All data deleted.');
    if (mounted) Navigator.of(context).pop();
  }

  Future<void> _rename() async {
    final name = await showNameDialog(
      context,
      title: _who.isOwner ? 'Your name' : 'Rename',
      initial: _name,
      others: widget.people.where((p) => p.id != widget.profile.id).toList(),
      // The owner is "You" until they choose otherwise; others need a name
      // to be told apart.
      optional: _who.isOwner,
      hint: _who.isOwner
          ? 'Shown in the list of people. Leave empty to appear as “You”.'
          : null,
    );
    if (name == null) return;
    final value = name.isEmpty ? null : name;
    await ProfileRepository().rename(widget.profile.id!, value);
    setState(() => _name = value);
  }

  Future<void> _removePerson() async {
    final label = Who.label(widget.profile);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Remove $label from this phone?'),
        content: Text(
          'Every cycle and note for $label will be permanently erased. '
          'Nobody else’s history is affected.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    await removePerson(widget.profile.id!, widget.notifications);
    _say('$label removed.');
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final error = Theme.of(context).colorScheme.error;
    final label = Who.label(widget.profile);
    void open(Widget screen) => Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => screen));

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: readablePadding(context,
                  base: const EdgeInsets.only(bottom: 32)),
              children: [
                Section(
                  title: !_hasPeople
                      ? 'Your cycle'
                      : _who.isOwner
                          ? 'Your settings'
                          : 'Settings for $label',
                  children: [
                    if (_hasPeople)
                      ListTile(
                        leading: const Icon(Icons.badge_outlined),
                        title: Text(_who.isOwner ? 'Your name' : 'Name'),
                        subtitle: Text(_name ?? 'You'),
                        onTap: _rename,
                      ),
                    SwitchListTile(
                      secondary: const Icon(Icons.notifications_none),
                      title: const Text('Reminders'),
                      subtitle: Text(
                          'A heads-up before ${_who.whose} period is expected.'),
                      value: _reminders,
                      onChanged: _setReminders,
                    ),
                    ListTile(
                      enabled: _reminders,
                      leading: const Icon(Icons.schedule),
                      title: const Text('Remind me'),
                      subtitle: Text(_leadDays == 1
                          ? '1 day ahead'
                          : '$_leadDays days ahead'),
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
                            .map((d) => DropdownMenuItem(
                                value: d,
                                child: Text('$d day${d == 1 ? '' : 's'}')))
                            .toList(),
                      ),
                    ),
                    // Only ever offered to the phone's owner: added people
                    // are often children.
                    if (widget.settings.offersFertileWindow)
                      SwitchListTile(
                        secondary: const Icon(Icons.eco_outlined),
                        title: const Text('Show fertile window estimate'),
                        subtitle: const Text(
                          'Off by default. An estimate from cycle timing '
                          'only — not reliable enough to use as '
                          'contraception.',
                        ),
                        value: _fertileWindow,
                        onChanged: (v) async {
                          await widget.settings.setShowFertileWindow(v);
                          setState(() => _fertileWindow = v);
                        },
                      ),
                    if (!_who.isOwner)
                      ListTile(
                        leading: const Icon(Icons.person_remove_outlined),
                        title: Text('Remove $label from this phone'),
                        onTap: _removePerson,
                      ),
                  ],
                ),
                Section(
                  title: 'People',
                  children: [
                    ListTile(
                      leading: const Icon(Icons.person_add_alt),
                      title: Text(
                          _hasPeople ? 'Add someone' : 'Track someone else too'),
                      subtitle: _hasPeople
                          ? null
                          : const Text(
                              'For example, a child who’s just starting.'),
                      onTap: () =>
                          Navigator.of(context).pop(const AddPersonAction()),
                    ),
                  ],
                ),
                Section(
                  title: 'Backup & moving',
                  children: [
                    ListTile(
                      leading: const Icon(Icons.save_alt),
                      title: const Text('Back up to a file'),
                      subtitle: Text(
                          'Save ${_hasPeople ? 'everyone’s' : 'your'} '
                          'history to a file, wherever you choose.'),
                      onTap: _backUp,
                    ),
                    ListTile(
                      leading: const Icon(Icons.restore),
                      title: const Text('Restore from a backup'),
                      subtitle: const Text('Replaces what is in Ebb now.'),
                      onTap: _restore,
                    ),
                    ListTile(
                      leading: const Icon(Icons.qr_code_2),
                      title: const Text('Send to another phone'),
                      subtitle: Text(
                          'Show ${_hasPeople ? 'everyone’s' : 'your'} '
                          'history as codes for another phone to scan.'),
                      onTap: _send,
                    ),
                    ListTile(
                      leading: const Icon(Icons.qr_code_scanner),
                      title: const Text('Receive from another phone'),
                      subtitle: const Text(
                          'Scan the codes. Replaces what is in Ebb now.'),
                      onTap: _receive,
                    ),
                  ],
                ),
                Section(
                  title: 'About Ebb',
                  children: [
                    ListTile(
                      leading: const Icon(Icons.help_outline),
                      title: const Text('How Ebb works'),
                      subtitle:
                          const Text('Logging, estimates, backups and more.'),
                      onTap: () => open(const HelpScreen()),
                    ),
                    ListTile(
                      leading: const Icon(Icons.lock_outline),
                      title: const Text('Your data'),
                      subtitle:
                          const Text('Where it lives and who can see it.'),
                      onTap: () => open(const AboutScreen()),
                    ),
                  ],
                ),
                Section(
                  children: [
                    ListTile(
                      leading: Icon(Icons.delete_forever_outlined, color: error),
                      title: Text('Delete all data',
                          style: TextStyle(color: error)),
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
                      'Ebb $_version\nMade by SuperDaveLab',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
              ],
            ),
    );
  }
}

enum _Incoming { add, replace }
