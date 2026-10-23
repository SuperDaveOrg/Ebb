// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get you => 'You';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get delete => 'Delete';

  @override
  String get remove => 'Remove';

  @override
  String get close => 'Close';

  @override
  String get done => 'Done';

  @override
  String get back => 'Back';

  @override
  String get next => 'Next';

  @override
  String get edit => 'Edit';

  @override
  String get add => 'Add';

  @override
  String get continueAction => 'Continue';

  @override
  String get language => 'Language';

  @override
  String get languagePhone => 'Phone\'s language';

  @override
  String languagePhoneIs(String language) {
    return 'Phone\'s language ($language)';
  }

  @override
  String get notifChannelName => 'Cycle reminders';

  @override
  String get notifChannelDescription =>
      'Heads-up before your period is expected, and a nudge to log it.';

  @override
  String notifUpcomingTitle(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Period expected soon',
      'other': '$name’s period expected soon',
    });
    return '$_temp0';
  }

  @override
  String notifUpcomingTomorrow(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Ebb expects your period to start tomorrow.',
      'other': 'Ebb expects $name’s period to start tomorrow.',
    });
    return '$_temp0';
  }

  @override
  String notifUpcomingInDays(String who, String name, int days) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Ebb expects your period in about $days days.',
      'other': 'Ebb expects $name’s period in about $days days.',
    });
    return '$_temp0';
  }

  @override
  String notifTodayTitle(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Period expected today',
      'other': '$name’s period expected today',
    });
    return '$_temp0';
  }

  @override
  String get notifTodayBody => 'Tap to log how things are going.';

  @override
  String get calendarTitle => 'Calendar';

  @override
  String get calendarCellToday => 'today';

  @override
  String get calendarCellPeriod => 'period';

  @override
  String get calendarCellPeriodUnlogged => 'period, end not logged';

  @override
  String get calendarCellLikely => 'next period likely';

  @override
  String get calendarCellFertile => 'estimated fertile window';

  @override
  String calendarCellMoon(String phase) {
    String _temp0 = intl.Intl.selectLogic(phase, {
      'newMoon': 'new moon',
      'firstQuarter': 'first quarter',
      'full': 'full moon',
      'other': 'last quarter',
    });
    return '$_temp0';
  }

  @override
  String calendarCellRated(int rating) {
    return 'rated $rating';
  }

  @override
  String calendarCellFelt(String feeling) {
    return 'felt $feeling';
  }

  @override
  String get calendarCellNote => 'has a note';

  @override
  String get calendarKeyPeriod => 'Period';

  @override
  String get calendarKeyEndNotLogged => 'End not logged';

  @override
  String get calendarKeyLikely => 'Likely start';

  @override
  String get calendarKeyFertile => 'Fertile (estimate)';

  @override
  String get calendarKeyToday => 'Today';

  @override
  String calendarStatusWindow(String who, String name, String from, String to) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Your next period is likely to start between $from and $to.',
      'other': '$name’s next period is likely to start between $from and $to.',
    });
    return '$_temp0';
  }

  @override
  String calendarStatusPeriodDay(String who, String name, int day) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Day $day of your period.',
      'other': 'Day $day of $name’s period.',
    });
    return '$_temp0';
  }

  @override
  String calendarStatusPeriodDayExcluded(String who, String name, int day) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Day $day of your period, in a cycle not counted in predictions.',
      'other':
          'Day $day of $name’s period, in a cycle not counted in predictions.',
    });
    return '$_temp0';
  }

  @override
  String calendarStatusUnlogged(String who, String name, int day) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you':
          'Day $day of your cycle. The end of this period wasn’t logged, so it’s drawn at the usual length.',
      'other':
          'Day $day of $name’s cycle. The end of this period wasn’t logged, so it’s drawn at the usual length.',
    });
    return '$_temp0';
  }

  @override
  String get calendarStatusFertile =>
      'In the estimated fertile window. Not reliable enough to use as contraception.';

  @override
  String calendarStatusCycleDay(String who, String name, int day) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Day $day of your cycle.',
      'other': 'Day $day of $name’s cycle.',
    });
    return '$_temp0';
  }

  @override
  String calendarDayToday(String date) {
    return 'Today, $date';
  }

  @override
  String get calendarPreviousDay => 'Previous day';

  @override
  String get calendarNextDay => 'Next day';

  @override
  String calendarMoonAt(String phase, String time) {
    return '$phase, $time';
  }

  @override
  String get calendarFutureDay => 'Days still to come can’t be logged yet.';

  @override
  String calendarMarkStarted(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Mark as the day your period started',
      'other': 'Mark as the day $name’s period started',
    });
    return '$_temp0';
  }

  @override
  String get calendarMoveStart => 'Make this the first day of the period';

  @override
  String calendarMoveStartFrom(String date) {
    return 'Moves its start from $date';
  }

  @override
  String calendarMarkEnded(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Mark as the day your period ended',
      'other': 'Mark as the day $name’s period ended',
    });
    return '$_temp0';
  }

  @override
  String get calendarMakeLastDay => 'Make this the last day of the period';

  @override
  String get calendarEditPeriod => 'Edit this period';

  @override
  String calendarRateDay(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Rate your day, 1–5',
      'other': 'Rate $name’s day, 1–5',
    });
    return '$_temp0';
  }

  @override
  String calendarHowFelt(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'How did you feel?',
      'other': 'How did $name feel?',
    });
    return '$_temp0';
  }

  @override
  String get calendarFlow => 'Flow';

  @override
  String get calendarNote => 'Note';

  @override
  String calendarTemperatureHeading(String unit) {
    return 'Temperature, $unit';
  }

  @override
  String calendarTemperatureRange(String low, String high, String unit) {
    return 'Enter a temperature from $low to $high $unit';
  }

  @override
  String get calendarTemperatureHelper => 'On waking, before getting up';

  @override
  String get calendarTemperatureAffected => 'Something may have affected it';

  @override
  String get calendarTemperatureAffectedHint =>
      'Illness, little sleep, alcohol, taken late';

  @override
  String get calendarMucus => 'Cervical mucus';

  @override
  String get calendarMucusFelt => 'How it felt';

  @override
  String get calendarMucusLooked => 'How it looked';

  @override
  String calendarLoggedRated(int rating, String ratingName) {
    return 'Rated $rating of 5, $ratingName';
  }

  @override
  String calendarLoggedFelt(String emoji, String feeling) {
    return 'Felt $emoji $feeling';
  }

  @override
  String calendarLoggedFlow(String flow) {
    String _temp0 = intl.Intl.selectLogic(flow, {
      'spotting': 'Flow: spotting',
      'light': 'Flow: light',
      'medium': 'Flow: medium',
      'other': 'Flow: heavy',
    });
    return '$_temp0';
  }

  @override
  String calendarLoggedTemperature(String temperature) {
    return 'Temperature: $temperature';
  }

  @override
  String calendarLoggedTemperatureAffected(String temperature) {
    return 'Temperature: $temperature, may have been affected';
  }

  @override
  String calendarLoggedMucus(String mucus) {
    return 'Cervical mucus: $mucus';
  }

  @override
  String calendarLoggedNote(String note) {
    return '“$note”';
  }

  @override
  String get calendarNothingLogged => 'Nothing logged this day.';

  @override
  String get calendarMoonNew => 'New moon';

  @override
  String get calendarMoonFirstQuarter => 'First quarter';

  @override
  String get calendarMoonFull => 'Full moon';

  @override
  String get calendarMoonLastQuarter => 'Last quarter';

  @override
  String get dayFlowNone => 'None';

  @override
  String get dayFlowSpotting => 'Spotting';

  @override
  String get dayFlowLight => 'Light';

  @override
  String get dayFlowMedium => 'Medium';

  @override
  String get dayFlowHeavy => 'Heavy';

  @override
  String get dayMucusNothing => 'Nothing';

  @override
  String get dayMucusFeelDry => 'Dry';

  @override
  String get dayMucusFeelWet => 'Wet';

  @override
  String get dayMucusFeelSlippery => 'Slippery';

  @override
  String get dayMucusLookCreamy => 'Creamy';

  @override
  String get dayMucusLookEggWhite => 'Egg white';

  @override
  String dayMucusFeelInline(String feel) {
    String _temp0 = intl.Intl.selectLogic(feel, {
      'dry': 'dry',
      'nothing': 'nothing felt',
      'wet': 'wet',
      'other': 'slippery',
    });
    return '$_temp0';
  }

  @override
  String dayMucusLookInline(String look) {
    String _temp0 = intl.Intl.selectLogic(look, {
      'nothing': 'nothing seen',
      'creamy': 'creamy',
      'other': 'egg white',
    });
    return '$_temp0';
  }

  @override
  String get dayFeelingHappy => 'Happy';

  @override
  String get dayFeelingCalm => 'Calm';

  @override
  String get dayFeelingLoving => 'Loving';

  @override
  String get dayFeelingEnergetic => 'Energetic';

  @override
  String get dayFeelingTired => 'Tired';

  @override
  String get dayFeelingSad => 'Sad';

  @override
  String get dayFeelingAnxious => 'Anxious';

  @override
  String get dayFeelingIrritable => 'Irritable';

  @override
  String get dayFeelingAngry => 'Angry';

  @override
  String get dayFeelingConfused => 'Confused';

  @override
  String get chartsTitle => 'Charts';

  @override
  String get chartsDayRating => 'Day rating';

  @override
  String get chartsNoRatings => 'No days in this range have a rating yet.';

  @override
  String get chartsBars => 'Bars';

  @override
  String get chartsLine => 'Line';

  @override
  String get chartsRatingCaptionBars =>
      'Each bar is one day’s rating, 1 to 5. Period days are shaded.';

  @override
  String get chartsRatingCaptionLine =>
      'Each point is one day’s rating, joined to the next day’s when both were rated, 1 to 5. Period days are shaded.';

  @override
  String get chartsRatingCaptionMoon =>
      'Moons mark the moon’s phases; over a long range, only the new and full moons, or just the full ones.';

  @override
  String get chartsTemperatureTitle => 'Temperature and cervical mucus';

  @override
  String get chartsTemperatureEmpty =>
      'Nothing logged in this range yet. Tap a day on the calendar to add a temperature or cervical mucus.';

  @override
  String chartsTemperatureCaption(String unit) {
    return 'Each point is one day’s temperature, in $unit, joined to the next day’s when both were taken. A hollow point may have been affected, and isn’t joined. Below, cervical mucus: taller bars are wetter (felt) and clearer and stretchier (looked). Period days are shaded.';
  }

  @override
  String get chartsFeelings => 'Feelings';

  @override
  String get chartsAroundPeriods => 'Around periods';

  @override
  String get chartsAroundMoon => 'Around the moon';

  @override
  String get chartsFeelingsEmptyMoon =>
      'Once you’ve picked how you felt on some days in this range, this shows which feelings came around full and new moons.';

  @override
  String get chartsFeelingsEmptyPeriods =>
      'Once you’ve picked how you felt on some days in this range, and a period has started since, this shows which feelings came when.';

  @override
  String get chartsFeelingsCaptionMoon => 'How many days each face was picked.';

  @override
  String get chartsFeelingsCaptionPeriods =>
      'How many days each face was picked. Days since the latest period started aren’t counted until the next one does.';

  @override
  String get chartsNoneYet => 'None yet.';

  @override
  String get chartsGroupDuringPeriod => 'During a period';

  @override
  String get chartsGroupBeforePeriod => 'Just before a period';

  @override
  String get chartsGroupOtherDays => 'Other days';

  @override
  String get chartsGroupFullMoon => 'Around a full moon';

  @override
  String get chartsGroupNewMoon => 'Around a new moon';

  @override
  String get chartsDetailLoggedPeriodDays => 'logged period days';

  @override
  String chartsDetailUsuallyDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'usually $days days',
      one: 'usually 1 day',
    );
    return '$_temp0';
  }

  @override
  String chartsDetailDaysBefore(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'the $days days before',
      one: 'the day before',
    );
    return '$_temp0';
  }

  @override
  String get chartsDetailRestOfCycle => 'the rest of the cycle';

  @override
  String get chartsDetailDayItself => 'the day itself';

  @override
  String chartsDetailDayEitherSide(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'the day, ±$days days',
      one: 'the day, ±1 day',
    );
    return '$_temp0';
  }

  @override
  String get chartsDetailRestOfMonth => 'the rest of the month';

  @override
  String chartsFeelingCount(String feeling, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days',
      one: '1 day',
    );
    return '$feeling on $_temp0';
  }

  @override
  String chartsFeelingGroupSummary(String group, String detail, String counts) {
    return '$group, $detail: $counts';
  }

  @override
  String get chartsFeelingGroupNone => 'none yet';

  @override
  String chartsRatingSummary(String from, String to, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count rated days',
      one: '1 rated day',
    );
    return 'Day ratings from $from to $to: $_temp0, with period days shaded.';
  }

  @override
  String chartsRatingSummaryMoons(String from, String to, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count rated days',
      one: '1 rated day',
    );
    return 'Day ratings from $from to $to: $_temp0, with period days shaded and moon phases marked.';
  }

  @override
  String chartsLanesSummary(String from, String to, String lanes) {
    return 'Periods from $from to $to. $lanes.';
  }

  @override
  String chartsLane(String name, String periods) {
    return '$name: $periods';
  }

  @override
  String get chartsLaneNone => 'no period days';

  @override
  String chartsLaneRun(String from, String to) {
    return '$from to $to';
  }

  @override
  String chartsLaneRunEstimated(String from, String to) {
    return '$from to $to, estimated';
  }

  @override
  String chartsTemperatureSummary(
    String from,
    String to,
    String range,
    int mucusDays,
  ) {
    String _temp0 = intl.Intl.pluralLogic(
      mucusDays,
      locale: localeName,
      other: '$mucusDays days',
      one: '1 day',
    );
    return 'Temperatures from $from to $to: $range, cervical mucus noted on $_temp0, with period days shaded.';
  }

  @override
  String get chartsNoTemperatures => 'no temperatures';

  @override
  String chartsTemperatureRange(int count, String low, String high) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count temperatures',
      one: '1 temperature',
    );
    return '$_temp0, from $low to $high';
  }

  @override
  String get chartsMucusFelt => 'Felt';

  @override
  String get chartsMucusLooked => 'Looked';

  @override
  String get faceRatingRough => 'Rough';

  @override
  String get faceRatingNotGreat => 'Not great';

  @override
  String get faceRatingOkay => 'Okay';

  @override
  String get faceRatingGood => 'Good';

  @override
  String get faceRatingGreat => 'Great';

  @override
  String get faceRatingRoughInline => 'rough';

  @override
  String get faceRatingNotGreatInline => 'not great';

  @override
  String get faceRatingOkayInline => 'okay';

  @override
  String get faceRatingGoodInline => 'good';

  @override
  String get faceRatingGreatInline => 'great';

  @override
  String faceRatingOption(int rating, String name) {
    return '$rating, $name';
  }

  @override
  String get faceMoreFaces => 'More faces';

  @override
  String get faceDifferentFace => 'A different face';

  @override
  String get faceOther => 'Other face';

  @override
  String get faceSmilingCat => 'Smiling cat';

  @override
  String get faceGrinningCat => 'Grinning cat';

  @override
  String get faceCatTearsOfJoy => 'Cat with tears of joy';

  @override
  String get faceCatHeartEyes => 'Cat with heart eyes';

  @override
  String get faceSmirkingCat => 'Smirking cat';

  @override
  String get faceKissingCat => 'Kissing cat';

  @override
  String get faceWearyCat => 'Weary cat';

  @override
  String get faceCryingCat => 'Crying cat';

  @override
  String get facePoutingCat => 'Pouting cat';

  @override
  String get faceAlien => 'Alien';

  @override
  String get faceSpaceInvader => 'Space invader';

  @override
  String get faceRobot => 'Robot';

  @override
  String get faceGhost => 'Ghost';

  @override
  String get faceSkull => 'Skull';

  @override
  String get faceClown => 'Clown';

  @override
  String get faceDevil => 'Devil';

  @override
  String get faceUnicorn => 'Unicorn';

  @override
  String get faceFrog => 'Frog';

  @override
  String get facePartying => 'Partying';

  @override
  String get faceCool => 'Cool';

  @override
  String get faceNerdy => 'Nerdy';

  @override
  String get faceAngelic => 'Angelic';

  @override
  String get faceHugging => 'Hugging';

  @override
  String get faceSilly => 'Silly';

  @override
  String get faceUpsideDown => 'Upside down';

  @override
  String get faceSmirking => 'Smirking';

  @override
  String get faceGrimacing => 'Grimacing';

  @override
  String get faceEyeRoll => 'Eye roll';

  @override
  String get faceSpeechless => 'Speechless';

  @override
  String get facePleading => 'Pleading';

  @override
  String get faceSobbing => 'Sobbing';

  @override
  String get faceScreaming => 'Screaming';

  @override
  String get faceFlushed => 'Flushed';

  @override
  String get faceOverwhelmed => 'Overwhelmed';

  @override
  String get faceWoozy => 'Woozy';

  @override
  String get faceUnwell => 'Unwell';

  @override
  String get faceHurting => 'Hurting';

  @override
  String get faceQueasy => 'Queasy';

  @override
  String get faceTooHot => 'Too hot';

  @override
  String get faceTooCold => 'Too cold';

  @override
  String get faceSparklingHeart => 'Sparkling heart';

  @override
  String get faceBrokenHeart => 'Broken heart';

  @override
  String get faceFire => 'Fire';

  @override
  String get faceRainbow => 'Rainbow';

  @override
  String get faceSun => 'Sun';

  @override
  String get faceRain => 'Rain';

  @override
  String get faceStorm => 'Storm';

  @override
  String get faceBlossom => 'Blossom';

  @override
  String get faceChocolate => 'Chocolate';

  @override
  String get faceInBed => 'In bed';

  @override
  String get homeCalendar => 'Calendar';

  @override
  String get homeHistory => 'History';

  @override
  String get homeCharts => 'Charts';

  @override
  String get homeSettings => 'Settings';

  @override
  String homeCalendarOf(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Your calendar',
      'other': '$name’s calendar',
    });
    return '$_temp0';
  }

  @override
  String homeHistoryOf(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Your history',
      'other': '$name’s history',
    });
    return '$_temp0';
  }

  @override
  String homeChartsOf(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Your charts',
      'other': '$name’s charts',
    });
    return '$_temp0';
  }

  @override
  String get homeWhenStarted => 'When did it start?';

  @override
  String get homeWhenEnded => 'When did it end?';

  @override
  String homePeriodEndedToday(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'My period ended today',
      'other': '$name’s period ended today',
    });
    return '$_temp0';
  }

  @override
  String homePeriodStartedToday(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'My period started today',
      'other': '$name’s period started today',
    });
    return '$_temp0';
  }

  @override
  String get homeEndedEarlier => 'It ended on an earlier day';

  @override
  String get homeStartedEarlier => 'It started on an earlier day';

  @override
  String homeAddLastEnd(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Add when your last period ended',
      'other': 'Add when $name’s last period ended',
    });
    return '$_temp0';
  }

  @override
  String homeSharedCopy(String who, String name, String date) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you':
          'Imported from your phone on $date. It can’t be changed here, and is brought up to date when you send it again.',
      'other':
          'Imported from $name’s phone on $date. It can’t be changed here, and is brought up to date when $name sends it again.',
    });
    return '$_temp0';
  }

  @override
  String homeNoPeriodSince(String date) {
    return 'No period logged since $date';
  }

  @override
  String get homeMissedOne =>
      'Ebb has assumed a period went unlogged and estimated from there. If you remember when it started, add it to put the estimate right.';

  @override
  String get homeMissedSome =>
      'Ebb has assumed some periods went unlogged and estimated from there. If you remember when any started, add them to put the estimate right.';

  @override
  String get homeWelcome => 'Welcome to Ebb';

  @override
  String get homeNothingYet => 'Nothing logged yet';

  @override
  String homeFirstLog(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Log the first day of your next period, or add past periods if you remember them, and Ebb will start learning your rhythm. Everything stays on this phone.',
      'other':
          'Log the first day of $name’s next period, or add past periods if you remember them, and Ebb will start learning the rhythm. Everything stays on this phone.',
    });
    return '$_temp0';
  }

  @override
  String homeDayOfPeriod(String who, String name, int day) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Day $day of your period',
      'other': 'Day $day of $name’s period',
    });
    return '$_temp0';
  }

  @override
  String homeDayOfCycle(String who, String name, int day) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Day $day of your cycle',
      'other': 'Day $day of $name’s cycle',
    });
    return '$_temp0';
  }

  @override
  String get homeTellEnd =>
      'Let Ebb know when it ends so the estimate stays accurate.';

  @override
  String homeDaysUntil(String who, String name, int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'About $days days until your period is expected.',
    );
    String _temp1 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'About $days days until $name’s period is expected.',
    );
    String _temp2 = intl.Intl.selectLogic(who, {
      'you': '$_temp0',
      'other': '$_temp1',
    });
    return '$_temp2';
  }

  @override
  String homeExpectedTomorrow(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Your period is expected tomorrow.',
      'other': '$name’s period is expected tomorrow.',
    });
    return '$_temp0';
  }

  @override
  String homeExpectedToday(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Your period is expected today.',
      'other': '$name’s period is expected today.',
    });
    return '$_temp0';
  }

  @override
  String homeDaysLate(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other:
          '$days days later than expected. Cycles shift for all sorts of reasons.',
      one: '1 day later than expected. Cycles shift for all sorts of reasons.',
    );
    return '$_temp0';
  }

  @override
  String get homeRingDay => 'DAY';

  @override
  String homeRingOfCycle(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'of your cycle',
      'other': 'of $name’s cycle',
    });
    return '$_temp0';
  }

  @override
  String homeRingOfPeriod(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'of your period',
      'other': 'of $name’s period',
    });
    return '$_temp0';
  }

  @override
  String get homeKeyPeriod => 'Period';

  @override
  String get homeKeyLikelyNext => 'Likely next';

  @override
  String get homeKeyToday => 'Today';

  @override
  String get homeAddPastPeriods => 'Add past periods';

  @override
  String get homeAddMissedPeriod => 'Add a missed period';

  @override
  String get homeNextPeriod => 'Next period';

  @override
  String homeLikelyBetween(String from, String to) {
    return 'likely between $from and $to';
  }

  @override
  String get homeFertileWindow => 'Estimated fertile window';

  @override
  String get homeFertileWarning =>
      'An estimate based on cycle timing alone. Not reliable enough to use as contraception.';

  @override
  String homeConfidenceUnlogged(String date) {
    return 'Estimated from the last period logged, on $date, so it may be less accurate than usual.';
  }

  @override
  String get homeConfidenceNone => 'Nothing logged yet.';

  @override
  String get homeConfidenceTypical =>
      'Based on a typical 28-day cycle for now. This will get more accurate as you log.';

  @override
  String homeConfidenceFew(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Based on $count cycles so far, so it may be less accurate for now.',
      one: 'Based on 1 cycle so far, so it may be less accurate for now.',
    );
    return '$_temp0';
  }

  @override
  String homeConfidenceIrregular(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Your cycles vary quite a bit, so this is a wide estimate rather than a firm date.',
      'other':
          '$name’s cycles vary quite a bit, so this is a wide estimate rather than a firm date.',
    });
    return '$_temp0';
  }

  @override
  String homeConfidenceLast(String who, String name, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Based on your last $count cycles.',
    );
    String _temp1 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Based on $name’s last $count cycles.',
    );
    String _temp2 = intl.Intl.selectLogic(who, {
      'you': '$_temp0',
      'other': '$_temp1',
    });
    return '$_temp2';
  }

  @override
  String homeConfidenceGood(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Based on $count fairly consistent cycles.',
    );
    return '$_temp0';
  }

  @override
  String get homeMilestoneFirstPeriod => 'First period logged';

  @override
  String get homeMilestoneFirstCycle => 'First full cycle';

  @override
  String get homeMilestoneThreeCycles => 'Three full cycles';

  @override
  String get homeMilestoneSixCycles => 'Six full cycles';

  @override
  String get homeMilestoneOneYear => 'A year of history';

  @override
  String get homeMilestoneTwoYears => 'Two years of history';

  @override
  String get homeMilestoneFiveYears => 'Five years of history';

  @override
  String get homeMilestoneFirstBackup => 'First backup saved';

  @override
  String homeMilestoneFirstPeriodMessage(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Your first period in Ebb.',
      'other': '$name’s first period in Ebb.',
    });
    return '$_temp0';
  }

  @override
  String homeMilestoneFirstCycleMessage(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'A first full cycle. Ebb can start learning your rhythm.',
      'other': 'A first full cycle. Ebb can start learning $name’s rhythm.',
    });
    return '$_temp0';
  }

  @override
  String get homeMilestoneThreeCyclesMessage =>
      'Three full cycles logged. Each one gives Ebb more to go on.';

  @override
  String get homeMilestoneSixCyclesMessage =>
      'Six full cycles logged: as many as Ebb looks at for each estimate.';

  @override
  String homeMilestoneOneYearMessage(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'A year of your history in Ebb.',
      'other': 'A year of $name’s history in Ebb.',
    });
    return '$_temp0';
  }

  @override
  String homeMilestoneTwoYearsMessage(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Two years of your history in Ebb.',
      'other': 'Two years of $name’s history in Ebb.',
    });
    return '$_temp0';
  }

  @override
  String homeMilestoneFiveYearsMessage(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Five years of your history in Ebb.',
      'other': 'Five years of $name’s history in Ebb.',
    });
    return '$_temp0';
  }

  @override
  String get homeMilestoneFirstBackupMessage =>
      'Your first backup is saved. Keep a copy somewhere other than this phone.';

  @override
  String get homeProblemStartInFuture =>
      'The start date can\'t be in the future.';

  @override
  String get homeProblemEndInFuture => 'The end date can\'t be in the future.';

  @override
  String get homeProblemEndBeforeStart =>
      'The end date is before the start date.';

  @override
  String get homeProblemDuplicateStart =>
      'A period starting on that day is already recorded.';

  @override
  String get homeProblemOverlapsPrevious =>
      'This overlaps the period before it. Check the earlier entry’s end date.';

  @override
  String get homeProblemOverlapsNext =>
      'This overlaps the period after it. Check the end date.';

  @override
  String get homeDeleteCycleTitle => 'Delete this cycle?';

  @override
  String homeDeleteCycleBody(String date) {
    return 'The entry starting $date will be removed. This cannot be undone.';
  }

  @override
  String get homeFirstDayOfPeriod => 'First day of the period';

  @override
  String get homeLastDayOfPeriod => 'Last day of the period';

  @override
  String get homeAddPastPeriodTitle => 'Add a past period';

  @override
  String get homeEditPeriod => 'Edit period';

  @override
  String get homeStarted => 'Started';

  @override
  String get homeEnded => 'Ended';

  @override
  String get homeStillGoing => 'Still going';

  @override
  String get homeNotRecorded => 'Not recorded';

  @override
  String get homeClearEnd => 'Clear end date';

  @override
  String get homeCountInPredictions => 'Count this cycle in predictions';

  @override
  String get homeCountInPredictionsHint =>
      'Turn off for a cycle that doesn’t reflect the usual rhythm — illness, a medication change, a pregnancy loss. It stays in your history either way.';

  @override
  String get homeNote => 'Note';

  @override
  String get homeNoteExcludedHint =>
      'Why it isn’t counted, so it’s easy to remember later.';

  @override
  String get homeNoteHint => 'Anything worth remembering about this one.';

  @override
  String get homeDeletePeriod => 'Delete this period';

  @override
  String get homeAddPastPeriod => 'Add past period';

  @override
  String get homeHistoryEmpty =>
      'No cycles recorded yet. If you remember when recent periods started, adding them gives Ebb a head start.';

  @override
  String get homeMilestones => 'Milestones';

  @override
  String homePeriodLength(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count-day period',
      one: '1-day period',
    );
    return '$_temp0';
  }

  @override
  String get homePeriodInProgress => 'Period in progress';

  @override
  String get homeEndNotRecorded => 'End not recorded';

  @override
  String get homeLongGap =>
      'A long gap. If a period here wasn’t logged, add it with “Add past period”.';

  @override
  String get homeNothingSince =>
      'Nothing logged since. If a period was missed, add it with “Add past period”.';

  @override
  String homeNotCounted(String detail) {
    return '$detail · not counted';
  }

  @override
  String get homeDayCycle => 'day cycle';

  @override
  String get homeLastLogged => 'Last logged';

  @override
  String get homeCurrent => 'Current';

  @override
  String get homeSpanMonths3 => 'Last 3 months';

  @override
  String get homeSpanMonths6 => 'Last 6 months';

  @override
  String get homeSpanYear => 'Last year';

  @override
  String get homeSpanAll => 'Everything';

  @override
  String get homeSpanCustom => 'Choose dates…';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsNotificationsOff =>
      'Notifications are turned off for Ebb in system settings.';

  @override
  String settingsNoBrowser(String website) {
    return 'No browser to open it with. Visit $website instead.';
  }

  @override
  String get settingsNothingToBackUp => 'Nothing to back up yet.';

  @override
  String get settingsBackupSaved =>
      'Backup saved. Keep a copy somewhere other than this phone.';

  @override
  String get settingsBackupNotSaved =>
      'The backup couldn\'t be saved there. Try another location.';

  @override
  String get settingsNoPicker =>
      'This phone has no file picker for Ebb to use. Sending to another phone works without one.';

  @override
  String get settingsFileTooLarge =>
      'That file is too large to be an Ebb backup.';

  @override
  String get settingsFileUnreadable => 'That file couldn\'t be read.';

  @override
  String get settingsNotABackup => 'This file isn\'t an Ebb backup.';

  @override
  String settingsPeriodCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count periods',
      one: '$count period',
    );
    return '$_temp0';
  }

  @override
  String get settingsSetUpTitle => 'Set up with this history?';

  @override
  String settingsSetUpBody(String periods, String date) {
    return '$periods, sent $date. On this phone it becomes your history.';
  }

  @override
  String settingsUpdateTitle(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Update your history?',
      'other': 'Update $name?',
    });
    return '$_temp0';
  }

  @override
  String settingsUpdateAction(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Update your history',
      'other': 'Update $name',
    });
    return '$_temp0';
  }

  @override
  String settingsUpdateSharedBody(
    String who,
    String name,
    String date,
    String periods,
  ) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you':
          'This is your history again, sent $date: $periods. It replaces the copy on this phone.',
      'other':
          'This is $name’s history again, sent $date: $periods. It replaces the copy on this phone.',
    });
    return '$_temp0';
  }

  @override
  String settingsUpdateBody(
    String who,
    String name,
    String date,
    String periods,
  ) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you':
          'This is your history, sent $date: $periods. It replaces what’s on this phone for you, including anything logged here since.',
      'other':
          'This is $name’s history, sent $date: $periods. It replaces what’s on this phone for $name, including anything logged here since.',
    });
    return '$_temp0';
  }

  @override
  String get settingsReplaceEverything => 'Replace everything';

  @override
  String settingsPersonUpdated(String name) {
    return '$name updated.';
  }

  @override
  String get settingsAddThisHistoryTitle => 'Add this history?';

  @override
  String settingsAddNamedTitle(String name) {
    return 'Add $name?';
  }

  @override
  String settingsAddBody(String periods) {
    return 'It has $periods. You can add it alongside what’s already here, or replace everything on this phone with it.';
  }

  @override
  String settingsAddNamedBody(String name, String periods) {
    return '$name’s history has $periods. You can add it alongside what’s already here, or replace everything on this phone with it.';
  }

  @override
  String get settingsAddAsNew => 'Add as someone new';

  @override
  String get settingsWhoIsThis => 'Who is this?';

  @override
  String get settingsWhoIsThisHint =>
      'A name to tell them apart on this phone.';

  @override
  String settingsPersonAdded(String name) {
    return '$name added.';
  }

  @override
  String get settingsRestored => 'Done. Ebb has been updated.';

  @override
  String get settingsReplaceTitle => 'Replace what’s in Ebb?';

  @override
  String settingsReplaceSaved(String date, String periods) {
    return 'Saved $date, with $periods.';
  }

  @override
  String settingsReplaceSavedPeople(int people, String date, String periods) {
    String _temp0 = intl.Intl.pluralLogic(
      people,
      locale: localeName,
      other: 'Saved $date, with $periods for $people people.',
    );
    return '$_temp0';
  }

  @override
  String settingsReplaceCurrent(String periods) {
    return 'It replaces everything in Ebb now, including $periods on this phone.';
  }

  @override
  String get settingsReplace => 'Replace';

  @override
  String get settingsDeleteAllTitle => 'Delete all data?';

  @override
  String get settingsDeleteAllBody =>
      'Every cycle and note will be permanently erased. Ebb keeps no other copy, so this cannot be undone unless you have saved a backup file.';

  @override
  String get settingsDeleteAllBodyEveryone =>
      'Every cycle and note, for everyone on this phone, will be permanently erased. Ebb keeps no other copy, so this cannot be undone unless you have saved a backup file.';

  @override
  String get settingsDeleteEverything => 'Delete everything';

  @override
  String get settingsAllDeleted => 'All data deleted.';

  @override
  String get settingsYourName => 'Your name';

  @override
  String get settingsRename => 'Rename';

  @override
  String get settingsYourNameHint =>
      'Shown in the list of people. Leave empty to appear as “You”.';

  @override
  String settingsRemoveTitle(String name) {
    return 'Remove $name from this phone?';
  }

  @override
  String settingsRemoveBody(String name) {
    return 'Every cycle and note for $name will be permanently erased. Nobody else’s history is affected.';
  }

  @override
  String settingsPersonRemoved(String name) {
    return '$name removed.';
  }

  @override
  String settingsRemovePerson(String name) {
    return 'Remove $name from this phone';
  }

  @override
  String get settingsYourCycle => 'Your cycle';

  @override
  String get settingsYourSettings => 'Your settings';

  @override
  String settingsSettingsFor(String name) {
    return 'Settings for $name';
  }

  @override
  String get settingsName => 'Name';

  @override
  String get settingsReminders => 'Reminders';

  @override
  String settingsRemindersHint(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'A heads-up before your period is expected.',
      'other': 'A heads-up before $name’s period is expected.',
    });
    return '$_temp0';
  }

  @override
  String get settingsRemindMe => 'Remind me';

  @override
  String settingsDaysAhead(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days ahead',
      one: '$count day ahead',
    );
    return '$_temp0';
  }

  @override
  String settingsDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days',
      one: '$count day',
    );
    return '$_temp0';
  }

  @override
  String get settingsFertile => 'Show fertile window estimate';

  @override
  String get settingsFertileHint =>
      'Off by default. An estimate from cycle timing only — not reliable enough to use as contraception.';

  @override
  String get settingsMoon => 'Show moon phases';

  @override
  String get settingsMoonHint =>
      'New, first quarter, full and last quarter, on the calendar and charts.';

  @override
  String get settingsTemperature => 'Track temperature and cervical mucus';

  @override
  String get settingsTemperatureHint =>
      'On each day of the calendar, with a temperature chart. Recorded and drawn, never used to estimate anything.';

  @override
  String get settingsTemperatureIn => 'Temperature in';

  @override
  String get settingsCelebrate => 'Celebrate milestones';

  @override
  String settingsCelebrateHint(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'A small celebration for things like a first full cycle or a year of history, listed in your History.',
      'other':
          'A small celebration for things like a first full cycle or a year of history, listed in $name’s History.',
    });
    return '$_temp0';
  }

  @override
  String get settingsPeople => 'People';

  @override
  String get settingsAddSomeone => 'Add someone';

  @override
  String get settingsTrackSomeoneElse => 'Track someone else too';

  @override
  String get settingsTrackSomeoneElseHint =>
      'For example, a child who’s just starting.';

  @override
  String get settingsBackupSection => 'Backup & moving';

  @override
  String get settingsBackUp => 'Back up to a file';

  @override
  String get settingsBackUpHint =>
      'Save your history to a file, wherever you choose.';

  @override
  String get settingsBackUpHintEveryone =>
      'Save everyone’s history to a file, wherever you choose.';

  @override
  String get settingsRestore => 'Restore from a backup';

  @override
  String get settingsRestoreHint => 'Replaces what is in Ebb now.';

  @override
  String get settingsSend => 'Send to another phone';

  @override
  String get settingsSendHint =>
      'Show your history as codes for another phone to scan.';

  @override
  String get settingsSendHintEveryone =>
      'Show everyone’s history as codes for another phone to scan.';

  @override
  String get settingsReceive => 'Receive from another phone';

  @override
  String get settingsReceiveHint =>
      'Scan the codes to add someone, update them, or replace everything.';

  @override
  String get settingsAdvanced => 'Advanced';

  @override
  String get settingsGroups => 'Groups';

  @override
  String get settingsGroupsHint =>
      'For circles and clubs that track together: gather people under a name. Turning this off hides groups without deleting them.';

  @override
  String get settingsManageGroups => 'Manage groups';

  @override
  String get settingsAboutEbb => 'About Ebb';

  @override
  String get settingsHowEbbWorks => 'How Ebb works';

  @override
  String get settingsHowEbbWorksHint => 'Logging, estimates, backups and more.';

  @override
  String get settingsYourData => 'Your data';

  @override
  String get settingsYourDataHint => 'Where it lives and who can see it.';

  @override
  String get settingsWebsite => 'Website';

  @override
  String get settingsSendFeedback => 'Send feedback';

  @override
  String get settingsSendFeedbackHint =>
      'A form on the website, in your browser.';

  @override
  String get settingsDeleteAll => 'Delete all data';

  @override
  String settingsVersion(String version) {
    return 'Ebb $version\nMade by SuperDaveLab';
  }

  @override
  String get settingsDataHeadline => 'Your cycle is your business.';

  @override
  String get settingsDataLede =>
      'Ebb is built so that the question \"what do they do with my data?\" has a boring answer: nothing, because we never receive it.';

  @override
  String get settingsDataTradeOff =>
      'One trade-off worth knowing: because there is no cloud backup, a lost or wiped phone means lost history. If that matters to you, save a backup file from Settings now and then, and keep it somewhere other than this phone.';

  @override
  String get settingsWhereDataLives => 'Where your data lives';

  @override
  String get settingsWhereDataLivesHint => 'Your data, and who can see it.';

  @override
  String get settingsDataStaysTitle => 'It stays on your phone';

  @override
  String get settingsDataStaysBody =>
      'Everything you log is written to a database on this device. There is no account to create and no server to sync with. It only goes anywhere else if you move it yourself — a backup file, or another phone you send it to.';

  @override
  String get settingsDataUnseenTitle => 'We cannot see it';

  @override
  String get settingsDataUnseenBody =>
      'Ebb is built without permission to use the internet at all. Android enforces that, and you can verify it yourself in the app\'s permission list.';

  @override
  String get settingsDataPermissionsTitle => 'What the permissions are for';

  @override
  String get settingsDataPermissionsBody =>
      'Notifications, for reminders. Camera, only while you receive history from another phone — it reads the codes and nothing is recorded or kept. Ebb also re-arms your reminders when the phone restarts. That is the whole list.';

  @override
  String get settingsDataNotForSaleTitle => 'There is nothing to sell';

  @override
  String get settingsDataNotForSaleBody =>
      'No analytics, no advertising, no third-party libraries phoning home. Since your data never reaches us, there is no copy of it for anyone to buy, subpoena, or leak.';

  @override
  String get settingsDataEraseTitle => 'You can erase it instantly';

  @override
  String get settingsDataEraseBody =>
      'Deleting your data in Settings, or uninstalling Ebb, removes everything Ebb holds. Ebb keeps no other copy — the only ones are backup files you saved or phones you sent it to yourself.';

  @override
  String get settingsDataOpenSourceTitle => 'You can check our work';

  @override
  String get settingsDataOpenSourceBody =>
      'Ebb is open source under the GNU General Public License. Anyone can read exactly what it does, and the published builds are made from that same code.';

  @override
  String get settingsHelpLoggingTitle => 'Logging a period';

  @override
  String get settingsHelpLoggingBody =>
      'Tap “My period started today” on the first day of bleeding, and “My period ended today” on the last.\n\nForgot to log it? Use “It started on an earlier day” instead. Any past period can be added or corrected in History (the clock icon): tap one to change its dates or add a note.\n\nIf no end is logged within two weeks, Ebb stops treating the period as still going and offers to add the end instead.';

  @override
  String get settingsHelpEstimateTitle => 'How the estimate works';

  @override
  String get settingsHelpEstimateBody =>
      'Ebb looks at the gaps between the starts of your recent periods — up to the last six.\n\nWith only a little history it leans on a typical 28-day cycle, and says so. The more you log, the more the estimate is your own rhythm.\n\nIt shows a range rather than a single date, and tells you how sure it is. If your cycles vary a lot, the range is wider.\n\nIf a period is late, Ebb says how late. If nothing is logged for nearly two cycles, it assumes a period went unlogged, estimates from there, and says so. History points out long gaps, and adding a missed period puts the estimate right.';

  @override
  String get settingsHelpExcludeTitle => 'A cycle that shouldn’t count';

  @override
  String get settingsHelpExcludeBody =>
      'Illness, a medication change or a pregnancy loss can throw one cycle right off, and it would pull the estimate with it.\n\nIn History, tap that period and turn off “Count this cycle in predictions”. It stays in your history; the estimate just ignores it. Add a note there too, so you remember why.';

  @override
  String get settingsHelpGroupsTitle => 'Groups';

  @override
  String get settingsHelpGroupsBody =>
      'For circles and clubs that track together. Turn them on in Settings → Advanced, then make a group and choose who’s in it. “See … together” in the list of people shows everyone side by side, with the moon.\n\nA group can have two kinds of member. Someone added to it is tracked on this phone, and you log for them here. Someone imported keeps tracking on their own phone and provides their history to the group: it stays theirs, and can’t be changed on anyone else’s phone.\n\nTo be imported, send just your history (Settings → Send to another phone) — as much or as little as you like, with or without your daily notes. The other phone imports it from the group: Manage groups → the group → Import from their phone. Importing you again brings it up to date.\n\nImported history belongs to its group. Taking someone imported out of their last group, or deleting that group, takes their history off the phone too. And it can’t be sent on: only your own history can.';

  @override
  String get settingsHelpRatingsTitle => 'Day ratings, feelings and charts';

  @override
  String get settingsHelpRatingsBody =>
      'Tap any day on the calendar to rate it from 1 to 5, and to pick a face for how you felt. Both are optional; tap a choice again to clear it.\n\nCharts (the chart icon) shows each day’s rating over the dates you choose, with periods shaded, and which feelings came during and before periods. With moon phases turned on in Settings, the moon is there too.\n\nThe charts show what you logged. They don’t say what it means — that’s yours to judge.';

  @override
  String get settingsHelpTemperatureTitle => 'Temperature and cervical mucus';

  @override
  String get settingsHelpTemperatureBody =>
      'Turn on “Track temperature and cervical mucus” in Settings, and each day on the calendar has room for your waking temperature and how cervical mucus felt and looked. If something may have thrown a reading off — illness, little sleep, alcohol, taking it late — tick the box under it.\n\nCharts shows the temperatures as a line, with mucus underneath and periods shaded, in °C or °F (Settings).\n\nEbb records and draws these, and that’s all. It doesn’t look for a rise or work out fertile days from them, and its fertile-window estimate still comes from cycle timing alone. If you follow a method such as the sympto-thermal method, the chart is there for you to read by its rules.';

  @override
  String get settingsHelpRemindersTitle => 'Reminders';

  @override
  String get settingsHelpRemindersBody =>
      'A heads-up a few days before your period is expected, and another on the day. Choose how far ahead in Settings.\n\nThey’re scheduled on the phone itself, so they arrive with no signal and in airplane mode.\n\nEbb sets them each time you open it, from the latest estimate. The phone keeps them through restarts, but Ebb can’t update them while it’s closed, so open it now and then — logging a period is enough.\n\nAndroid may deliver them a little after the usual time to save battery. If Ebb is force-stopped, or a battery saver restricts it, they may not arrive until you next open Ebb.';

  @override
  String get settingsHelpFertileTitle => 'The fertile window';

  @override
  String get settingsHelpFertileBody =>
      'Off unless you turn it on in Settings. It’s estimated from cycle timing alone, which is not reliable enough to use as contraception.';

  @override
  String get settingsHelpBackupTitle => 'Backing up';

  @override
  String get settingsHelpBackupBody =>
      'There’s no cloud copy of your history, so a lost or wiped phone means lost history.\n\nSettings → “Back up to a file” saves everything as a file, wherever you choose. Keep it somewhere other than this phone. “Restore from a backup” brings it back.';

  @override
  String get settingsHelpMovingTitle => 'Moving to a new phone';

  @override
  String get settingsHelpMovingBody =>
      'On the old phone: Settings → “Send to another phone”. On the new one: Settings → “Receive from another phone”, and point the camera at the screen.\n\nLonger histories take a few codes, which change on their own; the new phone collects them in any order. No internet is involved — one phone shows, the other looks.';

  @override
  String get settingsHelpSomeoneElseTitle => 'Tracking someone else';

  @override
  String get settingsHelpSomeoneElseBody =>
      'Helping someone else keep track — a child who’s just starting, say? Settings → “Track someone else too”, and give them a name. A nickname or initial is fine.\n\nTap the name at the top of the home screen to switch between people. Everyone has their own reminders, which start off for people you add. The fertile window is only ever offered for you.';

  @override
  String get settingsHelpHandoverTitle => 'Handing someone over';

  @override
  String get settingsHelpHandoverBody =>
      'When someone you track gets their own phone: “Send to another phone”, and choose just them. On their phone, “Receive from another phone”. On a fresh install their history simply becomes theirs.\n\nAfterwards Ebb asks whether to remove them from your phone. It never does that on its own.';

  @override
  String get settingsHelpDeletingTitle => 'Deleting';

  @override
  String get settingsHelpDeletingBody =>
      'Settings → “Delete all data” erases everything on this phone at once.\n\nTo remove one person you’ve added, open their settings and choose “Remove … from this phone”. Nobody else’s history is touched.';

  @override
  String shareRemoveTitle(String name) {
    return 'Remove $name from this phone?';
  }

  @override
  String shareRemoveBody(String name) {
    return 'If $name’s history arrived on the other phone, it can come off this one. You can also keep it here as well.';
  }

  @override
  String get shareKeep => 'Keep';

  @override
  String shareRemoved(String name) {
    return '$name removed.';
  }

  @override
  String get shareTitle => 'Send to another phone';

  @override
  String get shareWhatToSend => 'What would you like to send?';

  @override
  String get shareEveryone => 'Everyone';

  @override
  String get shareEveryoneHint => 'Moving to a new phone.';

  @override
  String get shareJustOne => 'Just one person';

  @override
  String get shareJustYours => 'Just your history';

  @override
  String shareJustName(String name) {
    return 'Just $name';
  }

  @override
  String shareForTheirPhone(String name) {
    return 'For $name’s own phone.';
  }

  @override
  String get shareCopiesNotOffered =>
      'People imported from other phones aren’t offered here: each person shares only their own history.';

  @override
  String shareHowMuch(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'How much of your history?',
      'other': 'How much of $name’s history?',
    });
    return '$_temp0';
  }

  @override
  String get shareHowMuchHint =>
      'Sending everything suits a new phone. Sharing with a group, you might send less. Nothing is removed from this phone.';

  @override
  String get shareHowFarBack => 'How far back';

  @override
  String get shareSpanEverything => 'Everything';

  @override
  String get shareSpanYear => 'The last year';

  @override
  String shareSpanMonths(int months) {
    String _temp0 = intl.Intl.pluralLogic(
      months,
      locale: localeName,
      other: 'The last $months months',
      one: 'The last $months month',
    );
    return '$_temp0';
  }

  @override
  String get shareSpanLatest => 'Just the latest period';

  @override
  String get shareWhatToInclude => 'What to include';

  @override
  String get shareWithDays => 'Periods and daily entries';

  @override
  String get shareWithDaysHint => 'Notes, ratings, feelings and flow too.';

  @override
  String get sharePeriodsOnly => 'Periods only';

  @override
  String get sharePeriodsOnlyHint => 'Just when each period started and ended.';

  @override
  String get shareShowCodes => 'Show the codes';

  @override
  String get shareNothing => 'Nothing to send yet.';

  @override
  String get shareHowToReceive =>
      'On the other phone, open Ebb, go to Settings → Receive from another phone, and point the camera at this screen.';

  @override
  String shareCodeOf(int index, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      total,
      locale: localeName,
      other: 'Code $index of $total',
    );
    return '$_temp0';
  }

  @override
  String get sharePreviousCode => 'Previous code';

  @override
  String get sharePause => 'Pause';

  @override
  String get sharePlay => 'Play';

  @override
  String get shareNextCode => 'Next code';

  @override
  String get shareCodesChange =>
      'The codes change on their own. The other phone collects them in any order.';

  @override
  String sharePeriodCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count periods',
      one: '$count period',
    );
    return '$_temp0';
  }

  @override
  String shareSummaryEverything(String periods) {
    return 'Everything in Ebb: $periods.';
  }

  @override
  String shareSummaryEverythingPeople(String periods, int people) {
    String _temp0 = intl.Intl.pluralLogic(
      people,
      locale: localeName,
      other: 'Everything in Ebb: $periods for $people people.',
    );
    return '$_temp0';
  }

  @override
  String shareSummaryHistoryAll(String who, String name, String periods) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Your history: $periods.',
      'other': '$name’s history: $periods.',
    });
    return '$_temp0';
  }

  @override
  String shareSummaryHistoryLatest(String who, String name, String periods) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Your history, latest period only: $periods.',
      'other': '$name’s history, latest period only: $periods.',
    });
    return '$_temp0';
  }

  @override
  String shareSummaryHistoryYear(String who, String name, String periods) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Your history from the last year: $periods.',
      'other': '$name’s history from the last year: $periods.',
    });
    return '$_temp0';
  }

  @override
  String shareSummaryHistoryMonths(
    String who,
    String name,
    String periods,
    int months,
  ) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Your history from the last $months months: $periods.',
      'other': '$name’s history from the last $months months: $periods.',
    });
    return '$_temp0';
  }

  @override
  String shareSummaryPeriodsAll(String who, String name, String periods) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Your periods: $periods.',
      'other': '$name’s periods: $periods.',
    });
    return '$_temp0';
  }

  @override
  String shareSummaryPeriodsLatest(String who, String name, String periods) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Your periods, latest period only: $periods.',
      'other': '$name’s periods, latest period only: $periods.',
    });
    return '$_temp0';
  }

  @override
  String shareSummaryPeriodsYear(String who, String name, String periods) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Your periods from the last year: $periods.',
      'other': '$name’s periods from the last year: $periods.',
    });
    return '$_temp0';
  }

  @override
  String shareSummaryPeriodsMonths(
    String who,
    String name,
    String periods,
    int months,
  ) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Your periods from the last $months months: $periods.',
      'other': '$name’s periods from the last $months months: $periods.',
    });
    return '$_temp0';
  }

  @override
  String get shareNotEbb => 'That code isn\'t from Ebb.';

  @override
  String get shareNewerVersion =>
      'The other phone has a newer version of Ebb. Update this one first.';

  @override
  String get shareRestarted =>
      'The other phone started over. Collecting the new codes.';

  @override
  String get shareUnreadable =>
      'Some codes didn\'t read cleanly. Let\'s scan them again.';

  @override
  String get shareNeedsCamera =>
      'Ebb needs the camera to read the codes. You can allow it in the system settings for Ebb.';

  @override
  String get sharePointCamera =>
      'Point the camera at the code on the other phone.';

  @override
  String get shareReading => 'Reading…';

  @override
  String shareCodesReceived(int received, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      total,
      locale: localeName,
      other: '$received of $total codes received',
    );
    return '$_temp0';
  }

  @override
  String get shareReceiveTitle => 'Receive from another phone';

  @override
  String shareStillNeeded(String codes) {
    return 'Still needed: $codes';
  }

  @override
  String get groupsMoreThanOne => 'That’s more than one person';

  @override
  String get groupsMoreThanOneBody =>
      'These codes hold a whole phone’s history. To join a group, each person sends just their own: on their phone, Settings → Send to another phone → Just your history.';

  @override
  String groupsUpdateTitle(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Update your history?',
      'other': 'Update $name?',
    });
    return '$_temp0';
  }

  @override
  String groupsUpdateAction(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Update your history',
      'other': 'Update $name',
    });
    return '$_temp0';
  }

  @override
  String groupsUpdateCopyBody(
    String who,
    String name,
    String sent,
    String periods,
  ) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you':
          'This is your history again, sent $sent: $periods. It replaces the copy on this phone.',
      'other':
          'This is $name’s history again, sent $sent: $periods. It replaces the copy on this phone.',
    });
    return '$_temp0';
  }

  @override
  String groupsUpdateBody(
    String who,
    String name,
    String sent,
    String periods,
  ) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you':
          'This is your history, sent $sent: $periods. It replaces what’s on this phone for you, including anything logged here since.',
      'other':
          'This is $name’s history, sent $sent: $periods. It replaces what’s on this phone for $name, including anything logged here since.',
    });
    return '$_temp0';
  }

  @override
  String groupsUpdated(String name) {
    return '$name updated.';
  }

  @override
  String groupsImportInto(String group) {
    return 'Import into $group';
  }

  @override
  String groupsImportHint(String periods, String sent) {
    return '$periods, sent $sent. Imported read-only: it can’t be changed here, and is brought up to date when it’s sent again.';
  }

  @override
  String groupsImported(String name, String group) {
    return '$name imported into $group.';
  }

  @override
  String get groupsGroup => 'Group';

  @override
  String get groupsNoMembers =>
      'No one is in this group yet. Add them in Settings → Advanced → Manage groups: tick people already on this phone, or add someone from their phone.';

  @override
  String get groupsPeriods => 'Periods';

  @override
  String get groupsChartHint =>
      'Each bar is a period; an outline is one whose end wasn’t logged, drawn at the usual length. Solid lines run down from each full moon, dashed ones from each new moon.';

  @override
  String get groupsNew => 'New group';

  @override
  String get groupsRename => 'Rename group';

  @override
  String get groupsNameHint => 'For example, the name of your circle or club.';

  @override
  String get groupsNameTaken => 'There’s already a group with that name.';

  @override
  String get groupsNoOneYet => 'No one yet';

  @override
  String get groupsTitle => 'Groups';

  @override
  String get groupsIntro =>
      'A group gathers people on this phone under one name — a circle or club that tracks together. Someone can be in more than one, and deleting a group never deletes anyone.';

  @override
  String groupsAddSomeoneTo(String group) {
    return 'Add someone to $group';
  }

  @override
  String get groupsAddSomeoneHint =>
      'Tracked on this phone: you log and change their history here. Someone who tracks on their own phone can be imported instead.';

  @override
  String groupsTakeOutTitle(String name, String group) {
    return 'Take $name out of $group?';
  }

  @override
  String groupsTakeOutBody(String name) {
    return '$name was imported from their phone and isn’t in any other group, so the imported history comes off this phone too. $name can send it again to rejoin.';
  }

  @override
  String get groupsTakeOut => 'Take out';

  @override
  String groupsDeleteTitle(String group) {
    return 'Delete $group?';
  }

  @override
  String get groupsDeleteBodyNone =>
      'Only the group goes. Everyone in it stays on this phone, with all their history.';

  @override
  String groupsDeleteBodySome(String names) {
    return 'The people imported only into this group come off this phone too: $names. Everyone else stays, with all their history.';
  }

  @override
  String get groupsDeleteGroup => 'Delete group';

  @override
  String get groupsRenameTooltip => 'Rename';

  @override
  String get groupsWhoIsIn => 'Who’s in it';

  @override
  String groupsImportedAsOf(String date) {
    return 'Imported · read-only, as of $date';
  }

  @override
  String get groupsTrackedHere => 'Tracked on this phone';

  @override
  String get groupsAddTo => 'Add to the group';

  @override
  String get groupsAddNew => 'Add someone new';

  @override
  String get groupsAddNewHint =>
      'Tracked on this phone: you log their periods here.';

  @override
  String get groupsImportFromPhone => 'Import from their phone';

  @override
  String get groupsImportFromPhoneHint =>
      'They keep tracking on their own phone and send it here, read-only. Importing them again brings them up to date.';

  @override
  String get groupsDeleteThis => 'Delete this group';

  @override
  String get peopleNameTaken => 'That name is already used on this phone.';

  @override
  String get peopleName => 'Name';

  @override
  String peopleSeeTogether(String group) {
    return 'See $group together';
  }

  @override
  String get peopleNotInGroup => 'Not in a group';

  @override
  String get peopleAddSomeone => 'Add someone';

  @override
  String get peopleTrackSomeoneElse => 'Track someone else';

  @override
  String get peopleNameHint =>
      'Just something to tell people apart — a first name, a nickname or an initial.';

  @override
  String backupUnnamedPerson(int number) {
    return 'Person $number';
  }

  @override
  String get backupNotEbb => 'This file isn\'t an Ebb backup.';

  @override
  String get backupNewer =>
      'This backup was made by a newer version of Ebb. Update Ebb, then try again.';

  @override
  String get backupNoOne => 'This backup has no one in it.';

  @override
  String get backupSameId =>
      'This backup looks damaged: two people in it have the same id.';

  @override
  String backupAfterExport(String date) {
    return '$date is after the day this backup was made.';
  }

  @override
  String backupSameName(String name) {
    return 'Two people in this backup are both called $name.';
  }

  @override
  String backupSameGroupName(String group) {
    return 'Two groups in this backup are both called $group.';
  }

  @override
  String backupEndsBefore(String date) {
    return 'The period starting $date ends before it begins.';
  }

  @override
  String backupTwoStarts(String date) {
    return 'Two periods start on $date for the same person.';
  }

  @override
  String backupDayTwice(String date) {
    return '$date appears twice for the same person.';
  }

  @override
  String backupOverlaps(String date) {
    return 'The period starting $date overlaps the one before it.';
  }

  @override
  String get backupDamaged =>
      'This backup looks damaged: the backup could not be read.';

  @override
  String get backupDamagedExportDate =>
      'This backup looks damaged: the export date could not be read.';

  @override
  String get backupDamagedGroup =>
      'This backup looks damaged: a group could not be read.';

  @override
  String get backupDamagedGroupName =>
      'This backup looks damaged: a group’s name could not be read.';

  @override
  String backupDamagedGroupPeople(String group) {
    return 'This backup looks damaged: the people in the group $group could not be read.';
  }

  @override
  String get backupDamagedPerson =>
      'This backup looks damaged: a person entry could not be read.';

  @override
  String get backupDamagedName =>
      'This backup looks damaged: a name could not be read.';

  @override
  String get backupDamagedPersonId =>
      'This backup looks damaged: a person’s id could not be read.';

  @override
  String get backupDamagedSharedOn =>
      'This backup looks damaged: the day a history was shared could not be read.';

  @override
  String get backupDamagedPeriod =>
      'This backup looks damaged: a period entry could not be read.';

  @override
  String get backupDamagedPeriodStart =>
      'This backup looks damaged: a period start could not be read.';

  @override
  String get backupDamagedPeriodEnd =>
      'This backup looks damaged: a period end could not be read.';

  @override
  String get backupDamagedDay =>
      'This backup looks damaged: a day entry could not be read.';

  @override
  String backupDamagedFlow(String date) {
    return 'This backup looks damaged: the flow on $date could not be read.';
  }

  @override
  String backupDamagedSymptom(String date) {
    return 'This backup looks damaged: a symptom on $date could not be read.';
  }

  @override
  String backupDamagedRating(String date) {
    return 'This backup looks damaged: the rating on $date could not be read.';
  }

  @override
  String backupDamagedFeeling(String date) {
    return 'This backup looks damaged: the feeling on $date could not be read.';
  }

  @override
  String backupDamagedTemperature(String date) {
    return 'This backup looks damaged: the temperature on $date could not be read.';
  }

  @override
  String backupDamagedMucus(String date) {
    return 'This backup looks damaged: the cervical mucus on $date could not be read.';
  }
}
