import 'package:ebb/data/database.dart';
import 'package:ebb/models/profile.dart';
import 'package:ebb/services/settings_service.dart';
import 'package:ebb/ui/wording.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  const owner = EbbDatabase.primaryProfileId;
  const sam = 2;

  group('settings per person', () {
    setUp(() => SharedPreferences.setMockInitialValues({}));

    test('reminders are on for the owner and off for anyone added', () async {
      expect(
        await SettingsService(profileId: owner).remindersEnabled(),
        isTrue,
      );
      expect(await SettingsService(profileId: sam).remindersEnabled(), isFalse);
    });

    test('the fertile window is only ever offered to the owner', () async {
      final theirs = SettingsService(profileId: sam);
      expect(theirs.offersFertileWindow, isFalse);
      // Even if a preference somehow got stored, it isn't honoured.
      await theirs.setShowFertileWindow(true);
      expect(await theirs.showFertileWindow(), isFalse);

      final mine = SettingsService(profileId: owner);
      expect(mine.offersFertileWindow, isTrue);
      await mine.setShowFertileWindow(true);
      expect(await mine.showFertileWindow(), isTrue);
    });

    test('one person’s settings never leak into another’s', () async {
      await SettingsService(profileId: sam).setLeadDays(5);
      expect(await SettingsService(profileId: owner).leadDays(), 2);
      expect(await SettingsService(profileId: sam).leadDays(), 5);
    });

    test('the owner keeps the keys used before profiles existed', () async {
      SharedPreferences.setMockInitialValues({'reminder_lead_days': 7});
      expect(await SettingsService(profileId: owner).leadDays(), 7);
    });

    test('removing someone forgets their preferences', () async {
      final theirs = SettingsService(profileId: sam);
      await theirs.setRemindersEnabled(true);
      await theirs.clear();
      expect(await theirs.remindersEnabled(), isFalse);
    });

    test('a restore forgets everyone else, so nobody inherits an ID', () async {
      await SettingsService(profileId: owner).setLeadDays(5);
      await SettingsService(profileId: sam).setRemindersEnabled(true);
      await SettingsService.forgetOthers();
      expect(await SettingsService(profileId: owner).leadDays(), 5);
      expect(await SettingsService(profileId: sam).remindersEnabled(), isFalse);
    });

    test('deleting everything forgets every preference', () async {
      await SettingsService(profileId: owner).setLeadDays(5);
      await SettingsService(profileId: owner).setRemindersEnabled(false);
      await SettingsService(profileId: sam).setLeadDays(7);
      await SettingsService.setLastActiveProfile(sam);
      await SettingsService.forgetEveryone();
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getKeys(), isEmpty);
    });
  });

  group('wording', () {
    test('the owner is "you", even after choosing a name', () {
      for (final name in [null, 'Dana']) {
        final who = Who(Profile(id: owner, name: name));
        expect(who.whose, 'your');
        expect(who.mine, 'My');
      }
    });

    test('anyone else is called by name, never a pronoun', () {
      final who = Who(const Profile(id: sam, name: 'Sam'));
      expect(who.whose, 'Sam’s');
      expect(who.whoseCap, 'Sam’s');
      expect(who.mine, 'Sam’s');
    });

    test('the switcher shows the owner as "You" until named', () {
      expect(Who.label(const Profile(id: owner)), 'You');
      expect(Who.label(const Profile(id: owner, name: 'Dana')), 'Dana');
      expect(Who.label(const Profile(id: sam, name: 'Sam')), 'Sam');
    });
  });
}
