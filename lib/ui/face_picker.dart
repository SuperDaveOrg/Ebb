import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:ebb/models/day_log.dart';

/// What each day rating, 1 to 5, is called by a screen reader. On screen
/// it's the number: faces are kept for feelings, so a face on the calendar
/// always means the same thing.
const ratingNames = ['Rough', 'Not great', 'Okay', 'Good', 'Great'];

/// Faces beyond the named feelings, for whatever they mean to her. Stored
/// as the emoji, so this list can grow without touching the backup format.
/// The names are only for screen readers.
///
/// Nothing newer than Emoji 11, so they draw on Android 9 and later.
const moreFaces = [
  ('😺', 'Smiling cat'),
  ('😸', 'Grinning cat'),
  ('😹', 'Cat with tears of joy'),
  ('😻', 'Cat with heart eyes'),
  ('😼', 'Smirking cat'),
  ('😽', 'Kissing cat'),
  ('🙀', 'Weary cat'),
  ('😿', 'Crying cat'),
  ('😾', 'Pouting cat'),
  ('👽', 'Alien'),
  ('👾', 'Space invader'),
  ('🤖', 'Robot'),
  ('👻', 'Ghost'),
  ('💀', 'Skull'),
  ('🤡', 'Clown'),
  ('😈', 'Devil'),
  ('🦄', 'Unicorn'),
  ('🐸', 'Frog'),
  ('🥳', 'Partying'),
  ('😎', 'Cool'),
  ('🤓', 'Nerdy'),
  ('😇', 'Angelic'),
  ('🤗', 'Hugging'),
  ('🤪', 'Silly'),
  ('🙃', 'Upside down'),
  ('😏', 'Smirking'),
  ('😬', 'Grimacing'),
  ('🙄', 'Eye roll'),
  ('😶', 'Speechless'),
  ('🥺', 'Pleading'),
  ('😭', 'Sobbing'),
  ('😱', 'Screaming'),
  ('😳', 'Flushed'),
  ('🤯', 'Overwhelmed'),
  ('🥴', 'Woozy'),
  ('🤒', 'Unwell'),
  ('🤕', 'Hurting'),
  ('🤢', 'Queasy'),
  ('🥵', 'Too hot'),
  ('🥶', 'Too cold'),
  ('💖', 'Sparkling heart'),
  ('💔', 'Broken heart'),
  ('🔥', 'Fire'),
  ('🌈', 'Rainbow'),
  ('☀️', 'Sun'),
  ('🌧️', 'Rain'),
  ('⛈️', 'Storm'),
  ('🌸', 'Blossom'),
  ('🍫', 'Chocolate'),
  ('🛌', 'In bed'),
];

/// What a screen reader says for a face that isn't a named feeling.
String faceName(String emoji) =>
    moreFaces.where((f) => f.$1 == emoji).firstOrNull?.$2 ?? 'Other face';

/// How the day went, 1 to 5, with the ends named.
class DayRatingPicker extends StatelessWidget {
  const DayRatingPicker({
    super.key,
    required this.rating,
    required this.onChanged,
  });

  final int? rating;
  final ValueChanged<int?> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ends = theme.textTheme.labelMedium?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );
    return Column(
      children: [
        FacePicker<int>(
          options: [
            for (var r = DayLog.minRating; r <= DayLog.maxRating; r++)
              (r, '$r', '$r, ${ratingNames[r - 1].toLowerCase()}'),
          ],
          selected: rating,
          onChanged: onChanged,
          style: theme.textTheme.titleLarge,
          outlined: true,
        ),
        const SizedBox(height: 4),
        ExcludeSemantics(
          child: Row(
            children: [
              SizedBox(
                width: FaceButton.size,
                child: Text(
                  ratingNames.first,
                  style: ends,
                  textAlign: TextAlign.center,
                ),
              ),
              const Spacer(),
              SizedBox(
                width: FaceButton.size,
                child: Text(
                  ratingNames.last,
                  style: ends,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// How she felt: the named feelings, then any other face from [moreFaces].
class FeelingPicker extends StatelessWidget {
  const FeelingPicker({
    super.key,
    required this.feeling,
    required this.onChanged,
  });

  final DayFeeling? feeling;
  final ValueChanged<DayFeeling?> onChanged;

  Future<void> _more(BuildContext context, DayFeeling? current) async {
    final picked = await showDialog<DayFeeling>(
      context: context,
      builder: (ctx) => AlertDialog(
        // Narrower margins than usual, so more faces fit to a row.
        insetPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 24,
        ),
        title: const Text('More faces'),
        content: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: FacePicker<DayFeeling>(
              options: [
                for (final (emoji, name) in moreFaces)
                  (DayFeeling.face(emoji)!, emoji, name),
              ],
              selected: current,
              onChanged: (f) => Navigator.of(ctx).pop(f ?? current),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
    if (picked != null) onChanged(picked);
  }

  @override
  Widget build(BuildContext context) {
    final f = feeling;
    final other = f != null && f.named == null ? f : null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FacePicker<DayFeeling>(
          options: [
            for (final named in Feeling.values)
              (DayFeeling.named(named), named.emoji, named.label),
          ],
          selected: feeling,
          onChanged: onChanged,
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            if (other != null) ...[
              FaceButton(
                emoji: other.emoji,
                name: faceName(other.emoji),
                chosen: true,
                onTap: () => onChanged(null),
              ),
              const SizedBox(width: 8),
            ],
            TextButton.icon(
              icon: const Icon(Icons.add_reaction_outlined),
              label: Text(other == null ? 'More faces' : 'A different face'),
              onPressed: () => _more(context, other),
            ),
          ],
        ),
      ],
    );
  }
}

/// Rows of faces to pick one of. Tapping the chosen one again clears it:
/// nothing picked is its own answer.
class FacePicker<T> extends StatelessWidget {
  const FacePicker({
    super.key,
    required this.options,
    required this.selected,
    required this.onChanged,
    this.style,
    this.outlined = false,
  });

  static const perRow = 5;

  /// Value, face, and the name a screen reader says.
  final List<(T, String, String)> options;
  final T? selected;
  final ValueChanged<T?> onChanged;

  /// For what's in each circle; emoji-sized when null.
  final TextStyle? style;

  /// Rings every circle, for plain text that wouldn't otherwise look like
  /// something to tap. Faces don't need it.
  final bool outlined;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, box) {
      // Fewer to a row when five won't fit, as on a phone with its display
      // size turned up, rather than running off the edge.
      final perRow = math.max(
        1,
        math.min(FacePicker.perRow, box.maxWidth ~/ FaceButton.size),
      );
      return _rows(perRow);
    },
  );

  Widget _rows(int perRow) {
    return Column(
      spacing: 8,
      children: [
        for (var i = 0; i < options.length; i += perRow)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (var j = i; j < i + perRow; j++)
                if (j < options.length)
                  FaceButton(
                    emoji: options[j].$2,
                    name: options[j].$3,
                    chosen: selected == options[j].$1,
                    faded: selected != null && selected != options[j].$1,
                    style: style,
                    outlined: outlined,
                    onTap: () => onChanged(
                      selected == options[j].$1 ? null : options[j].$1,
                    ),
                  )
                else
                  // Keeps a short last row lined up with the rows above.
                  const SizedBox(width: FaceButton.size),
            ],
          ),
      ],
    );
  }
}

/// One round face to tap.
class FaceButton extends StatelessWidget {
  const FaceButton({
    super.key,
    required this.emoji,
    required this.name,
    required this.chosen,
    this.faded = false,
    this.style,
    this.outlined = false,
    required this.onTap,
  });

  static const size = 52.0;

  final String emoji;
  final String name;
  final bool chosen;

  /// Another face is chosen, so this one steps back.
  final bool faded;

  /// Emoji-sized when null.
  final TextStyle? style;
  final bool outlined;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Semantics(
      button: true,
      selected: chosen,
      label: name,
      excludeSemantics: true,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: size,
          height: size,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: chosen ? scheme.primaryContainer : null,
            border: Border.all(
              color: chosen
                  ? scheme.primary
                  : outlined
                  ? scheme.outlineVariant
                  : Colors.transparent,
              width: chosen ? 2 : 1,
            ),
          ),
          child: Opacity(
            opacity: faded ? 0.45 : 1,
            child: Text(emoji, style: style ?? const TextStyle(fontSize: 28)),
          ),
        ),
      ),
    );
  }
}
