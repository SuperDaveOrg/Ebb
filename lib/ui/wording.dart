import 'package:ebb/data/database.dart';
import 'package:ebb/models/profile.dart';

/// How the app refers to the person whose cycle is on screen.
///
/// The phone's owner is always "you", even after setting a name — the name
/// only labels them in the people switcher. Anyone else is called by name,
/// never by a pronoun: the app doesn't know their pronouns and shouldn't
/// guess.
class Who {
  Who(Profile profile)
    : isOwner = profile.id == EbbDatabase.primaryProfileId,
      _name = profile.name;

  final bool isOwner;
  final String? _name;

  /// For the switcher: the owner's chosen name, or "You".
  static String label(Profile p) =>
      p.name ?? (p.id == EbbDatabase.primaryProfileId ? 'You' : '');

  /// The subject, mid-sentence: "you" / "Sam".
  String get subject => isOwner ? 'you' : _name!;

  /// Possessive, mid-sentence: "your" / "Sam’s".
  String get whose => isOwner ? 'your' : '${_name!}’s';

  /// Possessive, starting a sentence: "Your" / "Sam’s".
  String get whoseCap => isOwner ? 'Your' : '${_name!}’s';

  /// In first person, for buttons she presses about herself: "My" / "Sam’s".
  String get mine => isOwner ? 'My' : '${_name!}’s';
}
