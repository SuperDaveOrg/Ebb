import 'package:ebb/data/cycle_repository.dart';
import 'package:ebb/data/database.dart';
import 'package:ebb/data/profile_repository.dart';
import 'package:ebb/domain/predictor.dart';
import 'package:ebb/services/notification_service.dart';
import 'package:ebb/services/settings_service.dart';

/// Reschedules every person's reminders from their current history.
///
/// Run after anything changes, not just for whoever is on screen: a restore
/// or a change made while viewing one person must not leave another's
/// reminders stale or missing. It's a handful of queries, so doing it
/// wholesale is simpler than tracking what changed.
Future<void> syncAllReminders(
  NotificationService notifications, {
  EbbDatabase? db,
}) async {
  const predictor = Predictor();
  await notifications.init();
  await notifications.refreshTimeZone();
  for (final profile in await ProfileRepository(db: db).all()) {
    final id = profile.id!;
    final settings = SettingsService(profileId: id);
    final cycles = await CycleRepository(db: db, profileId: id).allCycles();
    await notifications.syncReminders(
      predictor.predict(cycles),
      profile: profile,
      enabled: await settings.remindersEnabled(),
      leadDays: await settings.leadDays(),
      hour: await settings.reminderHour(),
    );
  }
}
