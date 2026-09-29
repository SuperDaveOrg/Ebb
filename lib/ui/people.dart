import 'package:flutter/material.dart';

import 'package:ebb/data/database.dart';
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
}) {
  return showDialog<String>(
    context: context,
    builder: (_) => _NameDialog(
      title: title,
      others: others,
      initial: initial,
      optional: optional,
      hint: hint,
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
  });

  final String title;
  final List<Profile> others;
  final String? initial;
  final bool optional;
  final String? hint;

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
    final taken = widget.others.any(
      (p) =>
          Who.label(p).toLowerCase() == _name.toLowerCase() ||
          // "You" is how the owner appears when unnamed.
          (p.id == EbbDatabase.primaryProfileId &&
              p.name == null &&
              _name.toLowerCase() == 'you'),
    );
    return taken ? 'That name is already used on this phone.' : null;
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
        maxLength: Profile.maxNameLength,
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

/// The switcher opened from the title, once there is more than one person.
Future<PeopleChoice?> showPeopleSheet(
  BuildContext context, {
  required List<Profile> people,
  required Profile current,
}) {
  return showModalBottomSheet<PeopleChoice>(
    context: context,
    showDragHandle: true,
    builder: (ctx) => SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final p in people)
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 24),
              leading: Icon(
                p.id == current.id
                    ? Icons.radio_button_checked
                    : Icons.radio_button_unchecked,
              ),
              title: Text(Who.label(p)),
              onTap: () => Navigator.of(ctx).pop(SwitchTo(p)),
            ),
          const Divider(),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 24),
            leading: const Icon(Icons.person_add_alt),
            title: const Text('Add someone'),
            onTap: () => Navigator.of(ctx).pop(const AddSomeone()),
          ),
          const SizedBox(height: 8),
        ],
      ),
    ),
  );
}
