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

/// The named feelings offered first. Stored by [name], which is also what
/// backups use, so a face can be redrawn without touching anyone's history.
///
/// Kinds of feeling, not a scale: nothing here is better or worse than
/// anything else, so feelings are never averaged.
enum Feeling {
  happy('😁', 'Happy'),
  calm('😌', 'Calm'),
  loving('🥰', 'Loving'),
  energetic('🤩', 'Energetic'),
  tired('😴', 'Tired'),
  sad('😢', 'Sad'),
  anxious('😰', 'Anxious'),
  irritable('😤', 'Irritable'),
  angry('😠', 'Angry'),
  confused('🤔', 'Confused');

  const Feeling(this.emoji, this.label);
  final String emoji;
  final String label;

  static Feeling? fromName(String? name) =>
      Feeling.values.where((m) => m.name == name).firstOrNull;
}

/// How she felt on a day: one of the named [Feeling]s, or any other face,
/// which means whatever it means to her — a cat, an alien, a storm cloud.
///
/// Stored as one string: the feeling's name, or the emoji itself. Names are
/// plain ASCII and a face never is, so the two can't be confused.
class DayFeeling {
  const DayFeeling._(this.value);

  DayFeeling.named(Feeling feeling) : value = feeling.name;

  /// Null when [emoji] isn't something Ebb would store as a face.
  static DayFeeling? face(String emoji) =>
      isFace(emoji) ? DayFeeling._(emoji) : null;

  /// A stored value back again: null for null, and for anything that is
  /// neither a feeling's name nor a face.
  static DayFeeling? parse(String? value) {
    if (value == null) return null;
    if (Feeling.fromName(value) != null) return DayFeeling._(value);
    return face(value);
  }

  /// One emoji, loosely: short, with no ASCII and no spaces. Checked no more
  /// tightly than that, so faces added to Ebb's list later still restore in
  /// an Ebb that doesn't list them.
  static bool isFace(String s) =>
      s.isNotEmpty &&
      s.length <= 16 &&
      !s.codeUnits.any((c) => c < 0x80) &&
      !s.contains(RegExp(r'\s'));

  final String value;

  /// The named feeling, or null for any other face.
  Feeling? get named => Feeling.fromName(value);

  String get emoji => named?.emoji ?? value;

  @override
  bool operator ==(Object other) => other is DayFeeling && other.value == value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'DayFeeling($value)';
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
    this.rating,
    this.feeling,
  });

  /// The range of [rating].
  static const minRating = 1, maxRating = 5;

  static bool isRating(int? r) => r != null && r >= minRating && r <= maxRating;

  final int? id;
  final DateTime date;
  final Flow flow;
  final List<String> symptoms;
  final String? notes;

  /// How the day went, from 1 (rough) to 5 (great). Null when not rated,
  /// which is not the same as a middling 3.
  final int? rating;

  /// How she felt, separate from [rating]: a bad day can still be a calm one.
  final DayFeeling? feeling;

  bool get isEmpty =>
      flow == Flow.none &&
      symptoms.isEmpty &&
      (notes == null || notes!.trim().isEmpty) &&
      rating == null &&
      feeling == null;

  DayLog copyWith({
    DateTime? date,
    Flow? flow,
    List<String>? symptoms,
    String? notes,
    int? rating,
    DayFeeling? feeling,
  }) {
    return DayLog(
      id: id,
      date: date ?? this.date,
      flow: flow ?? this.flow,
      symptoms: symptoms ?? this.symptoms,
      notes: notes ?? this.notes,
      rating: rating ?? this.rating,
      feeling: feeling ?? this.feeling,
    );
  }

  Map<String, Object?> toRow() => {
    if (id != null) 'id': id,
    'log_date': isoDate(date),
    'flow': flow.name,
    // Tab-separated: symptom text is user-authored and may contain commas.
    'symptoms': symptoms.join('\t'),
    'notes': notes,
    'rating': rating,
    'feeling': feeling?.value,
  };

  factory DayLog.fromRow(Map<String, Object?> row) {
    final raw = (row['symptoms'] as String?) ?? '';
    return DayLog(
      id: row['id'] as int?,
      date: parseIsoDate(row['log_date'] as String),
      flow: Flow.fromName(row['flow'] as String?),
      symptoms: raw.isEmpty ? const [] : raw.split('\t'),
      notes: row['notes'] as String?,
      rating: row['rating'] as int?,
      feeling: DayFeeling.parse(row['feeling'] as String?),
    );
  }
}
