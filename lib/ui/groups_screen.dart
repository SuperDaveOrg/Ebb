import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:ebb/data/group_repository.dart';
import 'package:ebb/data/profile_repository.dart';
import 'package:ebb/models/person_group.dart';
import 'package:ebb/models/profile.dart';
import 'package:ebb/services/person_removal.dart';
import 'package:ebb/ui/confirm.dart';
import 'package:ebb/ui/group_receive.dart';
import 'package:ebb/ui/layout.dart';
import 'package:ebb/ui/people.dart';
import 'package:ebb/ui/section.dart';
import 'package:ebb/ui/wording.dart';

/// Settings → Groups: make, rename and delete groups, and choose who is in
/// each. Only reachable once the advanced groups option is on.
class GroupsScreen extends StatefulWidget {
  const GroupsScreen({super.key, this.groups, this.profiles});

  /// For tests; the app uses the default database.
  final GroupRepository? groups;
  final ProfileRepository? profiles;

  @override
  State<GroupsScreen> createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  late final _groups = widget.groups ?? GroupRepository();
  late final _profiles = widget.profiles ?? ProfileRepository();

  List<PersonGroup> _all = const [];
  List<Profile> _people = const [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final groups = await _groups.all();
    final people = await _profiles.all();
    if (!mounted) return;
    setState(() {
      _all = groups;
      _people = people;
      _loading = false;
    });
  }

  Future<String?> _askName({String? initial, int? except}) => showNameDialog(
    context,
    title: initial == null ? 'New group' : 'Rename group',
    others: const [],
    initial: initial,
    hint: 'For example, the name of your circle or club.',
    maxLength: PersonGroup.maxNameLength,
    takenMessage: 'There’s already a group with that name.',
    taken: (name) => _all.any(
      (g) => g.id != except && g.name.toLowerCase() == name.toLowerCase(),
    ),
  );

  Future<void> _add() async {
    final name = await _askName();
    if (name == null || name.isEmpty) return;
    final id = await _groups.add(name);
    await _load();
    final group = _all.where((g) => g.id == id).firstOrNull;
    if (group != null && mounted) await _edit(group);
  }

  Future<void> _edit(PersonGroup group) async {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => _GroupEditor(
          group: group,
          people: _people,
          groups: _groups,
          askName: (initial) => _askName(initial: initial, except: group.id),
        ),
      ),
    );
    await _load();
  }

  String _members(PersonGroup g) {
    final names = [
      for (final p in _people)
        if (g.memberIds.contains(p.id)) Who.label(p),
    ];
    return names.isEmpty ? 'No one yet' : names.join(', ');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Groups')),
      floatingActionButton: _loading
          ? null
          : FloatingActionButton.extended(
              onPressed: _add,
              icon: const Icon(Icons.group_add_outlined),
              label: const Text('New group'),
            ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _all.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Text(
                  'A group gathers people on this phone under one name — a '
                  'circle or club that tracks together. Someone can be in '
                  'more than one, and deleting a group never deletes anyone.',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge,
                ),
              ),
            )
          : ListView(
              padding: readablePadding(
                context,
                base: const EdgeInsets.only(bottom: 96),
              ),
              children: [
                Section(
                  children: [
                    for (final g in _all)
                      ListTile(
                        leading: const Icon(Icons.groups_outlined),
                        title: Text(g.name),
                        subtitle: Text(_members(g)),
                        onTap: () => _edit(g),
                      ),
                  ],
                ),
              ],
            ),
    );
  }
}

/// One group: its name, who's in it, adding someone from their phone, and
/// deleting it.
///
/// A shared copy only belongs here as part of a group, so taking one out of
/// her last group — or deleting that group — takes her copy off the phone,
/// after saying so. People who belong to this phone are never removed here.
class _GroupEditor extends StatefulWidget {
  const _GroupEditor({
    required this.group,
    required this.people,
    required this.groups,
    required this.askName,
  });

  final PersonGroup group;
  final List<Profile> people;
  final GroupRepository groups;
  final Future<String?> Function(String initial) askName;

  @override
  State<_GroupEditor> createState() => _GroupEditorState();
}

class _GroupEditorState extends State<_GroupEditor> {
  late String _name = widget.group.name;
  late Set<int> _members = {...widget.group.memberIds};
  late List<Profile> _people = widget.people;

  /// Every group, for knowing whether a copy is in any other.
  List<PersonGroup> _all = const [];

  int get _id => widget.group.id!;

  @override
  void initState() {
    super.initState();
    _reload();
  }

  Future<void> _reload() async {
    final all = await widget.groups.all();
    final people = await ProfileRepository().all();
    if (!mounted) return;
    setState(() {
      _all = all;
      _people = people;
      _members = {...?all.where((g) => g.id == _id).firstOrNull?.memberIds};
    });
  }

  /// Shared copies in this group and in no other.
  List<Profile> get _onlyHere => [
    for (final p in _people)
      if (p.isSharedCopy &&
          _members.contains(p.id) &&
          !_all.any((g) => g.id != _id && g.memberIds.contains(p.id)))
        p,
  ];

  Future<void> _rename() async {
    final name = await widget.askName(_name);
    if (name == null || name.isEmpty || name == _name) return;
    await widget.groups.rename(_id, name);
    setState(() => _name = name);
  }

  /// Someone tracked on this phone, logged for here, straight into the group.
  Future<void> _addNew() async {
    final name = await showNameDialog(
      context,
      title: 'Add someone to $_name',
      others: _people,
      hint:
          'Tracked on this phone: you log and change their history here. '
          'Someone who tracks on their own phone can be imported instead.',
    );
    if (name == null || name.isEmpty) return;
    final id = await ProfileRepository().add(Profile(name: name));
    await widget.groups.addMember(_id, id);
    await _reload();
  }

  Future<void> _addFromPhone() async {
    final group = PersonGroup(id: _id, name: _name, memberIds: [..._members]);
    if (await receiveIntoGroup(context, group)) await _reload();
  }

  Future<void> _toggle(Profile p, bool on) async {
    if (!on && _onlyHere.any((o) => o.id == p.id)) {
      final name = Who.label(p);
      final ok = await confirm(
        context,
        title: 'Take $name out of $_name?',
        body:
            '$name was imported from their phone and isn’t in any other group, '
            'so the imported history comes off this phone too. $name can '
            'send it again to rejoin.',
        action: 'Take out',
      );
      if (!ok) return;
      await removeSharedCopy(p.id!);
      await _reload();
      return;
    }
    setState(() => on ? _members.add(p.id!) : _members.remove(p.id));
    await widget.groups.setMembers(_id, _members);
  }

  Future<void> _delete() async {
    final going = _onlyHere;
    final names = going.map(Who.label).join(', ');
    final ok = await confirm(
      context,
      title: 'Delete $_name?',
      body: going.isEmpty
          ? 'Only the group goes. Everyone in it stays on this phone, with '
                'all their history.'
          : 'The people imported only into this group come off this phone '
                'too: $names. Everyone else stays, with all their history.',
      action: 'Delete group',
    );
    if (!ok) return;
    for (final p in going) {
      await removeSharedCopy(p.id!);
    }
    await widget.groups.delete(_id);
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final error = theme.colorScheme.error;
    final fmt = DateFormat.yMMMd();
    return Scaffold(
      appBar: AppBar(
        title: Text(_name),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            tooltip: 'Rename',
            onPressed: _rename,
          ),
        ],
      ),
      body: ListView(
        padding: readablePadding(
          context,
          base: const EdgeInsets.only(bottom: 32),
        ),
        children: [
          Section(
            title: 'Who’s in it',
            children: [
              for (final p in _people)
                // Which kind of member each is: tracked here, and changed
                // here; or imported, and only theirs to change.
                CheckboxListTile(
                  secondary: Icon(
                    p.isSharedCopy ? Icons.lock_outline : Icons.person_outline,
                  ),
                  title: Text(Who.label(p)),
                  subtitle: Text(
                    p.isSharedCopy
                        ? 'Imported · read-only, as of '
                              '${fmt.format(p.sharedOn!)}'
                        : 'Tracked on this phone',
                  ),
                  value: _members.contains(p.id),
                  onChanged: (on) => _toggle(p, on ?? false),
                ),
            ],
          ),
          // Two ways in: someone tracked here, whose history is logged on
          // this phone; or someone who tracks on their own phone and
          // provides it, read-only, to the group.
          Section(
            title: 'Add to the group',
            children: [
              ListTile(
                leading: const Icon(Icons.person_add_alt),
                title: const Text('Add someone new'),
                subtitle: const Text(
                  'Tracked on this phone: you log their periods here.',
                ),
                onTap: _addNew,
              ),
              ListTile(
                leading: const Icon(Icons.qr_code_scanner),
                title: const Text('Import from their phone'),
                subtitle: const Text(
                  'They keep tracking on their own phone and send it here, '
                  'read-only. Importing them again brings them up to date.',
                ),
                onTap: _addFromPhone,
              ),
            ],
          ),
          Section(
            children: [
              ListTile(
                leading: Icon(Icons.delete_outline, color: error),
                title: Text(
                  'Delete this group',
                  style: TextStyle(color: error),
                ),
                onTap: _delete,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
