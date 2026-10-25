import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:ebb/data/backup.dart';
import 'package:ebb/data/backup_service.dart';
import 'package:ebb/data/group_repository.dart';
import 'package:ebb/data/profile_repository.dart';
import 'package:ebb/models/person_group.dart';
import 'package:ebb/ui/confirm.dart';
import 'package:ebb/ui/language.dart';
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
        title: Text(ctx.l.groupsMoreThanOne),
        content: Text(ctx.l.groupsMoreThanOneBody),
        actions: [
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(ctx.l.ok),
          ),
        ],
      ),
    );
    return false;
  }

  final person = backup.people.single;
  final sent = DateFormat.yMMMd().format(backup.exportedOn);
  final periods = context.l.sharePeriodCount(backup.cycleCount);
  final groups = GroupRepository();
  final known = await service.personWithUid(person.profile.uid);
  if (!context.mounted) return false;

  if (known != null) {
    final w = Who(known);
    final ok = await confirm(
      context,
      title: context.l.groupsUpdateTitle(w.who, w.name),
      body: known.isSharedCopy
          ? context.l.groupsUpdateCopyBody(w.who, w.name, sent, periods)
          : context.l.groupsUpdateBody(w.who, w.name, sent, periods),
      action: context.l.groupsUpdateAction(w.who, w.name),
    );
    if (!ok) return false;
    await service.updatePerson(known.id!, person, sentOn: backup.exportedOn);
    await groups.addMember(group.id!, known.id!);
    if (context.mounted) say(context.l.groupsUpdated(Who.label(known)));
    return true;
  }

  final everyone = await ProfileRepository().all();
  if (!context.mounted) return false;
  final name = await showNameDialog(
    context,
    title: context.l.groupsImportInto(group.name),
    initial: person.profile.name,
    others: everyone,
    hint: context.l.groupsImportHint(periods, sent),
  );
  if (name == null || name.isEmpty) return false;
  final id = await service.addPerson(
    person,
    name: name,
    sharedOn: backup.exportedOn,
  );
  await groups.addMember(group.id!, id);
  if (context.mounted) say(context.l.groupsImported(name, group.name));
  return true;
}
