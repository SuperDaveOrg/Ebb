import 'package:flutter/material.dart' hide Flow;
import 'package:intl/intl.dart';

import 'package:ebb/data/cycle_repository.dart';
import 'package:ebb/domain/calendar.dart';
import 'package:ebb/domain/cycle_rules.dart';
import 'package:ebb/domain/dates.dart';
import 'package:ebb/domain/moon.dart';
import 'package:ebb/domain/predictor.dart';
import 'package:ebb/models/cycle.dart';
import 'package:ebb/models/day_log.dart';
import 'package:ebb/services/settings_service.dart';
import 'package:ebb/ui/cycle_editor.dart';
import 'package:ebb/ui/face_picker.dart';
import 'package:ebb/ui/layout.dart';
import 'package:ebb/ui/moon_icon.dart';
import 'package:ebb/ui/theme.dart';
import 'package:ebb/ui/wording.dart';

/// The same history as the ring and History, laid out by month. Scrolls up
/// into the past and down to the next likely window, and no further.
class CalendarScreen extends StatefulWidget {
  const CalendarScreen({
    super.key,
    required this.who,
    required this.repository,
    required this.settings,
    this.title = 'Calendar',
    this.readOnly = false,
  });

  final Who who;
  final CycleRepository repository;
  final SettingsService settings;
  final String title;

  /// For a shared copy: days can be looked at, not logged.
  final bool readOnly;

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {

  /// A calendar reads best a little narrower than a list.
  static const _maxWidth = 560.0;

  final _thisMonth = GlobalKey();

  List<Cycle> _cycles = const [];
  CyclePrediction _prediction = CyclePrediction.empty;
  CalendarMarks _marks = CalendarMarks(const [], CyclePrediction.empty);
  Map<String, DayLog> _logs = const {};
  bool _showFertile = false;
  bool _showMoon = false;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final cycles = await widget.repository.allCycles();
    final logs = await widget.repository.allLogs();
    final fertile = await widget.settings.showFertileWindow();
    final moon = await widget.settings.showMoonPhases();
    final prediction = const Predictor().predict(cycles);
    if (!mounted) return;
    setState(() {
      _cycles = cycles;
      _prediction = prediction;
      _showFertile = fertile;
      _showMoon = moon;
      _marks = CalendarMarks(cycles, prediction, showFertile: fertile);
      _logs = {for (final l in logs) isoDate(l.date): l};
      _loading = false;
    });
  }

  /// First of each month from the month before anything was logged to the
  /// one holding the end of the likely window.
  ///
  /// The spare month at the start is room to fill history in by hand: log a
  /// period there and the calendar reaches back another month next time.
  (List<DateTime> past, List<DateTime> ahead) get _months {
    final now = today();
    final current = DateTime(now.year, now.month);
    final logged = [
      ..._cycles.map((c) => c.start),
      ..._logs.values.map((l) => dateOnly(l.date)),
    ];
    final earliest = logged.isEmpty
        ? current
        : logged.reduce((a, b) => a.isBefore(b) ? a : b);
    final first = DateTime(earliest.year, earliest.month - 1);
    final latest = _prediction.latest;
    final last = latest != null && latest.isAfter(now)
        ? DateTime(latest.year, latest.month)
        : current;

    final past = <DateTime>[];
    for (
      var m = DateTime(current.year, current.month - 1);
      !m.isBefore(first);
      m = DateTime(m.year, m.month - 1)
    ) {
      past.add(m);
    }
    final ahead = <DateTime>[];
    for (var m = current; !m.isAfter(last); m = DateTime(m.year, m.month + 1)) {
      ahead.add(m);
    }
    return (past, ahead);
  }

  Future<void> _openDay(DateTime day) async {
    final info = _marks.on(day);
    final result = await showModalBottomSheet<_DayResult>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => _DaySheet(
        day: day,
        info: info,
        who: widget.who,
        cycles: _cycles,
        prediction: _prediction,
        log: _logs[isoDate(day)],
        moon: _showMoon ? moonPhasesByDay(day, day)[isoDate(day)] : null,
        readOnly: widget.readOnly,
      ),
    );
    if (result == null || widget.readOnly) return;

    final log = result.log;
    if (log != null) await widget.repository.saveLog(log);

    switch (result.action) {
      case _Started():
        await widget.repository.startPeriod(day);
      case _MovedStart(:final cycle):
        await widget.repository.updateCycle(cycle.copyWith(start: day));
      case _Ended(:final cycle):
        await widget.repository.endPeriod(cycle.id!, day);
      case _Edit(:final cycle):
        await _load();
        if (mounted) await _edit(cycle);
        return;
      case null:
        break;
    }
    await _load();
  }

  Future<void> _edit(Cycle cycle) => editCycle(
    context,
    repository: widget.repository,
    cycle: cycle,
    all: _cycles,
    onChanged: _load,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: readablePadding(
                    context,
                    base: const EdgeInsets.fromLTRB(12, 0, 12, 6),
                    maxWidth: _maxWidth,
                  ),
                  child: const _WeekdayHeader(),
                ),
                const Divider(),
                Expanded(child: _monthList(context)),
                _Key(
                  showUnrecorded: _marks.hasUnrecorded,
                  showFertile: _showFertile && _prediction.fertileStart != null,
                  showLikely: _prediction.hasPrediction,
                ),
              ],
            ),
    );
  }

  /// Months before this one grow upwards from it, so the screen opens on
  /// the present with the past a scroll away.
  Widget _monthList(BuildContext context) {
    final (past, ahead) = _months;
    final moons = _showMoon
        ? moonPhasesByDay(
            past.isEmpty ? ahead.first : past.last,
            DateTime(ahead.last.year, ahead.last.month + 1, 0),
          )
        : const <String, MoonEvent>{};
    final padding = readablePadding(
      context,
      base: const EdgeInsets.symmetric(horizontal: 12),
      maxWidth: _maxWidth,
    );

    Widget month(DateTime m) => _Month(
      month: m,
      marks: _marks,
      logs: _logs,
      moons: moons,
      onTap: _openDay,
    );

    return CustomScrollView(
      center: _thisMonth,
      slivers: [
        SliverPadding(
          padding: padding,
          sliver: SliverList.builder(
            itemCount: past.length,
            itemBuilder: (_, i) => month(past[i]),
          ),
        ),
        SliverPadding(
          key: _thisMonth,
          padding: padding + const EdgeInsets.only(bottom: 24),
          sliver: SliverList.builder(
            itemCount: ahead.length,
            itemBuilder: (_, i) => month(ahead[i]),
          ),
        ),
      ],
    );
  }
}

/// Weekday initials, starting on the locale's first day of the week.
class _WeekdayHeader extends StatelessWidget {
  const _WeekdayHeader();

  @override
  Widget build(BuildContext context) {
    final l = MaterialLocalizations.of(context);
    final style = Theme.of(context).textTheme.labelMedium;
    return ExcludeSemantics(
      child: Row(
        children: [
          for (var i = 0; i < 7; i++)
            Expanded(
              child: Center(
                child: Text(
                  l.narrowWeekdays[(l.firstDayOfWeekIndex + i) % 7],
                  style: style,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// One month: its name, then a grid of days in weeks.
class _Month extends StatelessWidget {
  const _Month({
    required this.month,
    required this.marks,
    required this.logs,
    required this.moons,
    required this.onTap,
  });

  final DateTime month;
  final CalendarMarks marks;
  final Map<String, DayLog> logs;
  final Map<String, MoonEvent> moons;
  final void Function(DateTime) onTap;

  static final _title = DateFormat.yMMMM();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final firstDow = MaterialLocalizations.of(context).firstDayOfWeekIndex;
    // DateTime.weekday runs Monday = 1 to Sunday = 7; the localizations
    // count from Sunday = 0.
    final lead = (month.weekday % 7 - firstDow + 7) % 7;
    final days = DateTime(month.year, month.month + 1, 0).day;
    final info = [
      for (var d = 1; d <= days; d++)
        marks.on(DateTime(month.year, month.month, d)),
    ];

    bool joins(int a, int b) =>
        a >= 0 &&
        b < days &&
        info[a].mark != DayMark.none &&
        info[a].mark == info[b].mark &&
        info[a].cycle?.excluded == info[b].cycle?.excluded;

    final weeks = <Widget>[];
    for (var row = 0; row * 7 < lead + days; row++) {
      weeks.add(
        Row(
          children: [
            for (var col = 0; col < 7; col++)
              Expanded(
                child: Builder(
                  builder: (context) {
                    final i = row * 7 + col - lead;
                    if (i < 0 || i >= days) {
                      return const SizedBox(height: _Cell.height);
                    }
                    final date = DateTime(month.year, month.month, i + 1);
                    return _Cell(
                      date: date,
                      info: info[i],
                      joinLeft: col > 0 && joins(i - 1, i),
                      joinRight: col < 6 && joins(i, i + 1),
                      log: logs[isoDate(date)],
                      moon: moons[isoDate(date)]?.phase,
                      onTap: () => onTap(date),
                    );
                  },
                ),
              ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: Text(
              _title.format(month),
              style: theme.textTheme.titleLarge,
            ),
          ),
          ...weeks,
        ],
      ),
    );
  }
}

class _Cell extends StatelessWidget {
  const _Cell({
    required this.date,
    required this.info,
    required this.joinLeft,
    required this.joinRight,
    this.log,
    this.moon,
    required this.onTap,
  });

  static const height = 48.0;

  final DateTime date;
  final CalendarDay info;

  /// Whether the band carries on into the neighbouring day, so a run of days
  /// reads as one shape rather than a row of beads.
  final bool joinLeft;
  final bool joinRight;
  final DayLog? log;
  final MoonPhase? moon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = EbbColors.of(context);
    final isToday = isSameDay(date, today());
    final future = date.isAfter(today());
    final excluded = info.cycle?.excluded ?? false;
    final feeling = log?.feeling;
    final rating = log?.rating;
    // Under the number: a pencil for a written note, otherwise a dot for a
    // rating, otherwise nothing, so days still to rate stand out. The
    // feeling has its own face.
    final hasNote = log?.notes?.trim().isNotEmpty ?? false;

    final Color? fill = switch (info.mark) {
      DayMark.period => excluded ? colors.elapsed : colors.period,
      DayMark.likelyStart => colors.window,
      DayMark.fertile => theme.colorScheme.primaryContainer,
      _ => null,
    };
    final outline = info.mark == DayMark.periodUnrecorded
        ? (excluded ? colors.elapsed : colors.period)
        : null;

    final onFill = info.mark == DayMark.period
        ? (ThemeData.estimateBrightnessForColor(fill!) == Brightness.dark
              ? Colors.white
              : Colors.black)
        : null;
    // Days still to come are quieter, except inside the likely window, where
    // muted text on the band would be hard to read.
    final ink =
        onFill ??
        (future && info.mark != DayMark.likelyStart
            ? theme.colorScheme.onSurfaceVariant
            : theme.colorScheme.onSurface);

    final meaning = switch (info.mark) {
      DayMark.period => ', period',
      DayMark.periodUnrecorded => ', period, end not logged',
      DayMark.likelyStart => ', next period likely',
      DayMark.fertile => ', estimated fertile window',
      DayMark.none => '',
    };
    return Semantics(
      button: true,
      excludeSemantics: true,
      label:
          '${DateFormat.MMMMEEEEd().format(date)}'
          '${isToday ? ', today' : ''}$meaning'
          '${moon == null ? '' : ', ${moon!.label.toLowerCase()}'}'
          '${rating == null ? '' : ', rated $rating'}'
          '${feeling == null ? '' : ', felt ${_feelingName(feeling)}'}'
          '${hasNote ? ', has a note' : ''}',
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: CustomPaint(
          painter: _BandPainter(
            fill: fill,
            outline: outline,
            joinLeft: joinLeft,
            joinRight: joinRight,
            today: isToday ? theme.colorScheme.primary : null,
          ),
          child: SizedBox(
            height: height,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Text(
                  '${date.day}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: ink,
                    fontWeight: isToday ? FontWeight.w700 : null,
                  ),
                ),
                // Up and to the left of the number, on the day's own
                // circle: pinned to the cell's corner it floats between
                // two days on a wide screen.
                if (moon case final phase?)
                  Transform.translate(
                    offset: const Offset(-16, -14),
                    child: MoonIcon(
                      phase,
                      size: 10,
                      backdrop: theme.scaffoldBackgroundColor,
                    ),
                  ),
                // The moon's mirror image, up and to the right. Small, and
                // drawn in its own colours, so it reads on any band.
                if (feeling case final f?)
                  Transform.translate(
                    offset: const Offset(17, -14),
                    child: ExcludeSemantics(
                      child: Text(
                        f.emoji,
                        style: const TextStyle(fontSize: 11, height: 1),
                      ),
                    ),
                  ),
                if (hasNote)
                  Positioned(
                    bottom: 5,
                    child: Icon(Icons.edit, size: 10, color: ink),
                  )
                else if (rating != null)
                  Positioned(
                    bottom: 11,
                    child: Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: ink,
                        shape: BoxShape.circle,
                      ),
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

/// A day's share of a band: filled for logged days and the likely window,
/// outlined for estimated ones. Rounded only where the band starts or stops.
class _BandPainter extends CustomPainter {
  _BandPainter({
    required this.fill,
    required this.outline,
    required this.joinLeft,
    required this.joinRight,
    required this.today,
  });

  final Color? fill;
  final Color? outline;
  final bool joinLeft;
  final bool joinRight;
  final Color? today;

  static const _band = 36.0;

  @override
  void paint(Canvas canvas, Size size) {
    const inset = 3.0;
    final top = (size.height - _band) / 2;
    final r = Rect.fromLTRB(
      joinLeft ? 0 : inset,
      top,
      joinRight ? size.width : size.width - inset,
      top + _band,
    );
    const rad = Radius.circular(_band / 2);

    final f = fill;
    if (f != null) {
      canvas.drawRRect(
        RRect.fromRectAndCorners(
          r,
          topLeft: joinLeft ? Radius.zero : rad,
          bottomLeft: joinLeft ? Radius.zero : rad,
          topRight: joinRight ? Radius.zero : rad,
          bottomRight: joinRight ? Radius.zero : rad,
        ),
        Paint()..color = f,
      );
    }

    final o = outline;
    if (o != null) {
      // Top and bottom edges, with a cap only at the band's own ends, so
      // joined days don't get a line between them.
      final line = r.deflate(0.75);
      final left = joinLeft ? line.left : line.left + rad.x;
      final right = joinRight ? line.right : line.right - rad.x;
      final path = Path()
        ..moveTo(left, line.top)
        ..lineTo(right, line.top);
      if (joinRight) {
        path.moveTo(right, line.bottom);
      } else {
        path.arcToPoint(Offset(right, line.bottom), radius: rad);
      }
      path.lineTo(left, line.bottom);
      if (!joinLeft) path.arcToPoint(Offset(left, line.top), radius: rad);
      canvas.drawPath(
        path,
        Paint()
          ..color = o
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5,
      );
    }

    final t = today;
    if (t != null) {
      canvas.drawCircle(
        size.center(Offset.zero),
        _band / 2 - 1,
        Paint()
          ..color = t
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2,
      );
    }
  }

  @override
  bool shouldRepaint(_BandPainter old) =>
      old.fill != fill ||
      old.outline != outline ||
      old.joinLeft != joinLeft ||
      old.joinRight != joinRight ||
      old.today != today;
}

/// What the marks mean, kept on screen while scrolling.
class _Key extends StatelessWidget {
  const _Key({
    required this.showUnrecorded,
    required this.showFertile,
    required this.showLikely,
  });

  final bool showUnrecorded;
  final bool showFertile;
  final bool showLikely;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = EbbColors.of(context);

    Widget entry(Widget swatch, String text) => Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        swatch,
        const SizedBox(width: 6),
        Text(text, style: theme.textTheme.labelMedium),
      ],
    );
    Widget pill({Color? fill, Color? border, bool round = false}) => Container(
      width: round ? 14 : 20,
      height: 14,
      decoration: BoxDecoration(
        color: fill,
        border: border == null ? null : Border.all(color: border, width: 1.5),
        borderRadius: BorderRadius.circular(7),
      ),
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        border: Border(top: BorderSide(color: colors.track)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 18,
            runSpacing: 8,
            children: [
              entry(pill(fill: colors.period), 'Period'),
              if (showUnrecorded)
                entry(pill(border: colors.period), 'End not logged'),
              if (showLikely) entry(pill(fill: colors.window), 'Likely start'),
              if (showFertile)
                entry(
                  pill(fill: theme.colorScheme.primaryContainer),
                  'Fertile (estimate)',
                ),
              entry(
                pill(border: theme.colorScheme.primary, round: true),
                'Today',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

sealed class _Action {}

class _Started extends _Action {}

/// The period starting soon after this day really started on it.
class _MovedStart extends _Action {
  _MovedStart(this.cycle);
  final Cycle cycle;
}

class _Ended extends _Action {
  _Ended(this.cycle);
  final Cycle cycle;
}

class _Edit extends _Action {
  _Edit(this.cycle);
  final Cycle cycle;
}

/// What the day sheet asks for: a period change, a changed day log, or
/// both. Either may be null.
class _DayResult {
  const _DayResult({this.action, this.log});
  final _Action? action;
  final DayLog? log;
}

/// Everything about one day, and what can be logged on it.
class _DaySheet extends StatefulWidget {
  const _DaySheet({
    required this.day,
    required this.info,
    required this.who,
    required this.cycles,
    required this.prediction,
    required this.log,
    this.moon,
    this.readOnly = false,
  });

  final DateTime day;
  final CalendarDay info;
  final Who who;
  final List<Cycle> cycles;
  final CyclePrediction prediction;
  final DayLog? log;
  final MoonEvent? moon;
  final bool readOnly;

  @override
  State<_DaySheet> createState() => _DaySheetState();
}

class _DaySheetState extends State<_DaySheet> {
  static final _range = DateFormat.MMMd();

  late Flow _flow = widget.log?.flow ?? Flow.none;
  late int? _rating = widget.log?.rating;
  late DayFeeling? _feeling = widget.log?.feeling;
  late final _notes = TextEditingController(text: widget.log?.notes);

  @override
  void dispose() {
    _notes.dispose();
    super.dispose();
  }

  bool get _future => widget.day.isAfter(today());

  /// The day's entry as edited, or null if nothing changed.
  DayLog? get _changedLog {
    String? clean(String? s) => s == null || s.trim().isEmpty ? null : s.trim();
    final old = widget.log;
    final notes = clean(_notes.text);
    if (_flow == (old?.flow ?? Flow.none) &&
        _rating == old?.rating &&
        _feeling == old?.feeling &&
        notes == clean(old?.notes)) {
      return null;
    }
    return DayLog(
      id: old?.id,
      date: widget.day,
      flow: _flow,
      symptoms: old?.symptoms ?? const [],
      notes: notes,
      rating: _rating,
      feeling: _feeling,
    );
  }

  void _done([_Action? action]) =>
      Navigator.of(context).pop(_DayResult(action: action, log: _changedLog));

  String get _status {
    final who = widget.who;
    final info = widget.info;
    final p = widget.prediction;
    final cycle = info.cycle;
    final n = cycle == null ? 0 : daysBetween(cycle.start, widget.day) + 1;
    final window = p.earliest == null
        ? ''
        : '${who.whoseCap} next period is likely to start between '
              '${_range.format(p.earliest!)} and ${_range.format(p.latest!)}.';
    return switch (info.mark) {
      DayMark.period =>
        'Day $n of ${who.whose} period'
            '${cycle!.excluded ? ', in a cycle not counted in predictions' : ''}.',
      DayMark.periodUnrecorded =>
        'Day $n of ${who.whose} cycle. The end of '
            'this period wasn’t logged, so it’s drawn at the usual length.',
      DayMark.likelyStart => window,
      DayMark.fertile =>
        'In the estimated fertile window. Not reliable '
            'enough to use as contraception.',
      DayMark.none when info.cycleDay != null =>
        'Day ${info.cycleDay} of ${who.whose} cycle.',
      _ => '',
    };
  }

  /// Offered only when it would pass the same checks as anywhere else, and
  /// not where moving the next period's start here is offered instead.
  bool get _canStart {
    if (_future) return false;
    final mark = widget.info.mark;
    if (mark == DayMark.period || mark == DayMark.periodUnrecorded) {
      return false;
    }
    if (_canMoveStart != null) return false;
    return checkCycle(Cycle(start: widget.day), widget.cycles) == null;
  }

  /// The period starting soon after this day, if its start can move here.
  Cycle? get _canMoveStart {
    if (_future) return null;
    final mark = widget.info.mark;
    if (mark == DayMark.period || mark == DayMark.periodUnrecorded) {
      return null;
    }
    final next = periodStartingSoonAfter(widget.day, widget.cycles);
    if (next == null || next.id == null) return null;
    return canMoveStartTo(next, widget.day, widget.cycles) ? next : null;
  }

  /// The period this day could be the last day of, if any.
  Cycle? get _canEnd {
    final c = widget.info.cycle;
    if (_future || c == null || c.id == null) return null;
    if (c.end != null && isSameDay(c.end!, widget.day)) return null;
    if (daysBetween(c.start, widget.day) >= Cycle.maxPeriodDays) return null;
    final candidate = c.copyWith(end: widget.day);
    return checkCycle(candidate, widget.cycles) == null ? c : null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final who = widget.who;
    final isToday = isSameDay(widget.day, today());
    final status = _status;
    final inPeriod =
        widget.info.mark == DayMark.period ||
        widget.info.mark == DayMark.periodUnrecorded;
    final ends = _canEnd;
    final moves = _canMoveStart;

    const side = EdgeInsets.symmetric(horizontal: 24);

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: side,
                child: Text(
                  '${isToday ? 'Today, ' : ''}'
                  '${DateFormat.MMMMEEEEd().format(widget.day)}',
                  style: theme.textTheme.titleLarge,
                ),
              ),
              if (status.isNotEmpty)
                Padding(
                  padding: side + const EdgeInsets.only(top: 6),
                  child: Text(
                    status,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              if (widget.moon case final moon?)
                Padding(
                  padding: side + const EdgeInsets.only(top: 6),
                  child: Row(
                    children: [
                      MoonIcon(moon.phase, size: 14),
                      const SizedBox(width: 8),
                      Text(
                        '${moon.phase.label}, '
                        '${DateFormat.jm().format(moon.at.toLocal())}',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 8),
              if (widget.readOnly)
                _LoggedDay(log: widget.log, padding: side)
              else if (_future)
                Padding(
                  padding: side + const EdgeInsets.only(bottom: 24, top: 8),
                  child: Text(
                    'Days still to come can’t be logged yet.',
                    style: theme.textTheme.bodyMedium,
                  ),
                )
              else ...[
                // Worded as things to do, not facts about the day: these are
                // buttons, and "My period started this day" read as a record.
                if (_canStart)
                  ListTile(
                    contentPadding: side,
                    leading: const Icon(Icons.water_drop_outlined),
                    title: Text('Mark as the day ${who.whose} period started'),
                    onTap: () => _done(_Started()),
                  ),
                if (moves != null)
                  ListTile(
                    contentPadding: side,
                    leading: const Icon(Icons.water_drop_outlined),
                    title: const Text('Make this the first day of the period'),
                    subtitle: Text(
                      'Moves its start from '
                      '${DateFormat.MMMEd().format(moves.start)}',
                    ),
                    onTap: () => _done(_MovedStart(moves)),
                  ),
                if (ends != null)
                  ListTile(
                    contentPadding: side,
                    leading: const Icon(Icons.check),
                    title: Text(
                      ends.end == null
                          ? 'Mark as the day ${who.whose} period ended'
                          : 'Make this the last day of the period',
                    ),
                    onTap: () => _done(_Ended(ends)),
                  ),
                if (inPeriod)
                  ListTile(
                    contentPadding: side,
                    leading: const Icon(Icons.edit_outlined),
                    title: const Text('Edit this period'),
                    onTap: () => _done(_Edit(widget.info.cycle!)),
                  ),
                const Divider(height: 24),
                Padding(
                  padding: side,
                  child: Text(
                    'Rate ${who.whose} day, 1–5',
                    style: theme.textTheme.titleSmall,
                  ),
                ),
                Padding(
                  padding: side + const EdgeInsets.only(top: 8),
                  child: DayRatingPicker(
                    rating: _rating,
                    onChanged: (r) => setState(() => _rating = r),
                  ),
                ),
                Padding(
                  padding: side + const EdgeInsets.only(top: 16),
                  child: Text(
                    'How did ${who.subject} feel?',
                    style: theme.textTheme.titleSmall,
                  ),
                ),
                Padding(
                  padding: side + const EdgeInsets.only(top: 8),
                  child: FeelingPicker(
                    feeling: _feeling,
                    onChanged: (f) => setState(() => _feeling = f),
                  ),
                ),
                Padding(
                  padding: side + const EdgeInsets.only(top: 16),
                  child: Text('Flow', style: theme.textTheme.titleSmall),
                ),
                // One row, like the faces above. No checkmark: it would
                // widen the chosen chip, and the fill already shows it.
                Padding(
                  padding: side + const EdgeInsets.only(top: 8),
                  child: Row(
                    children: [
                      for (final (i, f) in Flow.values.skip(1).indexed) ...[
                        if (i > 0) const SizedBox(width: 8),
                        Expanded(
                          child: ChoiceChip(
                            showCheckmark: false,
                            labelPadding: EdgeInsets.zero,
                            // Chosen the same way as the faces above.
                            selectedColor: theme.colorScheme.primaryContainer,
                            side: _flow == f
                                ? BorderSide(
                                    color: theme.colorScheme.primary,
                                    width: 2,
                                  )
                                : null,
                            label: Center(
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(f.label),
                              ),
                            ),
                            selected: _flow == f,
                            onSelected: (on) =>
                                setState(() => _flow = on ? f : Flow.none),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                Padding(
                  padding: side + const EdgeInsets.only(top: 16),
                  child: TextField(
                    controller: _notes,
                    minLines: 1,
                    maxLines: 4,
                    maxLength: 500,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: const InputDecoration(labelText: 'Note'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Cancel'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FilledButton(
                          onPressed: () => _done(),
                          child: const Text('Save'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// What a screen reader says for a feeling: "anxious", "smiling cat".
String _feelingName(DayFeeling f) =>
    (f.named?.label ?? faceName(f.emoji)).toLowerCase();

/// What was logged on a day of a shared copy, to read rather than change.
class _LoggedDay extends StatelessWidget {
  const _LoggedDay({required this.log, required this.padding});

  final DayLog? log;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l = log;
    final lines = <String>[
      if (l?.rating case final r?)
        'Rated $r of 5, ${ratingNames[r - 1].toLowerCase()}',
      if (l?.feeling case final f?) 'Felt ${f.emoji} ${_feelingName(f)}',
      if (l != null && l.flow != Flow.none)
        'Flow: ${l.flow.label.toLowerCase()}',
      if (l?.notes case final n? when n.trim().isNotEmpty) '“${n.trim()}”',
    ];
    return Padding(
      padding: padding + const EdgeInsets.only(top: 8, bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (lines.isEmpty)
            Text(
              'Nothing logged this day.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            )
          else
            for (final line in lines)
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(line, style: theme.textTheme.bodyLarge),
              ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ),
        ],
      ),
    );
  }
}
