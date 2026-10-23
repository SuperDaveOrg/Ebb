import 'package:ebb/domain/dates.dart';

/// How heavy the bleeding was on a given day.
enum Flow {
  none,
  spotting,
  light,
  medium,
  heavy;

  static Flow fromName(String? name) =>
      Flow.values.firstWhere((f) => f.name == name, orElse: () => Flow.none);
}

/// How cervical mucus felt, from driest to wettest: the sensation half of
/// what the sympto-thermal method records, in the categories drip uses.
/// Stored by [name]. The order is only dry to wet; Ebb draws no conclusion
/// from it.
enum MucusFeel {
  dry,
  nothing,
  wet,
  slippery;

  static MucusFeel? fromName(String? name) =>
      MucusFeel.values.where((m) => m.name == name).firstOrNull;
}

/// How cervical mucus looked, from none to clear and stretchy. Stored by
/// [name].
enum MucusLook {
  nothing,
  creamy,
  eggWhite;

  static MucusLook? fromName(String? name) =>
      MucusLook.values.where((m) => m.name == name).firstOrNull;
}

/// The named feelings offered first. Stored by [name], which is also what
/// backups use, so a face can be redrawn without touching anyone's history.
///
/// Kinds of feeling, not a scale: nothing here is better or worse than
/// anything else, so feelings are never averaged.
enum Feeling {
  happy('😁'),
  calm('😌'),
  loving('🥰'),
  energetic('🤩'),
  tired('😴'),
  sad('😢'),
  anxious('😰'),
  irritable('😤'),
  angry('😠'),
  confused('🤔');

  const Feeling(this.emoji);
  final String emoji;

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
    this.temperature,
    this.temperatureDisturbed = false,
    this.mucusFeel,
    this.mucusLook,
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

  /// Waking body temperature in °C, rounded to a thousandth. Null when not
  /// taken.
  final double? temperature;

  /// Something may have thrown the reading off: illness, little sleep,
  /// alcohol, taken late. Only meaningful with a [temperature].
  final bool temperatureDisturbed;

  final MucusFeel? mucusFeel;
  final MucusLook? mucusLook;

  bool get hasTemperatureOrMucus =>
      temperature != null || mucusFeel != null || mucusLook != null;

  bool get isEmpty =>
      flow == Flow.none &&
      symptoms.isEmpty &&
      (notes == null || notes!.trim().isEmpty) &&
      rating == null &&
      feeling == null &&
      !hasTemperatureOrMucus;

  DayLog copyWith({
    DateTime? date,
    Flow? flow,
    List<String>? symptoms,
    String? notes,
    int? rating,
    DayFeeling? feeling,
    double? temperature,
    bool? temperatureDisturbed,
    MucusFeel? mucusFeel,
    MucusLook? mucusLook,
  }) {
    return DayLog(
      id: id,
      date: date ?? this.date,
      flow: flow ?? this.flow,
      symptoms: symptoms ?? this.symptoms,
      notes: notes ?? this.notes,
      rating: rating ?? this.rating,
      feeling: feeling ?? this.feeling,
      temperature: temperature ?? this.temperature,
      temperatureDisturbed: temperatureDisturbed ?? this.temperatureDisturbed,
      mucusFeel: mucusFeel ?? this.mucusFeel,
      mucusLook: mucusLook ?? this.mucusLook,
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
    'temperature': temperature,
    'temperature_disturbed': temperature != null && temperatureDisturbed
        ? 1
        : 0,
    'mucus_feel': mucusFeel?.name,
    'mucus_look': mucusLook?.name,
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
      temperature: (row['temperature'] as num?)?.toDouble(),
      temperatureDisturbed: (row['temperature_disturbed'] as int? ?? 0) == 1,
      mucusFeel: MucusFeel.fromName(row['mucus_feel'] as String?),
      mucusLook: MucusLook.fromName(row['mucus_look'] as String?),
    );
  }
}
