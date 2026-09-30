import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:ebb/domain/dates.dart';

/// The ranges offered in the date menu.
enum SpanChoice {
  months3('Last 3 months', 91),
  months6('Last 6 months', 182),
  year('Last year', 365),
  all('Everything', null),
  custom('Choose dates…', null);

  const SpanChoice(this.label, this.days);
  final String label;
  final int? days;
}

/// Which days a chart covers: a choice from the menu, and the dates picked
/// for [SpanChoice.custom].
class DateSpan {
  const DateSpan(this.choice, {this.custom});

  final SpanChoice choice;
  final DateTimeRange? custom;

  /// First and last day, inclusive. [earliest] is the first day anything
  /// was logged, which is where "Everything" starts.
  (DateTime, DateTime) resolve(DateTime earliest) {
    final now = today();
    final c = custom;
    return switch (choice) {
      SpanChoice.custom when c != null => (dateOnly(c.start), dateOnly(c.end)),
      SpanChoice.all => (earliest, now),
      _ => (addDays(now, -((choice.days ?? 91) - 1)), now),
    };
  }
}

/// One button naming the range, opening a menu of the others. Choosing
/// dates opens Android's date-range picker.
class DateSpanButton extends StatelessWidget {
  const DateSpanButton({
    super.key,
    required this.span,
    required this.earliest,
    required this.onChanged,
  });

  final DateSpan span;
  final DateTime earliest;
  final ValueChanged<DateSpan> onChanged;

  Future<void> _pick(BuildContext context, SpanChoice choice) async {
    if (choice != SpanChoice.custom) {
      onChanged(DateSpan(choice));
      return;
    }
    final (from, to) = span.resolve(earliest);
    final picked = await showDateRangePicker(
      context: context,
      firstDate: earliest.isBefore(DateTime(2000)) ? earliest : DateTime(2000),
      lastDate: today(),
      initialDateRange: DateTimeRange(start: from, end: to),
    );
    if (picked != null) onChanged(DateSpan(SpanChoice.custom, custom: picked));
  }

  @override
  Widget build(BuildContext context) {
    final (from, to) = span.resolve(earliest);
    final fmt = from.year == to.year ? DateFormat.MMMd() : DateFormat.yMMMd();
    final label = span.choice == SpanChoice.custom
        ? '${fmt.format(from)} – ${fmt.format(to)}'
        : span.choice.label;
    return MenuAnchor(
      menuChildren: [
        for (final c in SpanChoice.values)
          MenuItemButton(
            leadingIcon: Icon(span.choice == c ? Icons.check : null, size: 20),
            // Choosing dates again stays possible while they're chosen.
            onPressed: () => _pick(context, c),
            child: Text(c.label),
          ),
      ],
      builder: (context, menu, _) => OutlinedButton.icon(
        onPressed: () => menu.isOpen ? menu.close() : menu.open(),
        icon: const Icon(Icons.date_range_outlined),
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [Text(label), const Icon(Icons.arrow_drop_down)],
        ),
      ),
    );
  }
}
