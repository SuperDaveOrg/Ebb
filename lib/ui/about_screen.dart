import 'package:flutter/material.dart';

import 'package:ebb/l10n/app_localizations.dart';
import 'package:ebb/ui/language.dart';
import 'package:ebb/ui/layout.dart';

/// Explains, in plain language, where the data lives.
///
/// The tone here matters and is easy to get wrong. Tracking your cycle is
/// ordinary and unremarkable, and Ebb should never imply otherwise. This screen
/// is a statement about *our* obligations — what we don't collect and can't
/// reach — not a warning about hers, and not a suggestion that she has
/// something to hide.
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  static List<(IconData, String, String)> _points(AppLocalizations l) => [
    (Icons.phone_android, l.settingsDataStaysTitle, l.settingsDataStaysBody),
    (Icons.cloud_off_outlined, l.settingsDataUnseenTitle, l.settingsDataUnseenBody),
    (Icons.checklist, l.settingsDataPermissionsTitle, l.settingsDataPermissionsBody),
    (Icons.sell_outlined, l.settingsDataNotForSaleTitle, l.settingsDataNotForSaleBody),
    (Icons.delete_outline, l.settingsDataEraseTitle, l.settingsDataEraseBody),
    (Icons.code, l.settingsDataOpenSourceTitle, l.settingsDataOpenSourceBody),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(context.l.settingsYourData)),
      body: ListView(
        padding: readablePadding(
          context,
          base: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        ),
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 20),
              child: Image.asset(
                'assets/brand/ebb_logo_512.png',
                width: 96,
                height: 96,
                semanticLabel: 'Ebb',
              ),
            ),
          ),
          Text(
            context.l.settingsDataHeadline,
            style: theme.textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            context.l.settingsDataLede,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 28),
          for (final (icon, title, body) in _points(context.l)) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, color: theme.colorScheme.primary),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: theme.textTheme.titleMedium),
                      const SizedBox(height: 4),
                      Text(body, style: theme.textTheme.bodyMedium),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
          const Divider(height: 32),
          Text(
            context.l.settingsDataTradeOff,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
