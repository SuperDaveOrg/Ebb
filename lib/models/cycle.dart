import 'package:ebb/domain/dates.dart';

/// One recorded menstrual cycle.
///
/// [start] is the first day of bleeding. [end] is the last day of bleeding,
/// or null while the period is still in progress. A cycle stays "open" at its
/// tail end until the next cycle begins — the cycle *length* is measured from
/// this start to the next start, not from start to end.
class Cycle {
  const Cycle({
    this.id,
    required this.start,
    this.end,
    this.notes,
    this.excluded = false,
  });

  final int? id;
  final DateTime start;
  final DateTime? end;
  final String? notes;

  /// Set by her when this cycle doesn't reflect her usual rhythm — illness, a
  /// medication change, a pregnancy loss. It stays in history but the
  /// predictor ignores both its length and its period length.
  final bool excluded;

  /// Days of bleeding recorded, inclusive of both ends. Null while ongoing.
  int? get periodLength {
    final e = end;
    if (e == null) return null;
    return daysBetween(start, e) + 1;
  }

  /// Longest a period is taken to last. Beyond it an unlogged end reads as
  /// "not recorded" rather than a period still going, and longer recorded
  /// ones are left out of the period-length estimate.
  static const maxPeriodDays = 14;

  /// Whether this period is still going on [day]: no end logged, and started
  /// recently enough to be plausible. A forgotten "ended" tap must not leave
  /// the home screen saying "Day 87 of your period".
  bool inProgressOn(DateTime day) =>
      end == null && daysBetween(start, day) < maxPeriodDays;

  Cycle copyWith({
    int? id,
    DateTime? start,
    DateTime? end,
    String? notes,
    bool? excluded,
    bool clearEnd = false,
    bool clearNotes = false,
  }) {
    return Cycle(
      id: id ?? this.id,
      start: start ?? this.start,
      end: clearEnd ? null : (end ?? this.end),
      notes: clearNotes ? null : (notes ?? this.notes),
      excluded: excluded ?? this.excluded,
    );
  }

  Map<String, Object?> toRow() => {
        if (id != null) 'id': id,
        'start_date': isoDate(start),
        'end_date': end == null ? null : isoDate(end!),
        'notes': notes,
        'excluded': excluded ? 1 : 0,
      };

  factory Cycle.fromRow(Map<String, Object?> row) => Cycle(
        id: row['id'] as int?,
        start: parseIsoDate(row['start_date'] as String),
        end: row['end_date'] == null
            ? null
            : parseIsoDate(row['end_date'] as String),
        notes: row['notes'] as String?,
        excluded: (row['excluded'] as int? ?? 0) != 0,
      );

  @override
  String toString() => 'Cycle(${isoDate(start)} -> ${end == null ? 'ongoing' : isoDate(end!)})';
}
