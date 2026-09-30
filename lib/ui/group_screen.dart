import 'package:flutter/material.dart';

import 'package:ebb/data/cycle_repository.dart';
import 'package:ebb/data/group_repository.dart';
import 'package:ebb/data/profile_repository.dart';
import 'package:ebb/domain/calendar.dart';
import 'package:ebb/domain/dates.dart';
import 'package:ebb/domain/day_charts.dart';
import 'package:ebb/domain/moon.dart';
import 'package:ebb/domain/predictor.dart';
import 'package:ebb/models/cycle.dart';
import 'package:ebb/models/person_group.dart';
import 'package:ebb/ui/charts.dart';
import 'package:ebb/ui/date_span.dart';
import 'package:ebb/ui/layout.dart';
import 'package:ebb/ui/section.dart';
import 'package:ebb/ui/wording.dart';

/// Everyone in a group, side by side against the moon.
///
/// The moon is always shown here, whatever each person's own setting: it's
/// what groups are for. Nothing is measured between the lanes — see
/// [GroupLanesChart].
class GroupScreen extends StatefulWidget {
  const GroupScreen({super.key, required this.groupId});

  final int groupId;

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

/// One member's history, loaded once.
class _Member {
  const _Member(this.name, this.cycles, this.marks);

  final String name;
  final List<Cycle> cycles;
  final CalendarMarks marks;
}

class _GroupScreenState extends State<GroupScreen> {
  PersonGroup? _group;
  List<_Member> _members = const [];
  DateSpan _span = const DateSpan(SpanChoice.months6);
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final group = (await GroupRepository().all())
        .where((g) => g.id == widget.groupId)
        .firstOrNull;
    final members = <_Member>[];
    if (group != null) {
      for (final p in await ProfileRepository().all()) {
        if (!group.memberIds.contains(p.id)) continue;
        final cycles = await CycleRepository(profileId: p.id!).allCycles();
        members.add(
          _Member(
            Who.label(p),
            cycles,
            CalendarMarks(cycles, const Predictor().predict(cycles)),
          ),
        );
      }
    }
    if (!mounted) return;
    setState(() {
      _group = group;
      _members = members;
      _loading = false;
    });
  }

  DateTime get _earliest {
    final starts = [
      for (final m in _members)
        for (final c in m.cycles) c.start,
    ];
    if (starts.isEmpty) return addDays(today(), -90);
    return starts.reduce((a, b) => a.isBefore(b) ? a : b);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final group = _group;
    final (from, to) = _span.resolve(_earliest);

    return Scaffold(
      appBar: AppBar(title: Text(group?.name ?? 'Group')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : group == null || _members.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Text(
                  'No one is in this group yet. Add them in Settings → '
                  'Advanced → Manage groups: tick people already on this '
                  'phone, or add someone from their phone.',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge,
                ),
              ),
            )
          : ListView(
              padding: readablePadding(
                context,
                base: const EdgeInsets.only(bottom: 32),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: DateSpanButton(
                      span: _span,
                      earliest: _earliest,
                      onChanged: (s) => setState(() => _span = s),
                    ),
                  ),
                ),
                Section(
                  title: 'Periods',
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          GroupLanesChart(
                            from: from,
                            to: to,
                            lanes: [
                              for (final m in _members)
                                GroupLane(
                                  m.name,
                                  periodRuns(m.marks, from: from, to: to),
                                ),
                            ],
                            moons: moonPhasesByDay(from, to),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Each bar is a period; an outline is one whose '
                            'end wasn’t logged, drawn at the usual length. '
                            'Solid lines run down from each full moon, '
                            'dashed ones from each new moon.',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
