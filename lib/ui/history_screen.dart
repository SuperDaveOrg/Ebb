import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:ebb/data/cycle_repository.dart';
import 'package:ebb/domain/dates.dart';
import 'package:ebb/domain/predictor.dart';
import 'package:ebb/models/cycle.dart';
import 'package:ebb/ui/cycle_editor.dart';
import 'package:ebb/ui/layout.dart';
import 'package:ebb/ui/section.dart';
import 'package:ebb/ui/theme.dart';

/// Every recorded cycle, newest first.
class HistoryScreen extends StatefulWidget {
  const HistoryScreen({
    super.key,
    required this.repository,
    this.title = 'History',
    this.readOnly = false,
  });

  final CycleRepository repository;
  final String title;

  /// For a shared copy: cycles can be looked at, not added or changed.
  final bool readOnly;

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  static final _day = DateFormat.MMMEd();

  List<Cycle> _cycles = const [];

  /// What counts as "usual" here, for spotting gaps that look like a period
  /// went unlogged.
  CyclePrediction _prediction = CyclePrediction.empty;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final cycles = await widget.repository.allCycles();
    if (!mounted) return;
    setState(() {
      _cycles = cycles.reversed.toList();
      _prediction = const Predictor().predict(cycles);
      _loading = false;
    });
  }

  Future<void> _edit(Cycle cycle) => editCycle(
    context,
    repository: widget.repository,
    cycle: cycle,
    all: _cycles,
    onChanged: _load,
  );

  Future<void> _addPast() async {
    final added = await showCycleEditor(context, all: _cycles);
    if (added == null) return;
    await widget.repository.addCycle(added);
    await _load();
  }

  /// Days from this cycle's start to the next one's — the cycle length. Null
  /// for the current cycle, which hasn't finished.
  int? _lengthOf(int indexInReversedList) {
    // The list is newest-first, so the *following* cycle is the index before.
    if (indexInReversedList == 0) return null;
    final current = _cycles[indexInReversedList];
    final following = _cycles[indexInReversedList - 1];
    return daysBetween(current.start, following.start);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Newest first, grouped by the year each period started.
    final years = <int, List<int>>{};
    for (var i = 0; i < _cycles.length; i++) {
      years.putIfAbsent(_cycles[i].start.year, () => []).add(i);
    }

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      floatingActionButton: _loading || widget.readOnly
          ? null
          : FloatingActionButton.extended(
              onPressed: _addPast,
              icon: const Icon(Icons.add),
              label: const Text('Add past period'),
            ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _cycles.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Text(
                  'No cycles recorded yet. If you remember when recent '
                  'periods started, adding them gives Ebb a head start.',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge,
                ),
              ),
            )
          : ListView(
              // Keep the last row clear of the floating button.
              padding: readablePadding(
                context,
                base: const EdgeInsets.only(bottom: 96),
              ),
              children: [
                for (final entry in years.entries)
                  Section(
                    title: '${entry.key}',
                    children: [for (final i in entry.value) _row(context, i)],
                  ),
              ],
            ),
    );
  }

  Widget _row(BuildContext context, int i) {
    final theme = Theme.of(context);
    final cycle = _cycles[i];
    final length = _lengthOf(i);
    final periodLength = cycle.periodLength;

    final String detail;
    if (periodLength != null) {
      detail = '$periodLength-day period';
    } else if (i == 0 && cycle.inProgressOn(today())) {
      detail = 'Period in progress';
    } else {
      detail = 'End not recorded';
    }

    // A gap long enough that a period in it probably went unlogged. Only a
    // hint: nothing is assumed about the history itself.
    final String? gap = length != null
        ? (_prediction.spansUnloggedPeriod(length)
              ? 'A long gap. If a period here wasn’t logged, add it with '
                    '“Add past period”.'
              : null)
        : (_prediction.unloggedCycles > 0
              ? 'Nothing logged since. If a period was missed, add it with '
                    '“Add past period”.'
              : null);
    final notes = cycle.notes;

    return InkWell(
      onTap: widget.readOnly ? null : () => _edit(cycle),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _day.format(cycle.start),
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    cycle.excluded ? '$detail · not counted' : detail,
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 8),
                  _CycleBar(
                    periodDays: periodLength ?? (i == 0 ? 1 : 0),
                    cycleDays: length,
                    excluded: cycle.excluded,
                  ),
                  if (notes != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      notes,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                  if (gap != null) ...[
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.history_toggle_off,
                          size: 16,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            gap,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 12),
            if (length != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('$length', style: theme.textTheme.titleLarge),
                  Text('day cycle', style: theme.textTheme.bodySmall),
                ],
              )
            else
              // "Current" only while it plausibly is; once Ebb assumes
              // periods went unlogged since, it's just the latest one logged.
              Text(
                _prediction.unloggedCycles > 0 ? 'Last logged' : 'Current',
                style: theme.textTheme.labelMedium,
              ),
          ],
        ),
      ),
    );
  }
}

/// A cycle drawn to scale: the whole bar is the cycle, the warm part is the
/// period. Rows line up, so a glance down the list shows the rhythm.
class _CycleBar extends StatelessWidget {
  const _CycleBar({
    required this.periodDays,
    required this.cycleDays,
    required this.excluded,
  });

  final int periodDays;

  /// Null for the current cycle, which hasn't finished.
  final int? cycleDays;
  final bool excluded;

  /// Anything longer is drawn full width.
  static const _scaleDays = 45;

  @override
  Widget build(BuildContext context) {
    final colors = EbbColors.of(context);
    return LayoutBuilder(
      builder: (context, box) {
        final perDay = box.maxWidth / _scaleDays;
        final total = (cycleDays ?? periodDays).clamp(1, _scaleDays);
        return SizedBox(
          height: 6,
          width: box.maxWidth,
          child: Stack(
            children: [
              Container(
                width: total * perDay,
                decoration: BoxDecoration(
                  color: cycleDays == null ? Colors.transparent : colors.track,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              Container(
                width: periodDays.clamp(0, total) * perDay,
                decoration: BoxDecoration(
                  color: excluded ? colors.elapsed : colors.period,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
