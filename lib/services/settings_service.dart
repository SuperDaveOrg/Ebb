import 'package:shared_preferences/shared_preferences.dart';

import 'package:ebb/data/database.dart';
import 'package:ebb/domain/dates.dart';
import 'package:ebb/domain/milestones.dart';

/// One person's preferences, stored on the device alongside everything else.
///
/// Every setting here is per person: a parent tracking a child's cycle may
/// well want reminders for the child and the fertile window for themselves.
class SettingsService {
  SettingsService({this.profileId = EbbDatabase.primaryProfileId});

  final int profileId;

  String get _kRemindersEnabled => _key('reminders_enabled');
  String get _kLeadDays => _key('reminder_lead_days');
  String get _kReminderHour => _key('reminder_hour');
  String get _kShowFertileWindow => _key('show_fertile_window');
  String get _kShowMoonPhases => _key('show_moon_phases');
  String get _kCelebrations => _key('celebrations');
  String get _kMilestonesSeen => _key('milestones_seen');

  /// The primary profile keeps the original un-prefixed keys, so installs
  /// from before profiles existed keep their preferences untouched.
  String _key(String name) => profileId == EbbDatabase.primaryProfileId
      ? name
      : '$_othersPrefix$profileId.$name';

  bool get _isOwner => profileId == EbbDatabase.primaryProfileId;

  /// On by default for the phone's owner. Off for anyone added: a parent
  /// tracking alongside a child decides for themselves whether to be nudged.
  Future<bool> remindersEnabled() async =>
      (await SharedPreferences.getInstance()).getBool(_kRemindersEnabled) ??
      _isOwner;

  Future<void> setRemindersEnabled(bool value) async =>
      (await SharedPreferences.getInstance()).setBool(
        _kRemindersEnabled,
        value,
      );

  /// How many days ahead of the predicted start to send a heads-up.
  Future<int> leadDays() async =>
      (await SharedPreferences.getInstance()).getInt(_kLeadDays) ?? 2;

  Future<void> setLeadDays(int value) async =>
      (await SharedPreferences.getInstance()).setInt(_kLeadDays, value);

  Future<int> reminderHour() async =>
      (await SharedPreferences.getInstance()).getInt(_kReminderHour) ?? 9;

  Future<void> setReminderHour(int value) async =>
      (await SharedPreferences.getInstance()).setInt(_kReminderHour, value);

  /// Whether the fertile-window option exists at all for this person. Only
  /// the owner gets it: added people are often children.
  bool get offersFertileWindow => _isOwner;

  /// Off by default. Whether a fertile-window estimate is useful depends
  /// entirely on what she is using Ebb for, and the app should not assume.
  Future<bool> showFertileWindow() async =>
      offersFertileWindow &&
      ((await SharedPreferences.getInstance()).getBool(_kShowFertileWindow) ??
          false);

  Future<void> setShowFertileWindow(bool value) async =>
      (await SharedPreferences.getInstance()).setBool(
        _kShowFertileWindow,
        value,
      );

  /// Off by default: interesting to some, clutter to others.
  Future<bool> showMoonPhases() async =>
      (await SharedPreferences.getInstance()).getBool(_kShowMoonPhases) ??
      false;

  Future<void> setShowMoonPhases(bool value) async =>
      (await SharedPreferences.getInstance()).setBool(_kShowMoonPhases, value);

  /// On by default: a small celebration when a milestone is reached.
  Future<bool> celebrations() async =>
      (await SharedPreferences.getInstance()).getBool(_kCelebrations) ?? true;

  Future<void> setCelebrations(bool value) async =>
      (await SharedPreferences.getInstance()).setBool(_kCelebrations, value);

  /// Milestones already reached as far as the app knows, so each is
  /// celebrated once at most.
  Future<Set<Milestone>> milestonesSeen() async {
    final names =
        (await SharedPreferences.getInstance()).getStringList(
          _kMilestonesSeen,
        ) ??
        const [];
    return {
      for (final m in Milestone.values)
        if (names.contains(m.name)) m,
    };
  }

  Future<void> setMilestonesSeen(Set<Milestone> seen) async =>
      (await SharedPreferences.getInstance()).setStringList(
        _kMilestonesSeen,
        [for (final m in seen) m.name],
      );

  /// Forgets this person's preferences, when they're removed from the phone.
  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    for (final k in [
      _kRemindersEnabled,
      _kLeadDays,
      _kReminderHour,
      _kShowFertileWindow,
      _kShowMoonPhases,
      _kCelebrations,
      _kMilestonesSeen,
    ]) {
      await prefs.remove(k);
    }
  }

  /// Forgets the preferences of everyone except the owner.
  ///
  /// Run after a restore, which renumbers people from scratch: without this,
  /// whoever becomes person 2 would inherit the old person 2's reminders.
  static Future<void> forgetOthers() async {
    final prefs = await SharedPreferences.getInstance();
    for (final k in prefs.getKeys().where((k) => k.startsWith(_othersPrefix))) {
      await prefs.remove(k);
    }
  }

  /// Forgets every preference on the phone, for "Delete all data".
  static Future<void> forgetEveryone() async {
    await forgetOthers();
    await SettingsService().clear();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kActiveProfile);
    await prefs.remove(_kGroupsEnabled);
    await prefs.remove(_kFirstBackup);
  }

  static const _othersPrefix = 'profile_';
  static const _kFirstBackup = 'first_backup_on';
  static const _kActiveProfile = 'active_profile_id';
  static const _kGroupsEnabled = 'groups_enabled';

  /// Whether the advanced groups option is on. Phone-wide, and off by
  /// default: most people with more than one person here are a parent and
  /// children, who have no use for it. Turning it off hides groups without
  /// deleting them.
  static Future<bool> groupsEnabled() async =>
      (await SharedPreferences.getInstance()).getBool(_kGroupsEnabled) ?? false;

  static Future<void> setGroupsEnabled(bool value) async =>
      (await SharedPreferences.getInstance()).setBool(_kGroupsEnabled, value);

  /// Whose cycle the app showed last. A phone-wide setting, not a person's.
  static Future<int?> lastActiveProfile() async =>
      (await SharedPreferences.getInstance()).getInt(_kActiveProfile);

  static Future<void> setLastActiveProfile(int id) async =>
      (await SharedPreferences.getInstance()).setInt(_kActiveProfile, id);

  /// When a backup file was first saved on this phone. Phone-wide, since a
  /// backup holds everyone; shown as the owner's milestone.
  static Future<DateTime?> firstBackupOn() async {
    final iso = (await SharedPreferences.getInstance()).getString(
      _kFirstBackup,
    );
    return iso == null ? null : parseIsoDate(iso);
  }

  /// Records [day] as the first backup, unless there already was one.
  /// Returns whether this was the first.
  static Future<bool> noteBackup(DateTime day) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(_kFirstBackup)) return false;
    await prefs.setString(_kFirstBackup, isoDate(day));
    return true;
  }
}
