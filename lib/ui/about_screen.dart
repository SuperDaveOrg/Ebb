import 'package:flutter/material.dart';
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

  static const _points = <(IconData, String, String)>[
    (
      Icons.phone_android,
      'It stays on your phone',
      'Everything you log is written to a database on this device. There is '
          'no account to create and no server to sync with. It only goes '
          'anywhere else if you move it yourself — a backup file, or another '
          'phone you send it to.',
    ),
    (
      Icons.cloud_off_outlined,
      'We cannot see it',
      'Ebb is built without permission to use '
          'the internet at all. Android enforces that, and you can verify it '
          'yourself in the app\'s permission list.',
    ),
    (
      Icons.checklist,
      'What the permissions are for',
      'Notifications, for reminders. Camera, only while you receive history '
          'from another phone — it reads the codes and nothing is recorded or '
          'kept. Ebb also re-arms your reminders when the phone restarts. '
          'That is the whole list.',
    ),
    (
      Icons.sell_outlined,
      'There is nothing to sell',
      'No analytics, no advertising, no third-party libraries phoning home. '
          'Since your data never reaches us, there is no copy of it for anyone '
          'to buy, subpoena, or leak.',
    ),
    (
      Icons.delete_outline,
      'You can erase it instantly',
      'Deleting your data in Settings, or uninstalling Ebb, removes '
          'everything Ebb holds. Ebb keeps no other copy — the only ones are '
          'backup files you saved or phones you sent it to yourself.',
    ),
    (
      Icons.code,
      'You can check our work',
      'Ebb is open source under the GNU General Public License. Anyone can '
          'read exactly what it does, and the published builds are made from '
          'that same code.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Your data')),
      body: ListView(
        padding: readablePadding(context,
            base: const EdgeInsets.fromLTRB(20, 8, 20, 32)),
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 20),
              child: Image.asset('assets/brand/ebb_logo_512.png',
                  width: 96, height: 96, semanticLabel: 'Ebb'),
            ),
          ),
          Text(
            'Your cycle is your business.',
            style: theme.textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Ebb is built so that the question "what do they do with my data?" '
            'has a boring answer: nothing, because we never receive it.',
            style: theme.textTheme.bodyLarge
                ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: 28),
          for (final (icon, title, body) in _points) ...[
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
            'One trade-off worth knowing: because there is no cloud backup, a '
            'lost or wiped phone means lost history. If that matters to you, '
            'save a backup file from Settings now and then, and keep it '
            'somewhere other than this phone.',
            style: theme.textTheme.bodySmall
                ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}
