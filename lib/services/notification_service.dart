import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

import 'package:ebb/data/database.dart';
import 'package:ebb/domain/dates.dart';
import 'package:ebb/domain/predictor.dart';
import 'package:ebb/models/profile.dart';

/// Schedules reminders with the operating system.
///
/// Everything here is a *local* notification: the OS holds the alarm and fires
/// it on the device. Ebb has no push server and no network permission, so
/// reminders keep working in airplane mode and nothing leaves the phone.
///
/// Alarms are scheduled inexactly on purpose. A period reminder is useful if it
/// arrives sometime that morning; it does not need to be accurate to the
/// second, and asking for exact-alarm permission would be a real permission
/// prompt bought for no benefit.
class NotificationService {
  NotificationService({FlutterLocalNotificationsPlugin? plugin})
    : _plugin = plugin ?? FlutterLocalNotificationsPlugin();

  final FlutterLocalNotificationsPlugin _plugin;

  static const _channelId = 'ebb_cycle_reminders';
  static const _channelName = 'Cycle reminders';
  static const _channelDescription =
      'Heads-up before your period is expected, and a nudge to log it.';

  /// IDs are fixed per profile so that rescheduling replaces rather than
  /// stacks, and one person's reminders never cancel another's. The primary
  /// profile gets 1001 and 1002, the IDs used before profiles existed.
  static int _idUpcoming(int profileId) => profileId * 1000 + 1;
  static int _idExpectedToday(int profileId) => profileId * 1000 + 2;

  bool _ready = false;

  Future<void> init() async {
    if (_ready) return;
    tzdata.initializeTimeZones();
    await refreshTimeZone();

    await _plugin.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      ),
    );
    _ready = true;
  }

  /// Asks for notification permission (Android 13+). Returns false if declined.
  Future<bool> requestPermission() async {
    final android = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    if (android == null) return false;
    return await android.requestNotificationsPermission() ?? false;
  }

  /// Rewrites [profile]'s scheduled reminders to match [prediction].
  ///
  /// Called after every change to cycle history, so the reminders always
  /// reflect the current estimate rather than a stale one.
  Future<void> syncReminders(
    CyclePrediction prediction, {
    required Profile profile,
    required bool enabled,
    required int leadDays,
    required int hour,
  }) async {
    await init();
    final id = profile.id!;
    await _plugin.cancel(id: _idUpcoming(id));
    await _plugin.cancel(id: _idExpectedToday(id));
    if (!enabled || !prediction.hasPrediction) return;

    final expected = prediction.nextStart!;
    final headsUp = addDays(expected, -leadDays);

    // The owner is "you" even with a name set; anyone else is named, so the
    // reminder says whose period it is.
    final owner = id == EbbDatabase.primaryProfileId;
    final whose = owner ? 'your' : '${profile.name}’s';
    final subject = owner ? 'Period' : '${profile.name}’s period';

    await _scheduleAt(
      id: _idUpcoming(id),
      when: headsUp,
      hour: hour,
      title: '$subject expected soon',
      body: leadDays == 1
          ? 'Ebb expects $whose period to start tomorrow.'
          : 'Ebb expects $whose period in about $leadDays days.',
    );

    await _scheduleAt(
      id: _idExpectedToday(id),
      when: expected,
      hour: hour,
      title: '$subject expected today',
      body: 'Tap to log how things are going.',
    );
  }

  Future<void> _scheduleAt({
    required int id,
    required DateTime when,
    required int hour,
    required String title,
    required String body,
  }) async {
    final scheduled = tz.TZDateTime(
      tz.local,
      when.year,
      when.month,
      when.day,
      hour,
    );
    if (scheduled.isBefore(tz.TZDateTime.now(tz.local))) return;

    await _plugin.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: scheduled,
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          _channelName,
          channelDescription: _channelDescription,
          importance: Importance.defaultImportance,
          priority: Priority.defaultPriority,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    );
  }

  Future<void> cancelAll() async => _plugin.cancelAll();

  /// Drops one person's reminders, when they're removed from the phone.
  Future<void> cancelFor(int profileId) async {
    await _plugin.cancel(id: _idUpcoming(profileId));
    await _plugin.cancel(id: _idExpectedToday(profileId));
  }

  /// Re-reads the phone's time zone, so reminders fire at the chosen hour
  /// where she is now rather than where she was when Ebb started. Run before
  /// every reschedule; alarms already set keep the zone they were set in until
  /// then.
  Future<void> refreshTimeZone() async {
    try {
      final name = (await FlutterTimezone.getLocalTimezone()).identifier;
      tz.setLocalLocation(tz.getLocation(name));
    } catch (_) {
      // An unknown or unreadable zone: keep the last one that worked, or
      // UTC if there never was one.
    }
  }
}
