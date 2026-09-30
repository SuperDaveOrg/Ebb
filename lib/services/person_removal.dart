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

/// Takes a shared copy off this phone: when it leaves its last group, a
/// copy of someone else's history has no reason to stay. Copies never have
/// reminders, so there are none to cancel.
Future<void> removeSharedCopy(int profileId) async {
  await ProfileRepository().remove(profileId);
  await SettingsService(profileId: profileId).clear();
}
