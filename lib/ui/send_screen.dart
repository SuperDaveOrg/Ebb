import 'dart:async';

import 'package:flutter/material.dart';

import 'package:ebb/data/backup.dart';
import 'package:ebb/data/backup_service.dart';
import 'package:ebb/data/database.dart';
import 'package:ebb/data/qr_transfer.dart';
import 'package:ebb/models/profile.dart';
import 'package:ebb/services/notification_service.dart';
import 'package:ebb/services/person_removal.dart';
import 'package:ebb/ui/layout.dart';
import 'package:ebb/ui/qr_code_view.dart';
import 'package:ebb/ui/section.dart';
import 'package:ebb/ui/wording.dart';

/// Shows history as a series of QR codes for another phone running Ebb to
/// scan. Nothing is sent anywhere; the other phone reads the screen.
///
/// With more than one person on the phone it first asks what to send:
/// everyone (moving to a new phone) or one person (handing their history to
/// their own phone). Pops with true if someone was removed afterwards.
class SendScreen extends StatefulWidget {
  SendScreen({
    super.key,
    required this.people,
    required this.notifications,
    BackupService? backups,
  }) : backups = backups ?? BackupService();

  final List<Profile> people;
  final NotificationService notifications;
  final BackupService backups;

  @override
  State<SendScreen> createState() => _SendScreenState();
}

class _SendScreenState extends State<SendScreen> {
  /// Long enough for a scanner to lock on, short enough not to wait on.
  static const _dwell = Duration(milliseconds: 1800);

  /// Who is being sent: null for everyone. Unset until chosen.
  Profile? _only;
  bool _chosen = false;

  Backup? _backup;
  List<String> _frames = const [];
  int _index = 0;
  bool _playing = true;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // One person on the phone: nothing to choose.
    if (widget.people.length == 1) _choose(null);
  }

  Future<void> _choose(Profile? only) async {
    setState(() {
      _only = only;
      _chosen = true;
    });
    final backup = await widget.backups.snapshot(onlyProfileId: only?.id);
    if (!mounted) return;
    setState(() {
      _backup = backup;
      _frames = encodeTransfer(encodeBackup(backup, pretty: false));
    });
    _schedule();
  }

  void _schedule() {
    _timer?.cancel();
    if (!_playing || _frames.length < 2) return;
    _timer = Timer.periodic(_dwell, (_) => _step(1, fromTimer: true));
  }

  void _step(int by, {bool fromTimer = false}) {
    setState(() => _index = (_index + by) % _frames.length);
    // Stepping by hand pauses, so the code stays put while she aims.
    if (!fromTimer && _playing) {
      setState(() => _playing = false);
      _timer?.cancel();
    }
  }

  void _togglePlaying() {
    setState(() => _playing = !_playing);
    _schedule();
  }

  /// After handing someone over, offer — never assume — to take them off
  /// this phone. Ebb can't know the other phone got everything.
  Future<void> _done() async {
    _timer?.cancel();
    final only = _only;
    if (only == null || only.id == EbbDatabase.primaryProfileId) {
      Navigator.of(context).pop(false);
      return;
    }
    final name = Who.label(only);
    final remove = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Remove $name from this phone?'),
        content: Text(
          'If $name’s history arrived on the other phone, it can come off '
          'this one. You can also keep it here as well.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Keep'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
    if (remove == null || !mounted) return; // dismissed: stay on the codes
    if (remove) {
      await removePerson(only.id!, widget.notifications);
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('$name removed.')));
    }
    Navigator.of(context).pop(remove);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Send to another phone')),
      body: !_chosen ? _chooser(context) : _codes(context),
    );
  }

  Widget _chooser(BuildContext context) {
    final theme = Theme.of(context);
    return ListView(
      padding: readablePadding(
        context,
        base: const EdgeInsets.only(bottom: 32),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
          child: Text(
            'What would you like to send?',
            style: theme.textTheme.titleLarge,
          ),
        ),
        Section(
          children: [
            ListTile(
              leading: const Icon(Icons.groups_outlined),
              title: const Text('Everyone'),
              subtitle: const Text('Moving to a new phone.'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _choose(null),
            ),
          ],
        ),
        Section(
          title: 'Just one person',
          children: [
            for (final p in widget.people)
              ListTile(
                leading: const Icon(Icons.person_outline),
                title: Text(
                  p.id == EbbDatabase.primaryProfileId
                      ? 'Just your history'
                      : 'Just ${Who.label(p)}',
                ),
                subtitle: p.id == EbbDatabase.primaryProfileId
                    ? null
                    : Text('For ${Who.label(p)}’s own phone.'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _choose(p),
              ),
          ],
        ),
      ],
    );
  }

  Widget _codes(BuildContext context) {
    final theme = Theme.of(context);
    final backup = _backup;
    if (backup == null) {
      return const Center(child: CircularProgressIndicator());
    }
    if (backup.cycleCount == 0 && backup.dayCount == 0) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Text('Nothing to send yet.', textAlign: TextAlign.center),
        ),
      );
    }
    final muted = theme.textTheme.bodySmall?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );

    return ListView(
      // Narrower than other screens, so a whole code fits on a landscape
      // tablet without scrolling.
      padding: readablePadding(
        context,
        base: const EdgeInsets.fromLTRB(24, 8, 24, 32),
        maxWidth: 480,
      ),
      children: [
        Text(
          'On the other phone, open Ebb, go to Settings → Receive from another '
          'phone, and point the camera at this screen.',
          style: theme.textTheme.bodyMedium,
        ),
        const SizedBox(height: 20),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: QrCodeView(data: _frames[_index]),
        ),
        const SizedBox(height: 16),
        if (_frames.length > 1) ...[
          Text(
            'Code ${_index + 1} of ${_frames.length}',
            textAlign: TextAlign.center,
            style: theme.textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                tooltip: 'Previous code',
                onPressed: () => _step(-1),
              ),
              IconButton.filledTonal(
                icon: Icon(_playing ? Icons.pause : Icons.play_arrow),
                tooltip: _playing ? 'Pause' : 'Play',
                onPressed: _togglePlaying,
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                tooltip: 'Next code',
                onPressed: () => _step(1),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'The codes change on their own. The other phone collects them in '
            'any order.',
            textAlign: TextAlign.center,
            style: muted,
          ),
        ],
        const SizedBox(height: 16),
        Text(_summary(backup), textAlign: TextAlign.center, style: muted),
        const SizedBox(height: 20),
        FilledButton.tonal(onPressed: _done, child: const Text('Done')),
      ],
    );
  }

  String _summary(Backup b) {
    final periods = b.cycleCount == 1 ? '1 period' : '${b.cycleCount} periods';
    final only = _only;
    if (only == null) {
      final people = b.people.length > 1
          ? ' for ${b.people.length} people'
          : '';
      return 'Everything in Ebb: $periods$people.';
    }
    return only.id == EbbDatabase.primaryProfileId
        ? 'Your history: $periods.'
        : '${Who.label(only)}’s history: $periods.';
  }
}
