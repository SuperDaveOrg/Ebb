import 'dart:async';

import 'package:flutter/material.dart';

import 'package:ebb/data/backup.dart';
import 'package:ebb/data/backup_service.dart';
import 'package:ebb/data/database.dart';
import 'package:ebb/data/qr_transfer.dart';
import 'package:ebb/models/profile.dart';
import 'package:ebb/services/notification_service.dart';
import 'package:ebb/services/person_removal.dart';
import 'package:ebb/ui/language.dart';
import 'package:ebb/ui/layout.dart';
import 'package:ebb/ui/qr_code_view.dart';
import 'package:ebb/ui/section.dart';
import 'package:ebb/ui/wording.dart';

/// Shows history as a series of QR codes for another phone running Ebb to
/// scan. Nothing is sent anywhere; the other phone reads the screen.
///
/// With more than one person on the phone it first asks who to send:
/// everyone (moving to a new phone) or one person (handing their history to
/// their own phone, or sharing it with a group). Sending one person — or
/// the only person, on a phone with just one — then asks how much: how far
/// back, and whether daily entries go too. Everything is the default, so a
/// handover sends it all. Pops with true if someone was removed afterwards.
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
  _Stage _stage = _Stage.who;

  /// How much of one person to send.
  SendSpan _span = SendSpan.everything;
  bool _periodsOnly = false;

  Backup? _backup;
  List<String> _frames = const [];
  int _index = 0;
  bool _playing = true;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // One person on the phone: nobody to choose, only how much.
    if (widget.people.length == 1) {
      _only = widget.people.single;
      _stage = _Stage.what;
    }
  }

  /// Everyone, straight to the codes; one person, on to how much.
  void _choose(Profile? only) {
    if (only == null) {
      _send(null);
    } else {
      setState(() {
        _only = only;
        _stage = _Stage.what;
      });
    }
  }

  Future<void> _send(Profile? only) async {
    setState(() {
      _only = only;
      _stage = _Stage.codes;
    });
    var backup = await widget.backups.snapshot(onlyProfileId: only?.id);
    if (only != null) {
      backup = Backup(
        exportedOn: backup.exportedOn,
        people: [
          backup.people.single.trimmed(span: _span, periodsOnly: _periodsOnly),
        ],
      );
    }
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
        title: Text(ctx.l.shareRemoveTitle(name)),
        content: Text(ctx.l.shareRemoveBody(name)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(ctx.l.shareKeep),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(ctx.l.remove),
          ),
        ],
      ),
    );
    if (remove == null || !mounted) return; // dismissed: stay on the codes
    if (remove) {
      await removePerson(only.id!, widget.notifications);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l.shareRemoved(name))),
      );
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
      appBar: AppBar(title: Text(context.l.shareTitle)),
      // From "how much", back goes to "who" when there was a choice of who.
      body: PopScope(
        canPop: _stage != _Stage.what || widget.people.length == 1,
        onPopInvokedWithResult: (didPop, _) {
          if (!didPop) setState(() => _stage = _Stage.who);
        },
        child: switch (_stage) {
          _Stage.who => _chooser(context),
          _Stage.what => _howMuch(context),
          _Stage.codes => _codes(context),
        },
      ),
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
            context.l.shareWhatToSend,
            style: theme.textTheme.titleLarge,
          ),
        ),
        Section(
          children: [
            ListTile(
              leading: const Icon(Icons.groups_outlined),
              title: Text(context.l.shareEveryone),
              subtitle: Text(context.l.shareEveryoneHint),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _choose(null),
            ),
          ],
        ),
        Section(
          title: context.l.shareJustOne,
          children: [
            // A shared copy is someone else's history from her phone. It
            // isn't this phone's to pass on: she sends her own.
            for (final p in widget.people.where((p) => !p.isSharedCopy))
              ListTile(
                leading: const Icon(Icons.person_outline),
                title: Text(
                  p.id == EbbDatabase.primaryProfileId
                      ? context.l.shareJustYours
                      : context.l.shareJustName(Who.label(p)),
                ),
                subtitle: p.id == EbbDatabase.primaryProfileId
                    ? null
                    : Text(context.l.shareForTheirPhone(Who.label(p))),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _choose(p),
              ),
          ],
        ),
        if (widget.people.any((p) => p.isSharedCopy))
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
            child: Text(
              context.l.shareCopiesNotOffered,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
      ],
    );
  }

  /// How much of one person's history to send.
  Widget _howMuch(BuildContext context) {
    final theme = Theme.of(context);
    final only = _only!;
    final who = Who(only);

    Widget choice({
      required bool selected,
      required String title,
      String? subtitle,
      required VoidCallback onTap,
    }) => ListTile(
      leading: Icon(
        selected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
        color: selected ? theme.colorScheme.primary : null,
      ),
      title: Text(title),
      subtitle: subtitle == null ? null : Text(subtitle),
      selected: selected,
      onTap: onTap,
    );

    return ListView(
      padding: readablePadding(
        context,
        base: const EdgeInsets.only(bottom: 32),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
          child: Text(
            context.l.shareHowMuch(who.who, who.name),
            style: theme.textTheme.titleLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
          child: Text(
            context.l.shareHowMuchHint,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        Section(
          title: context.l.shareHowFarBack,
          children: [
            for (final span in SendSpan.values)
              choice(
                selected: _span == span,
                title: _spanLabel(context, span),
                onTap: () => setState(() => _span = span),
              ),
          ],
        ),
        Section(
          title: context.l.shareWhatToInclude,
          children: [
            choice(
              selected: !_periodsOnly,
              title: context.l.shareWithDays,
              subtitle: context.l.shareWithDaysHint,
              onTap: () => setState(() => _periodsOnly = false),
            ),
            choice(
              selected: _periodsOnly,
              title: context.l.sharePeriodsOnly,
              subtitle: context.l.sharePeriodsOnlyHint,
              onTap: () => setState(() => _periodsOnly = true),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
          child: FilledButton(
            onPressed: () => _send(only),
            child: Text(context.l.shareShowCodes),
          ),
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
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Text(context.l.shareNothing, textAlign: TextAlign.center),
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
          context.l.shareHowToReceive,
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
            context.l.shareCodeOf(_index + 1, _frames.length),
            textAlign: TextAlign.center,
            style: theme.textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                tooltip: context.l.sharePreviousCode,
                onPressed: () => _step(-1),
              ),
              IconButton.filledTonal(
                icon: Icon(_playing ? Icons.pause : Icons.play_arrow),
                tooltip: _playing
                    ? context.l.sharePause
                    : context.l.sharePlay,
                onPressed: _togglePlaying,
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                tooltip: context.l.shareNextCode,
                onPressed: () => _step(1),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            context.l.shareCodesChange,
            textAlign: TextAlign.center,
            style: muted,
          ),
        ],
        const SizedBox(height: 16),
        Text(
          _summary(context, backup),
          textAlign: TextAlign.center,
          style: muted,
        ),
        const SizedBox(height: 20),
        FilledButton.tonal(onPressed: _done, child: Text(context.l.done)),
      ],
    );
  }

  String _summary(BuildContext context, Backup b) {
    final l = context.l;
    final periods = l.sharePeriodCount(b.cycleCount);
    final only = _only;
    if (only == null) {
      return b.people.length > 1
          ? l.shareSummaryEverythingPeople(periods, b.people.length)
          : l.shareSummaryEverything(periods);
    }
    final w = Who(only);
    return switch ((_periodsOnly, _span)) {
      (false, SendSpan.everything) =>
        l.shareSummaryHistoryAll(w.who, w.name, periods),
      (false, SendSpan.latest) =>
        l.shareSummaryHistoryLatest(w.who, w.name, periods),
      (false, SendSpan.year) =>
        l.shareSummaryHistoryYear(w.who, w.name, periods),
      (false, SendSpan.months6) =>
        l.shareSummaryHistoryMonths(w.who, w.name, periods, 6),
      (false, SendSpan.months3) =>
        l.shareSummaryHistoryMonths(w.who, w.name, periods, 3),
      (true, SendSpan.everything) =>
        l.shareSummaryPeriodsAll(w.who, w.name, periods),
      (true, SendSpan.latest) =>
        l.shareSummaryPeriodsLatest(w.who, w.name, periods),
      (true, SendSpan.year) =>
        l.shareSummaryPeriodsYear(w.who, w.name, periods),
      (true, SendSpan.months6) =>
        l.shareSummaryPeriodsMonths(w.who, w.name, periods, 6),
      (true, SendSpan.months3) =>
        l.shareSummaryPeriodsMonths(w.who, w.name, periods, 3),
    };
  }
}

/// How far back [span] reaches, as the choice reads.
String _spanLabel(BuildContext context, SendSpan span) => switch (span) {
  SendSpan.everything => context.l.shareSpanEverything,
  SendSpan.year => context.l.shareSpanYear,
  SendSpan.months6 => context.l.shareSpanMonths(6),
  SendSpan.months3 => context.l.shareSpanMonths(3),
  SendSpan.latest => context.l.shareSpanLatest,
};

enum _Stage { who, what, codes }
