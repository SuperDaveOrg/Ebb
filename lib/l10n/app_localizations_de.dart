// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get you => 'Du';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get save => 'Speichern';

  @override
  String get delete => 'Löschen';

  @override
  String get remove => 'Entfernen';

  @override
  String get close => 'Schließen';

  @override
  String get done => 'Fertig';

  @override
  String get back => 'Zurück';

  @override
  String get next => 'Weiter';

  @override
  String get edit => 'Bearbeiten';

  @override
  String get add => 'Hinzufügen';

  @override
  String get continueAction => 'Weiter';

  @override
  String get language => 'Sprache';

  @override
  String get languagePhone => 'Wie auf dem Telefon';

  @override
  String languagePhoneIs(String language) {
    return 'Wie auf dem Telefon ($language)';
  }

  @override
  String get notifChannelName => 'Zyklus-Erinnerungen';

  @override
  String get notifChannelDescription =>
      'Eine Vorwarnung, bevor deine Periode erwartet wird, und ein Anstoß, sie einzutragen.';

  @override
  String notifUpcomingTitle(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Periode bald erwartet',
      'other': 'Periode von $name bald erwartet',
    });
    return '$_temp0';
  }

  @override
  String notifUpcomingTomorrow(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Ebb erwartet, dass deine Periode morgen beginnt.',
      'other': 'Ebb erwartet, dass die Periode von $name morgen beginnt.',
    });
    return '$_temp0';
  }

  @override
  String notifUpcomingInDays(String who, String name, int days) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Ebb erwartet deine Periode in etwa $days Tagen.',
      'other': 'Ebb erwartet die Periode von $name in etwa $days Tagen.',
    });
    return '$_temp0';
  }

  @override
  String notifTodayTitle(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Periode heute erwartet',
      'other': 'Periode von $name heute erwartet',
    });
    return '$_temp0';
  }

  @override
  String get notifTodayBody => 'Tippe, um einzutragen, wie es läuft.';

  @override
  String get calendarTitle => 'Kalender';

  @override
  String get calendarCellToday => 'heute';

  @override
  String get calendarCellPeriod => 'Periode';

  @override
  String get calendarCellPeriodUnlogged => 'Periode, Ende nicht eingetragen';

  @override
  String get calendarCellLikely => 'nächste Periode wahrscheinlich';

  @override
  String get calendarCellFertile => 'geschätztes fruchtbares Fenster';

  @override
  String calendarCellMoon(String phase) {
    String _temp0 = intl.Intl.selectLogic(phase, {
      'newMoon': 'Neumond',
      'firstQuarter': 'erstes Viertel',
      'full': 'Vollmond',
      'other': 'letztes Viertel',
    });
    return '$_temp0';
  }

  @override
  String calendarCellRated(int rating) {
    return 'bewertet mit $rating';
  }

  @override
  String calendarCellFelt(String feeling) {
    return 'Gefühl: $feeling';
  }

  @override
  String get calendarCellNote => 'hat eine Notiz';

  @override
  String get calendarKeyPeriod => 'Periode';

  @override
  String get calendarKeyEndNotLogged => 'Ende nicht eingetragen';

  @override
  String get calendarKeyLikely => 'Wahrscheinlicher Beginn';

  @override
  String get calendarKeyFertile => 'Fruchtbar (geschätzt)';

  @override
  String get calendarKeyToday => 'Heute';

  @override
  String calendarStatusWindow(String who, String name, String from, String to) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you':
          'Deine nächste Periode beginnt wahrscheinlich zwischen $from und $to.',
      'other':
          'Die nächste Periode von $name beginnt wahrscheinlich zwischen $from und $to.',
    });
    return '$_temp0';
  }

  @override
  String calendarStatusPeriodDay(String who, String name, int day) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Tag $day deiner Periode.',
      'other': 'Tag $day der Periode von $name.',
    });
    return '$_temp0';
  }

  @override
  String calendarStatusPeriodDayExcluded(String who, String name, int day) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you':
          'Tag $day deiner Periode, in einem Zyklus, der nicht in die Vorhersagen einfließt.',
      'other':
          'Tag $day der Periode von $name, in einem Zyklus, der nicht in die Vorhersagen einfließt.',
    });
    return '$_temp0';
  }

  @override
  String calendarStatusUnlogged(String who, String name, int day) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you':
          'Tag $day deines Zyklus. Das Ende dieser Periode wurde nicht eingetragen, daher wird sie in der üblichen Länge gezeigt.',
      'other':
          'Tag $day des Zyklus von $name. Das Ende dieser Periode wurde nicht eingetragen, daher wird sie in der üblichen Länge gezeigt.',
    });
    return '$_temp0';
  }

  @override
  String get calendarStatusFertile =>
      'Im geschätzten fruchtbaren Fenster. Nicht zuverlässig genug zur Verhütung.';

  @override
  String calendarStatusCycleDay(String who, String name, int day) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Tag $day deines Zyklus.',
      'other': 'Tag $day des Zyklus von $name.',
    });
    return '$_temp0';
  }

  @override
  String calendarDayToday(String date) {
    return 'Heute, $date';
  }

  @override
  String get calendarPreviousDay => 'Vorheriger Tag';

  @override
  String get calendarNextDay => 'Nächster Tag';

  @override
  String calendarMoonAt(String phase, String time) {
    return '$phase, $time';
  }

  @override
  String get calendarFutureDay =>
      'Kommende Tage können noch nicht eingetragen werden.';

  @override
  String calendarMarkStarted(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Als Tag markieren, an dem deine Periode angefangen hat',
      'other': 'Als Tag markieren, an dem die Periode von $name angefangen hat',
    });
    return '$_temp0';
  }

  @override
  String get calendarMoveStart => 'Zum ersten Tag der Periode machen';

  @override
  String calendarMoveStartFrom(String date) {
    return 'Verschiebt den Beginn vom $date';
  }

  @override
  String calendarMarkEnded(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Als Tag markieren, an dem deine Periode aufgehört hat',
      'other': 'Als Tag markieren, an dem die Periode von $name aufgehört hat',
    });
    return '$_temp0';
  }

  @override
  String get calendarMakeLastDay => 'Zum letzten Tag der Periode machen';

  @override
  String get calendarEditPeriod => 'Diese Periode bearbeiten';

  @override
  String calendarRateDay(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Bewerte deinen Tag, 1–5',
      'other': 'Bewerte den Tag von $name, 1–5',
    });
    return '$_temp0';
  }

  @override
  String calendarHowFelt(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Wie hast du dich gefühlt?',
      'other': 'Wie hat sich $name gefühlt?',
    });
    return '$_temp0';
  }

  @override
  String get calendarFlow => 'Blutung';

  @override
  String get calendarNote => 'Notiz';

  @override
  String calendarTemperatureHeading(String unit) {
    return 'Temperatur, $unit';
  }

  @override
  String calendarTemperatureRange(String low, String high, String unit) {
    return 'Gib eine Temperatur von $low bis $high $unit ein';
  }

  @override
  String get calendarTemperatureHelper =>
      'Nach dem Aufwachen, vor dem Aufstehen';

  @override
  String get calendarTemperatureAffected =>
      'Etwas könnte sie beeinflusst haben';

  @override
  String get calendarTemperatureAffectedHint =>
      'Krankheit, wenig Schlaf, Alkohol, später gemessen';

  @override
  String get calendarMucus => 'Zervixschleim';

  @override
  String get calendarMucusFelt => 'Empfinden';

  @override
  String get calendarMucusLooked => 'Aussehen';

  @override
  String calendarLoggedRated(int rating, String ratingName) {
    return 'Bewertet mit $rating von 5: $ratingName';
  }

  @override
  String calendarLoggedFelt(String emoji, String feeling) {
    return 'Gefühl: $emoji $feeling';
  }

  @override
  String calendarLoggedFlow(String flow) {
    String _temp0 = intl.Intl.selectLogic(flow, {
      'spotting': 'Blutung: Schmierblutung',
      'light': 'Blutung: leicht',
      'medium': 'Blutung: mittel',
      'other': 'Blutung: stark',
    });
    return '$_temp0';
  }

  @override
  String calendarLoggedTemperature(String temperature) {
    return 'Temperatur: $temperature';
  }

  @override
  String calendarLoggedTemperatureAffected(String temperature) {
    return 'Temperatur: $temperature, eventuell beeinflusst';
  }

  @override
  String calendarLoggedMucus(String mucus) {
    return 'Zervixschleim: $mucus';
  }

  @override
  String calendarLoggedNote(String note) {
    return '„$note“';
  }

  @override
  String get calendarNothingLogged => 'An diesem Tag nichts eingetragen.';

  @override
  String get calendarMoonNew => 'Neumond';

  @override
  String get calendarMoonFirstQuarter => 'Erstes Viertel';

  @override
  String get calendarMoonFull => 'Vollmond';

  @override
  String get calendarMoonLastQuarter => 'Letztes Viertel';

  @override
  String get dayFlowNone => 'Keine';

  @override
  String get dayFlowSpotting => 'Schmierblutung';

  @override
  String get dayFlowLight => 'Leicht';

  @override
  String get dayFlowMedium => 'Mittel';

  @override
  String get dayFlowHeavy => 'Stark';

  @override
  String get dayMucusNothing => 'Nichts';

  @override
  String get dayMucusFeelDry => 'Trocken';

  @override
  String get dayMucusFeelWet => 'Feucht';

  @override
  String get dayMucusFeelSlippery => 'Nass';

  @override
  String get dayMucusLookCreamy => 'Cremig';

  @override
  String get dayMucusLookEggWhite => 'Spinnbar';

  @override
  String dayMucusFeelInline(String feel) {
    String _temp0 = intl.Intl.selectLogic(feel, {
      'dry': 'trocken',
      'nothing': 'nichts gespürt',
      'wet': 'feucht',
      'other': 'nass',
    });
    return '$_temp0';
  }

  @override
  String dayMucusLookInline(String look) {
    String _temp0 = intl.Intl.selectLogic(look, {
      'nothing': 'nichts gesehen',
      'creamy': 'cremig',
      'other': 'spinnbar',
    });
    return '$_temp0';
  }

  @override
  String get dayFeelingHappy => 'Glücklich';

  @override
  String get dayFeelingCalm => 'Ruhig';

  @override
  String get dayFeelingLoving => 'Liebevoll';

  @override
  String get dayFeelingEnergetic => 'Energiegeladen';

  @override
  String get dayFeelingTired => 'Müde';

  @override
  String get dayFeelingSad => 'Traurig';

  @override
  String get dayFeelingAnxious => 'Ängstlich';

  @override
  String get dayFeelingIrritable => 'Gereizt';

  @override
  String get dayFeelingAngry => 'Wütend';

  @override
  String get dayFeelingConfused => 'Verwirrt';

  @override
  String get chartsTitle => 'Diagramme';

  @override
  String get chartsDayRating => 'Tagesbewertung';

  @override
  String get chartsNoRatings =>
      'In diesem Zeitraum hat noch kein Tag eine Bewertung.';

  @override
  String get chartsBars => 'Balken';

  @override
  String get chartsLine => 'Linie';

  @override
  String get chartsRatingCaptionBars =>
      'Jeder Balken ist die Bewertung eines Tages, 1 bis 5. Periodentage sind schattiert.';

  @override
  String get chartsRatingCaptionLine =>
      'Jeder Punkt ist die Bewertung eines Tages, 1 bis 5, verbunden mit dem nächsten Tag, wenn beide bewertet wurden. Periodentage sind schattiert.';

  @override
  String get chartsRatingCaptionMoon =>
      'Monde markieren die Mondphasen; über einen langen Zeitraum nur Neu- und Vollmonde oder nur die Vollmonde.';

  @override
  String get chartsTemperatureTitle => 'Temperatur und Zervixschleim';

  @override
  String get chartsTemperatureEmpty =>
      'In diesem Zeitraum noch nichts eingetragen. Tippe im Kalender auf einen Tag, um eine Temperatur oder Zervixschleim einzutragen.';

  @override
  String chartsTemperatureCaption(String unit) {
    return 'Jeder Punkt ist die Temperatur eines Tages in $unit, verbunden mit dem nächsten Tag, wenn an beiden gemessen wurde. Ein hohler Punkt wurde eventuell beeinflusst und ist nicht verbunden. Darunter der Zervixschleim: Höhere Balken bedeuten nasser (gefühlt) und klarer und spinnbarer (gesehen). Periodentage sind schattiert.';
  }

  @override
  String get chartsFeelings => 'Gefühle';

  @override
  String get chartsAroundPeriods => 'Rund um die Periode';

  @override
  String get chartsAroundMoon => 'Rund um den Mond';

  @override
  String get chartsFeelingsEmptyMoon =>
      'Sobald du an einigen Tagen in diesem Zeitraum gewählt hast, wie du dich gefühlt hast, zeigt sich hier, welche Gefühle rund um Voll- und Neumond auftraten.';

  @override
  String get chartsFeelingsEmptyPeriods =>
      'Sobald du an einigen Tagen in diesem Zeitraum gewählt hast, wie du dich gefühlt hast, und seitdem eine Periode angefangen hat, zeigt sich hier, welche Gefühle wann auftraten.';

  @override
  String get chartsFeelingsCaptionMoon =>
      'An wie vielen Tagen jedes Gesicht gewählt wurde.';

  @override
  String get chartsFeelingsCaptionPeriods =>
      'An wie vielen Tagen jedes Gesicht gewählt wurde. Tage seit Beginn der letzten Periode zählen erst, wenn die nächste anfängt.';

  @override
  String get chartsNoneYet => 'Noch keine.';

  @override
  String get chartsGroupDuringPeriod => 'Während einer Periode';

  @override
  String get chartsGroupBeforePeriod => 'Kurz vor einer Periode';

  @override
  String get chartsGroupOtherDays => 'Andere Tage';

  @override
  String get chartsGroupFullMoon => 'Rund um einen Vollmond';

  @override
  String get chartsGroupNewMoon => 'Rund um einen Neumond';

  @override
  String get chartsDetailLoggedPeriodDays => 'eingetragene Periodentage';

  @override
  String chartsDetailUsuallyDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'meist $days Tage',
      one: 'meist 1 Tag',
    );
    return '$_temp0';
  }

  @override
  String chartsDetailDaysBefore(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'die $days Tage davor',
      one: 'der Tag davor',
    );
    return '$_temp0';
  }

  @override
  String get chartsDetailRestOfCycle => 'der Rest des Zyklus';

  @override
  String get chartsDetailDayItself => 'der Tag selbst';

  @override
  String chartsDetailDayEitherSide(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'der Tag, ±$days Tage',
      one: 'der Tag, ±1 Tag',
    );
    return '$_temp0';
  }

  @override
  String get chartsDetailRestOfMonth => 'der Rest des Monats';

  @override
  String chartsFeelingCount(String feeling, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Tagen',
      one: '1 Tag',
    );
    return '$feeling an $_temp0';
  }

  @override
  String chartsFeelingGroupSummary(String group, String detail, String counts) {
    return '$group, $detail: $counts';
  }

  @override
  String get chartsFeelingGroupNone => 'noch keine';

  @override
  String chartsRatingSummary(String from, String to, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count bewertete Tage',
      one: '1 bewerteter Tag',
    );
    return 'Tagesbewertungen vom $from bis $to: $_temp0, Periodentage schattiert.';
  }

  @override
  String chartsRatingSummaryMoons(String from, String to, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count bewertete Tage',
      one: '1 bewerteter Tag',
    );
    return 'Tagesbewertungen vom $from bis $to: $_temp0, Periodentage schattiert und Mondphasen markiert.';
  }

  @override
  String chartsLanesSummary(String from, String to, String lanes) {
    return 'Perioden vom $from bis $to. $lanes.';
  }

  @override
  String chartsLane(String name, String periods) {
    return '$name: $periods';
  }

  @override
  String get chartsLaneNone => 'keine Periodentage';

  @override
  String chartsLaneRun(String from, String to) {
    return '$from bis $to';
  }

  @override
  String chartsLaneRunEstimated(String from, String to) {
    return '$from bis $to, geschätzt';
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
      other: '$mucusDays Tagen',
      one: '1 Tag',
    );
    return 'Temperaturen vom $from bis $to: $range, Zervixschleim an $_temp0 notiert, Periodentage schattiert.';
  }

  @override
  String get chartsNoTemperatures => 'keine Temperaturen';

  @override
  String chartsTemperatureRange(int count, String low, String high) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Temperaturen',
      one: '1 Temperatur',
    );
    return '$_temp0, von $low bis $high';
  }

  @override
  String get chartsMucusFelt => 'Gefühlt';

  @override
  String get chartsMucusLooked => 'Gesehen';

  @override
  String get faceRatingRough => 'Mies';

  @override
  String get faceRatingNotGreat => 'Nicht so gut';

  @override
  String get faceRatingOkay => 'Okay';

  @override
  String get faceRatingGood => 'Gut';

  @override
  String get faceRatingGreat => 'Super';

  @override
  String get faceRatingRoughInline => 'mies';

  @override
  String get faceRatingNotGreatInline => 'nicht so gut';

  @override
  String get faceRatingOkayInline => 'okay';

  @override
  String get faceRatingGoodInline => 'gut';

  @override
  String get faceRatingGreatInline => 'super';

  @override
  String faceRatingOption(int rating, String name) {
    return '$rating, $name';
  }

  @override
  String get faceMoreFaces => 'Mehr Gesichter';

  @override
  String get faceDifferentFace => 'Ein anderes Gesicht';

  @override
  String get faceOther => 'Sonstiges Gesicht';

  @override
  String get faceSmilingCat => 'Lächelnde Katze';

  @override
  String get faceGrinningCat => 'Grinsende Katze';

  @override
  String get faceCatTearsOfJoy => 'Katze mit Freudentränen';

  @override
  String get faceCatHeartEyes => 'Katze mit Herzaugen';

  @override
  String get faceSmirkingCat => 'Verschmitzte Katze';

  @override
  String get faceKissingCat => 'Küssende Katze';

  @override
  String get faceWearyCat => 'Erschöpfte Katze';

  @override
  String get faceCryingCat => 'Weinende Katze';

  @override
  String get facePoutingCat => 'Schmollende Katze';

  @override
  String get faceAlien => 'Außerirdischer';

  @override
  String get faceSpaceInvader => 'Weltraummonster';

  @override
  String get faceRobot => 'Roboter';

  @override
  String get faceGhost => 'Gespenst';

  @override
  String get faceSkull => 'Totenkopf';

  @override
  String get faceClown => 'Clown';

  @override
  String get faceDevil => 'Teufel';

  @override
  String get faceUnicorn => 'Einhorn';

  @override
  String get faceFrog => 'Frosch';

  @override
  String get facePartying => 'Feiernd';

  @override
  String get faceCool => 'Lässig';

  @override
  String get faceNerdy => 'Nerdig';

  @override
  String get faceAngelic => 'Engelsgleich';

  @override
  String get faceHugging => 'Umarmend';

  @override
  String get faceSilly => 'Albern';

  @override
  String get faceUpsideDown => 'Kopfüber';

  @override
  String get faceSmirking => 'Verschmitzt';

  @override
  String get faceGrimacing => 'Grimasse';

  @override
  String get faceEyeRoll => 'Augenrollen';

  @override
  String get faceSpeechless => 'Sprachlos';

  @override
  String get facePleading => 'Bittend';

  @override
  String get faceSobbing => 'Schluchzend';

  @override
  String get faceScreaming => 'Schreiend';

  @override
  String get faceFlushed => 'Errötet';

  @override
  String get faceOverwhelmed => 'Überwältigt';

  @override
  String get faceWoozy => 'Benommen';

  @override
  String get faceUnwell => 'Unwohl';

  @override
  String get faceHurting => 'Schmerzen';

  @override
  String get faceQueasy => 'Übel';

  @override
  String get faceTooHot => 'Zu heiß';

  @override
  String get faceTooCold => 'Zu kalt';

  @override
  String get faceSparklingHeart => 'Funkelndes Herz';

  @override
  String get faceBrokenHeart => 'Gebrochenes Herz';

  @override
  String get faceFire => 'Feuer';

  @override
  String get faceRainbow => 'Regenbogen';

  @override
  String get faceSun => 'Sonne';

  @override
  String get faceRain => 'Regen';

  @override
  String get faceStorm => 'Gewitter';

  @override
  String get faceBlossom => 'Blüte';

  @override
  String get faceChocolate => 'Schokolade';

  @override
  String get faceInBed => 'Im Bett';

  @override
  String get homeCalendar => 'Kalender';

  @override
  String get homeHistory => 'Verlauf';

  @override
  String get homeCharts => 'Diagramme';

  @override
  String get homeSettings => 'Einstellungen';

  @override
  String homeCalendarOf(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Dein Kalender',
      'other': 'Kalender von $name',
    });
    return '$_temp0';
  }

  @override
  String homeHistoryOf(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Dein Verlauf',
      'other': 'Verlauf von $name',
    });
    return '$_temp0';
  }

  @override
  String homeChartsOf(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Deine Diagramme',
      'other': 'Diagramme von $name',
    });
    return '$_temp0';
  }

  @override
  String get homeWhenStarted => 'Wann hat sie angefangen?';

  @override
  String get homeWhenEnded => 'Wann hat sie aufgehört?';

  @override
  String homePeriodEndedToday(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Meine Periode hat heute aufgehört',
      'other': 'Die Periode von $name hat heute aufgehört',
    });
    return '$_temp0';
  }

  @override
  String homePeriodStartedToday(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Meine Periode hat heute angefangen',
      'other': 'Die Periode von $name hat heute angefangen',
    });
    return '$_temp0';
  }

  @override
  String get homeEndedEarlier => 'Sie hat an einem früheren Tag aufgehört';

  @override
  String get homeStartedEarlier => 'Sie hat an einem früheren Tag angefangen';

  @override
  String homeAddLastEnd(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Eintragen, wann deine letzte Periode aufgehört hat',
      'other': 'Eintragen, wann die letzte Periode von $name aufgehört hat',
    });
    return '$_temp0';
  }

  @override
  String homeSharedCopy(String who, String name, String date) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you':
          'Am $date von deinem Telefon importiert. Hier lässt sich nichts ändern; aktualisiert wird es, wenn du es erneut sendest.',
      'other':
          'Am $date vom Telefon von $name importiert. Hier lässt sich nichts ändern; aktualisiert wird es, wenn $name es erneut sendet.',
    });
    return '$_temp0';
  }

  @override
  String homeNoPeriodSince(String date) {
    return 'Seit $date keine Periode eingetragen';
  }

  @override
  String get homeMissedOne =>
      'Ebb hat angenommen, dass eine Periode nicht eingetragen wurde, und von dort aus geschätzt. Wenn du weißt, wann sie angefangen hat, trag sie ein, um die Schätzung zu korrigieren.';

  @override
  String get homeMissedSome =>
      'Ebb hat angenommen, dass einige Perioden nicht eingetragen wurden, und von dort aus geschätzt. Wenn du weißt, wann eine davon angefangen hat, trag sie ein, um die Schätzung zu korrigieren.';

  @override
  String get homeWelcome => 'Willkommen bei Ebb';

  @override
  String get homeNothingYet => 'Noch nichts eingetragen';

  @override
  String homeFirstLog(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Trag den ersten Tag deiner nächsten Periode ein oder füge frühere Perioden hinzu, wenn du dich an sie erinnerst, und Ebb fängt an, deinen Rhythmus kennenzulernen. Alles bleibt auf diesem Telefon.',
      'other':
          'Trag den ersten Tag der nächsten Periode von $name ein oder füge frühere Perioden hinzu, wenn du dich an sie erinnerst, und Ebb fängt an, den Rhythmus kennenzulernen. Alles bleibt auf diesem Telefon.',
    });
    return '$_temp0';
  }

  @override
  String homeDayOfPeriod(String who, String name, int day) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Tag $day deiner Periode',
      'other': 'Tag $day der Periode von $name',
    });
    return '$_temp0';
  }

  @override
  String homeDayOfCycle(String who, String name, int day) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Tag $day deines Zyklus',
      'other': 'Tag $day des Zyklus von $name',
    });
    return '$_temp0';
  }

  @override
  String get homeTellEnd =>
      'Sag Ebb Bescheid, wenn sie aufhört, damit die Schätzung genau bleibt.';

  @override
  String homeDaysUntil(String who, String name, int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Noch etwa $days Tage, bis deine Periode erwartet wird.',
    );
    String _temp1 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Noch etwa $days Tage, bis die Periode von $name erwartet wird.',
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
      'you': 'Deine Periode wird morgen erwartet.',
      'other': 'Die Periode von $name wird morgen erwartet.',
    });
    return '$_temp0';
  }

  @override
  String homeExpectedToday(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Deine Periode wird heute erwartet.',
      'other': 'Die Periode von $name wird heute erwartet.',
    });
    return '$_temp0';
  }

  @override
  String homeDaysLate(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other:
          '$days Tage später als erwartet. Zyklen verschieben sich aus allen möglichen Gründen.',
      one: '1 Tag später als erwartet. Zyklen verschieben sich aus allen möglichen Gründen.',
    );
    return '$_temp0';
  }

  @override
  String get homeRingDay => 'TAG';

  @override
  String homeRingOfCycle(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'deines Zyklus',
      'other': 'des Zyklus von $name',
    });
    return '$_temp0';
  }

  @override
  String homeRingOfPeriod(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'deiner Periode',
      'other': 'der Periode von $name',
    });
    return '$_temp0';
  }

  @override
  String get homeKeyPeriod => 'Periode';

  @override
  String get homeKeyLikelyNext => 'Wahrscheinlich nächste';

  @override
  String get homeKeyToday => 'Heute';

  @override
  String get homeAddPastPeriods => 'Frühere Perioden hinzufügen';

  @override
  String get homeAddMissedPeriod => 'Fehlende Periode hinzufügen';

  @override
  String get homeNextPeriod => 'Nächste Periode';

  @override
  String homeLikelyBetween(String from, String to) {
    return 'wahrscheinlich zwischen $from und $to';
  }

  @override
  String get homeFertileWindow => 'Geschätztes fruchtbares Fenster';

  @override
  String get homeFertileWarning =>
      'Eine Schätzung allein aus dem zeitlichen Ablauf des Zyklus. Nicht zuverlässig genug zur Verhütung.';

  @override
  String homeConfidenceUnlogged(String date) {
    return 'Geschätzt ab der letzten eingetragenen Periode am $date, daher eventuell ungenauer als sonst.';
  }

  @override
  String get homeConfidenceNone => 'Noch nichts eingetragen.';

  @override
  String get homeConfidenceTypical =>
      'Vorerst auf Basis eines typischen 28-Tage-Zyklus. Je mehr du einträgst, desto genauer wird es.';

  @override
  String homeConfidenceFew(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Bisher auf Basis von $count Zyklen, daher vorerst eventuell ungenauer.',
      one: 'Bisher auf Basis von 1 Zyklus, daher vorerst eventuell ungenauer.',
    );
    return '$_temp0';
  }

  @override
  String homeConfidenceIrregular(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Deine Zyklen schwanken ziemlich, daher ist das eine breite Schätzung und kein festes Datum.',
      'other':
          'Die Zyklen von $name schwanken ziemlich, daher ist das eine breite Schätzung und kein festes Datum.',
    });
    return '$_temp0';
  }

  @override
  String homeConfidenceLast(String who, String name, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Auf Basis deiner letzten $count Zyklen.',
    );
    String _temp1 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Auf Basis der letzten $count Zyklen von $name.',
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
      other: 'Auf Basis von $count recht gleichmäßigen Zyklen.',
    );
    return '$_temp0';
  }

  @override
  String get homeMilestoneFirstPeriod => 'Erste Periode eingetragen';

  @override
  String get homeMilestoneFirstCycle => 'Erster vollständiger Zyklus';

  @override
  String get homeMilestoneThreeCycles => 'Drei vollständige Zyklen';

  @override
  String get homeMilestoneSixCycles => 'Sechs vollständige Zyklen';

  @override
  String get homeMilestoneOneYear => 'Ein Jahr Verlauf';

  @override
  String get homeMilestoneTwoYears => 'Zwei Jahre Verlauf';

  @override
  String get homeMilestoneFiveYears => 'Fünf Jahre Verlauf';

  @override
  String get homeMilestoneFirstBackup => 'Erste Sicherung gespeichert';

  @override
  String homeMilestoneFirstPeriodMessage(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Deine erste Periode in Ebb.',
      'other': 'Die erste Periode von $name in Ebb.',
    });
    return '$_temp0';
  }

  @override
  String homeMilestoneFirstCycleMessage(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Ein erster vollständiger Zyklus. Ebb kann anfangen, deinen Rhythmus kennenzulernen.',
      'other':
          'Ein erster vollständiger Zyklus. Ebb kann anfangen, den Rhythmus von $name kennenzulernen.',
    });
    return '$_temp0';
  }

  @override
  String get homeMilestoneThreeCyclesMessage =>
      'Drei vollständige Zyklen eingetragen. Jeder gibt Ebb mehr Anhaltspunkte.';

  @override
  String get homeMilestoneSixCyclesMessage =>
      'Sechs vollständige Zyklen eingetragen: so viele, wie Ebb für jede Schätzung heranzieht.';

  @override
  String homeMilestoneOneYearMessage(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Ein Jahr deines Verlaufs in Ebb.',
      'other': 'Ein Jahr Verlauf von $name in Ebb.',
    });
    return '$_temp0';
  }

  @override
  String homeMilestoneTwoYearsMessage(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Zwei Jahre deines Verlaufs in Ebb.',
      'other': 'Zwei Jahre Verlauf von $name in Ebb.',
    });
    return '$_temp0';
  }

  @override
  String homeMilestoneFiveYearsMessage(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Fünf Jahre deines Verlaufs in Ebb.',
      'other': 'Fünf Jahre Verlauf von $name in Ebb.',
    });
    return '$_temp0';
  }

  @override
  String get homeMilestoneFirstBackupMessage =>
      'Deine erste Sicherung ist gespeichert. Bewahre eine Kopie woanders als auf diesem Telefon auf.';

  @override
  String get homeProblemStartInFuture =>
      'Das Anfangsdatum kann nicht in der Zukunft liegen.';

  @override
  String get homeProblemEndInFuture =>
      'Das Enddatum kann nicht in der Zukunft liegen.';

  @override
  String get homeProblemEndBeforeStart =>
      'Das Enddatum liegt vor dem Anfangsdatum.';

  @override
  String get homeProblemDuplicateStart =>
      'Eine Periode, die an diesem Tag anfängt, ist schon eingetragen.';

  @override
  String get homeProblemOverlapsPrevious =>
      'Das überschneidet sich mit der Periode davor. Prüfe das Enddatum des früheren Eintrags.';

  @override
  String get homeProblemOverlapsNext =>
      'Das überschneidet sich mit der Periode danach. Prüfe das Enddatum.';

  @override
  String get homeDeleteCycleTitle => 'Diesen Zyklus löschen?';

  @override
  String homeDeleteCycleBody(String date) {
    return 'Der Eintrag ab $date wird entfernt. Das lässt sich nicht rückgängig machen.';
  }

  @override
  String get homeFirstDayOfPeriod => 'Erster Tag der Periode';

  @override
  String get homeLastDayOfPeriod => 'Letzter Tag der Periode';

  @override
  String get homeAddPastPeriodTitle => 'Frühere Periode hinzufügen';

  @override
  String get homeEditPeriod => 'Periode bearbeiten';

  @override
  String get homeStarted => 'Angefangen';

  @override
  String get homeEnded => 'Aufgehört';

  @override
  String get homeStillGoing => 'Läuft noch';

  @override
  String get homeNotRecorded => 'Nicht eingetragen';

  @override
  String get homeClearEnd => 'Enddatum entfernen';

  @override
  String get homeCountInPredictions =>
      'Diesen Zyklus in Vorhersagen einbeziehen';

  @override
  String get homeCountInPredictionsHint =>
      'Ausschalten bei einem Zyklus, der nicht dem üblichen Rhythmus entspricht – Krankheit, ein Medikamentenwechsel, eine Fehlgeburt. Er bleibt so oder so in deinem Verlauf.';

  @override
  String get homeNote => 'Notiz';

  @override
  String get homeNoteExcludedHint =>
      'Warum er nicht zählt, damit du dich später leicht daran erinnerst.';

  @override
  String get homeNoteHint =>
      'Alles, was du dir zu dieser Periode merken möchtest.';

  @override
  String get homeDeletePeriod => 'Diese Periode löschen';

  @override
  String get homeAddPastPeriod => 'Frühere Periode hinzufügen';

  @override
  String get homeHistoryEmpty =>
      'Noch keine Zyklen eingetragen. Wenn du weißt, wann deine letzten Perioden angefangen haben, verschafft ihr Eintragen Ebb einen Vorsprung.';

  @override
  String get homeMilestones => 'Meilensteine';

  @override
  String homePeriodLength(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count-tägige Periode',
      one: '1-tägige Periode',
    );
    return '$_temp0';
  }

  @override
  String get homePeriodInProgress => 'Periode läuft';

  @override
  String get homeEndNotRecorded => 'Ende nicht eingetragen';

  @override
  String get homeLongGap =>
      'Eine lange Lücke. Wenn hier eine Periode nicht eingetragen wurde, füge sie mit „Frühere Periode hinzufügen“ hinzu.';

  @override
  String get homeNothingSince =>
      'Seitdem nichts eingetragen. Wenn eine Periode fehlt, füge sie mit „Frühere Periode hinzufügen“ hinzu.';

  @override
  String homeNotCounted(String detail) {
    return '$detail · nicht gezählt';
  }

  @override
  String get homeDayCycle => 'Tage-Zyklus';

  @override
  String get homeLastLogged => 'Zuletzt eingetragen';

  @override
  String get homeCurrent => 'Aktuell';

  @override
  String get homeSpanMonths3 => 'Letzte 3 Monate';

  @override
  String get homeSpanMonths6 => 'Letzte 6 Monate';

  @override
  String get homeSpanYear => 'Letzte 12 Monate';

  @override
  String get homeSpanAll => 'Alles';

  @override
  String get homeSpanCustom => 'Zeitraum wählen…';

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get settingsNotificationsOff =>
      'Benachrichtigungen für Ebb sind in den Systemeinstellungen ausgeschaltet.';

  @override
  String settingsNoBrowser(String website) {
    return 'Kein Browser zum Öffnen vorhanden. Besuche stattdessen $website.';
  }

  @override
  String get settingsNothingToBackUp => 'Noch nichts zu sichern.';

  @override
  String get settingsBackupSaved =>
      'Sicherung gespeichert. Bewahre eine Kopie woanders als auf diesem Telefon auf.';

  @override
  String get settingsBackupNotSaved =>
      'Die Sicherung konnte dort nicht gespeichert werden. Versuche einen anderen Speicherort.';

  @override
  String get settingsNoPicker =>
      'Dieses Telefon hat keine Dateiauswahl, die Ebb nutzen kann. Das Senden an ein anderes Telefon funktioniert auch ohne.';

  @override
  String get settingsFileTooLarge =>
      'Diese Datei ist zu groß für eine Ebb-Sicherung.';

  @override
  String get settingsFileUnreadable =>
      'Diese Datei konnte nicht gelesen werden.';

  @override
  String get settingsNotABackup => 'Diese Datei ist keine Ebb-Sicherung.';

  @override
  String settingsPeriodCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Perioden',
      one: '$count Periode',
    );
    return '$_temp0';
  }

  @override
  String get settingsSetUpTitle => 'Mit diesem Verlauf einrichten?';

  @override
  String settingsSetUpBody(String periods, String date) {
    return '$periods, gesendet am $date. Auf diesem Telefon wird daraus dein Verlauf.';
  }

  @override
  String settingsUpdateTitle(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Deinen Verlauf aktualisieren?',
      'other': '$name aktualisieren?',
    });
    return '$_temp0';
  }

  @override
  String settingsUpdateAction(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Deinen Verlauf aktualisieren',
      'other': '$name aktualisieren',
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
          'Das ist wieder dein Verlauf, gesendet am $date: $periods. Er ersetzt die Kopie auf diesem Telefon.',
      'other':
          'Das ist wieder der Verlauf von $name, gesendet am $date: $periods. Er ersetzt die Kopie auf diesem Telefon.',
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
          'Das ist dein Verlauf, gesendet am $date: $periods. Er ersetzt, was auf diesem Telefon für dich gespeichert ist, auch alles, was seitdem hier eingetragen wurde.',
      'other':
          'Das ist der Verlauf von $name, gesendet am $date: $periods. Er ersetzt, was auf diesem Telefon für $name gespeichert ist, auch alles, was seitdem hier eingetragen wurde.',
    });
    return '$_temp0';
  }

  @override
  String get settingsReplaceEverything => 'Alles ersetzen';

  @override
  String settingsPersonUpdated(String name) {
    return 'Aktualisiert: $name.';
  }

  @override
  String get settingsAddThisHistoryTitle => 'Diesen Verlauf hinzufügen?';

  @override
  String settingsAddNamedTitle(String name) {
    return '$name hinzufügen?';
  }

  @override
  String settingsAddBody(String periods) {
    return 'Er enthält $periods. Du kannst ihn zu dem hinzufügen, was schon hier ist, oder alles auf diesem Telefon damit ersetzen.';
  }

  @override
  String settingsAddNamedBody(String name, String periods) {
    return 'Der Verlauf von $name enthält $periods. Du kannst ihn zu dem hinzufügen, was schon hier ist, oder alles auf diesem Telefon damit ersetzen.';
  }

  @override
  String get settingsAddAsNew => 'Als neue Person hinzufügen';

  @override
  String get settingsWhoIsThis => 'Wer ist das?';

  @override
  String get settingsWhoIsThisHint =>
      'Ein Name, um die Personen auf diesem Telefon zu unterscheiden.';

  @override
  String settingsPersonAdded(String name) {
    return 'Hinzugefügt: $name.';
  }

  @override
  String get settingsRestored => 'Fertig. Ebb wurde aktualisiert.';

  @override
  String get settingsReplaceTitle => 'Ersetzen, was in Ebb ist?';

  @override
  String settingsReplaceSaved(String date, String periods) {
    return 'Gespeichert am $date, mit $periods.';
  }

  @override
  String settingsReplaceSavedPeople(int people, String date, String periods) {
    String _temp0 = intl.Intl.pluralLogic(
      people,
      locale: localeName,
      other: 'Gespeichert am $date, mit $periods für $people Personen.',
    );
    return '$_temp0';
  }

  @override
  String settingsReplaceCurrent(String periods) {
    return 'Sie ersetzt alles, was jetzt in Ebb ist, einschließlich $periods auf diesem Telefon.';
  }

  @override
  String get settingsReplace => 'Ersetzen';

  @override
  String get settingsDeleteAllTitle => 'Alle Daten löschen?';

  @override
  String get settingsDeleteAllBody =>
      'Alle Zyklen und Notizen werden endgültig gelöscht. Ebb hat keine andere Kopie, daher lässt sich das nicht rückgängig machen, außer du hast eine Sicherungsdatei gespeichert.';

  @override
  String get settingsDeleteAllBodyEveryone =>
      'Alle Zyklen und Notizen, für alle Personen auf diesem Telefon, werden endgültig gelöscht. Ebb hat keine andere Kopie, daher lässt sich das nicht rückgängig machen, außer du hast eine Sicherungsdatei gespeichert.';

  @override
  String get settingsDeleteEverything => 'Alles löschen';

  @override
  String get settingsAllDeleted => 'Alle Daten gelöscht.';

  @override
  String get settingsYourName => 'Dein Name';

  @override
  String get settingsRename => 'Umbenennen';

  @override
  String get settingsYourNameHint =>
      'Wird in der Personenliste angezeigt. Leer lassen, um als „Du“ zu erscheinen.';

  @override
  String settingsRemoveTitle(String name) {
    return '$name von diesem Telefon entfernen?';
  }

  @override
  String settingsRemoveBody(String name) {
    return 'Alle Zyklen und Notizen von $name werden endgültig gelöscht. Der Verlauf aller anderen bleibt unberührt.';
  }

  @override
  String settingsPersonRemoved(String name) {
    return 'Entfernt: $name.';
  }

  @override
  String settingsRemovePerson(String name) {
    return '$name von diesem Telefon entfernen';
  }

  @override
  String get settingsYourCycle => 'Dein Zyklus';

  @override
  String get settingsYourSettings => 'Deine Einstellungen';

  @override
  String settingsSettingsFor(String name) {
    return 'Einstellungen für $name';
  }

  @override
  String get settingsName => 'Name';

  @override
  String get settingsReminders => 'Erinnerungen';

  @override
  String settingsRemindersHint(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Eine Vorwarnung, bevor deine Periode erwartet wird.',
      'other': 'Eine Vorwarnung, bevor die Periode von $name erwartet wird.',
    });
    return '$_temp0';
  }

  @override
  String get settingsRemindMe => 'Erinnern';

  @override
  String settingsDaysAhead(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Tage vorher',
      one: '$count Tag vorher',
    );
    return '$_temp0';
  }

  @override
  String settingsDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Tage',
      one: '$count Tag',
    );
    return '$_temp0';
  }

  @override
  String get settingsFertile => 'Geschätztes fruchtbares Fenster anzeigen';

  @override
  String get settingsFertileHint =>
      'Standardmäßig aus. Eine Schätzung nur aus dem zeitlichen Ablauf des Zyklus – nicht zuverlässig genug zur Verhütung.';

  @override
  String get settingsMoon => 'Mondphasen anzeigen';

  @override
  String get settingsMoonHint =>
      'Neumond, erstes Viertel, Vollmond und letztes Viertel, im Kalender und in den Diagrammen.';

  @override
  String get settingsTemperature => 'Temperatur und Zervixschleim erfassen';

  @override
  String get settingsTemperatureHint =>
      'An jedem Tag im Kalender, mit einem Temperaturdiagramm. Wird festgehalten und gezeichnet, aber nie für Schätzungen verwendet.';

  @override
  String get settingsTemperatureIn => 'Temperatur in';

  @override
  String get settingsCelebrate => 'Meilensteine feiern';

  @override
  String settingsCelebrateHint(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Eine kleine Feier für Dinge wie einen ersten vollständigen Zyklus oder ein Jahr Verlauf, aufgelistet in deinem Verlauf.',
      'other':
          'Eine kleine Feier für Dinge wie einen ersten vollständigen Zyklus oder ein Jahr Verlauf, aufgelistet im Verlauf von $name.',
    });
    return '$_temp0';
  }

  @override
  String get settingsPeople => 'Personen';

  @override
  String get settingsAddSomeone => 'Person hinzufügen';

  @override
  String get settingsTrackSomeoneElse => 'Auch für jemand anderen eintragen';

  @override
  String get settingsTrackSomeoneElseHint =>
      'Zum Beispiel für ein Kind, das gerade die ersten Perioden hat.';

  @override
  String get settingsBackupSection => 'Sicherung & Umzug';

  @override
  String get settingsBackUp => 'In einer Datei sichern';

  @override
  String get settingsBackUpHint =>
      'Speichere deinen Verlauf in einer Datei, wo du möchtest.';

  @override
  String get settingsBackUpHintEveryone =>
      'Speichere den Verlauf aller Personen in einer Datei, wo du möchtest.';

  @override
  String get settingsRestore => 'Aus einer Sicherung wiederherstellen';

  @override
  String get settingsRestoreHint => 'Ersetzt, was jetzt in Ebb ist.';

  @override
  String get settingsSend => 'An ein anderes Telefon senden';

  @override
  String get settingsSendHint =>
      'Zeigt deinen Verlauf als Codes, die ein anderes Telefon scannen kann.';

  @override
  String get settingsSendHintEveryone =>
      'Zeigt den Verlauf aller Personen als Codes, die ein anderes Telefon scannen kann.';

  @override
  String get settingsReceive => 'Von einem anderen Telefon empfangen';

  @override
  String get settingsReceiveHint =>
      'Scanne die Codes, um jemanden hinzuzufügen, zu aktualisieren oder alles zu ersetzen.';

  @override
  String get settingsAdvanced => 'Erweitert';

  @override
  String get settingsGroups => 'Gruppen';

  @override
  String get settingsGroupsHint =>
      'Für Kreise und Clubs, die gemeinsam ihren Zyklus verfolgen: Personen unter einem Namen sammeln. Ausschalten blendet Gruppen aus, ohne sie zu löschen.';

  @override
  String get settingsManageGroups => 'Gruppen verwalten';

  @override
  String get settingsAboutEbb => 'Über Ebb';

  @override
  String get settingsHowEbbWorks => 'So funktioniert Ebb';

  @override
  String get settingsHowEbbWorksHint =>
      'Eintragen, Schätzungen, Sicherungen und mehr.';

  @override
  String get settingsYourData => 'Deine Daten';

  @override
  String get settingsYourDataHint => 'Wo sie liegen und wer sie sehen kann.';

  @override
  String get settingsWebsite => 'Website';

  @override
  String get settingsSendFeedback => 'Feedback senden';

  @override
  String get settingsSendFeedbackHint =>
      'Ein Formular auf der Website, in deinem Browser.';

  @override
  String get settingsDeleteAll => 'Alle Daten löschen';

  @override
  String settingsVersion(String version) {
    return 'Ebb $version\nVon SuperDaveLab';
  }

  @override
  String get settingsDataHeadline => 'Dein Zyklus ist deine Sache.';

  @override
  String get settingsDataLede =>
      'Ebb ist so gebaut, dass die Frage „Was machen die mit meinen Daten?“ eine langweilige Antwort hat: nichts, weil wir sie nie bekommen.';

  @override
  String get settingsDataTradeOff =>
      'Ein Kompromiss, den du kennen solltest: Weil es keine Cloud-Sicherung gibt, ist der Verlauf weg, wenn das Telefon verloren geht oder zurückgesetzt wird. Wenn dir das wichtig ist, speichere ab und zu in den Einstellungen eine Sicherungsdatei und bewahre sie woanders als auf diesem Telefon auf.';

  @override
  String get settingsWhereDataLives => 'Wo deine Daten liegen';

  @override
  String get settingsWhereDataLivesHint =>
      'Deine Daten und wer sie sehen kann.';

  @override
  String get settingsDataStaysTitle => 'Sie bleiben auf deinem Telefon';

  @override
  String get settingsDataStaysBody =>
      'Alles, was du einträgst, wird in einer Datenbank auf diesem Gerät gespeichert. Es gibt kein Konto und keinen Server zum Synchronisieren. Woandershin gelangt es nur, wenn du es selbst dorthin bringst – als Sicherungsdatei oder auf ein anderes Telefon, an das du es sendest.';

  @override
  String get settingsDataUnseenTitle => 'Wir können sie nicht sehen';

  @override
  String get settingsDataUnseenBody =>
      'Ebb wird ganz ohne die Berechtigung gebaut, das Internet zu nutzen. Android setzt das durch, und du kannst es selbst in der Berechtigungsliste der App prüfen.';

  @override
  String get settingsDataPermissionsTitle => 'Wofür die Berechtigungen da sind';

  @override
  String get settingsDataPermissionsBody =>
      'Benachrichtigungen, für die Erinnerungen. Kamera, nur während du einen Verlauf von einem anderen Telefon empfängst – sie liest die Codes, und nichts wird aufgenommen oder behalten. Außerdem stellt Ebb deine Erinnerungen neu, wenn das Telefon neu startet. Das ist die ganze Liste.';

  @override
  String get settingsDataNotForSaleTitle => 'Es gibt nichts zu verkaufen';

  @override
  String get settingsDataNotForSaleBody =>
      'Keine Analyse, keine Werbung, keine Bibliotheken von Dritten, die nach Hause telefonieren. Da deine Daten uns nie erreichen, gibt es keine Kopie, die jemand kaufen, per Gerichtsbeschluss anfordern oder durchsickern lassen könnte.';

  @override
  String get settingsDataEraseTitle => 'Du kannst sie sofort löschen';

  @override
  String get settingsDataEraseBody =>
      'Wenn du deine Daten in den Einstellungen löschst oder Ebb deinstallierst, ist alles entfernt, was Ebb gespeichert hat. Ebb behält keine andere Kopie – die einzigen sind Sicherungsdateien, die du gespeichert hast, oder Telefone, an die du sie selbst gesendet hast.';

  @override
  String get settingsDataOpenSourceTitle => 'Du kannst unsere Arbeit prüfen';

  @override
  String get settingsDataOpenSourceBody =>
      'Ebb ist Open Source unter der GNU General Public License. Alle können genau nachlesen, was es tut, und die veröffentlichten Versionen werden aus genau diesem Code gebaut.';

  @override
  String get settingsHelpLoggingTitle => 'Eine Periode eintragen';

  @override
  String get settingsHelpLoggingBody =>
      'Tippe am ersten Tag der Blutung auf „Meine Periode hat heute angefangen“ und am letzten auf „Meine Periode hat heute aufgehört“.\n\nVergessen, sie einzutragen? Nimm stattdessen „Sie hat an einem früheren Tag angefangen“. Jede frühere Periode lässt sich im Verlauf (das Uhr-Symbol) hinzufügen oder korrigieren: Tippe auf eine, um ihre Daten zu ändern oder eine Notiz hinzuzufügen.\n\nWenn innerhalb von zwei Wochen kein Ende eingetragen wird, behandelt Ebb die Periode nicht mehr als laufend und bietet stattdessen an, das Ende einzutragen.';

  @override
  String get settingsHelpEstimateTitle => 'So funktioniert die Schätzung';

  @override
  String get settingsHelpEstimateBody =>
      'Ebb schaut sich die Abstände zwischen den Anfängen deiner letzten Perioden an – bis zu den letzten sechs.\n\nMit wenig Verlauf stützt sich Ebb auf einen typischen 28-Tage-Zyklus und sagt das auch. Je mehr du einträgst, desto mehr entspricht die Schätzung deinem eigenen Rhythmus.\n\nSie zeigt einen Zeitraum statt eines einzelnen Datums und sagt dir, wie sicher sie ist. Wenn deine Zyklen stark schwanken, ist der Zeitraum breiter.\n\nKommt eine Periode später als erwartet, sagt Ebb, wie viel später. Wenn fast zwei Zyklen lang nichts eingetragen wird, nimmt Ebb an, dass eine Periode nicht eingetragen wurde, schätzt von dort aus und sagt das auch. Der Verlauf weist auf lange Lücken hin, und eine fehlende Periode nachzutragen korrigiert die Schätzung.';

  @override
  String get settingsHelpExcludeTitle => 'Ein Zyklus, der nicht zählen soll';

  @override
  String get settingsHelpExcludeBody =>
      'Krankheit, ein Medikamentenwechsel oder eine Fehlgeburt können einen Zyklus völlig durcheinanderbringen, und er würde die Schätzung mit sich ziehen.\n\nTippe im Verlauf auf diese Periode und schalte „Diesen Zyklus in Vorhersagen einbeziehen“ aus. Er bleibt in deinem Verlauf; die Schätzung lässt ihn nur weg. Füge dort auch eine Notiz hinzu, damit du weißt, warum.';

  @override
  String get settingsHelpGroupsTitle => 'Gruppen';

  @override
  String get settingsHelpGroupsBody =>
      'Für Kreise und Clubs, die gemeinsam ihren Zyklus verfolgen. Schalte sie unter Einstellungen → Erweitert ein, erstelle dann eine Gruppe und wähle, wer dazugehört. „… gemeinsam ansehen“ in der Personenliste zeigt alle nebeneinander, mit dem Mond.\n\nEine Gruppe kann zwei Arten von Mitgliedern haben. Wer hinzugefügt wird, wird auf diesem Telefon geführt, und du trägst hier für die Person ein. Wer importiert wird, trägt weiter auf dem eigenen Telefon ein und stellt der Gruppe den eigenen Verlauf zur Verfügung: Er gehört weiterhin der Person und kann auf keinem anderen Telefon geändert werden.\n\nUm importiert zu werden, sende nur deinen Verlauf (Einstellungen → An ein anderes Telefon senden) – so viel oder so wenig du möchtest, mit oder ohne deine täglichen Notizen. Das andere Telefon importiert ihn aus der Gruppe heraus: Gruppen verwalten → die Gruppe → Vom Telefon der Person importieren. Ein erneuter Import bringt dich auf den neuesten Stand.\n\nImportierter Verlauf gehört zu seiner Gruppe. Wird eine importierte Person aus ihrer letzten Gruppe genommen oder diese Gruppe gelöscht, wird auch ihr Verlauf vom Telefon entfernt. Und er kann nicht weitergesendet werden: Das geht nur mit deinem eigenen Verlauf.';

  @override
  String get settingsHelpRatingsTitle =>
      'Tagesbewertungen, Gefühle und Diagramme';

  @override
  String get settingsHelpRatingsBody =>
      'Tippe im Kalender auf einen Tag, um ihn von 1 bis 5 zu bewerten und ein Gesicht dafür zu wählen, wie du dich gefühlt hast. Beides ist optional; tippe eine Auswahl erneut an, um sie zu entfernen.\n\nDiagramme (das Diagramm-Symbol) zeigt die Bewertung jedes Tages über den gewählten Zeitraum, mit schattierten Perioden, und welche Gefühle während und vor den Perioden auftraten. Wenn die Mondphasen in den Einstellungen eingeschaltet sind, ist auch der Mond zu sehen.\n\nDie Diagramme zeigen, was du eingetragen hast. Sie sagen nicht, was es bedeutet – das zu beurteilen ist deine Sache.';

  @override
  String get settingsHelpTemperatureTitle => 'Temperatur und Zervixschleim';

  @override
  String get settingsHelpTemperatureBody =>
      'Schalte in den Einstellungen „Temperatur und Zervixschleim erfassen“ ein, dann hat jeder Tag im Kalender Platz für deine Aufwachtemperatur und dafür, wie sich der Zervixschleim angefühlt hat und wie er aussah. Wenn etwas eine Messung verfälscht haben könnte – Krankheit, wenig Schlaf, Alkohol, spät gemessen –, setze das Häkchen darunter.\n\nDiagramme zeigt die Temperaturen als Linie, darunter den Zervixschleim, mit schattierten Perioden, in °C oder °F (Einstellungen).\n\nEbb hält diese Werte fest und zeichnet sie, mehr nicht. Es sucht keinen Anstieg und berechnet daraus keine fruchtbaren Tage, und die Schätzung des fruchtbaren Fensters beruht weiterhin allein auf dem zeitlichen Ablauf des Zyklus. Wenn du einer Methode wie der symptothermalen Methode folgst, kannst du das Diagramm nach ihren Regeln lesen.';

  @override
  String get settingsHelpRemindersTitle => 'Erinnerungen';

  @override
  String get settingsHelpRemindersBody =>
      'Eine Vorwarnung ein paar Tage, bevor deine Periode erwartet wird, und eine weitere am Tag selbst. Wie weit im Voraus, wählst du in den Einstellungen.\n\nSie werden auf dem Telefon selbst gestellt und kommen daher auch ohne Netz und im Flugmodus.\n\nEbb stellt sie bei jedem Öffnen neu, nach der neuesten Schätzung. Das Telefon behält sie auch nach einem Neustart, aber Ebb kann sie nicht aktualisieren, solange es geschlossen ist. Öffne es also ab und zu – eine Periode einzutragen reicht.\n\nAndroid stellt sie eventuell etwas später als üblich zu, um Akku zu sparen. Wenn Ebb zwangsweise beendet wird oder ein Energiesparmodus es einschränkt, kommen sie vielleicht erst, wenn du Ebb das nächste Mal öffnest.';

  @override
  String get settingsHelpFertileTitle => 'Das fruchtbare Fenster';

  @override
  String get settingsHelpFertileBody =>
      'Aus, solange du es nicht in den Einstellungen einschaltest. Es wird allein aus dem zeitlichen Ablauf des Zyklus geschätzt und ist nicht zuverlässig genug zur Verhütung.';

  @override
  String get settingsHelpBackupTitle => 'Sichern';

  @override
  String get settingsHelpBackupBody =>
      'Es gibt keine Kopie deines Verlaufs in der Cloud. Geht das Telefon verloren oder wird es zurückgesetzt, ist der Verlauf weg.\n\nEinstellungen → „In einer Datei sichern“ speichert alles als Datei, wo du möchtest. Bewahre sie woanders als auf diesem Telefon auf. „Aus einer Sicherung wiederherstellen“ holt alles zurück.';

  @override
  String get settingsHelpMovingTitle => 'Umzug auf ein neues Telefon';

  @override
  String get settingsHelpMovingBody =>
      'Auf dem alten Telefon: Einstellungen → „An ein anderes Telefon senden“. Auf dem neuen: Einstellungen → „Von einem anderen Telefon empfangen“, und richte die Kamera auf den Bildschirm.\n\nLängere Verläufe brauchen mehrere Codes, die von selbst wechseln; das neue Telefon sammelt sie in beliebiger Reihenfolge. Das Internet ist nicht im Spiel – ein Telefon zeigt, das andere schaut.';

  @override
  String get settingsHelpSomeoneElseTitle => 'Für jemand anderen eintragen';

  @override
  String get settingsHelpSomeoneElseBody =>
      'Du hilfst jemand anderem, den Überblick zu behalten – etwa einem Kind, das gerade die ersten Perioden hat? Einstellungen → „Auch für jemand anderen eintragen“, und gib der Person einen Namen. Ein Spitzname oder eine Initiale reicht.\n\nTippe oben auf dem Startbildschirm auf den Namen, um zwischen Personen zu wechseln. Jede Person hat eigene Erinnerungen; bei Personen, die du hinzufügst, sind sie zunächst aus. Das fruchtbare Fenster wird nur für dich angeboten.';

  @override
  String get settingsHelpHandoverTitle => 'Jemanden übergeben';

  @override
  String get settingsHelpHandoverBody =>
      'Wenn jemand, für den du einträgst, ein eigenes Telefon bekommt: „An ein anderes Telefon senden“, und wähle nur diese Person. Auf dem Telefon der Person: „Von einem anderen Telefon empfangen“. Bei einer frischen Installation wird der Verlauf einfach zu ihrem eigenen.\n\nDanach fragt Ebb, ob die Person von deinem Telefon entfernt werden soll. Von sich aus tut Ebb das nie.';

  @override
  String get settingsHelpDeletingTitle => 'Löschen';

  @override
  String get settingsHelpDeletingBody =>
      'Einstellungen → „Alle Daten löschen“ löscht alles auf diesem Telefon auf einmal.\n\nUm eine Person zu entfernen, die du hinzugefügt hast, öffne ihre Einstellungen und wähle „… von diesem Telefon entfernen“. Der Verlauf aller anderen bleibt unberührt.';

  @override
  String shareRemoveTitle(String name) {
    return '$name von diesem Telefon entfernen?';
  }

  @override
  String shareRemoveBody(String name) {
    return 'Wenn der Verlauf von $name auf dem anderen Telefon angekommen ist, kann er von diesem entfernt werden. Du kannst ihn aber auch hier behalten.';
  }

  @override
  String get shareKeep => 'Behalten';

  @override
  String shareRemoved(String name) {
    return 'Entfernt: $name.';
  }

  @override
  String get shareTitle => 'An ein anderes Telefon senden';

  @override
  String get shareWhatToSend => 'Was möchtest du senden?';

  @override
  String get shareEveryone => 'Alle';

  @override
  String get shareEveryoneHint => 'Umzug auf ein neues Telefon.';

  @override
  String get shareJustOne => 'Nur eine Person';

  @override
  String get shareJustYours => 'Nur dein Verlauf';

  @override
  String shareJustName(String name) {
    return 'Nur $name';
  }

  @override
  String shareForTheirPhone(String name) {
    return 'Für das eigene Telefon von $name.';
  }

  @override
  String get shareCopiesNotOffered =>
      'Personen, die von anderen Telefonen importiert wurden, werden hier nicht angeboten: Jede Person teilt nur ihren eigenen Verlauf.';

  @override
  String shareHowMuch(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Wie viel von deinem Verlauf?',
      'other': 'Wie viel vom Verlauf von $name?',
    });
    return '$_temp0';
  }

  @override
  String get shareHowMuchHint =>
      'Für ein neues Telefon passt es, alles zu senden. Für eine Gruppe sendest du vielleicht weniger. Von diesem Telefon wird nichts entfernt.';

  @override
  String get shareHowFarBack => 'Wie weit zurück';

  @override
  String get shareSpanEverything => 'Alles';

  @override
  String get shareSpanYear => 'Die letzten 12 Monate';

  @override
  String shareSpanMonths(int months) {
    String _temp0 = intl.Intl.pluralLogic(
      months,
      locale: localeName,
      other: 'Die letzten $months Monate',
      one: 'Der letzte Monat',
    );
    return '$_temp0';
  }

  @override
  String get shareSpanLatest => 'Nur die letzte Periode';

  @override
  String get shareWhatToInclude => 'Was enthalten sein soll';

  @override
  String get shareWithDays => 'Perioden und tägliche Einträge';

  @override
  String get shareWithDaysHint =>
      'Auch Notizen, Bewertungen, Gefühle und Blutung.';

  @override
  String get sharePeriodsOnly => 'Nur Perioden';

  @override
  String get sharePeriodsOnlyHint =>
      'Nur, wann jede Periode angefangen und aufgehört hat.';

  @override
  String get shareShowCodes => 'Codes anzeigen';

  @override
  String get shareNothing => 'Noch nichts zu senden.';

  @override
  String get shareHowToReceive =>
      'Öffne auf dem anderen Telefon Ebb, geh zu Einstellungen → Von einem anderen Telefon empfangen und richte die Kamera auf diesen Bildschirm.';

  @override
  String shareCodeOf(int index, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      total,
      locale: localeName,
      other: 'Code $index von $total',
    );
    return '$_temp0';
  }

  @override
  String get sharePreviousCode => 'Vorheriger Code';

  @override
  String get sharePause => 'Pause';

  @override
  String get sharePlay => 'Abspielen';

  @override
  String get shareNextCode => 'Nächster Code';

  @override
  String get shareCodesChange =>
      'Die Codes wechseln von selbst. Das andere Telefon sammelt sie in beliebiger Reihenfolge.';

  @override
  String sharePeriodCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Perioden',
      one: '$count Periode',
    );
    return '$_temp0';
  }

  @override
  String shareSummaryEverything(String periods) {
    return 'Alles in Ebb: $periods.';
  }

  @override
  String shareSummaryEverythingPeople(String periods, int people) {
    String _temp0 = intl.Intl.pluralLogic(
      people,
      locale: localeName,
      other: 'Alles in Ebb: $periods für $people Personen.',
    );
    return '$_temp0';
  }

  @override
  String shareSummaryHistoryAll(String who, String name, String periods) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Dein Verlauf: $periods.',
      'other': 'Verlauf von $name: $periods.',
    });
    return '$_temp0';
  }

  @override
  String shareSummaryHistoryLatest(String who, String name, String periods) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Dein Verlauf, nur die letzte Periode: $periods.',
      'other': 'Verlauf von $name, nur die letzte Periode: $periods.',
    });
    return '$_temp0';
  }

  @override
  String shareSummaryHistoryYear(String who, String name, String periods) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Dein Verlauf aus den letzten 12 Monaten: $periods.',
      'other': 'Verlauf von $name aus den letzten 12 Monaten: $periods.',
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
      'you': 'Dein Verlauf aus den letzten $months Monaten: $periods.',
      'other': 'Verlauf von $name aus den letzten $months Monaten: $periods.',
    });
    return '$_temp0';
  }

  @override
  String shareSummaryPeriodsAll(String who, String name, String periods) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Deine Perioden: $periods.',
      'other': 'Perioden von $name: $periods.',
    });
    return '$_temp0';
  }

  @override
  String shareSummaryPeriodsLatest(String who, String name, String periods) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Deine Perioden, nur die letzte Periode: $periods.',
      'other': 'Perioden von $name, nur die letzte Periode: $periods.',
    });
    return '$_temp0';
  }

  @override
  String shareSummaryPeriodsYear(String who, String name, String periods) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Deine Perioden aus den letzten 12 Monaten: $periods.',
      'other': 'Perioden von $name aus den letzten 12 Monaten: $periods.',
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
      'you': 'Deine Perioden aus den letzten $months Monaten: $periods.',
      'other': 'Perioden von $name aus den letzten $months Monaten: $periods.',
    });
    return '$_temp0';
  }

  @override
  String get shareNotEbb => 'Dieser Code stammt nicht von Ebb.';

  @override
  String get shareNewerVersion =>
      'Das andere Telefon hat eine neuere Version von Ebb. Aktualisiere zuerst dieses hier.';

  @override
  String get shareRestarted =>
      'Das andere Telefon hat neu angefangen. Die neuen Codes werden gesammelt.';

  @override
  String get shareUnreadable =>
      'Einige Codes wurden nicht sauber gelesen. Scannen wir sie noch einmal.';

  @override
  String get shareNeedsCamera =>
      'Ebb braucht die Kamera, um die Codes zu lesen. Du kannst sie in den Systemeinstellungen für Ebb erlauben.';

  @override
  String get sharePointCamera =>
      'Richte die Kamera auf den Code auf dem anderen Telefon.';

  @override
  String get shareReading => 'Wird gelesen…';

  @override
  String shareCodesReceived(int received, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      total,
      locale: localeName,
      other: '$received von $total Codes empfangen',
    );
    return '$_temp0';
  }

  @override
  String get shareReceiveTitle => 'Von einem anderen Telefon empfangen';

  @override
  String shareStillNeeded(String codes) {
    return 'Noch benötigt: $codes';
  }

  @override
  String get groupsMoreThanOne => 'Das ist mehr als eine Person';

  @override
  String get groupsMoreThanOneBody =>
      'Diese Codes enthalten den Verlauf eines ganzen Telefons. Um einer Gruppe beizutreten, sendet jede Person nur den eigenen: auf dem eigenen Telefon Einstellungen → An ein anderes Telefon senden → Nur dein Verlauf.';

  @override
  String groupsUpdateTitle(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Deinen Verlauf aktualisieren?',
      'other': '$name aktualisieren?',
    });
    return '$_temp0';
  }

  @override
  String groupsUpdateAction(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Deinen Verlauf aktualisieren',
      'other': '$name aktualisieren',
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
          'Das ist wieder dein Verlauf, gesendet am $sent: $periods. Er ersetzt die Kopie auf diesem Telefon.',
      'other':
          'Das ist wieder der Verlauf von $name, gesendet am $sent: $periods. Er ersetzt die Kopie auf diesem Telefon.',
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
          'Das ist dein Verlauf, gesendet am $sent: $periods. Er ersetzt, was auf diesem Telefon für dich gespeichert ist, auch alles, was seitdem hier eingetragen wurde.',
      'other':
          'Das ist der Verlauf von $name, gesendet am $sent: $periods. Er ersetzt, was auf diesem Telefon für $name gespeichert ist, auch alles, was seitdem hier eingetragen wurde.',
    });
    return '$_temp0';
  }

  @override
  String groupsUpdated(String name) {
    return 'Aktualisiert: $name.';
  }

  @override
  String groupsImportInto(String group) {
    return 'In $group importieren';
  }

  @override
  String groupsImportHint(String periods, String sent) {
    return '$periods, gesendet am $sent. Schreibgeschützt importiert: Hier lässt sich nichts ändern; aktualisiert wird es, wenn es erneut gesendet wird.';
  }

  @override
  String groupsImported(String name, String group) {
    return '$name in $group importiert.';
  }

  @override
  String get groupsGroup => 'Gruppe';

  @override
  String get groupsNoMembers =>
      'Noch niemand in dieser Gruppe. Füge Personen unter Einstellungen → Erweitert → Gruppen verwalten hinzu: Hake Personen an, die schon auf diesem Telefon sind, oder füge jemanden vom Telefon der Person hinzu.';

  @override
  String get groupsPeriods => 'Perioden';

  @override
  String get groupsChartHint =>
      'Jeder Balken ist eine Periode; ein Umriss ist eine, deren Ende nicht eingetragen wurde, in der üblichen Länge gezeichnet. Durchgezogene Linien laufen von jedem Vollmond nach unten, gestrichelte von jedem Neumond.';

  @override
  String get groupsNew => 'Neue Gruppe';

  @override
  String get groupsRename => 'Gruppe umbenennen';

  @override
  String get groupsNameHint =>
      'Zum Beispiel der Name deines Kreises oder Clubs.';

  @override
  String get groupsNameTaken => 'Es gibt schon eine Gruppe mit diesem Namen.';

  @override
  String get groupsNoOneYet => 'Noch niemand';

  @override
  String get groupsTitle => 'Gruppen';

  @override
  String get groupsIntro =>
      'Eine Gruppe fasst Personen auf diesem Telefon unter einem Namen zusammen – ein Kreis oder Club, der gemeinsam den Zyklus verfolgt. Eine Person kann in mehreren Gruppen sein, und das Löschen einer Gruppe löscht nie eine Person.';

  @override
  String groupsAddSomeoneTo(String group) {
    return 'Jemanden zu $group hinzufügen';
  }

  @override
  String get groupsAddSomeoneHint =>
      'Auf diesem Telefon geführt: Du trägst den Verlauf der Person hier ein und änderst ihn hier. Wer auf dem eigenen Telefon einträgt, kann stattdessen importiert werden.';

  @override
  String groupsTakeOutTitle(String name, String group) {
    return '$name aus $group herausnehmen?';
  }

  @override
  String groupsTakeOutBody(String name) {
    return '$name wurde vom eigenen Telefon importiert und ist in keiner anderen Gruppe, daher wird der importierte Verlauf auch von diesem Telefon entfernt. $name kann ihn erneut senden, um wieder beizutreten.';
  }

  @override
  String get groupsTakeOut => 'Herausnehmen';

  @override
  String groupsDeleteTitle(String group) {
    return '$group löschen?';
  }

  @override
  String get groupsDeleteBodyNone =>
      'Nur die Gruppe wird gelöscht. Alle darin bleiben mit ihrem gesamten Verlauf auf diesem Telefon.';

  @override
  String groupsDeleteBodySome(String names) {
    return 'Personen, die nur in diese Gruppe importiert wurden, werden auch von diesem Telefon entfernt: $names. Alle anderen bleiben, mit ihrem gesamten Verlauf.';
  }

  @override
  String get groupsDeleteGroup => 'Gruppe löschen';

  @override
  String get groupsRenameTooltip => 'Umbenennen';

  @override
  String get groupsWhoIsIn => 'Wer dazugehört';

  @override
  String groupsImportedAsOf(String date) {
    return 'Importiert · schreibgeschützt, Stand: $date';
  }

  @override
  String get groupsTrackedHere => 'Auf diesem Telefon geführt';

  @override
  String get groupsAddTo => 'Zur Gruppe hinzufügen';

  @override
  String get groupsAddNew => 'Neue Person hinzufügen';

  @override
  String get groupsAddNewHint =>
      'Auf diesem Telefon geführt: Du trägst die Perioden der Person hier ein.';

  @override
  String get groupsImportFromPhone => 'Vom Telefon der Person importieren';

  @override
  String get groupsImportFromPhoneHint =>
      'Die Person trägt weiter auf dem eigenen Telefon ein und sendet den Verlauf hierher, schreibgeschützt. Ein erneuter Import bringt ihn auf den neuesten Stand.';

  @override
  String get groupsDeleteThis => 'Diese Gruppe löschen';

  @override
  String get peopleNameTaken =>
      'Dieser Name wird auf diesem Telefon schon verwendet.';

  @override
  String get peopleName => 'Name';

  @override
  String peopleSeeTogether(String group) {
    return '$group gemeinsam ansehen';
  }

  @override
  String get peopleNotInGroup => 'In keiner Gruppe';

  @override
  String get peopleAddSomeone => 'Person hinzufügen';

  @override
  String get peopleTrackSomeoneElse => 'Für jemand anderen eintragen';

  @override
  String get peopleNameHint =>
      'Nur etwas, um Personen zu unterscheiden – ein Vorname, ein Spitzname oder eine Initiale.';

  @override
  String backupUnnamedPerson(int number) {
    return 'Person $number';
  }

  @override
  String get backupNotEbb => 'Diese Datei ist keine Ebb-Sicherung.';

  @override
  String get backupNewer =>
      'Diese Sicherung stammt aus einer neueren Version von Ebb. Aktualisiere Ebb und versuche es dann noch einmal.';

  @override
  String get backupNoOne => 'In dieser Sicherung ist niemand enthalten.';

  @override
  String get backupSameId =>
      'Diese Sicherung scheint beschädigt zu sein: Zwei Personen darin haben dieselbe ID.';

  @override
  String backupAfterExport(String date) {
    return '$date liegt nach dem Tag, an dem diese Sicherung erstellt wurde.';
  }

  @override
  String backupSameName(String name) {
    return 'Zwei Personen in dieser Sicherung heißen beide $name.';
  }

  @override
  String backupSameGroupName(String group) {
    return 'Zwei Gruppen in dieser Sicherung heißen beide $group.';
  }

  @override
  String backupEndsBefore(String date) {
    return 'Die Periode ab $date endet, bevor sie anfängt.';
  }

  @override
  String backupTwoStarts(String date) {
    return 'Zwei Perioden derselben Person fangen am $date an.';
  }

  @override
  String backupDayTwice(String date) {
    return '$date kommt für dieselbe Person zweimal vor.';
  }

  @override
  String backupOverlaps(String date) {
    return 'Die Periode ab $date überschneidet sich mit der davor.';
  }

  @override
  String get backupDamaged =>
      'Diese Sicherung scheint beschädigt zu sein: Die Sicherung konnte nicht gelesen werden.';

  @override
  String get backupDamagedExportDate =>
      'Diese Sicherung scheint beschädigt zu sein: Das Exportdatum konnte nicht gelesen werden.';

  @override
  String get backupDamagedGroup =>
      'Diese Sicherung scheint beschädigt zu sein: Eine Gruppe konnte nicht gelesen werden.';

  @override
  String get backupDamagedGroupName =>
      'Diese Sicherung scheint beschädigt zu sein: Der Name einer Gruppe konnte nicht gelesen werden.';

  @override
  String backupDamagedGroupPeople(String group) {
    return 'Diese Sicherung scheint beschädigt zu sein: Die Personen in der Gruppe $group konnten nicht gelesen werden.';
  }

  @override
  String get backupDamagedPerson =>
      'Diese Sicherung scheint beschädigt zu sein: Ein Personeneintrag konnte nicht gelesen werden.';

  @override
  String get backupDamagedName =>
      'Diese Sicherung scheint beschädigt zu sein: Ein Name konnte nicht gelesen werden.';

  @override
  String get backupDamagedPersonId =>
      'Diese Sicherung scheint beschädigt zu sein: Die ID einer Person konnte nicht gelesen werden.';

  @override
  String get backupDamagedSharedOn =>
      'Diese Sicherung scheint beschädigt zu sein: Der Tag, an dem ein Verlauf geteilt wurde, konnte nicht gelesen werden.';

  @override
  String get backupDamagedPeriod =>
      'Diese Sicherung scheint beschädigt zu sein: Ein Periodeneintrag konnte nicht gelesen werden.';

  @override
  String get backupDamagedPeriodStart =>
      'Diese Sicherung scheint beschädigt zu sein: Ein Periodenbeginn konnte nicht gelesen werden.';

  @override
  String get backupDamagedPeriodEnd =>
      'Diese Sicherung scheint beschädigt zu sein: Ein Periodenende konnte nicht gelesen werden.';

  @override
  String get backupDamagedDay =>
      'Diese Sicherung scheint beschädigt zu sein: Ein Tageseintrag konnte nicht gelesen werden.';

  @override
  String backupDamagedFlow(String date) {
    return 'Diese Sicherung scheint beschädigt zu sein: Die Blutung am $date konnte nicht gelesen werden.';
  }

  @override
  String backupDamagedSymptom(String date) {
    return 'Diese Sicherung scheint beschädigt zu sein: Ein Symptom am $date konnte nicht gelesen werden.';
  }

  @override
  String backupDamagedRating(String date) {
    return 'Diese Sicherung scheint beschädigt zu sein: Die Bewertung am $date konnte nicht gelesen werden.';
  }

  @override
  String backupDamagedFeeling(String date) {
    return 'Diese Sicherung scheint beschädigt zu sein: Das Gefühl am $date konnte nicht gelesen werden.';
  }

  @override
  String backupDamagedTemperature(String date) {
    return 'Diese Sicherung scheint beschädigt zu sein: Die Temperatur am $date konnte nicht gelesen werden.';
  }

  @override
  String backupDamagedMucus(String date) {
    return 'Diese Sicherung scheint beschädigt zu sein: Der Zervixschleim am $date konnte nicht gelesen werden.';
  }
}
