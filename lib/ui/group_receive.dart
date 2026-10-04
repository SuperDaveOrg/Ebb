import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:ebb/data/backup.dart';
import 'package:ebb/data/backup_service.dart';
import 'package:ebb/data/database.dart';
import 'package:ebb/data/group_repository.dart';
import 'package:ebb/data/profile_repository.dart';
import 'package:ebb/models/person_group.dart';
import 'package:ebb/ui/confirm.dart';
import 'package:ebb/ui/people.dart';
import 'package:ebb/ui/receive_screen.dart';
import 'package:ebb/ui/wording.dart';

/// "Import from their phone": scans one person's codes into [group].
///
/// Someone new arrives imported, as a shared copy — read-only here, updated when she
/// sends again — and joins the group. Someone already on the phone is
/// updated and joins the group if she wasn't in it. A whole phone's worth of
/// people isn't taken: in a group, each person sends only her own.
///
/// Returns true if anyone was added or updated.
Future<bool> receiveIntoGroup(
  BuildContext context,
  PersonGroup group, {
  BackupService? backups,
}) async {
  final service = backups ?? BackupService();
  final messenger = ScaffoldMessenger.of(context);
  void say(String text) =>
      messenger.showSnackBar(SnackBar(content: Text(text)));

  final backup = await Navigator.of(context)
      .push<Backup>(MaterialPageRoute(builder: (_) => const ReceiveScreen()));
  if (backup == null || !context.mounted) return false;

  if (backup.people.length != 1) {
    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('That’s more than one person'),
        content: const Text(
          'These codes hold a whole phone’s history. To join a group, each '
          'person sends just their own: on their phone, Settings → Send to '
          'another phone → Just your history.',
        ),
        actions: [
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
    return false;
  }

  final person = backup.people.single;
  final sent = DateFormat.yMMMd().format(backup.exportedOn);
  final periods = backup.cycleCount == 1
      ? '1 period'
      : '${backup.cycleCount} periods';
  final groups = GroupRepository();
  final known = await service.personWithUid(person.profile.uid);
  if (!context.mounted) return false;

  if (known != null) {
    final name = known.id == EbbDatabase.primaryProfileId
        ? 'your history'
        : Who.label(known);
    final ok = await confirm(
      context,
      title: 'Update $name?',
      body: known.isSharedCopy
          ? 'This is ${Who(known).whose} history again, sent $sent: '
                '$periods. It replaces the copy on this phone.'
          : 'This is ${Who(known).whose} history, sent $sent: $periods. '
                'It replaces what’s on this phone for '
                '${known.name ?? 'you'}, including anything logged here '
                'since.',
      action: 'Update $name',
    );
    if (!ok) return false;
    await service.updatePerson(known.id!, person, sentOn: backup.exportedOn);
    await groups.addMember(group.id!, known.id!);
    say('${Who.label(known)} updated.');
    return true;
  }

  final everyone = await ProfileRepository().all();
  if (!context.mounted) return false;
  final name = await showNameDialog(
    context,
    title: 'Import into ${group.name}',
    initial: person.profile.name,
    others: everyone,
    hint:
        '$periods, sent $sent. Imported read-only: it can’t be changed '
        'here, and is brought up to date when it’s sent again.',
  );
  if (name == null || name.isEmpty) return false;
  final id = await service.addPerson(
    person,
    name: name,
    sharedOn: backup.exportedOn,
  );
  await groups.addMember(group.id!, id);
  say('$name imported into ${group.name}.');
  return true;
}
