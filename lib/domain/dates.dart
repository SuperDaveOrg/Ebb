library;

/// Date helpers. Everything in Ebb is a *calendar day*, never an instant:
/// cycles are counted in whole local days, so all DateTimes are normalised to
/// local midnight before they are compared, stored, or subtracted.

/// Strips the time component, returning local midnight on the same day.
DateTime dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

DateTime today() => dateOnly(DateTime.now());

/// Whole calendar days from [a] to [b]; negative when [b] precedes [a].
///
/// Uses a UTC projection so that daylight-saving transitions — which make some
/// local days 23 or 25 hours long — cannot round a day away.
int daysBetween(DateTime a, DateTime b) {
  final ua = DateTime.utc(a.year, a.month, a.day);
  final ub = DateTime.utc(b.year, b.month, b.day);
  return ub.difference(ua).inDays;
}

DateTime addDays(DateTime d, int days) =>
    dateOnly(DateTime(d.year, d.month, d.day + days));

bool isSameDay(DateTime a, DateTime b) => daysBetween(a, b) == 0;

/// `YYYY-MM-DD`, the storage format for every date in the database.
String isoDate(DateTime d) {
  final m = d.month.toString().padLeft(2, '0');
  final day = d.day.toString().padLeft(2, '0');
  return '${d.year.toString().padLeft(4, '0')}-$m-$day';
}

DateTime parseIsoDate(String s) {
  final parts = s.split('-');
  return DateTime(int.parse(parts[0]), int.parse(parts[1]), int.parse(parts[2]));
}
