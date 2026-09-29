import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:ebb/data/cycle_repository.dart';
import 'package:ebb/domain/cycle_rules.dart';
import 'package:ebb/domain/dates.dart';
import 'package:ebb/domain/predictor.dart';
import 'package:ebb/models/cycle.dart';
import 'package:ebb/models/profile.dart';
import 'package:ebb/services/notification_service.dart';
import 'package:ebb/services/reminder_sync.dart';
import 'package:ebb/services/settings_service.dart';
import 'package:ebb/ui/calendar_screen.dart';
import 'package:ebb/ui/charts_screen.dart';
import 'package:ebb/ui/cycle_editor.dart';
import 'package:ebb/ui/cycle_ring.dart';
import 'package:ebb/ui/history_screen.dart';
import 'package:ebb/ui/layout.dart';
import 'package:ebb/ui/people.dart';
import 'package:ebb/ui/settings_screen.dart';
import 'package:ebb/ui/theme.dart';
import 'package:ebb/ui/wording.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.profile,
    required this.people,
    required this.repository,
    required this.settings,
    required this.notifications,
    required this.onSwitch,
    required this.onAddPerson,
    required this.onPeopleChanged,
  });

  /// Whose cycle this screen shows.
  final Profile profile;

  /// Everyone on the phone. Almost always just [profile].
  final List<Profile> people;
  final CycleRepository repository;
  final SettingsService settings;
  final NotificationService notifications;
  final void Function(Profile) onSwitch;
  final Future<void> Function() onAddPerson;

  /// Re-read everyone; switch to [show] if given.
  final Future<void> Function({int? show}) onPeopleChanged;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  static const _predictor = Predictor();

  List<Cycle> _cycles = const [];
  CyclePrediction _prediction = CyclePrediction.empty;
  bool _showFertileWindow = false;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _refresh();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// Coming back to Ebb may mean a new day, or a new time zone: recount the
  /// days and reschedule reminders for where she is now.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) _refresh();
  }

  Who get _who => Who(widget.profile);

  bool get _hasPeople => widget.people.length > 1;

  Future<void> _refresh() async {
    final cycles = await widget.repository.allCycles();
    final showFertile = await widget.settings.showFertileWindow();
    final prediction = _predictor.predict(cycles);

    await syncAllReminders(widget.notifications);

    if (!mounted) return;
    setState(() {
      _cycles = cycles;
      _prediction = prediction;
      _showFertileWindow = showFertile;
      _loading = false;
    });
  }

  Cycle? get _current => _cycles.isEmpty ? null : _cycles.last;

  bool get _periodInProgress => _current?.inProgressOn(today()) ?? false;

  /// The latest period has no end logged, and it's too long ago to still be
  /// going.
  bool get _endMissing {
    final c = _current;
    return c != null && c.end == null && !_periodInProgress;
  }

  /// Ebb has assumed a period went unlogged, and should offer to add it.
  bool get _assumesMissed =>
      !_periodInProgress && _prediction.unloggedCycles > 0;

  Future<void> _startPeriod([DateTime? on]) async {
    final day = on ?? today();
    if (!_allowed(Cycle(start: day))) return;
    await widget.repository.startPeriod(day);
    await _refresh();
  }

  Future<void> _endPeriod([DateTime? on]) async {
    final c = _current;
    if (c?.id == null) return;
    final day = on ?? today();
    if (on != null && !_allowed(c!.copyWith(end: day))) return;
    await widget.repository.endPeriod(c!.id!, day);
    await _refresh();
  }

  /// Checks an entry against the rest of the history, explaining any problem
  /// instead of saving it.
  bool _allowed(Cycle candidate) {
    final problem = checkCycle(candidate, _cycles);
    if (problem == null) return true;
    if (!mounted) return false;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(describeCycleProblem(problem))));
    return false;
  }

  Future<DateTime?> _pickEarlierDay({
    required DateTime firstDate,
    DateTime? lastDate,
    required String helpText,
  }) async {
    // If the last period ended today there is no valid earlier day; allow
    // today anyway and let checkCycle explain why it doesn't fit.
    final first = firstDate.isAfter(today()) ? today() : firstDate;
    final last = lastDate == null || lastDate.isAfter(today())
        ? today()
        : lastDate;
    final yesterday = addDays(today(), -1);
    final picked = await showDatePicker(
      context: context,
      initialDate: yesterday.isBefore(first)
          ? first
          : yesterday.isAfter(last)
          ? last
          : yesterday,
      firstDate: first,
      lastDate: last,
      helpText: helpText,
    );
    return picked == null ? null : dateOnly(picked);
  }

  Future<void> _startedEarlier() async {
    final last = _current;
    final lastEnd = last?.end;
    final day = await _pickEarlierDay(
      // Nothing before the last recorded period is reachable from here;
      // older gaps are filled in from History.
      firstDate: lastEnd != null
          ? addDays(lastEnd, 1)
          : last != null
          ? addDays(last.start, 1)
          : addDays(today(), -90),
      helpText: 'When did it start?',
    );
    if (day != null) await _startPeriod(day);
  }

  Future<void> _endedEarlier() async {
    final c = _current;
    if (c == null) return;
    final day = await _pickEarlierDay(
      firstDate: c.start,
      lastDate: addDays(c.start, Cycle.maxPeriodDays - 1),
      helpText: 'When did it end?',
    );
    if (day != null) await _endPeriod(day);
  }

  Future<void> _addPastPeriod() async {
    final added = await showCycleEditor(context, all: _cycles);
    if (added == null) return;
    await widget.repository.addCycle(added);
    await _refresh();
  }

  Future<void> _openPeople() async {
    final choice = await showPeopleSheet(
      context,
      people: widget.people,
      current: widget.profile,
    );
    switch (choice) {
      case SwitchTo(:final profile):
        if (profile.id != widget.profile.id) widget.onSwitch(profile);
      case AddSomeone():
        await widget.onAddPerson();
      case null:
        break;
    }
  }

  Future<void> _openSettings() async {
    final action = await Navigator.of(context).push<SettingsAction>(
      MaterialPageRoute(
        builder: (_) => SettingsScreen(
          profile: widget.profile,
          people: widget.people,
          settings: widget.settings,
          notifications: widget.notifications,
        ),
      ),
    );
    // Settings may have renamed, removed or restored people; this screen may
    // not even belong to anyone any more, so let the app decide first.
    switch (action) {
      case ShowPersonAction(:final profileId):
        await widget.onPeopleChanged(show: profileId);
      case AddPersonAction():
        await widget.onPeopleChanged();
        await widget.onAddPerson();
      case null:
        await widget.onPeopleChanged();
    }
    if (mounted) await _refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // With one person the title is just the app's name. With more, it
        // names whose cycle this is and opens the switcher.
        title: _hasPeople
            ? InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: _openPeople,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 6,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          Who.label(widget.profile),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
              )
            : const Text('Ebb'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_month_outlined),
            tooltip: 'Calendar',
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => CalendarScreen(
                    who: _who,
                    repository: widget.repository,
                    settings: widget.settings,
                    title: _hasPeople
                        ? '${_who.whoseCap} calendar'
                        : 'Calendar',
                  ),
                ),
              );
              await _refresh();
            },
          ),
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: 'History',
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => HistoryScreen(
                    repository: widget.repository,
                    title: _hasPeople ? '${_who.whoseCap} history' : 'History',
                  ),
                ),
              );
              await _refresh();
            },
          ),
          IconButton(
            icon: const Icon(Icons.insights_outlined),
            tooltip: 'Charts',
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => ChartsScreen(
                  repository: widget.repository,
                  settings: widget.settings,
                  title: _hasPeople ? '${_who.whoseCap} charts' : 'Charts',
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            tooltip: 'Settings',
            onPressed: _openSettings,
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(onRefresh: _refresh, child: _body(context)),
    );
  }

  /// One column on phones; on wide screens the ring gets the left half and
  /// the estimate and buttons the right, so nothing needs scrolling.
  Widget _body(BuildContext context) {
    final wide = isWide(context);
    final width = MediaQuery.sizeOf(context).width;

    final status = _StatusCard(
      who: _who,
      current: _current,
      prediction: _prediction,
      periodInProgress: _periodInProgress,
      onAddPast: _cycles.isEmpty || _assumesMissed ? _addPastPeriod : null,
      ringSize: wide ? 320 : (width >= 600 ? 288 : 248),
    );
    final details = <Widget>[
      if (_prediction.hasPrediction) ...[
        _PredictionCard(
          who: _who,
          prediction: _prediction,
          showFertileWindow: _showFertileWindow,
        ),
        const SizedBox(height: 20),
      ],
      if (_periodInProgress) ...[
        FilledButton.tonalIcon(
          onPressed: _endPeriod,
          icon: const Icon(Icons.check),
          label: Text('${_who.mine} period ended today'),
        ),
        TextButton(
          onPressed: _endedEarlier,
          child: const Text('It ended on an earlier day'),
        ),
      ] else ...[
        FilledButton.icon(
          onPressed: _startPeriod,
          icon: const Icon(Icons.water_drop_outlined),
          label: Text('${_who.mine} period started today'),
        ),
        TextButton(
          onPressed: _startedEarlier,
          child: const Text('It started on an earlier day'),
        ),
        if (_endMissing)
          TextButton(
            onPressed: _endedEarlier,
            child: Text('Add when ${_who.whose} last period ended'),
          ),
      ],
    ];

    const base = EdgeInsets.fromLTRB(16, 8, 16, 32);
    if (!wide) {
      return ListView(
        padding: readablePadding(context, base: base),
        children: [status, const SizedBox(height: 12), ...details],
      );
    }
    // Centred on screen when it fits, as it does on a landscape tablet;
    // still scrollable (and pull-to-refresh) when it doesn't.
    final padding = readablePadding(
      context,
      base: base,
      maxWidth: wideContentWidth,
    );
    return LayoutBuilder(
      builder: (context, box) => SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: padding,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: math.max(0, box.maxHeight - padding.vertical),
          ),
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(flex: 11, child: status),
                const SizedBox(width: 24),
                Expanded(
                  flex: 9,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: details,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Where she is right now: day of cycle, or day N of her period.
class _StatusCard extends StatelessWidget {
  const _StatusCard({
    required this.who,
    required this.current,
    required this.prediction,
    required this.periodInProgress,
    this.onAddPast,
    this.ringSize = 248,
  });

  final Who who;
  final double ringSize;

  /// The latest recorded cycle, for how many period days to draw.
  final Cycle? current;
  final CyclePrediction prediction;
  final bool periodInProgress;

  /// Offered while nothing is logged, so past periods can be filled in
  /// straight away instead of waiting a month for the first one.
  final VoidCallback? onAddPast;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final day = prediction.dayOfCycle;
    final missed = !periodInProgress && prediction.unloggedCycles > 0;

    final String headline;
    final String detail;

    if (missed) {
      headline =
          'No period logged since '
          '${DateFormat.MMMd().format(prediction.lastStart!)}';
      detail = prediction.unloggedCycles == 1
          ? 'Ebb has assumed a period went unlogged and estimated from '
                'there. If you remember when it started, add it to put the '
                'estimate right.'
          : 'Ebb has assumed some periods went unlogged and estimated from '
                'there. If you remember when any started, add them to put the '
                'estimate right.';
    } else if (day == null) {
      headline = who.isOwner ? 'Welcome to Ebb' : 'Nothing logged yet';
      detail =
          'Log the first day of ${who.whose} next period, or add past '
          'periods if you remember them, and Ebb will start learning '
          '${who.isOwner ? 'your' : 'the'} rhythm. Everything stays on this '
          'phone.';
    } else if (periodInProgress) {
      headline = 'Day $day of ${who.whose} period';
      detail = 'Let Ebb know when it ends so the estimate stays accurate.';
    } else {
      headline = 'Day $day of ${who.whose} cycle';
      final until = prediction.daysUntilNext;
      detail = until == null
          ? ''
          : until > 1
          ? 'About $until days until ${who.whose} period is expected.'
          : until == 1
          ? '${who.whoseCap} period is expected tomorrow.'
          : until == 0
          ? '${who.whoseCap} period is expected today.'
          : '${-until} days later than expected. '
                'Cycles shift for all sorts of reasons.';
    }

    final p = prediction;
    if (!missed &&
        day != null &&
        p.nextStart != null &&
        p.cycleLength != null) {
      // Everything on the ring is measured in days of this cycle.
      final start = addDays(p.nextStart!, -p.cycleLength!);
      int dayOf(DateTime d) => daysBetween(start, d) + 1;
      final colors = EbbColors.of(context);

      return Card(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 28, 20, 22),
          child: Column(
            children: [
              CycleRing(
                day: day,
                cycleLength: p.cycleLength!,
                periodDays: periodInProgress
                    ? day
                    : current?.periodLength ?? p.periodLength ?? 0,
                windowStart: p.earliest == null ? null : dayOf(p.earliest!),
                windowEnd: p.latest == null ? null : dayOf(p.latest!),
                inPeriod: periodInProgress,
                label:
                    'of ${who.whose} ${periodInProgress ? 'period' : 'cycle'}',
                size: ringSize,
              ),
              const SizedBox(height: 18),
              if (detail.isNotEmpty)
                Text(
                  detail,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge,
                ),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _Key(color: colors.period, text: 'Period'),
                  const SizedBox(width: 18),
                  _Key(color: colors.window, text: 'Likely next'),
                  const SizedBox(width: 18),
                  _Key(
                    color: theme.colorScheme.primary,
                    text: 'Today',
                    dot: true,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(22, 24, 22, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(headline, style: theme.textTheme.headlineMedium),
            if (detail.isNotEmpty) ...[
              const SizedBox(height: 10),
              Text(detail, style: theme.textTheme.bodyLarge),
            ],
            if (onAddPast != null) ...[
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: onAddPast,
                  icon: const Icon(Icons.add),
                  label: Text(
                    current == null
                        ? 'Add past periods'
                        : 'Add a missed period',
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// One entry in the ring's key.
class _Key extends StatelessWidget {
  const _Key({required this.color, required this.text, this.dot = false});

  final Color color;
  final String text;
  final bool dot;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: dot ? 10 : 16,
          height: dot ? 10 : 6,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(width: 6),
        Text(text, style: Theme.of(context).textTheme.labelMedium),
      ],
    );
  }
}

/// The estimate, stated with its uncertainty rather than as a bare date.
class _PredictionCard extends StatelessWidget {
  const _PredictionCard({
    required this.who,
    required this.prediction,
    required this.showFertileWindow,
  });

  final Who who;
  final CyclePrediction prediction;
  final bool showFertileWindow;

  static final _fmt = DateFormat.MMMEd();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final p = prediction;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Next period', style: theme.textTheme.titleMedium),
            const SizedBox(height: 6),
            Text(
              _fmt.format(p.nextStart!),
              style: theme.textTheme.headlineSmall,
            ),
            const SizedBox(height: 4),
            Text(
              'likely between ${_fmt.format(p.earliest!)} '
              'and ${_fmt.format(p.latest!)}',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 14),
            _ConfidenceNote(who: who, prediction: p),
            if (showFertileWindow && p.fertileStart != null) ...[
              const Divider(height: 28),
              Text(
                'Estimated fertile window',
                style: theme.textTheme.titleSmall,
              ),
              const SizedBox(height: 4),
              Text(
                '${_fmt.format(p.fertileStart!)} – ${_fmt.format(p.fertileEnd!)}',
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 6),
              Text(
                'An estimate based on cycle timing alone. Not reliable enough '
                'to use as contraception.',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Says plainly how much history the estimate rests on.
class _ConfidenceNote extends StatelessWidget {
  const _ConfidenceNote({required this.who, required this.prediction});

  final Who who;
  final CyclePrediction prediction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final p = prediction;

    final (IconData icon, String text) = switch (p.confidence) {
      _ when p.unloggedCycles > 0 => (
        Icons.history_toggle_off,
        'Estimated from the last period logged, on '
            '${DateFormat.MMMd().format(p.lastStart!)}, so it may be less '
            'accurate than usual.',
      ),
      PredictionConfidence.none => (Icons.help_outline, 'Nothing logged yet.'),
      PredictionConfidence.low => (
        Icons.trending_up,
        p.observedCycles == 0
            ? 'Based on a typical 28-day cycle for now. This will get more '
                  'accurate as you log.'
            : 'Based on ${p.observedCycles} cycle'
                  '${p.observedCycles == 1 ? '' : 's'} so far, so it may be '
                  'less accurate for now.',
      ),
      PredictionConfidence.moderate => (
        Icons.show_chart,
        p.isIrregular
            ? '${who.whoseCap} cycles vary quite a bit, so this is a wide '
                  'estimate rather than a firm date.'
            : 'Based on ${who.whose} last ${p.observedCycles} cycles.',
      ),
      PredictionConfidence.good => (
        Icons.check_circle_outline,
        'Based on ${p.observedCycles} fairly consistent cycles.',
      ),
    };

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: theme.colorScheme.onSurfaceVariant),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }
}
