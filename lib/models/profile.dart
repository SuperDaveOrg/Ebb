import 'dart:math';

import 'package:ebb/domain/dates.dart';

/// One person whose cycles are tracked on this phone.
///
/// Most installs only ever have the primary profile, whose [name] is null —
/// the app then speaks in the second person and never asks for a name. A name
/// only matters once there is more than one person to tell apart.
class Profile {
  const Profile({this.id, this.name, this.uid, this.sharedOn});

  final int? id;
  final String? name;

  /// Who this is, across phones: random, made once, and carried in backups
  /// and transfers so that when Ana sends her history again, the phone that
  /// has her already can offer to update her rather than add her twice.
  /// Null only for a profile not yet saved.
  final String? uid;

  /// Set when this is a read-only copy of someone's history from her own
  /// phone — part of the groups option. The date is when she sent it. A
  /// copy is never edited here, only replaced by her sending it again.
  final DateTime? sharedOn;

  bool get isSharedCopy => sharedOn != null;

  /// Longest name the app accepts: it only has to tell people apart.
  static const maxNameLength = 30;

  /// A new [uid]: 128 random bits, as hex.
  static String newUid() {
    final r = Random.secure();
    return [
      for (var i = 0; i < 16; i++)
        r.nextInt(256).toRadixString(16).padLeft(2, '0'),
    ].join();
  }

  /// What a [uid] may look like in a backup: generous, since another app
  /// might write one, but nothing that could hide in a file unnoticed.
  static final uidPattern = RegExp(r'^[A-Za-z0-9_-]{1,64}$');

  Map<String, Object?> toRow() => {
    if (id != null) 'id': id,
    'name': name,
    'uid': uid ?? newUid(),
    'shared_on': sharedOn == null ? null : isoDate(sharedOn!),
  };

  factory Profile.fromRow(Map<String, Object?> row) => Profile(
    id: row['id'] as int?,
    name: row['name'] as String?,
    uid: row['uid'] as String?,
    sharedOn: row['shared_on'] == null
        ? null
        : parseIsoDate(row['shared_on'] as String),
  );
}
