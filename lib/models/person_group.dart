/// A named set of people on this phone — a club or circle that tracks
/// together. Only a label: a person can be in several groups, and deleting a
/// group never touches anyone's history.
///
/// Part of the advanced groups option, off by default. See docs/roadmap.md.
class PersonGroup {
  const PersonGroup({this.id, required this.name, this.memberIds = const []});

  final int? id;
  final String name;

  /// Profile ids, in the order people were added to the phone.
  final List<int> memberIds;

  /// Same limit as a person's name: it only has to tell groups apart.
  static const maxNameLength = 30;
}
