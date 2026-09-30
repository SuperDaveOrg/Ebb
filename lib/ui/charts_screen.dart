import 'package:flutter/material.dart';

import 'package:ebb/data/cycle_repository.dart';
import 'package:ebb/domain/calendar.dart';
import 'package:ebb/domain/dates.dart';
import 'package:ebb/domain/day_charts.dart';
import 'package:ebb/domain/moon.dart';
import 'package:ebb/domain/predictor.dart';
import 'package:ebb/models/cycle.dart';
import 'package:ebb/models/day_log.dart';
import 'package:ebb/services/settings_service.dart';
import 'package:ebb/ui/charts.dart';
import 'package:ebb/ui/date_span.dart';
import 'package:ebb/ui/face_picker.dart';
import 'package:ebb/ui/layout.dart';
import 'package:ebb/ui/section.dart';

/// How feelings are grouped.
enum _FeelingsBy { periods, moon }

/// Day ratings and feelings, laid against the cycle and, for anyone who has
/// turned the moon on, against the moon.
///
/// Shows what was logged and says nothing about what it means: see
/// lib/domain/day_charts.dart.
class ChartsScreen extends StatefulWidget {
  const ChartsScreen({
    super.key,
    required this.repository,
    required this.settings,
    this.title = 'Charts',
  });

  final CycleRepository repository;
  final SettingsService settings;
  final String title;

  @override
  State<ChartsScreen> createState() => _ChartsScreenState();
}

class _ChartsScreenState extends State<ChartsScreen> {
  List<Cycle> _cycles = const [];
  List<DayLog> _logs = const [];
  CyclePrediction _prediction = CyclePrediction.empty;
  bool _showMoon = false;
  bool _loading = true;

  DateSpan _span = const DateSpan(SpanChoice.months3);
  TimelineStyle _style = TimelineStyle.bars;
  _FeelingsBy _feelingsBy = _FeelingsBy.periods;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final cycles = await widget.repository.allCycles();
    final logs = await widget.repository.allLogs();
    final moon = await widget.settings.showMoonPhases();
    if (!mounted) return;
    setState(() {
      _cycles = cycles;
      _logs = logs;
      _prediction = const Predictor().predict(cycles);
      _showMoon = moon;
      _loading = false;
    });
  }

  /// The first day anything was logged, for "All" and the date picker.
  DateTime get _earliest {
    final dates = [
      ..._cycles.map((c) => c.start),
      ..._logs.map((l) => dateOnly(l.date)),
    ];
    if (dates.isEmpty) return addDays(today(), -90);
    return dates.reduce((a, b) => a.isBefore(b) ? a : b);
  }

  @override
  Widget build(BuildContext context) {
    if (!_showMoon) _feelingsBy = _FeelingsBy.periods;

    final (from, to) = _span.resolve(_earliest);
    final logs = [
      for (final l in _logs)
        if (!l.date.isBefore(from) && !dateOnly(l.date).isAfter(to)) l,
    ];
    final marks = CalendarMarks(_cycles, _prediction);

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
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
                _timeline(context, logs, marks, from, to),
                _feelings(context, logs, marks),
              ],
            ),
    );
  }

  /// Toggles here sit beside other controls, so a size smaller.
  ButtonStyle _compact(BuildContext context) => SegmentedButton.styleFrom(
    textStyle: Theme.of(context).textTheme.labelMedium,
    padding: const EdgeInsets.symmetric(horizontal: 8),
  );

  Widget _padded(Widget child) =>
      Padding(padding: const EdgeInsets.all(16), child: child);

  Text _caption(BuildContext context, String text, {bool center = false}) {
    final theme = Theme.of(context);
    return Text(
      text,
      textAlign: center ? TextAlign.center : null,
      style: theme.textTheme.bodySmall?.copyWith(
        color: theme.colorScheme.onSurfaceVariant,
      ),
    );
  }

  Widget _empty(BuildContext context, String text) =>
      _padded(Text(text, style: Theme.of(context).textTheme.bodyMedium));

  Widget _timeline(
    BuildContext context,
    List<DayLog> logs,
    CalendarMarks marks,
    DateTime from,
    DateTime to,
  ) {
    final days = ratingTimeline(marks, logs, from: from, to: to);
    final bars = _style == TimelineStyle.bars;
    return Section(
      title: 'Day rating',
      children: [
        if (days.every((d) => d.rating == null))
          _empty(context, 'No days in this range have a rating yet.')
        else
          _padded(
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: SegmentedButton<TimelineStyle>(
                    showSelectedIcon: false,
                    style: _compact(context),
                    segments: const [
                      ButtonSegment(
                        value: TimelineStyle.bars,
                        icon: Icon(Icons.bar_chart),
                        label: Text('Bars'),
                      ),
                      ButtonSegment(
                        value: TimelineStyle.line,
                        icon: Icon(Icons.show_chart),
                        label: Text('Line'),
                      ),
                    ],
                    selected: {_style},
                    onSelectionChanged: (s) =>
                        setState(() => _style = s.single),
                  ),
                ),
                const SizedBox(height: 12),
                RatingTimelineChart(
                  days: days,
                  style: _style,
                  moons: _showMoon ? moonPhasesByDay(from, to) : null,
                ),
                const SizedBox(height: 8),
                _caption(
                  context,
                  '${bars ? 'Each bar is one day’s rating' : 'Each point is one day’s rating, joined to the next day’s when both were rated'}, '
                  '1 to 5. Period days are shaded.'
                  '${_showMoon ? ' Moons mark the moon’s phases; over a long range, only the new and full moons, or just the full ones.' : ''}',
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _feelings(
    BuildContext context,
    List<DayLog> logs,
    CalendarMarks marks,
  ) {
    final byMoon = _feelingsBy == _FeelingsBy.moon;
    final groups = byMoon
        ? feelingsAroundMoon(logs)
        : feelingsAroundPeriods(
            _cycles,
            logs,
            marks,
            usualPeriodLength: _prediction.periodLength,
          );
    final total = groups.fold(0, (n, g) => n + g.days);
    return Section(
      title: 'Feelings',
      children: [
        _padded(
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_showMoon) ...[
                SegmentedButton<_FeelingsBy>(
                  showSelectedIcon: false,
                  style: _compact(context),
                  segments: const [
                    ButtonSegment(
                      value: _FeelingsBy.periods,
                      label: Text('Around periods'),
                    ),
                    ButtonSegment(
                      value: _FeelingsBy.moon,
                      label: Text('Around the moon'),
                    ),
                  ],
                  selected: {_feelingsBy},
                  onSelectionChanged: (s) =>
                      setState(() => _feelingsBy = s.single),
                ),
                const SizedBox(height: 16),
              ],
              if (total == 0)
                Text(
                  byMoon
                      ? 'Once you’ve picked how you felt on some days in this '
                            'range, this shows which feelings came around full '
                            'and new moons.'
                      : 'Once you’ve picked how you felt on some days in this '
                            'range, and a period has started since, this shows '
                            'which feelings came when.',
                  style: Theme.of(context).textTheme.bodyMedium,
                )
              else ...[
                for (final g in groups) ...[
                  _FeelingGroup(group: g),
                  const SizedBox(height: 16),
                ],
                _caption(
                  context,
                  byMoon
                      ? 'How many days each face was picked.'
                      : 'How many days each face was picked. Days since the '
                            'latest period started aren’t counted until the '
                            'next one does.',
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

/// One group's feelings, most picked first.
class _FeelingGroup extends StatelessWidget {
  const _FeelingGroup({required this.group});

  final FeelingGroup group;

  String _name(DayFeeling f) => f.named?.label ?? faceName(f.emoji);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final g = group;
    String times(int n) => '$n day${n == 1 ? '' : 's'}';
    return Semantics(
      label:
          '${g.title}, ${g.detail}: '
          '${g.counts.isEmpty ? 'none yet' : g.counts.map((c) => '${_name(c.$1)} on ${times(c.$2)}').join(', ')}',
      excludeSemantics: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(text: g.title),
                TextSpan(
                  text: '  (${g.detail})',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            style: theme.textTheme.titleSmall,
          ),
          const SizedBox(height: 8),
          if (g.counts.isEmpty)
            Text(
              'None yet.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            )
          else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final (feeling, n) in g.counts)
                  Container(
                    padding: const EdgeInsets.fromLTRB(8, 4, 12, 4),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: feeling.emoji,
                            style: const TextStyle(fontSize: 18),
                          ),
                          TextSpan(
                            text: '  $n',
                            style: theme.textTheme.labelLarge,
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
