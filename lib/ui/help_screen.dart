import 'package:flutter/material.dart';

import 'package:ebb/l10n/app_localizations.dart';
import 'package:ebb/ui/about_screen.dart';
import 'package:ebb/ui/language.dart';
import 'package:ebb/ui/layout.dart';

/// Short, plain answers to the questions someone actually has, in the app
/// itself: people don't read a README, and help that lives on a website would
/// need the network Ebb doesn't have.
///
/// Tone follows docs/privacy.md — ordinary, unembarrassed, no assumptions
/// about why someone is tracking.
class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  static List<(IconData, String, String)> _topics(AppLocalizations l) => [
    (Icons.water_drop_outlined, l.settingsHelpLoggingTitle, l.settingsHelpLoggingBody),
    (Icons.show_chart, l.settingsHelpEstimateTitle, l.settingsHelpEstimateBody),
    (Icons.do_not_disturb_on_outlined, l.settingsHelpExcludeTitle, l.settingsHelpExcludeBody),
    (Icons.groups_outlined, l.settingsHelpGroupsTitle, l.settingsHelpGroupsBody),
    (Icons.insights_outlined, l.settingsHelpRatingsTitle, l.settingsHelpRatingsBody),
    (Icons.thermostat_outlined, l.settingsHelpTemperatureTitle, l.settingsHelpTemperatureBody),
    (Icons.notifications_none, l.settingsHelpRemindersTitle, l.settingsHelpRemindersBody),
    (Icons.eco_outlined, l.settingsHelpFertileTitle, l.settingsHelpFertileBody),
    (Icons.save_alt, l.settingsHelpBackupTitle, l.settingsHelpBackupBody),
    (Icons.qr_code_2, l.settingsHelpMovingTitle, l.settingsHelpMovingBody),
    (Icons.person_add_alt, l.settingsHelpSomeoneElseTitle, l.settingsHelpSomeoneElseBody),
    (Icons.phone_android, l.settingsHelpHandoverTitle, l.settingsHelpHandoverBody),
    (Icons.delete_outline, l.settingsHelpDeletingTitle, l.settingsHelpDeletingBody),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(context.l.settingsHowEbbWorks)),
      body: ListView(
        padding: readablePadding(
          context,
          base: const EdgeInsets.only(bottom: 32),
        ),
        children: [
          for (final (icon, title, body) in _topics(context.l))
            ExpansionTile(
              leading: Icon(icon, color: theme.colorScheme.primary),
              title: Text(title),
              shape: const Border(),
              childrenPadding: const EdgeInsets.fromLTRB(72, 0, 24, 16),
              expandedAlignment: Alignment.centerLeft,
              children: [Text(body, style: theme.textTheme.bodyMedium)],
            ),
          const Divider(height: 32),
          ListTile(
            leading: const Icon(Icons.lock_outline),
            title: Text(context.l.settingsWhereDataLives),
            subtitle: Text(context.l.settingsWhereDataLivesHint),
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const AboutScreen())),
          ),
        ],
      ),
    );
  }
}
