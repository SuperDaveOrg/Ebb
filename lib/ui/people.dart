import 'package:flutter/material.dart';

import 'package:ebb/data/database.dart';
import 'package:ebb/models/person_group.dart';
import 'package:ebb/models/profile.dart';
import 'package:ebb/ui/wording.dart';

/// Asks for a name. Returns the trimmed name, `''` if [optional] and she
/// cleared it, or null if she backed out.
///
/// Only a name: no age, gender or photo. It exists to tell people apart, so a
/// nickname or an initial is fine.
Future<String?> showNameDialog(
  BuildContext context, {
  required String title,
  required List<Profile> others,
  String? initial,
  bool optional = false,
  String? hint,
  bool Function(String name)? taken,
  String takenMessage = 'That name is already used on this phone.',
  int maxLength = Profile.maxNameLength,
}) {
  return showDialog<String>(
    context: context,
    builder: (_) => _NameDialog(
      title: title,
      others: others,
      initial: initial,
      optional: optional,
      hint: hint,
      taken: taken,
      takenMessage: takenMessage,
      maxLength: maxLength,
    ),
  );
}

class _NameDialog extends StatefulWidget {
  const _NameDialog({
    required this.title,
    required this.others,
    required this.initial,
    required this.optional,
    required this.hint,
    required this.taken,
    required this.takenMessage,
    required this.maxLength,
  });

  final String title;
  final List<Profile> others;
  final String? initial;
  final bool optional;
  final String? hint;

  /// Replaces the check against [others], for naming things other than
  /// people.
  final bool Function(String name)? taken;
  final String takenMessage;
  final int maxLength;

  @override
  State<_NameDialog> createState() => _NameDialogState();
}

class _NameDialogState extends State<_NameDialog> {
  late final _controller = TextEditingController(text: widget.initial);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String get _name => _controller.text.trim();

  /// Why the name can't be used, or null if it can.
  String? get _problem {
    if (_name.isEmpty) return widget.optional ? null : '';
    final check = widget.taken;
    if (check != null) return check(_name) ? widget.takenMessage : null;
    final taken = widget.others.any(
      (p) =>
          Who.label(p).toLowerCase() == _name.toLowerCase() ||
          // "You" is how the owner appears when unnamed.
          (p.id == EbbDatabase.primaryProfileId &&
              p.name == null &&
              _name.toLowerCase() == 'you'),
    );
    return taken ? widget.takenMessage : null;
  }

  void _save() {
    if (_problem == null) Navigator.of(context).pop(_name);
  }

  @override
  Widget build(BuildContext context) {
    final problem = _problem;
    return AlertDialog(
      title: Text(widget.title),
      content: TextField(
        controller: _controller,
        autofocus: true,
        maxLength: widget.maxLength,
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
          labelText: 'Name',
          helperText: widget.hint,
          helperMaxLines: 3,
          errorMaxLines: 2,
          errorText: problem == null || problem.isEmpty ? null : problem,
        ),
        onChanged: (_) => setState(() {}),
        onSubmitted: (_) => _save(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: problem == null ? _save : null,
          child: const Text('Save'),
        ),
      ],
    );
  }
}

/// What she chose in the people sheet.
sealed class PeopleChoice {
  const PeopleChoice();
}

class SwitchTo extends PeopleChoice {
  const SwitchTo(this.profile);
  final Profile profile;
}

class AddSomeone extends PeopleChoice {
  const AddSomeone();
}

/// Everyone in a group, side by side.
class SeeGroup extends PeopleChoice {
  const SeeGroup(this.group);
  final PersonGroup group;
}

/// The switcher opened from the title, once there is more than one person.
///
/// With [groups] (the advanced option on, and some made), people are listed
/// under their groups, then anyone in none; someone in two groups appears in
/// both. Without, it's the plain list.
Future<PeopleChoice?> showPeopleSheet(
  BuildContext context, {
  required List<Profile> people,
  required Profile current,
  List<PersonGroup> groups = const [],
}) {
  return showModalBottomSheet<PeopleChoice>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (ctx) {
      final theme = Theme.of(ctx);
      const side = EdgeInsets.symmetric(horizontal: 24);

      Widget person(Profile p) => ListTile(
        contentPadding: side,
        leading: Icon(
          p.id == current.id
              ? Icons.radio_button_checked
              : Icons.radio_button_unchecked,
        ),
        title: Text(Who.label(p)),
        onTap: () => Navigator.of(ctx).pop(SwitchTo(p)),
      );

      Widget heading(String text) => Padding(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 4),
        child: Text(
          text.toUpperCase(),
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.primary,
          ),
        ),
      );

      final grouped = {for (final g in groups) ...g.memberIds};
      final loose = [
        for (final p in people)
          if (!grouped.contains(p.id)) p,
      ];

      return SafeArea(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(ctx).height * 0.8,
          ),
          child: ListView(
            shrinkWrap: true,
            children: [
              if (groups.isEmpty)
                for (final p in people) person(p)
              else ...[
                for (final g in groups) ...[
                  heading(g.name),
                  ListTile(
                    contentPadding: side,
                    leading: const Icon(Icons.view_timeline_outlined),
                    title: Text('See ${g.name} together'),
                    onTap: () => Navigator.of(ctx).pop(SeeGroup(g)),
                  ),
                  for (final p in people)
                    if (g.memberIds.contains(p.id)) person(p),
                  if (g.memberIds.isEmpty)
                    Padding(
                      padding: side + const EdgeInsets.only(bottom: 8),
                      child: Text(
                        'No one yet',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                ],
                if (loose.isNotEmpty) ...[
                  heading('Not in a group'),
                  for (final p in loose) person(p),
                ],
              ],
              const Divider(),
              ListTile(
                contentPadding: side,
                leading: const Icon(Icons.person_add_alt),
                title: const Text('Add someone'),
                onTap: () => Navigator.of(ctx).pop(const AddSomeone()),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      );
    },
  );
}
