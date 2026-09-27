/// One person whose cycles are tracked on this phone.
///
/// Most installs only ever have the primary profile, whose [name] is null —
/// the app then speaks in the second person and never asks for a name. A name
/// only matters once there is more than one person to tell apart.
class Profile {
  const Profile({this.id, this.name});

  final int? id;
  final String? name;

  /// Longest name the app accepts: it only has to tell people apart.
  static const maxNameLength = 30;

  Map<String, Object?> toRow() => {
        if (id != null) 'id': id,
        'name': name,
      };

  factory Profile.fromRow(Map<String, Object?> row) => Profile(
        id: row['id'] as int?,
        name: row['name'] as String?,
      );
}
