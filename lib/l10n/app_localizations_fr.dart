// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get you => 'Vous';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Annuler';

  @override
  String get save => 'Enregistrer';

  @override
  String get delete => 'Supprimer';

  @override
  String get remove => 'Retirer';

  @override
  String get close => 'Fermer';

  @override
  String get done => 'Terminé';

  @override
  String get back => 'Retour';

  @override
  String get next => 'Suivant';

  @override
  String get edit => 'Modifier';

  @override
  String get add => 'Ajouter';

  @override
  String get continueAction => 'Continuer';

  @override
  String get language => 'Langue';

  @override
  String get languagePhone => 'Comme le téléphone';

  @override
  String languagePhoneIs(String language) {
    return 'Comme le téléphone ($language)';
  }

  @override
  String get notifChannelName => 'Rappels de cycle';

  @override
  String get notifChannelDescription =>
      'Un avis avant la date prévue de vos règles, et un petit rappel pour les enregistrer.';

  @override
  String notifUpcomingTitle(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Règles prévues bientôt',
      'other': '$name : règles prévues bientôt',
    });
    return '$_temp0';
  }

  @override
  String notifUpcomingTomorrow(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'D’après Ebb, vos règles devraient commencer demain.',
      'other': 'D’après Ebb, les règles de $name devraient commencer demain.',
    });
    return '$_temp0';
  }

  @override
  String notifUpcomingInDays(String who, String name, int days) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'D’après Ebb, vos règles sont prévues dans environ $days jours.',
      'other':
          'D’après Ebb, les règles de $name sont prévues dans environ $days jours.',
    });
    return '$_temp0';
  }

  @override
  String notifTodayTitle(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Règles prévues aujourd’hui',
      'other': '$name : règles prévues aujourd’hui',
    });
    return '$_temp0';
  }

  @override
  String get notifTodayBody => 'Touchez pour noter comment ça se passe.';

  @override
  String get calendarTitle => 'Calendrier';

  @override
  String get calendarCellToday => 'aujourd’hui';

  @override
  String get calendarCellPeriod => 'règles';

  @override
  String get calendarCellPeriodUnlogged => 'règles, fin non enregistrée';

  @override
  String get calendarCellLikely => 'prochaines règles probables';

  @override
  String get calendarCellFertile => 'fenêtre de fertilité estimée';

  @override
  String calendarCellMoon(String phase) {
    String _temp0 = intl.Intl.selectLogic(phase, {
      'newMoon': 'nouvelle lune',
      'firstQuarter': 'premier quartier',
      'full': 'pleine lune',
      'other': 'dernier quartier',
    });
    return '$_temp0';
  }

  @override
  String calendarCellRated(int rating) {
    return 'note $rating';
  }

  @override
  String calendarCellFelt(String feeling) {
    return 'ressenti : $feeling';
  }

  @override
  String get calendarCellNote => 'avec une note';

  @override
  String get calendarKeyPeriod => 'Règles';

  @override
  String get calendarKeyEndNotLogged => 'Fin non enregistrée';

  @override
  String get calendarKeyLikely => 'Début probable';

  @override
  String get calendarKeyFertile => 'Fertilité (estimation)';

  @override
  String get calendarKeyToday => 'Aujourd’hui';

  @override
  String calendarStatusWindow(String who, String name, String from, String to) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you':
          'Vos prochaines règles devraient probablement commencer entre le $from et le $to.',
      'other':
          'Les prochaines règles de $name devraient probablement commencer entre le $from et le $to.',
    });
    return '$_temp0';
  }

  @override
  String calendarStatusPeriodDay(String who, String name, int day) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Jour $day de vos règles.',
      'other': 'Jour $day des règles de $name.',
    });
    return '$_temp0';
  }

  @override
  String calendarStatusPeriodDayExcluded(String who, String name, int day) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you':
          'Jour $day de vos règles, dans un cycle non compté dans les prévisions.',
      'other':
          'Jour $day des règles de $name, dans un cycle non compté dans les prévisions.',
    });
    return '$_temp0';
  }

  @override
  String calendarStatusUnlogged(String who, String name, int day) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you':
          'Jour $day de votre cycle. La fin de ces règles n’a pas été enregistrée : elles sont donc affichées avec la durée habituelle.',
      'other':
          'Jour $day du cycle de $name. La fin de ces règles n’a pas été enregistrée : elles sont donc affichées avec la durée habituelle.',
    });
    return '$_temp0';
  }

  @override
  String get calendarStatusFertile =>
      'Dans la fenêtre de fertilité estimée. Pas assez fiable pour servir de contraception.';

  @override
  String calendarStatusCycleDay(String who, String name, int day) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Jour $day de votre cycle.',
      'other': 'Jour $day du cycle de $name.',
    });
    return '$_temp0';
  }

  @override
  String calendarDayToday(String date) {
    return 'Aujourd’hui, $date';
  }

  @override
  String get calendarPreviousDay => 'Jour précédent';

  @override
  String get calendarNextDay => 'Jour suivant';

  @override
  String calendarMoonAt(String phase, String time) {
    return '$phase, $time';
  }

  @override
  String get calendarFutureDay =>
      'Les jours à venir ne peuvent pas encore être enregistrés.';

  @override
  String calendarMarkStarted(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Indiquer que vos règles ont commencé ce jour-là',
      'other': 'Indiquer que les règles de $name ont commencé ce jour-là',
    });
    return '$_temp0';
  }

  @override
  String get calendarMoveStart => 'Faire de ce jour le premier jour des règles';

  @override
  String calendarMoveStartFrom(String date) {
    return 'Déplace leur début, actuellement le $date';
  }

  @override
  String calendarMarkEnded(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Indiquer que vos règles se sont terminées ce jour-là',
      'other': 'Indiquer que les règles de $name se sont terminées ce jour-là',
    });
    return '$_temp0';
  }

  @override
  String get calendarMakeLastDay =>
      'Faire de ce jour le dernier jour des règles';

  @override
  String get calendarEditPeriod => 'Modifier ces règles';

  @override
  String calendarRateDay(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Notez votre journée, de 1 à 5',
      'other': 'Notez la journée de $name, de 1 à 5',
    });
    return '$_temp0';
  }

  @override
  String calendarHowFelt(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Comment vous sentiez-vous ?',
      'other': 'Comment se sentait $name ?',
    });
    return '$_temp0';
  }

  @override
  String get calendarFlow => 'Flux';

  @override
  String get calendarNote => 'Note';

  @override
  String calendarTemperatureHeading(String unit) {
    return 'Température, $unit';
  }

  @override
  String calendarTemperatureRange(String low, String high, String unit) {
    return 'Saisissez une température entre $low et $high $unit';
  }

  @override
  String get calendarTemperatureHelper => 'Au réveil, avant de se lever';

  @override
  String get calendarTemperatureAffected => 'Quelque chose a pu la fausser';

  @override
  String get calendarTemperatureAffectedHint =>
      'Maladie, manque de sommeil, alcool, prise tardive';

  @override
  String get calendarMucus => 'Glaire cervicale';

  @override
  String get calendarMucusFelt => 'Sensation';

  @override
  String get calendarMucusLooked => 'Aspect';

  @override
  String calendarLoggedRated(int rating, String ratingName) {
    return 'Noté $rating sur 5, $ratingName';
  }

  @override
  String calendarLoggedFelt(String emoji, String feeling) {
    return 'Ressenti : $emoji $feeling';
  }

  @override
  String calendarLoggedFlow(String flow) {
    String _temp0 = intl.Intl.selectLogic(flow, {
      'spotting': 'Flux : spotting',
      'light': 'Flux : léger',
      'medium': 'Flux : moyen',
      'other': 'Flux : abondant',
    });
    return '$_temp0';
  }

  @override
  String calendarLoggedTemperature(String temperature) {
    return 'Température : $temperature';
  }

  @override
  String calendarLoggedTemperatureAffected(String temperature) {
    return 'Température : $temperature, peut-être faussée';
  }

  @override
  String calendarLoggedMucus(String mucus) {
    return 'Glaire cervicale : $mucus';
  }

  @override
  String calendarLoggedNote(String note) {
    return '« $note »';
  }

  @override
  String get calendarNothingLogged => 'Rien d’enregistré ce jour-là.';

  @override
  String get calendarMoonNew => 'Nouvelle lune';

  @override
  String get calendarMoonFirstQuarter => 'Premier quartier';

  @override
  String get calendarMoonFull => 'Pleine lune';

  @override
  String get calendarMoonLastQuarter => 'Dernier quartier';

  @override
  String get dayFlowNone => 'Aucun';

  @override
  String get dayFlowSpotting => 'Spotting';

  @override
  String get dayFlowLight => 'Léger';

  @override
  String get dayFlowMedium => 'Moyen';

  @override
  String get dayFlowHeavy => 'Abondant';

  @override
  String get dayMucusNothing => 'Rien';

  @override
  String get dayMucusFeelDry => 'Sèche';

  @override
  String get dayMucusFeelWet => 'Humide';

  @override
  String get dayMucusFeelSlippery => 'Glissante';

  @override
  String get dayMucusLookCreamy => 'Crémeuse';

  @override
  String get dayMucusLookEggWhite => 'Blanc d’œuf';

  @override
  String dayMucusFeelInline(String feel) {
    String _temp0 = intl.Intl.selectLogic(feel, {
      'dry': 'sèche',
      'nothing': 'rien ressenti',
      'wet': 'humide',
      'other': 'glissante',
    });
    return '$_temp0';
  }

  @override
  String dayMucusLookInline(String look) {
    String _temp0 = intl.Intl.selectLogic(look, {
      'nothing': 'rien vu',
      'creamy': 'crémeuse',
      'other': 'blanc d’œuf',
    });
    return '$_temp0';
  }

  @override
  String get dayFeelingHappy => 'Joie';

  @override
  String get dayFeelingCalm => 'Calme';

  @override
  String get dayFeelingLoving => 'Tendresse';

  @override
  String get dayFeelingEnergetic => 'Énergie';

  @override
  String get dayFeelingTired => 'Fatigue';

  @override
  String get dayFeelingSad => 'Tristesse';

  @override
  String get dayFeelingAnxious => 'Anxiété';

  @override
  String get dayFeelingIrritable => 'Irritabilité';

  @override
  String get dayFeelingAngry => 'Colère';

  @override
  String get dayFeelingConfused => 'Confusion';

  @override
  String get chartsTitle => 'Graphiques';

  @override
  String get chartsDayRating => 'Note du jour';

  @override
  String get chartsNoRatings =>
      'Aucun jour de cette période n’a encore de note.';

  @override
  String get chartsBars => 'Barres';

  @override
  String get chartsLine => 'Courbe';

  @override
  String get chartsRatingCaptionBars =>
      'Chaque barre est la note d’un jour, de 1 à 5. Les jours de règles sont ombrés.';

  @override
  String get chartsRatingCaptionLine =>
      'Chaque point est la note d’un jour, de 1 à 5, relié à celui du lendemain quand les deux jours sont notés. Les jours de règles sont ombrés.';

  @override
  String get chartsRatingCaptionMoon =>
      'Les lunes indiquent les phases de la lune ; sur une longue période, seulement les nouvelles et pleines lunes, ou seulement les pleines lunes.';

  @override
  String get chartsTemperatureTitle => 'Température et glaire cervicale';

  @override
  String get chartsTemperatureEmpty =>
      'Rien d’enregistré sur cette période pour l’instant. Touchez un jour du calendrier pour ajouter une température ou la glaire cervicale.';

  @override
  String chartsTemperatureCaption(String unit) {
    return 'Chaque point est la température d’un jour, en $unit, relié à celui du lendemain quand les deux ont été prises. Un point creux a peut-être été faussé, et n’est pas relié. En dessous, la glaire cervicale : plus la barre est haute, plus elle est humide (Senti) et plus elle est claire et filante (Vu). Les jours de règles sont ombrés.';
  }

  @override
  String get chartsFeelings => 'Ressentis';

  @override
  String get chartsAroundPeriods => 'Autour des règles';

  @override
  String get chartsAroundMoon => 'Autour de la lune';

  @override
  String get chartsFeelingsEmptyMoon =>
      'Quand vous aurez indiqué votre ressenti sur quelques jours de cette période, vous verrez ici quels ressentis sont apparus autour des pleines et nouvelles lunes.';

  @override
  String get chartsFeelingsEmptyPeriods =>
      'Quand vous aurez indiqué votre ressenti sur quelques jours de cette période, et que des règles auront commencé depuis, vous verrez ici quels ressentis sont apparus à quel moment.';

  @override
  String get chartsFeelingsCaptionMoon =>
      'Nombre de jours où chaque visage a été choisi.';

  @override
  String get chartsFeelingsCaptionPeriods =>
      'Nombre de jours où chaque visage a été choisi. Les jours depuis le début des dernières règles ne sont comptés qu’une fois les suivantes commencées.';

  @override
  String get chartsNoneYet => 'Aucun pour l’instant.';

  @override
  String get chartsGroupDuringPeriod => 'Pendant les règles';

  @override
  String get chartsGroupBeforePeriod => 'Juste avant les règles';

  @override
  String get chartsGroupOtherDays => 'Autres jours';

  @override
  String get chartsGroupFullMoon => 'Autour d’une pleine lune';

  @override
  String get chartsGroupNewMoon => 'Autour d’une nouvelle lune';

  @override
  String get chartsDetailLoggedPeriodDays => 'jours de règles enregistrés';

  @override
  String chartsDetailUsuallyDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days jours en général',
      one: '1 jour en général',
      zero: '$days jours en général',
    );
    return '$_temp0';
  }

  @override
  String chartsDetailDaysBefore(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'les $days jours précédents',
      one: 'la veille',
      zero: 'les $days jours précédents',
    );
    return '$_temp0';
  }

  @override
  String get chartsDetailRestOfCycle => 'le reste du cycle';

  @override
  String get chartsDetailDayItself => 'le jour même';

  @override
  String chartsDetailDayEitherSide(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'le jour même, ±$days jours',
      one: 'le jour même, ±1 jour',
      zero: 'le jour même, ±$days jours',
    );
    return '$_temp0';
  }

  @override
  String get chartsDetailRestOfMonth => 'le reste du mois';

  @override
  String chartsFeelingCount(String feeling, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count jours',
      one: '1 jour',
    );
    return '$feeling sur $_temp0';
  }

  @override
  String chartsFeelingGroupSummary(String group, String detail, String counts) {
    return '$group, $detail : $counts';
  }

  @override
  String get chartsFeelingGroupNone => 'aucun pour l’instant';

  @override
  String chartsRatingSummary(String from, String to, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count jours notés',
      one: '1 jour noté',
    );
    return 'Notes des jours du $from au $to : $_temp0, jours de règles ombrés.';
  }

  @override
  String chartsRatingSummaryMoons(String from, String to, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count jours notés',
      one: '1 jour noté',
    );
    return 'Notes des jours du $from au $to : $_temp0, jours de règles ombrés et phases de la lune indiquées.';
  }

  @override
  String chartsLanesSummary(String from, String to, String lanes) {
    return 'Règles du $from au $to. $lanes.';
  }

  @override
  String chartsLane(String name, String periods) {
    return '$name : $periods';
  }

  @override
  String get chartsLaneNone => 'aucun jour de règles';

  @override
  String chartsLaneRun(String from, String to) {
    return 'du $from au $to';
  }

  @override
  String chartsLaneRunEstimated(String from, String to) {
    return 'du $from au $to, estimées';
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
      other: '$mucusDays jours',
      one: '1 jour',
    );
    return 'Températures du $from au $to : $range, glaire cervicale notée sur $_temp0, jours de règles ombrés.';
  }

  @override
  String get chartsNoTemperatures => 'aucune température';

  @override
  String chartsTemperatureRange(int count, String low, String high) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count températures',
      one: '1 température',
      zero: '$count températures',
    );
    return '$_temp0, de $low à $high';
  }

  @override
  String get chartsMucusFelt => 'Senti';

  @override
  String get chartsMucusLooked => 'Vu';

  @override
  String get faceRatingRough => 'Difficile';

  @override
  String get faceRatingNotGreat => 'Pas terrible';

  @override
  String get faceRatingOkay => 'Ça va';

  @override
  String get faceRatingGood => 'Bien';

  @override
  String get faceRatingGreat => 'Super';

  @override
  String get faceRatingRoughInline => 'difficile';

  @override
  String get faceRatingNotGreatInline => 'pas terrible';

  @override
  String get faceRatingOkayInline => 'ça va';

  @override
  String get faceRatingGoodInline => 'bien';

  @override
  String get faceRatingGreatInline => 'super';

  @override
  String faceRatingOption(int rating, String name) {
    return '$rating, $name';
  }

  @override
  String get faceMoreFaces => 'Plus de visages';

  @override
  String get faceDifferentFace => 'Un autre visage';

  @override
  String get faceOther => 'Autre visage';

  @override
  String get faceSmilingCat => 'Chat souriant';

  @override
  String get faceGrinningCat => 'Chat au grand sourire';

  @override
  String get faceCatTearsOfJoy => 'Chat qui pleure de joie';

  @override
  String get faceCatHeartEyes => 'Chat aux yeux en cœur';

  @override
  String get faceSmirkingCat => 'Chat au sourire en coin';

  @override
  String get faceKissingCat => 'Chat qui fait un bisou';

  @override
  String get faceWearyCat => 'Chat épuisé';

  @override
  String get faceCryingCat => 'Chat qui pleure';

  @override
  String get facePoutingCat => 'Chat boudeur';

  @override
  String get faceAlien => 'Extraterrestre';

  @override
  String get faceSpaceInvader => 'Monstre de l’espace';

  @override
  String get faceRobot => 'Robot';

  @override
  String get faceGhost => 'Fantôme';

  @override
  String get faceSkull => 'Tête de mort';

  @override
  String get faceClown => 'Clown';

  @override
  String get faceDevil => 'Diablotin';

  @override
  String get faceUnicorn => 'Licorne';

  @override
  String get faceFrog => 'Grenouille';

  @override
  String get facePartying => 'Fête';

  @override
  String get faceCool => 'Cool';

  @override
  String get faceNerdy => 'Intello';

  @override
  String get faceAngelic => 'Ange';

  @override
  String get faceHugging => 'Câlin';

  @override
  String get faceSilly => 'Loufoque';

  @override
  String get faceUpsideDown => 'À l’envers';

  @override
  String get faceSmirking => 'Sourire en coin';

  @override
  String get faceGrimacing => 'Grimace';

  @override
  String get faceEyeRoll => 'Yeux au ciel';

  @override
  String get faceSpeechless => 'Sans voix';

  @override
  String get facePleading => 'Yeux suppliants';

  @override
  String get faceSobbing => 'Sanglots';

  @override
  String get faceScreaming => 'Cri d’effroi';

  @override
  String get faceFlushed => 'Joues rouges';

  @override
  String get faceOverwhelmed => 'Tête qui explose';

  @override
  String get faceWoozy => 'Tête qui tourne';

  @override
  String get faceUnwell => 'Malade';

  @override
  String get faceHurting => 'Douleur';

  @override
  String get faceQueasy => 'Nausée';

  @override
  String get faceTooHot => 'Trop chaud';

  @override
  String get faceTooCold => 'Trop froid';

  @override
  String get faceSparklingHeart => 'Cœur scintillant';

  @override
  String get faceBrokenHeart => 'Cœur brisé';

  @override
  String get faceFire => 'Feu';

  @override
  String get faceRainbow => 'Arc-en-ciel';

  @override
  String get faceSun => 'Soleil';

  @override
  String get faceRain => 'Pluie';

  @override
  String get faceStorm => 'Orage';

  @override
  String get faceBlossom => 'Fleur';

  @override
  String get faceChocolate => 'Chocolat';

  @override
  String get faceInBed => 'Au lit';

  @override
  String get homeCalendar => 'Calendrier';

  @override
  String get homeHistory => 'Historique';

  @override
  String get homeCharts => 'Graphiques';

  @override
  String get homeSettings => 'Paramètres';

  @override
  String homeCalendarOf(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Votre calendrier',
      'other': 'Calendrier de $name',
    });
    return '$_temp0';
  }

  @override
  String homeHistoryOf(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Votre historique',
      'other': 'Historique de $name',
    });
    return '$_temp0';
  }

  @override
  String homeChartsOf(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Vos graphiques',
      'other': 'Graphiques de $name',
    });
    return '$_temp0';
  }

  @override
  String get homeWhenStarted => 'Quand ont-elles commencé ?';

  @override
  String get homeWhenEnded => 'Quand se sont-elles terminées ?';

  @override
  String homePeriodEndedToday(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Mes règles se sont terminées aujourd’hui',
      'other': 'Les règles de $name se sont terminées aujourd’hui',
    });
    return '$_temp0';
  }

  @override
  String homePeriodStartedToday(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Mes règles ont commencé aujourd’hui',
      'other': 'Les règles de $name ont commencé aujourd’hui',
    });
    return '$_temp0';
  }

  @override
  String get homeEndedEarlier => 'Elles se sont terminées avant aujourd’hui';

  @override
  String get homeStartedEarlier => 'Elles ont commencé avant aujourd’hui';

  @override
  String homeAddLastEnd(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Indiquer la fin de vos dernières règles',
      'other': 'Indiquer la fin des dernières règles de $name',
    });
    return '$_temp0';
  }

  @override
  String homeSharedCopy(String who, String name, String date) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you':
          'Historique importé de votre téléphone le $date. Il ne peut pas être modifié ici ; il est mis à jour quand vous l’envoyez de nouveau.',
      'other':
          'Historique importé du téléphone de $name le $date. Il ne peut pas être modifié ici ; il est mis à jour quand $name l’envoie de nouveau.',
    });
    return '$_temp0';
  }

  @override
  String homeNoPeriodSince(String date) {
    return 'Pas de règles enregistrées depuis le $date';
  }

  @override
  String get homeMissedOne =>
      'Ebb suppose que des règles n’ont pas été enregistrées et fait son estimation à partir de là. Si vous vous souvenez de leur date de début, ajoutez-les pour corriger l’estimation.';

  @override
  String get homeMissedSome =>
      'Ebb suppose que plusieurs règles n’ont pas été enregistrées et fait son estimation à partir de là. Si vous vous souvenez de certaines dates de début, ajoutez-les pour corriger l’estimation.';

  @override
  String get homeWelcome => 'Bienvenue dans Ebb';

  @override
  String get homeNothingYet => 'Rien d’enregistré pour l’instant';

  @override
  String homeFirstLog(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Enregistrez le premier jour de vos prochaines règles, ou ajoutez des règles passées si vous vous en souvenez, et Ebb commencera à apprendre votre rythme. Tout reste sur ce téléphone.',
      'other':
          'Enregistrez le premier jour des prochaines règles de $name, ou ajoutez des règles passées si vous vous en souvenez, et Ebb commencera à apprendre son rythme. Tout reste sur ce téléphone.',
    });
    return '$_temp0';
  }

  @override
  String homeDayOfPeriod(String who, String name, int day) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Jour $day de vos règles',
      'other': 'Jour $day des règles de $name',
    });
    return '$_temp0';
  }

  @override
  String homeDayOfCycle(String who, String name, int day) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Jour $day de votre cycle',
      'other': 'Jour $day du cycle de $name',
    });
    return '$_temp0';
  }

  @override
  String get homeTellEnd =>
      'Indiquez à Ebb quand elles se terminent pour que l’estimation reste juste.';

  @override
  String homeDaysUntil(String who, String name, int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Vos règles sont prévues dans environ $days jours.',
    );
    String _temp1 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Les règles de $name sont prévues dans environ $days jours.',
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
      'you': 'Vos règles sont prévues demain.',
      'other': 'Les règles de $name sont prévues demain.',
    });
    return '$_temp0';
  }

  @override
  String homeExpectedToday(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Vos règles sont prévues aujourd’hui.',
      'other': 'Les règles de $name sont prévues aujourd’hui.',
    });
    return '$_temp0';
  }

  @override
  String homeDaysLate(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other:
          '$days jours de plus que prévu. Les cycles varient pour toutes sortes de raisons.',
      one: '1 jour de plus que prévu. Les cycles varient pour toutes sortes de raisons.',
      zero:
          '$days jours de plus que prévu. Les cycles varient pour toutes sortes de raisons.',
    );
    return '$_temp0';
  }

  @override
  String get homeRingDay => 'JOUR';

  @override
  String homeRingOfCycle(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'de votre cycle',
      'other': 'du cycle de $name',
    });
    return '$_temp0';
  }

  @override
  String homeRingOfPeriod(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'de vos règles',
      'other': 'des règles de $name',
    });
    return '$_temp0';
  }

  @override
  String get homeKeyPeriod => 'Règles';

  @override
  String get homeKeyLikelyNext => 'Début probable';

  @override
  String get homeKeyToday => 'Aujourd’hui';

  @override
  String get homeAddPastPeriods => 'Ajouter des règles passées';

  @override
  String get homeAddMissedPeriod => 'Ajouter des règles oubliées';

  @override
  String get homeNextPeriod => 'Prochaines règles';

  @override
  String homeLikelyBetween(String from, String to) {
    return 'probablement entre le $from et le $to';
  }

  @override
  String get homeFertileWindow => 'Fenêtre de fertilité estimée';

  @override
  String get homeFertileWarning =>
      'Une estimation fondée uniquement sur la durée des cycles. Pas assez fiable pour servir de contraception.';

  @override
  String homeConfidenceUnlogged(String date) {
    return 'Estimée à partir des dernières règles enregistrées, le $date : elle peut donc être moins précise que d’habitude.';
  }

  @override
  String get homeConfidenceNone => 'Rien d’enregistré pour l’instant.';

  @override
  String get homeConfidenceTypical =>
      'Fondée pour l’instant sur un cycle type de 28 jours. Elle deviendra plus précise au fil de vos enregistrements.';

  @override
  String homeConfidenceFew(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Fondée sur $count cycles pour l’instant : elle peut donc être moins précise.',
      one: 'Fondée sur 1 seul cycle pour l’instant : elle peut donc être moins précise.',
      zero:
          'Fondée sur $count cycles pour l’instant : elle peut donc être moins précise.',
    );
    return '$_temp0';
  }

  @override
  String homeConfidenceIrregular(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Vos cycles varient pas mal : c’est donc une estimation large plutôt qu’une date ferme.',
      'other':
          'Les cycles de $name varient pas mal : c’est donc une estimation large plutôt qu’une date ferme.',
    });
    return '$_temp0';
  }

  @override
  String homeConfidenceLast(String who, String name, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Fondée sur vos $count derniers cycles.',
    );
    String _temp1 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Fondée sur les $count derniers cycles de $name.',
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
      other: 'Fondée sur $count cycles assez réguliers.',
    );
    return '$_temp0';
  }

  @override
  String get homeMilestoneFirstPeriod => 'Premières règles enregistrées';

  @override
  String get homeMilestoneFirstCycle => 'Premier cycle complet';

  @override
  String get homeMilestoneThreeCycles => 'Trois cycles complets';

  @override
  String get homeMilestoneSixCycles => 'Six cycles complets';

  @override
  String get homeMilestoneOneYear => 'Un an d’historique';

  @override
  String get homeMilestoneTwoYears => 'Deux ans d’historique';

  @override
  String get homeMilestoneFiveYears => 'Cinq ans d’historique';

  @override
  String get homeMilestoneFirstBackup => 'Première sauvegarde enregistrée';

  @override
  String homeMilestoneFirstPeriodMessage(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Vos premières règles dans Ebb.',
      'other': 'Les premières règles de $name dans Ebb.',
    });
    return '$_temp0';
  }

  @override
  String homeMilestoneFirstCycleMessage(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Un premier cycle complet. Ebb peut commencer à apprendre votre rythme.',
      'other':
          'Un premier cycle complet. Ebb peut commencer à apprendre le rythme de $name.',
    });
    return '$_temp0';
  }

  @override
  String get homeMilestoneThreeCyclesMessage =>
      'Trois cycles complets enregistrés. Chacun donne à Ebb un peu plus de matière.';

  @override
  String get homeMilestoneSixCyclesMessage =>
      'Six cycles complets enregistrés : autant qu’Ebb en prend en compte pour chaque estimation.';

  @override
  String homeMilestoneOneYearMessage(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Un an de votre historique dans Ebb.',
      'other': 'Un an de l’historique de $name dans Ebb.',
    });
    return '$_temp0';
  }

  @override
  String homeMilestoneTwoYearsMessage(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Deux ans de votre historique dans Ebb.',
      'other': 'Deux ans de l’historique de $name dans Ebb.',
    });
    return '$_temp0';
  }

  @override
  String homeMilestoneFiveYearsMessage(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Cinq ans de votre historique dans Ebb.',
      'other': 'Cinq ans de l’historique de $name dans Ebb.',
    });
    return '$_temp0';
  }

  @override
  String get homeMilestoneFirstBackupMessage =>
      'Votre première sauvegarde est enregistrée. Gardez-en une copie ailleurs que sur ce téléphone.';

  @override
  String get homeProblemStartInFuture =>
      'La date de début ne peut pas être dans le futur.';

  @override
  String get homeProblemEndInFuture =>
      'La date de fin ne peut pas être dans le futur.';

  @override
  String get homeProblemEndBeforeStart =>
      'La date de fin est antérieure à la date de début.';

  @override
  String get homeProblemDuplicateStart =>
      'Des règles commençant ce jour-là sont déjà enregistrées.';

  @override
  String get homeProblemOverlapsPrevious =>
      'Ces dates chevauchent les règles précédentes. Vérifiez la date de fin de l’entrée précédente.';

  @override
  String get homeProblemOverlapsNext =>
      'Ces dates chevauchent les règles suivantes. Vérifiez la date de fin.';

  @override
  String get homeDeleteCycleTitle => 'Supprimer ce cycle ?';

  @override
  String homeDeleteCycleBody(String date) {
    return 'L’entrée commençant le $date sera supprimée. Cette action est irréversible.';
  }

  @override
  String get homeFirstDayOfPeriod => 'Premier jour des règles';

  @override
  String get homeLastDayOfPeriod => 'Dernier jour des règles';

  @override
  String get homeAddPastPeriodTitle => 'Ajouter des règles passées';

  @override
  String get homeEditPeriod => 'Modifier les règles';

  @override
  String get homeStarted => 'Début';

  @override
  String get homeEnded => 'Fin';

  @override
  String get homeStillGoing => 'En cours';

  @override
  String get homeNotRecorded => 'Non enregistrée';

  @override
  String get homeClearEnd => 'Effacer la date de fin';

  @override
  String get homeCountInPredictions => 'Compter ce cycle dans les prévisions';

  @override
  String get homeCountInPredictionsHint =>
      'À désactiver pour un cycle qui ne reflète pas le rythme habituel : maladie, changement de traitement, perte de grossesse. Il reste dans votre historique dans tous les cas.';

  @override
  String get homeNote => 'Note';

  @override
  String get homeNoteExcludedHint =>
      'Pourquoi il n’est pas compté, pour s’en souvenir facilement plus tard.';

  @override
  String get homeNoteHint => 'Tout ce qui mérite d’être retenu sur ces règles.';

  @override
  String get homeDeletePeriod => 'Supprimer ces règles';

  @override
  String get homeAddPastPeriod => 'Ajouter des règles passées';

  @override
  String get homeHistoryEmpty =>
      'Aucun cycle enregistré pour l’instant. Si vous vous souvenez du début de vos dernières règles, les ajouter donne une longueur d’avance à Ebb.';

  @override
  String get homeMilestones => 'Étapes';

  @override
  String homePeriodLength(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Règles de $count jours',
      one: 'Règles de 1 jour',
      zero: 'Règles de $count jours',
    );
    return '$_temp0';
  }

  @override
  String get homePeriodInProgress => 'Règles en cours';

  @override
  String get homeEndNotRecorded => 'Fin non enregistrée';

  @override
  String get homeLongGap =>
      'Un long intervalle. Si des règles n’ont pas été enregistrées ici, ajoutez-les avec « Ajouter des règles passées ».';

  @override
  String get homeNothingSince =>
      'Rien d’enregistré depuis. Si des règles ont été oubliées, ajoutez-les avec « Ajouter des règles passées ».';

  @override
  String homeNotCounted(String detail) {
    return '$detail · non compté';
  }

  @override
  String get homeDayCycle => 'jours de cycle';

  @override
  String get homeLastLogged => 'Dernier enregistré';

  @override
  String get homeCurrent => 'En cours';

  @override
  String get homeSpanMonths3 => '3 derniers mois';

  @override
  String get homeSpanMonths6 => '6 derniers mois';

  @override
  String get homeSpanYear => '12 derniers mois';

  @override
  String get homeSpanAll => 'Tout';

  @override
  String get homeSpanCustom => 'Choisir les dates…';

  @override
  String get settingsTitle => 'Paramètres';

  @override
  String get settingsNotificationsOff =>
      'Les notifications d’Ebb sont désactivées dans les paramètres du système.';

  @override
  String settingsNoBrowser(String website) {
    return 'Aucun navigateur pour l’ouvrir. Rendez-vous sur $website.';
  }

  @override
  String get settingsNothingToBackUp => 'Rien à sauvegarder pour l’instant.';

  @override
  String get settingsBackupSaved =>
      'Sauvegarde enregistrée. Gardez-en une copie ailleurs que sur ce téléphone.';

  @override
  String get settingsBackupNotSaved =>
      'Impossible d’enregistrer la sauvegarde à cet endroit. Essayez un autre emplacement.';

  @override
  String get settingsNoPicker =>
      'Ce téléphone n’a pas de sélecteur de fichiers utilisable par Ebb. L’envoi vers un autre téléphone fonctionne sans.';

  @override
  String get settingsFileTooLarge =>
      'Ce fichier est trop volumineux pour être une sauvegarde Ebb.';

  @override
  String get settingsFileUnreadable => 'Impossible de lire ce fichier.';

  @override
  String get settingsNotABackup => 'Ce fichier n’est pas une sauvegarde Ebb.';

  @override
  String settingsPeriodCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count périodes de règles',
      one: '$count période de règles',
    );
    return '$_temp0';
  }

  @override
  String get settingsSetUpTitle => 'Commencer avec cet historique ?';

  @override
  String settingsSetUpBody(String periods, String date) {
    return '$periods, envoi du $date. Sur ce téléphone, cet historique devient le vôtre.';
  }

  @override
  String settingsUpdateTitle(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Mettre à jour votre historique ?',
      'other': 'Mettre à jour $name ?',
    });
    return '$_temp0';
  }

  @override
  String settingsUpdateAction(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Mettre à jour votre historique',
      'other': 'Mettre à jour $name',
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
          'Voici de nouveau votre historique, envoyé le $date : $periods. Il remplace la copie présente sur ce téléphone.',
      'other':
          'Voici de nouveau l’historique de $name, envoyé le $date : $periods. Il remplace la copie présente sur ce téléphone.',
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
          'Voici votre historique, envoyé le $date : $periods. Il remplace ce qui se trouve sur ce téléphone pour vous, y compris tout ce qui a été enregistré ici depuis.',
      'other':
          'Voici l’historique de $name, envoyé le $date : $periods. Il remplace ce qui se trouve sur ce téléphone pour $name, y compris tout ce qui a été enregistré ici depuis.',
    });
    return '$_temp0';
  }

  @override
  String get settingsReplaceEverything => 'Tout remplacer';

  @override
  String settingsPersonUpdated(String name) {
    return '$name : mise à jour effectuée.';
  }

  @override
  String get settingsAddThisHistoryTitle => 'Ajouter cet historique ?';

  @override
  String settingsAddNamedTitle(String name) {
    return 'Ajouter $name ?';
  }

  @override
  String settingsAddBody(String periods) {
    return 'Il contient $periods. Vous pouvez l’ajouter à ce qui se trouve déjà ici, ou tout remplacer sur ce téléphone par son contenu.';
  }

  @override
  String settingsAddNamedBody(String name, String periods) {
    return 'L’historique de $name contient $periods. Vous pouvez l’ajouter à ce qui se trouve déjà ici, ou tout remplacer sur ce téléphone par son contenu.';
  }

  @override
  String get settingsAddAsNew => 'Ajouter comme nouvelle personne';

  @override
  String get settingsWhoIsThis => 'De qui s’agit-il ?';

  @override
  String get settingsWhoIsThisHint =>
      'Un nom pour distinguer les personnes sur ce téléphone.';

  @override
  String settingsPersonAdded(String name) {
    return '$name : ajout effectué.';
  }

  @override
  String get settingsRestored => 'C’est fait. Ebb a été mis à jour.';

  @override
  String get settingsReplaceTitle => 'Remplacer le contenu d’Ebb ?';

  @override
  String settingsReplaceSaved(String date, String periods) {
    return 'Sauvegarde enregistrée le $date, avec $periods.';
  }

  @override
  String settingsReplaceSavedPeople(int people, String date, String periods) {
    String _temp0 = intl.Intl.pluralLogic(
      people,
      locale: localeName,
      other:
          'Sauvegarde enregistrée le $date, avec $periods pour $people personnes.',
    );
    return '$_temp0';
  }

  @override
  String settingsReplaceCurrent(String periods) {
    return 'Elle remplace tout ce qui se trouve actuellement dans Ebb, y compris $periods sur ce téléphone.';
  }

  @override
  String get settingsReplace => 'Remplacer';

  @override
  String get settingsDeleteAllTitle => 'Supprimer toutes les données ?';

  @override
  String get settingsDeleteAllBody =>
      'Tous les cycles et toutes les notes seront définitivement effacés. Ebb ne garde aucune autre copie : cette action est irréversible, sauf si vous avez enregistré un fichier de sauvegarde.';

  @override
  String get settingsDeleteAllBodyEveryone =>
      'Tous les cycles et toutes les notes, pour toutes les personnes de ce téléphone, seront définitivement effacés. Ebb ne garde aucune autre copie : cette action est irréversible, sauf si vous avez enregistré un fichier de sauvegarde.';

  @override
  String get settingsDeleteEverything => 'Tout supprimer';

  @override
  String get settingsAllDeleted => 'Toutes les données ont été supprimées.';

  @override
  String get settingsYourName => 'Votre nom';

  @override
  String get settingsRename => 'Renommer';

  @override
  String get settingsYourNameHint =>
      'Affiché dans la liste des personnes. Laissez vide pour apparaître comme « Vous ».';

  @override
  String settingsRemoveTitle(String name) {
    return 'Retirer $name de ce téléphone ?';
  }

  @override
  String settingsRemoveBody(String name) {
    return 'Tous les cycles et toutes les notes de $name seront définitivement effacés. L’historique des autres personnes n’est pas touché.';
  }

  @override
  String settingsPersonRemoved(String name) {
    return '$name : retrait effectué.';
  }

  @override
  String settingsRemovePerson(String name) {
    return 'Retirer $name de ce téléphone';
  }

  @override
  String get settingsYourCycle => 'Votre cycle';

  @override
  String get settingsYourSettings => 'Vos paramètres';

  @override
  String settingsSettingsFor(String name) {
    return 'Paramètres pour $name';
  }

  @override
  String get settingsName => 'Nom';

  @override
  String get settingsReminders => 'Rappels';

  @override
  String settingsRemindersHint(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Un avis avant la date prévue de vos règles.',
      'other': 'Un avis avant la date prévue des règles de $name.',
    });
    return '$_temp0';
  }

  @override
  String get settingsRemindMe => 'Me prévenir';

  @override
  String settingsDaysAhead(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count jours avant',
      one: '$count jour avant',
    );
    return '$_temp0';
  }

  @override
  String settingsDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count jours',
      one: '$count jour',
    );
    return '$_temp0';
  }

  @override
  String get settingsFertile =>
      'Afficher l’estimation de la fenêtre de fertilité';

  @override
  String get settingsFertileHint =>
      'Désactivé par défaut. Une estimation fondée uniquement sur la durée des cycles, pas assez fiable pour servir de contraception.';

  @override
  String get settingsMoon => 'Afficher les phases de la lune';

  @override
  String get settingsMoonHint =>
      'Nouvelle lune, premier quartier, pleine lune et dernier quartier, sur le calendrier et les graphiques.';

  @override
  String get settingsTemperature =>
      'Suivre la température et la glaire cervicale';

  @override
  String get settingsTemperatureHint =>
      'Sur chaque jour du calendrier, avec un graphique de température. Enregistrées et affichées, jamais utilisées pour estimer quoi que ce soit.';

  @override
  String get settingsTemperatureIn => 'Température en';

  @override
  String get settingsCelebrate => 'Fêter les étapes';

  @override
  String settingsCelebrateHint(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Une petite célébration pour des étapes comme un premier cycle complet ou un an d’historique, listées dans votre Historique.',
      'other':
          'Une petite célébration pour des étapes comme un premier cycle complet ou un an d’historique, listées dans l’Historique de $name.',
    });
    return '$_temp0';
  }

  @override
  String get settingsPeople => 'Personnes';

  @override
  String get settingsAddSomeone => 'Ajouter une personne';

  @override
  String get settingsTrackSomeoneElse => 'Suivre aussi une autre personne';

  @override
  String get settingsTrackSomeoneElseHint =>
      'Par exemple, un enfant qui vient d’avoir ses premières règles.';

  @override
  String get settingsBackupSection => 'Sauvegarde et transfert';

  @override
  String get settingsBackUp => 'Sauvegarder dans un fichier';

  @override
  String get settingsBackUpHint =>
      'Enregistrez votre historique dans un fichier, où vous le souhaitez.';

  @override
  String get settingsBackUpHintEveryone =>
      'Enregistrez l’historique de tout le monde dans un fichier, où vous le souhaitez.';

  @override
  String get settingsRestore => 'Restaurer une sauvegarde';

  @override
  String get settingsRestoreHint =>
      'Remplace ce qui se trouve actuellement dans Ebb.';

  @override
  String get settingsSend => 'Envoyer vers un autre téléphone';

  @override
  String get settingsSendHint =>
      'Affichez votre historique sous forme de codes à scanner par un autre téléphone.';

  @override
  String get settingsSendHintEveryone =>
      'Affichez l’historique de tout le monde sous forme de codes à scanner par un autre téléphone.';

  @override
  String get settingsReceive => 'Recevoir d’un autre téléphone';

  @override
  String get settingsReceiveHint =>
      'Scannez les codes pour ajouter une personne, la mettre à jour ou tout remplacer.';

  @override
  String get settingsAdvanced => 'Avancé';

  @override
  String get settingsGroups => 'Groupes';

  @override
  String get settingsGroupsHint =>
      'Pour les cercles et les clubs qui suivent leur cycle ensemble : réunissez des personnes sous un même nom. Désactiver cette option masque les groupes sans les supprimer.';

  @override
  String get settingsManageGroups => 'Gérer les groupes';

  @override
  String get settingsAboutEbb => 'À propos d’Ebb';

  @override
  String get settingsHowEbbWorks => 'Comment fonctionne Ebb';

  @override
  String get settingsHowEbbWorksHint =>
      'Enregistrement, estimations, sauvegardes et plus encore.';

  @override
  String get settingsYourData => 'Vos données';

  @override
  String get settingsYourDataHint =>
      'Où elles se trouvent et qui peut les voir.';

  @override
  String get settingsWebsite => 'Site web';

  @override
  String get settingsSendFeedback => 'Envoyer un commentaire';

  @override
  String get settingsSendFeedbackHint =>
      'Un formulaire sur le site web, dans votre navigateur.';

  @override
  String get settingsDeleteAll => 'Supprimer toutes les données';

  @override
  String settingsVersion(String version) {
    return 'Ebb $version\nRéalisé par SuperDaveLab';
  }

  @override
  String get settingsDataHeadline => 'Votre cycle, c’est votre affaire.';

  @override
  String get settingsDataLede =>
      'Ebb est conçu pour que la question « que font-ils de mes données ? » ait une réponse ennuyeuse : rien, puisque nous ne les recevons jamais.';

  @override
  String get settingsDataTradeOff =>
      'Une contrepartie à connaître : comme il n’y a pas de copie dans le cloud, un téléphone perdu ou réinitialisé, c’est un historique perdu. Si cela compte pour vous, enregistrez de temps en temps un fichier de sauvegarde depuis les Paramètres, et gardez-le ailleurs que sur ce téléphone.';

  @override
  String get settingsWhereDataLives => 'Où se trouvent vos données';

  @override
  String get settingsWhereDataLivesHint => 'Vos données, et qui peut les voir.';

  @override
  String get settingsDataStaysTitle => 'Elles restent sur votre téléphone';

  @override
  String get settingsDataStaysBody =>
      'Tout ce que vous enregistrez est écrit dans une base de données sur cet appareil. Il n’y a ni compte à créer ni serveur avec lequel se synchroniser. Vos données ne vont ailleurs que si vous les déplacez vous-même : un fichier de sauvegarde, ou un autre téléphone vers lequel vous les envoyez.';

  @override
  String get settingsDataUnseenTitle => 'Nous ne pouvons pas les voir';

  @override
  String get settingsDataUnseenBody =>
      'Ebb est conçu sans aucune autorisation d’accès à internet. Android le garantit, et vous pouvez le vérifier vous-même dans la liste des autorisations de l’application.';

  @override
  String get settingsDataPermissionsTitle => 'À quoi servent les autorisations';

  @override
  String get settingsDataPermissionsBody =>
      'Notifications, pour les rappels. Appareil photo, uniquement quand vous recevez un historique d’un autre téléphone : il lit les codes, et rien n’est enregistré ni conservé. Ebb reprogramme aussi vos rappels quand le téléphone redémarre. C’est la liste complète.';

  @override
  String get settingsDataNotForSaleTitle => 'Il n’y a rien à vendre';

  @override
  String get settingsDataNotForSaleBody =>
      'Pas de statistiques d’utilisation, pas de publicité, pas de bibliothèques tierces qui envoient des informations. Comme vos données ne nous parviennent jamais, il n’en existe aucune copie que quiconque pourrait acheter, réclamer en justice ou divulguer.';

  @override
  String get settingsDataEraseTitle => 'Vous pouvez les effacer immédiatement';

  @override
  String get settingsDataEraseBody =>
      'Supprimer vos données dans les Paramètres, ou désinstaller Ebb, efface tout ce que contient Ebb. Ebb ne garde aucune autre copie : les seules sont les fichiers de sauvegarde que vous avez enregistrés ou les téléphones vers lesquels vous les avez vous-même envoyées.';

  @override
  String get settingsDataOpenSourceTitle =>
      'Vous pouvez vérifier notre travail';

  @override
  String get settingsDataOpenSourceBody =>
      'Ebb est open source, sous licence publique générale GNU. Tout le monde peut lire exactement ce qu’il fait, et les versions publiées sont compilées à partir de ce même code.';

  @override
  String get settingsHelpLoggingTitle => 'Enregistrer ses règles';

  @override
  String get settingsHelpLoggingBody =>
      'Touchez « Mes règles ont commencé aujourd’hui » le premier jour des saignements, et « Mes règles se sont terminées aujourd’hui » le dernier.\n\nVous avez oublié de les enregistrer ? Utilisez plutôt « Elles ont commencé avant aujourd’hui ». Toutes les règles passées peuvent être ajoutées ou corrigées dans l’Historique (l’icône d’horloge) : touchez-en une entrée pour modifier ses dates ou ajouter une note.\n\nSi aucune fin n’est enregistrée dans les deux semaines, Ebb ne considère plus les règles comme en cours et propose plutôt d’en ajouter la fin.';

  @override
  String get settingsHelpEstimateTitle => 'Comment fonctionne l’estimation';

  @override
  String get settingsHelpEstimateBody =>
      'Ebb regarde les intervalles entre les débuts de vos dernières règles, jusqu’aux six dernières.\n\nAvec peu d’historique, il s’appuie sur un cycle type de 28 jours, et le dit. Plus vous enregistrez, plus l’estimation suit votre propre rythme.\n\nIl affiche une plage plutôt qu’une date unique, et indique son degré de certitude. Si vos cycles varient beaucoup, la plage est plus large.\n\nSi les règles sont en retard, Ebb indique de combien. Si rien n’est enregistré pendant près de deux cycles, il suppose que des règles n’ont pas été enregistrées, fait son estimation à partir de là, et le dit. L’Historique signale les longs intervalles, et ajouter des règles oubliées corrige l’estimation.';

  @override
  String get settingsHelpExcludeTitle => 'Un cycle qui ne devrait pas compter';

  @override
  String get settingsHelpExcludeBody =>
      'Une maladie, un changement de traitement ou une perte de grossesse peuvent complètement dérégler un cycle, qui fausserait alors l’estimation.\n\nDans l’Historique, touchez ces règles et désactivez « Compter ce cycle dans les prévisions ». Le cycle reste dans votre historique ; l’estimation l’ignore simplement. Ajoutez-y aussi une note, pour vous souvenir pourquoi.';

  @override
  String get settingsHelpGroupsTitle => 'Groupes';

  @override
  String get settingsHelpGroupsBody =>
      'Pour les cercles et les clubs qui suivent leur cycle ensemble. Activez-les dans Paramètres → Avancé, puis créez un groupe et choisissez qui en fait partie. « Voir … ensemble », dans la liste des personnes, affiche tout le monde côte à côte, avec la lune.\n\nUn groupe peut avoir deux sortes de membres. Une personne ajoutée au groupe est suivie sur ce téléphone, et c’est vous qui enregistrez pour elle ici. Une personne importée continue de suivre son cycle sur son propre téléphone et fournit son historique au groupe : il reste le sien, et ne peut être modifié sur le téléphone de personne d’autre.\n\nPour figurer dans un groupe sur un autre téléphone, envoyez uniquement votre historique (Paramètres → Envoyer vers un autre téléphone), autant ou aussi peu que vous voulez, avec ou sans vos notes quotidiennes. L’autre téléphone l’importe depuis le groupe : Gérer les groupes → le groupe → Importer depuis son téléphone. Vous importer de nouveau met votre historique à jour.\n\nUn historique importé appartient à son groupe. Retirer une personne importée de son dernier groupe, ou supprimer ce groupe, retire aussi son historique du téléphone. Et il ne peut pas être transmis plus loin : seul votre propre historique peut l’être.';

  @override
  String get settingsHelpRatingsTitle =>
      'Notes du jour, ressentis et graphiques';

  @override
  String get settingsHelpRatingsBody =>
      'Touchez n’importe quel jour du calendrier pour le noter de 1 à 5, et pour choisir un visage qui dit comment vous vous sentiez. Les deux sont facultatifs ; touchez de nouveau un choix pour l’effacer.\n\nGraphiques (l’icône de graphique) montre la note de chaque jour sur les dates que vous choisissez, avec les règles ombrées, et quels ressentis sont apparus pendant et avant les règles. Si les phases de la lune sont activées dans les Paramètres, la lune y figure aussi.\n\nLes graphiques montrent ce que vous avez enregistré. Ils ne disent pas ce que cela signifie : c’est à vous d’en juger.';

  @override
  String get settingsHelpTemperatureTitle => 'Température et glaire cervicale';

  @override
  String get settingsHelpTemperatureBody =>
      'Activez « Suivre la température et la glaire cervicale » dans les Paramètres : chaque jour du calendrier aura alors de la place pour votre température au réveil et pour la sensation et l’aspect de la glaire cervicale. Si quelque chose a pu fausser une mesure (maladie, manque de sommeil, alcool, prise tardive), cochez la case en dessous.\n\nGraphiques montre les températures sous forme de courbe, avec la glaire en dessous et les règles ombrées, en °C ou en °F (Paramètres).\n\nEbb enregistre et affiche ces données, et c’est tout. Il ne cherche pas de montée de température et n’en déduit pas de jours fertiles, et son estimation de la fenêtre de fertilité repose toujours uniquement sur la durée des cycles. Si vous suivez une méthode comme la symptothermie, le graphique est là pour que vous le lisiez selon ses règles.';

  @override
  String get settingsHelpRemindersTitle => 'Rappels';

  @override
  String get settingsHelpRemindersBody =>
      'Un avis quelques jours avant la date prévue de vos règles, et un autre le jour même. Choisissez combien de temps à l’avance dans les Paramètres.\n\nIls sont programmés sur le téléphone lui-même : ils arrivent donc sans réseau et en mode avion.\n\nEbb les programme à chaque ouverture, à partir de la dernière estimation. Le téléphone les conserve après un redémarrage, mais Ebb ne peut pas les mettre à jour tant qu’il est fermé : ouvrez-le de temps en temps (enregistrer des règles suffit).\n\nAndroid peut les délivrer un peu après l’heure habituelle pour économiser la batterie. Si Ebb est arrêté de force, ou limité par un économiseur de batterie, ils risquent de n’arriver qu’à la prochaine ouverture d’Ebb.';

  @override
  String get settingsHelpFertileTitle => 'La fenêtre de fertilité';

  @override
  String get settingsHelpFertileBody =>
      'Désactivée tant que vous ne l’activez pas dans les Paramètres. Elle est estimée uniquement à partir de la durée des cycles, ce qui n’est pas assez fiable pour servir de contraception.';

  @override
  String get settingsHelpBackupTitle => 'Sauvegarder';

  @override
  String get settingsHelpBackupBody =>
      'Il n’y a pas de copie de votre historique dans le cloud : un téléphone perdu ou réinitialisé, c’est un historique perdu.\n\nParamètres → « Sauvegarder dans un fichier » enregistre tout dans un fichier, où vous le souhaitez. Gardez-le ailleurs que sur ce téléphone. « Restaurer une sauvegarde » le récupère.';

  @override
  String get settingsHelpMovingTitle => 'Passer à un nouveau téléphone';

  @override
  String get settingsHelpMovingBody =>
      'Sur l’ancien téléphone : Paramètres → « Envoyer vers un autre téléphone ». Sur le nouveau : Paramètres → « Recevoir d’un autre téléphone », puis pointez l’appareil photo vers l’écran.\n\nLes historiques plus longs demandent plusieurs codes, qui changent d’eux-mêmes ; le nouveau téléphone les récupère dans n’importe quel ordre. Internet n’intervient pas : un téléphone montre, l’autre regarde.';

  @override
  String get settingsHelpSomeoneElseTitle => 'Suivre une autre personne';

  @override
  String get settingsHelpSomeoneElseBody =>
      'Vous aidez quelqu’un à suivre son cycle, par exemple un enfant qui vient d’avoir ses premières règles ? Paramètres → « Suivre aussi une autre personne », et donnez-lui un nom. Un surnom ou une initiale suffit.\n\nTouchez le nom en haut de l’écran d’accueil pour passer d’une personne à l’autre. Chacun a ses propres rappels, désactivés au départ pour les personnes que vous ajoutez. La fenêtre de fertilité n’est proposée que pour vous.';

  @override
  String get settingsHelpHandoverTitle => 'Confier son suivi à quelqu’un';

  @override
  String get settingsHelpHandoverBody =>
      'Quand une personne que vous suivez a son propre téléphone : « Envoyer vers un autre téléphone », en ne choisissant qu’elle. Sur son téléphone : « Recevoir d’un autre téléphone ». Sur une nouvelle installation, son historique devient simplement le sien.\n\nEnsuite, Ebb vous demande s’il faut la retirer de votre téléphone. Il ne le fait jamais de lui-même.';

  @override
  String get settingsHelpDeletingTitle => 'Supprimer';

  @override
  String get settingsHelpDeletingBody =>
      'Paramètres → « Supprimer toutes les données » efface d’un coup tout ce qui se trouve sur ce téléphone.\n\nPour retirer une personne que vous avez ajoutée, ouvrez ses paramètres et choisissez « Retirer … de ce téléphone ». L’historique des autres personnes n’est pas touché.';

  @override
  String shareRemoveTitle(String name) {
    return 'Retirer $name de ce téléphone ?';
  }

  @override
  String shareRemoveBody(String name) {
    return 'Si l’historique de $name est bien arrivé sur l’autre téléphone, il peut être retiré de celui-ci. Vous pouvez aussi le garder ici.';
  }

  @override
  String get shareKeep => 'Garder';

  @override
  String shareRemoved(String name) {
    return '$name : retrait effectué.';
  }

  @override
  String get shareTitle => 'Envoyer vers un autre téléphone';

  @override
  String get shareWhatToSend => 'Que voulez-vous envoyer ?';

  @override
  String get shareEveryone => 'Tout le monde';

  @override
  String get shareEveryoneHint => 'Pour passer à un nouveau téléphone.';

  @override
  String get shareJustOne => 'Une seule personne';

  @override
  String get shareJustYours => 'Uniquement votre historique';

  @override
  String shareJustName(String name) {
    return 'Uniquement $name';
  }

  @override
  String shareForTheirPhone(String name) {
    return 'Pour le téléphone de $name.';
  }

  @override
  String get shareCopiesNotOffered =>
      'Les personnes importées d’autres téléphones ne sont pas proposées ici : chacun ne partage que son propre historique.';

  @override
  String shareHowMuch(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Quelle part de votre historique ?',
      'other': 'Quelle part de l’historique de $name ?',
    });
    return '$_temp0';
  }

  @override
  String get shareHowMuchHint =>
      'Tout envoyer convient pour un nouveau téléphone. Pour un groupe, vous pouvez en envoyer moins. Rien n’est retiré de ce téléphone.';

  @override
  String get shareHowFarBack => 'Depuis quand';

  @override
  String get shareSpanEverything => 'Tout';

  @override
  String get shareSpanYear => 'Les 12 derniers mois';

  @override
  String shareSpanMonths(int months) {
    String _temp0 = intl.Intl.pluralLogic(
      months,
      locale: localeName,
      other: 'Les $months derniers mois',
      one: 'Les $months derniers mois',
    );
    return '$_temp0';
  }

  @override
  String get shareSpanLatest => 'Uniquement les dernières règles';

  @override
  String get shareWhatToInclude => 'Que faut-il inclure';

  @override
  String get shareWithDays => 'Règles et entrées quotidiennes';

  @override
  String get shareWithDaysHint =>
      'Notes écrites, notes du jour, ressentis et flux aussi.';

  @override
  String get sharePeriodsOnly => 'Règles uniquement';

  @override
  String get sharePeriodsOnlyHint =>
      'Seulement le début et la fin de chaque période de règles.';

  @override
  String get shareShowCodes => 'Afficher les codes';

  @override
  String get shareNothing => 'Rien à envoyer pour l’instant.';

  @override
  String get shareHowToReceive =>
      'Sur l’autre téléphone, ouvrez Ebb, allez dans Paramètres → Recevoir d’un autre téléphone, et pointez l’appareil photo vers cet écran.';

  @override
  String shareCodeOf(int index, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      total,
      locale: localeName,
      other: 'Code $index sur $total',
    );
    return '$_temp0';
  }

  @override
  String get sharePreviousCode => 'Code précédent';

  @override
  String get sharePause => 'Pause';

  @override
  String get sharePlay => 'Lecture';

  @override
  String get shareNextCode => 'Code suivant';

  @override
  String get shareCodesChange =>
      'Les codes changent d’eux-mêmes. L’autre téléphone les récupère dans n’importe quel ordre.';

  @override
  String sharePeriodCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count périodes de règles',
      one: '$count période de règles',
    );
    return '$_temp0';
  }

  @override
  String shareSummaryEverything(String periods) {
    return 'Tout le contenu d’Ebb : $periods.';
  }

  @override
  String shareSummaryEverythingPeople(String periods, int people) {
    String _temp0 = intl.Intl.pluralLogic(
      people,
      locale: localeName,
      other: 'Tout le contenu d’Ebb : $periods pour $people personnes.',
    );
    return '$_temp0';
  }

  @override
  String shareSummaryHistoryAll(String who, String name, String periods) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Votre historique : $periods.',
      'other': 'Historique de $name : $periods.',
    });
    return '$_temp0';
  }

  @override
  String shareSummaryHistoryLatest(String who, String name, String periods) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Votre historique, dernières règles uniquement : $periods.',
      'other': 'Historique de $name, dernières règles uniquement : $periods.',
    });
    return '$_temp0';
  }

  @override
  String shareSummaryHistoryYear(String who, String name, String periods) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Votre historique des 12 derniers mois : $periods.',
      'other': 'Historique de $name des 12 derniers mois : $periods.',
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
      'you': 'Votre historique des $months derniers mois : $periods.',
      'other': 'Historique de $name des $months derniers mois : $periods.',
    });
    return '$_temp0';
  }

  @override
  String shareSummaryPeriodsAll(String who, String name, String periods) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Vos règles : $periods.',
      'other': 'Règles de $name : $periods.',
    });
    return '$_temp0';
  }

  @override
  String shareSummaryPeriodsLatest(String who, String name, String periods) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Vos règles, dernières règles uniquement : $periods.',
      'other': 'Règles de $name, dernières règles uniquement : $periods.',
    });
    return '$_temp0';
  }

  @override
  String shareSummaryPeriodsYear(String who, String name, String periods) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Vos règles des 12 derniers mois : $periods.',
      'other': 'Règles de $name des 12 derniers mois : $periods.',
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
      'you': 'Vos règles des $months derniers mois : $periods.',
      'other': 'Règles de $name des $months derniers mois : $periods.',
    });
    return '$_temp0';
  }

  @override
  String get shareNotEbb => 'Ce code ne vient pas d’Ebb.';

  @override
  String get shareNewerVersion =>
      'L’autre téléphone a une version plus récente d’Ebb. Mettez d’abord celui-ci à jour.';

  @override
  String get shareRestarted =>
      'L’autre téléphone a recommencé. Récupération des nouveaux codes.';

  @override
  String get shareUnreadable =>
      'Certains codes n’ont pas été bien lus. Scannons-les de nouveau.';

  @override
  String get shareNeedsCamera =>
      'Ebb a besoin de l’appareil photo pour lire les codes. Vous pouvez l’autoriser dans les paramètres système d’Ebb.';

  @override
  String get sharePointCamera =>
      'Pointez l’appareil photo vers le code sur l’autre téléphone.';

  @override
  String get shareReading => 'Lecture…';

  @override
  String shareCodesReceived(int received, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      total,
      locale: localeName,
      other: '$received codes reçus sur $total',
    );
    return '$_temp0';
  }

  @override
  String get shareReceiveTitle => 'Recevoir d’un autre téléphone';

  @override
  String shareStillNeeded(String codes) {
    return 'Encore nécessaires : $codes';
  }

  @override
  String get groupsMoreThanOne => 'Il y a plus d’une personne';

  @override
  String get groupsMoreThanOneBody =>
      'Ces codes contiennent l’historique de tout un téléphone. Pour rejoindre un groupe, chaque personne envoie uniquement le sien : sur son téléphone, Paramètres → Envoyer vers un autre téléphone → Uniquement votre historique.';

  @override
  String groupsUpdateTitle(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Mettre à jour votre historique ?',
      'other': 'Mettre à jour $name ?',
    });
    return '$_temp0';
  }

  @override
  String groupsUpdateAction(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Mettre à jour votre historique',
      'other': 'Mettre à jour $name',
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
          'Voici de nouveau votre historique, envoyé le $sent : $periods. Il remplace la copie présente sur ce téléphone.',
      'other':
          'Voici de nouveau l’historique de $name, envoyé le $sent : $periods. Il remplace la copie présente sur ce téléphone.',
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
          'Voici votre historique, envoyé le $sent : $periods. Il remplace ce qui se trouve sur ce téléphone pour vous, y compris tout ce qui a été enregistré ici depuis.',
      'other':
          'Voici l’historique de $name, envoyé le $sent : $periods. Il remplace ce qui se trouve sur ce téléphone pour $name, y compris tout ce qui a été enregistré ici depuis.',
    });
    return '$_temp0';
  }

  @override
  String groupsUpdated(String name) {
    return '$name : mise à jour effectuée.';
  }

  @override
  String groupsImportInto(String group) {
    return 'Importer dans $group';
  }

  @override
  String groupsImportHint(String periods, String sent) {
    return '$periods, envoi du $sent. Cet historique est importé en lecture seule : il ne peut pas être modifié ici, et sera mis à jour quand il sera envoyé de nouveau.';
  }

  @override
  String groupsImported(String name, String group) {
    return '$name : importation dans $group effectuée.';
  }

  @override
  String get groupsGroup => 'Groupe';

  @override
  String get groupsNoMembers =>
      'Personne n’est encore dans ce groupe. Ajoutez des membres dans Paramètres → Avancé → Gérer les groupes : cochez des personnes déjà présentes sur ce téléphone, ou ajoutez quelqu’un depuis son téléphone.';

  @override
  String get groupsPeriods => 'Règles';

  @override
  String get groupsChartHint =>
      'Chaque barre représente des règles ; un contour indique des règles dont la fin n’a pas été enregistrée, affichées avec la durée habituelle. Des lignes pleines partent de chaque pleine lune, des lignes pointillées de chaque nouvelle lune.';

  @override
  String get groupsNew => 'Nouveau groupe';

  @override
  String get groupsRename => 'Renommer le groupe';

  @override
  String get groupsNameHint =>
      'Par exemple, le nom de votre cercle ou de votre club.';

  @override
  String get groupsNameTaken => 'Un groupe porte déjà ce nom.';

  @override
  String get groupsNoOneYet => 'Personne pour l’instant';

  @override
  String get groupsTitle => 'Groupes';

  @override
  String get groupsIntro =>
      'Un groupe réunit des personnes de ce téléphone sous un même nom : un cercle ou un club qui suit son cycle ensemble. Une personne peut faire partie de plusieurs groupes, et supprimer un groupe ne supprime jamais personne.';

  @override
  String groupsAddSomeoneTo(String group) {
    return 'Ajouter une personne à $group';
  }

  @override
  String get groupsAddSomeoneHint =>
      'Suivie sur ce téléphone : vous enregistrez et modifiez son historique ici. Une personne qui suit son cycle sur son propre téléphone peut plutôt être importée.';

  @override
  String groupsTakeOutTitle(String name, String group) {
    return 'Retirer $name de $group ?';
  }

  @override
  String groupsTakeOutBody(String name) {
    return 'L’historique de $name a été importé depuis son téléphone et ne fait partie d’aucun autre groupe : il est donc aussi retiré de ce téléphone. $name peut l’envoyer de nouveau pour revenir.';
  }

  @override
  String get groupsTakeOut => 'Retirer';

  @override
  String groupsDeleteTitle(String group) {
    return 'Supprimer $group ?';
  }

  @override
  String get groupsDeleteBodyNone =>
      'Seul le groupe disparaît. Toutes les personnes qui en font partie restent sur ce téléphone, avec tout leur historique.';

  @override
  String groupsDeleteBodySome(String names) {
    return 'Les personnes importées uniquement dans ce groupe sont aussi retirées de ce téléphone : $names. Toutes les autres restent, avec tout leur historique.';
  }

  @override
  String get groupsDeleteGroup => 'Supprimer le groupe';

  @override
  String get groupsRenameTooltip => 'Renommer';

  @override
  String get groupsWhoIsIn => 'Membres';

  @override
  String groupsImportedAsOf(String date) {
    return 'Historique importé · lecture seule, au $date';
  }

  @override
  String get groupsTrackedHere => 'Suivi sur ce téléphone';

  @override
  String get groupsAddTo => 'Ajouter au groupe';

  @override
  String get groupsAddNew => 'Ajouter une nouvelle personne';

  @override
  String get groupsAddNewHint =>
      'Suivie sur ce téléphone : vous enregistrez ses règles ici.';

  @override
  String get groupsImportFromPhone => 'Importer depuis son téléphone';

  @override
  String get groupsImportFromPhoneHint =>
      'La personne continue de suivre son cycle sur son propre téléphone et l’envoie ici, en lecture seule. L’importer de nouveau la met à jour.';

  @override
  String get groupsDeleteThis => 'Supprimer ce groupe';

  @override
  String get peopleNameTaken => 'Ce nom est déjà utilisé sur ce téléphone.';

  @override
  String get peopleName => 'Nom';

  @override
  String peopleSeeTogether(String group) {
    return 'Voir $group ensemble';
  }

  @override
  String get peopleNotInGroup => 'Dans aucun groupe';

  @override
  String get peopleAddSomeone => 'Ajouter une personne';

  @override
  String get peopleTrackSomeoneElse => 'Suivre une autre personne';

  @override
  String get peopleNameHint =>
      'Juste de quoi distinguer les personnes : un prénom, un surnom ou une initiale.';

  @override
  String backupUnnamedPerson(int number) {
    return 'Personne $number';
  }

  @override
  String get backupNotEbb => 'Ce fichier n’est pas une sauvegarde Ebb.';

  @override
  String get backupNewer =>
      'Cette sauvegarde provient d’une version plus récente d’Ebb. Mettez Ebb à jour, puis réessayez.';

  @override
  String get backupNoOne => 'Cette sauvegarde ne contient aucune personne.';

  @override
  String get backupSameId =>
      'Cette sauvegarde semble endommagée : deux personnes y ont le même identifiant.';

  @override
  String backupAfterExport(String date) {
    return 'Le $date est postérieur au jour où cette sauvegarde a été faite.';
  }

  @override
  String backupSameName(String name) {
    return 'Deux personnes de cette sauvegarde s’appellent toutes deux $name.';
  }

  @override
  String backupSameGroupName(String group) {
    return 'Deux groupes de cette sauvegarde s’appellent tous deux $group.';
  }

  @override
  String backupEndsBefore(String date) {
    return 'Les règles commençant le $date se terminent avant d’avoir commencé.';
  }

  @override
  String backupTwoStarts(String date) {
    return 'Deux périodes de règles commencent le $date pour la même personne.';
  }

  @override
  String backupDayTwice(String date) {
    return 'Le $date apparaît deux fois pour la même personne.';
  }

  @override
  String backupOverlaps(String date) {
    return 'Les règles commençant le $date chevauchent les précédentes.';
  }

  @override
  String get backupDamaged =>
      'Cette sauvegarde semble endommagée : impossible de la lire.';

  @override
  String get backupDamagedExportDate =>
      'Cette sauvegarde semble endommagée : impossible de lire la date d’export.';

  @override
  String get backupDamagedGroup =>
      'Cette sauvegarde semble endommagée : impossible de lire un groupe.';

  @override
  String get backupDamagedGroupName =>
      'Cette sauvegarde semble endommagée : impossible de lire le nom d’un groupe.';

  @override
  String backupDamagedGroupPeople(String group) {
    return 'Cette sauvegarde semble endommagée : impossible de lire les personnes du groupe $group.';
  }

  @override
  String get backupDamagedPerson =>
      'Cette sauvegarde semble endommagée : impossible de lire une fiche de personne.';

  @override
  String get backupDamagedName =>
      'Cette sauvegarde semble endommagée : impossible de lire un nom.';

  @override
  String get backupDamagedPersonId =>
      'Cette sauvegarde semble endommagée : impossible de lire l’identifiant d’une personne.';

  @override
  String get backupDamagedSharedOn =>
      'Cette sauvegarde semble endommagée : impossible de lire le jour où un historique a été partagé.';

  @override
  String get backupDamagedPeriod =>
      'Cette sauvegarde semble endommagée : impossible de lire une entrée de règles.';

  @override
  String get backupDamagedPeriodStart =>
      'Cette sauvegarde semble endommagée : impossible de lire un début de règles.';

  @override
  String get backupDamagedPeriodEnd =>
      'Cette sauvegarde semble endommagée : impossible de lire une fin de règles.';

  @override
  String get backupDamagedDay =>
      'Cette sauvegarde semble endommagée : impossible de lire une entrée de jour.';

  @override
  String backupDamagedFlow(String date) {
    return 'Cette sauvegarde semble endommagée : impossible de lire le flux du $date.';
  }

  @override
  String backupDamagedSymptom(String date) {
    return 'Cette sauvegarde semble endommagée : impossible de lire un symptôme du $date.';
  }

  @override
  String backupDamagedRating(String date) {
    return 'Cette sauvegarde semble endommagée : impossible de lire la note du $date.';
  }

  @override
  String backupDamagedFeeling(String date) {
    return 'Cette sauvegarde semble endommagée : impossible de lire le ressenti du $date.';
  }

  @override
  String backupDamagedTemperature(String date) {
    return 'Cette sauvegarde semble endommagée : impossible de lire la température du $date.';
  }

  @override
  String backupDamagedMucus(String date) {
    return 'Cette sauvegarde semble endommagée : impossible de lire la glaire cervicale du $date.';
  }
}
