import 'package:flutter/material.dart';

import 'package:ebb/data/cycle_repository.dart';
import 'package:ebb/domain/calendar.dart';
import 'package:ebb/domain/dates.dart';
import 'package:ebb/domain/day_charts.dart';
import 'package:ebb/domain/moon.dart';
import 'package:ebb/domain/predictor.dart';
import 'package:ebb/domain/temperature.dart';
import 'package:ebb/l10n/app_localizations.dart';
import 'package:ebb/models/cycle.dart';
import 'package:ebb/models/day_log.dart';
import 'package:ebb/services/settings_service.dart';
import 'package:ebb/ui/charts.dart';
import 'package:ebb/ui/date_span.dart';
import 'package:ebb/ui/day_log_words.dart';
import 'package:ebb/ui/face_picker.dart';
import 'package:ebb/ui/language.dart';
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
    this.title,
  });

  final CycleRepository repository;
  final SettingsService settings;

  /// "Charts" when null.
  final String? title;

  @override
  State<ChartsScreen> createState() => _ChartsScreenState();
}

class _ChartsScreenState extends State<ChartsScreen> {
  List<Cycle> _cycles = const [];
  List<DayLog> _logs = const [];
  CyclePrediction _prediction = CyclePrediction.empty;
  bool _showMoon = false;
  bool _tracksTemperature = false;
  TemperatureUnit _unit = TemperatureUnit.celsius;
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
    final temperature = await widget.settings.tracksTemperature();
    final unit = await SettingsService.temperatureUnit();
    if (!mounted) return;
    setState(() {
      _cycles = cycles;
      _logs = logs;
      _prediction = const Predictor().predict(cycles);
      _showMoon = moon;
      _tracksTemperature = temperature;
      _unit = unit;
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
      appBar: AppBar(title: Text(widget.title ?? context.l.chartsTitle)),
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
                // Also for anyone who has turned tracking off since, or a
                // shared copy that came with readings.
                if (_tracksTemperature ||
                    _logs.any((l) => l.hasTemperatureOrMucus))
                  _temperature(context, logs, marks, from, to),
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
      title: context.l.chartsDayRating,
      children: [
        if (days.every((d) => d.rating == null))
          _empty(context, context.l.chartsNoRatings)
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
                    segments: [
                      ButtonSegment(
                        value: TimelineStyle.bars,
                        icon: const Icon(Icons.bar_chart),
                        label: Text(context.l.chartsBars),
                      ),
                      ButtonSegment(
                        value: TimelineStyle.line,
                        icon: const Icon(Icons.show_chart),
                        label: Text(context.l.chartsLine),
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
                  [
                    bars
                        ? context.l.chartsRatingCaptionBars
                        : context.l.chartsRatingCaptionLine,
                    if (_showMoon) context.l.chartsRatingCaptionMoon,
                  ].join(' '),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _temperature(
    BuildContext context,
    List<DayLog> logs,
    CalendarMarks marks,
    DateTime from,
    DateTime to,
  ) {
    final days = temperatureTimeline(marks, logs, from: from, to: to);
    return Section(
      title: context.l.chartsTemperatureTitle,
      children: [
        if (!days.any(
          (d) =>
              d.temperature != null ||
              d.mucusFeel != null ||
              d.mucusLook != null,
        ))
          _empty(context, context.l.chartsTemperatureEmpty)
        else
          _padded(
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TemperatureChart(days: days, unit: _unit),
                const SizedBox(height: 8),
                _caption(
                  context,
                  context.l.chartsTemperatureCaption(_unit.symbol),
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
      title: context.l.chartsFeelings,
      children: [
        _padded(
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_showMoon) ...[
                SegmentedButton<_FeelingsBy>(
                  showSelectedIcon: false,
                  style: _compact(context),
                  segments: [
                    ButtonSegment(
                      value: _FeelingsBy.periods,
                      label: Text(context.l.chartsAroundPeriods),
                    ),
                    ButtonSegment(
                      value: _FeelingsBy.moon,
                      label: Text(context.l.chartsAroundMoon),
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
                      ? context.l.chartsFeelingsEmptyMoon
                      : context.l.chartsFeelingsEmptyPeriods,
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
                      ? context.l.chartsFeelingsCaptionMoon
                      : context.l.chartsFeelingsCaptionPeriods,
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

  String _name(DayFeeling f) => f.named?.word ?? faceName(f.emoji);

  String _title(AppLocalizations l) => switch (group.kind) {
    FeelingDays.duringPeriod => l.chartsGroupDuringPeriod,
    FeelingDays.beforePeriod => l.chartsGroupBeforePeriod,
    FeelingDays.restOfCycle ||
    FeelingDays.restOfMonth => l.chartsGroupOtherDays,
    FeelingDays.nearFullMoon => l.chartsGroupFullMoon,
    FeelingDays.nearNewMoon => l.chartsGroupNewMoon,
  };

  /// Which days the group covers, briefly: "the 5 days before".
  String _detail(AppLocalizations l) {
    final span = group.span;
    return switch (group.kind) {
      FeelingDays.duringPeriod => span == null
          ? l.chartsDetailLoggedPeriodDays
          : l.chartsDetailUsuallyDays(span),
      FeelingDays.beforePeriod => l.chartsDetailDaysBefore(span!),
      FeelingDays.restOfCycle => l.chartsDetailRestOfCycle,
      FeelingDays.nearFullMoon || FeelingDays.nearNewMoon => span == 0
          ? l.chartsDetailDayItself
          : l.chartsDetailDayEitherSide(span!),
      FeelingDays.restOfMonth => l.chartsDetailRestOfMonth,
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final g = group;
    final l = context.l;
    final title = _title(l), detail = _detail(l);
    return Semantics(
      label: l.chartsFeelingGroupSummary(
        title,
        detail,
        g.counts.isEmpty
            ? l.chartsFeelingGroupNone
            : g.counts
                  .map((c) => l.chartsFeelingCount(_name(c.$1), c.$2))
                  .join(', '),
      ),
      excludeSemantics: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(text: title),
                TextSpan(
                  text: '  ($detail)',
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
              l.chartsNoneYet,
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
