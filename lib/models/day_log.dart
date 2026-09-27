import 'package:ebb/domain/dates.dart';

/// How heavy the bleeding was on a given day.
enum Flow {
  none('None'),
  spotting('Spotting'),
  light('Light'),
  medium('Medium'),
  heavy('Heavy');

  const Flow(this.label);
  final String label;

  static Flow fromName(String? name) =>
      Flow.values.firstWhere((f) => f.name == name, orElse: () => Flow.none);
}

/// A free-form note attached to one calendar day.
///
/// Symptoms are stored as plain strings rather than an enum on purpose: the
/// vocabulary here belongs to the person using the app, and a fixed list would
/// quietly tell her which experiences count.
class DayLog {
  const DayLog({
    this.id,
    required this.date,
    this.flow = Flow.none,
    this.symptoms = const [],
    this.notes,
  });

  final int? id;
  final DateTime date;
  final Flow flow;
  final List<String> symptoms;
  final String? notes;

  bool get isEmpty =>
      flow == Flow.none &&
      symptoms.isEmpty &&
      (notes == null || notes!.trim().isEmpty);

  DayLog copyWith({
    DateTime? date,
    Flow? flow,
    List<String>? symptoms,
    String? notes,
  }) {
    return DayLog(
      id: id,
      date: date ?? this.date,
      flow: flow ?? this.flow,
      symptoms: symptoms ?? this.symptoms,
      notes: notes ?? this.notes,
    );
  }

  Map<String, Object?> toRow() => {
        if (id != null) 'id': id,
        'log_date': isoDate(date),
        'flow': flow.name,
        // Tab-separated: symptom text is user-authored and may contain commas.
        'symptoms': symptoms.join('\t'),
        'notes': notes,
      };

  factory DayLog.fromRow(Map<String, Object?> row) {
    final raw = (row['symptoms'] as String?) ?? '';
    return DayLog(
      id: row['id'] as int?,
      date: parseIsoDate(row['log_date'] as String),
      flow: Flow.fromName(row['flow'] as String?),
      symptoms: raw.isEmpty ? const [] : raw.split('\t'),
      notes: row['notes'] as String?,
    );
  }
}
