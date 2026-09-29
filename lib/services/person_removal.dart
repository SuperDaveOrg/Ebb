import 'package:ebb/data/profile_repository.dart';
import 'package:ebb/services/notification_service.dart';
import 'package:ebb/services/settings_service.dart';

/// Takes someone off this phone completely: their history (by cascade),
/// their scheduled reminders and their preferences. Nobody else is touched.
///
/// Used from their settings, and after handing their history to their own
/// phone.
Future<void> removePerson(
  int profileId,
  NotificationService notifications,
) async {
  await ProfileRepository().remove(profileId);
  await notifications.cancelFor(profileId);
  await SettingsService(profileId: profileId).clear();
}
