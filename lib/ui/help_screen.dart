import 'package:flutter/material.dart';

import 'package:ebb/ui/about_screen.dart';
import 'package:ebb/ui/layout.dart';

/// Short, plain answers to the questions someone actually has, in the app
/// itself: people don't read a README, and help that lives on a website would
/// need the network Ebb doesn't have.
///
/// Tone follows docs/privacy.md — ordinary, unembarrassed, no assumptions
/// about why someone is tracking.
class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  static const _topics = <(IconData, String, String)>[
    (
      Icons.water_drop_outlined,
      'Logging a period',
      'Tap “My period started today” on the first day of bleeding, and “My '
          'period ended today” on the last.\n\n'
          'Forgot to log it? Use “It started on an earlier day” instead. Any '
          'past period can be added or corrected in History (the clock icon): '
          'tap one to change its dates or add a note.\n\n'
          'If no end is logged within two weeks, Ebb stops treating the period '
          'as still going and offers to add the end instead.',
    ),
    (
      Icons.show_chart,
      'How the estimate works',
      'Ebb looks at the gaps between the starts of your recent periods — up '
          'to the last six.\n\n'
          'With only a little history it leans on a typical 28-day cycle, and '
          'says so. The more you log, the more the estimate is your own '
          'rhythm.\n\n'
          'It shows a range rather than a single date, and tells you how sure '
          'it is. If your cycles vary a lot, the range is wider.\n\n'
          'If a period is late, Ebb says how late. If nothing is logged for '
          'nearly two cycles, it assumes a period went unlogged, estimates '
          'from there, and says so. History points out long gaps, and adding '
          'a missed period puts the estimate right.',
    ),
    (
      Icons.do_not_disturb_on_outlined,
      'A cycle that shouldn’t count',
      'Illness, a medication change or a pregnancy loss can throw one cycle '
          'right off, and it would pull the estimate with it.\n\n'
          'In History, tap that period and turn off “Count this cycle in '
          'predictions”. It stays in your history; the estimate just ignores '
          'it. Add a note there too, so you remember why.',
    ),
    (
      Icons.groups_outlined,
      'Groups',
      'For circles and clubs that track together. Turn them on in Settings '
          '→ Advanced, then make a group and choose who’s in it. “See … '
          'together” in the list of people shows everyone side by side, with '
          'the moon.\n\n'
          'A group can have two kinds of member. Someone added to it is '
          'tracked on this phone, and you log for them here. Someone '
          'imported keeps tracking on their own phone and provides their '
          'history to the group: it stays theirs, and can’t be changed on '
          'anyone else’s phone.\n\n'
          'To be imported, send just your history (Settings → Send to '
          'another phone) — as much or as little as you like, with or without '
          'your daily notes. The other phone imports it from the group: '
          'Manage groups → the group → Import from their phone. Importing '
          'you again brings it up to date.\n\n'
          'Imported history belongs to its group. Taking someone imported out '
          'of their last group, or deleting that group, takes their history '
          'off the phone too. And it can’t be sent on: only your own history '
          'can.',
    ),
    (
      Icons.insights_outlined,
      'Day ratings, feelings and charts',
      'Tap any day on the calendar to rate it from 1 to 5, and to pick a '
          'face for how you felt. Both are optional; tap a choice again to '
          'clear it.\n\n'
          'Charts (the chart icon) shows each day’s rating over the dates '
          'you choose, with periods shaded, and which feelings came during '
          'and before periods. With moon phases turned on in Settings, the '
          'moon is there too.\n\n'
          'The charts show what you logged. They don’t say what it means — '
          'that’s yours to judge.',
    ),
    (
      Icons.notifications_none,
      'Reminders',
      'A heads-up a few days before your period is expected, and another on '
          'the day. Choose how far ahead in Settings.\n\n'
          'They’re scheduled on the phone itself, so they arrive with no '
          'signal and in airplane mode.\n\n'
          'Ebb sets them each time you open it, from the latest estimate. The '
          'phone keeps them through restarts, but Ebb can’t update them while '
          'it’s closed, so open it now and then — logging a period is enough.\n\n'
          'Android may deliver them a little after the usual time to save '
          'battery. If Ebb is force-stopped, or a battery saver restricts it, '
          'they may not arrive until you next open Ebb.',
    ),
    (
      Icons.eco_outlined,
      'The fertile window',
      'Off unless you turn it on in Settings. It’s estimated from cycle '
          'timing alone, which is not reliable enough to use as '
          'contraception.',
    ),
    (
      Icons.save_alt,
      'Backing up',
      'There’s no cloud copy of your history, so a lost or wiped phone means '
          'lost history.\n\n'
          'Settings → “Back up to a file” saves everything as a file, wherever '
          'you choose. Keep it somewhere other than this phone. “Restore from '
          'a backup” brings it back.',
    ),
    (
      Icons.qr_code_2,
      'Moving to a new phone',
      'On the old phone: Settings → “Send to another phone”. On the new one: '
          'Settings → “Receive from another phone”, and point the camera at '
          'the screen.\n\n'
          'Longer histories take a few codes, which change on their own; the '
          'new phone collects them in any order. No internet is involved — '
          'one phone shows, the other looks.',
    ),
    (
      Icons.person_add_alt,
      'Tracking someone else',
      'Helping someone else keep track — a child who’s just starting, say? '
          'Settings → “Track someone else too”, and give them a name. A '
          'nickname or initial is fine.\n\n'
          'Tap the name at the top of the home screen to switch between '
          'people. Everyone has their own reminders, which start off for '
          'people you add. The fertile window is only ever offered for you.',
    ),
    (
      Icons.phone_android,
      'Handing someone over',
      'When someone you track gets their own phone: “Send to another phone”, '
          'and choose just them. On their phone, “Receive from another '
          'phone”. On a fresh install their history simply becomes theirs.\n\n'
          'Afterwards Ebb asks whether to remove them from your phone. It '
          'never does that on its own.',
    ),
    (
      Icons.delete_outline,
      'Deleting',
      'Settings → “Delete all data” erases everything on this phone at '
          'once.\n\n'
          'To remove one person you’ve added, open their settings and choose '
          '“Remove … from this phone”. Nobody else’s history is touched.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('How Ebb works')),
      body: ListView(
        padding: readablePadding(
          context,
          base: const EdgeInsets.only(bottom: 32),
        ),
        children: [
          for (final (icon, title, body) in _topics)
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
            title: const Text('Where your data lives'),
            subtitle: const Text('Your data, and who can see it.'),
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const AboutScreen())),
          ),
        ],
      ),
    );
  }
}
