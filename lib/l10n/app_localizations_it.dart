// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get you => 'Tu';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Annulla';

  @override
  String get save => 'Salva';

  @override
  String get delete => 'Elimina';

  @override
  String get remove => 'Rimuovi';

  @override
  String get close => 'Chiudi';

  @override
  String get done => 'Fatto';

  @override
  String get back => 'Indietro';

  @override
  String get next => 'Avanti';

  @override
  String get edit => 'Modifica';

  @override
  String get add => 'Aggiungi';

  @override
  String get continueAction => 'Continua';

  @override
  String get language => 'Lingua';

  @override
  String get languagePhone => 'Come il telefono';

  @override
  String languagePhoneIs(String language) {
    return 'Come il telefono ($language)';
  }

  @override
  String get notifChannelName => 'Promemoria del ciclo';

  @override
  String get notifChannelDescription =>
      'Un preavviso prima delle mestruazioni previste e un invito a registrarle.';

  @override
  String notifUpcomingTitle(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Mestruazioni previste a breve',
      'other': 'Mestruazioni di $name previste a breve',
    });
    return '$_temp0';
  }

  @override
  String notifUpcomingTomorrow(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Ebb prevede che le tue mestruazioni inizino domani.',
      'other': 'Ebb prevede che le mestruazioni di $name inizino domani.',
    });
    return '$_temp0';
  }

  @override
  String notifUpcomingInDays(String who, String name, int days) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Ebb prevede le tue mestruazioni tra circa $days giorni.',
      'other': 'Ebb prevede le mestruazioni di $name tra circa $days giorni.',
    });
    return '$_temp0';
  }

  @override
  String notifTodayTitle(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Mestruazioni previste per oggi',
      'other': 'Mestruazioni di $name previste per oggi',
    });
    return '$_temp0';
  }

  @override
  String get notifTodayBody => 'Tocca per registrare come va.';

  @override
  String get calendarTitle => 'Calendario';

  @override
  String get calendarCellToday => 'oggi';

  @override
  String get calendarCellPeriod => 'mestruazioni';

  @override
  String get calendarCellPeriodUnlogged => 'mestruazioni, fine non registrata';

  @override
  String get calendarCellLikely =>
      'probabile inizio delle prossime mestruazioni';

  @override
  String get calendarCellFertile => 'finestra fertile stimata';

  @override
  String calendarCellMoon(String phase) {
    String _temp0 = intl.Intl.selectLogic(phase, {
      'newMoon': 'luna nuova',
      'firstQuarter': 'primo quarto',
      'full': 'luna piena',
      'other': 'ultimo quarto',
    });
    return '$_temp0';
  }

  @override
  String calendarCellRated(int rating) {
    return 'voto $rating';
  }

  @override
  String calendarCellFelt(String feeling) {
    return 'stato d’animo: $feeling';
  }

  @override
  String get calendarCellNote => 'c’è una nota';

  @override
  String get calendarKeyPeriod => 'Mestruazioni';

  @override
  String get calendarKeyEndNotLogged => 'Fine non registrata';

  @override
  String get calendarKeyLikely => 'Inizio probabile';

  @override
  String get calendarKeyFertile => 'Fertile (stima)';

  @override
  String get calendarKeyToday => 'Oggi';

  @override
  String calendarStatusWindow(String who, String name, String from, String to) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you':
          'Le tue prossime mestruazioni inizieranno probabilmente tra $from e $to.',
      'other':
          'Le prossime mestruazioni di $name inizieranno probabilmente tra $from e $to.',
    });
    return '$_temp0';
  }

  @override
  String calendarStatusPeriodDay(String who, String name, int day) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Giorno $day delle tue mestruazioni.',
      'other': 'Giorno $day delle mestruazioni di $name.',
    });
    return '$_temp0';
  }

  @override
  String calendarStatusPeriodDayExcluded(String who, String name, int day) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you':
          'Giorno $day delle tue mestruazioni, in un ciclo non conteggiato nelle previsioni.',
      'other':
          'Giorno $day delle mestruazioni di $name, in un ciclo non conteggiato nelle previsioni.',
    });
    return '$_temp0';
  }

  @override
  String calendarStatusUnlogged(String who, String name, int day) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you':
          'Giorno $day del tuo ciclo. La fine di queste mestruazioni non è stata registrata, quindi sono mostrate con la durata abituale.',
      'other':
          'Giorno $day del ciclo di $name. La fine di queste mestruazioni non è stata registrata, quindi sono mostrate con la durata abituale.',
    });
    return '$_temp0';
  }

  @override
  String get calendarStatusFertile =>
      'Nella finestra fertile stimata. Non abbastanza affidabile da usare come contraccezione.';

  @override
  String calendarStatusCycleDay(String who, String name, int day) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Giorno $day del tuo ciclo.',
      'other': 'Giorno $day del ciclo di $name.',
    });
    return '$_temp0';
  }

  @override
  String calendarDayToday(String date) {
    return 'Oggi, $date';
  }

  @override
  String get calendarPreviousDay => 'Giorno precedente';

  @override
  String get calendarNextDay => 'Giorno successivo';

  @override
  String calendarMoonAt(String phase, String time) {
    return '$phase, $time';
  }

  @override
  String get calendarFutureDay =>
      'I giorni futuri non si possono ancora registrare.';

  @override
  String calendarMarkStarted(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Segna come giorno di inizio delle mestruazioni',
      'other': 'Segna come giorno di inizio delle mestruazioni di $name',
    });
    return '$_temp0';
  }

  @override
  String get calendarMoveStart =>
      'Fai di questo il primo giorno delle mestruazioni';

  @override
  String calendarMoveStartFrom(String date) {
    return 'Ne sposta l’inizio da $date';
  }

  @override
  String calendarMarkEnded(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Segna come giorno di fine delle mestruazioni',
      'other': 'Segna come giorno di fine delle mestruazioni di $name',
    });
    return '$_temp0';
  }

  @override
  String get calendarMakeLastDay =>
      'Fai di questo l’ultimo giorno delle mestruazioni';

  @override
  String get calendarEditPeriod => 'Modifica queste mestruazioni';

  @override
  String calendarRateDay(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Dai un voto alla tua giornata, 1–5',
      'other': 'Dai un voto alla giornata di $name, 1–5',
    });
    return '$_temp0';
  }

  @override
  String calendarHowFelt(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Come stavi?',
      'other': 'Come stava $name?',
    });
    return '$_temp0';
  }

  @override
  String get calendarFlow => 'Flusso';

  @override
  String get calendarNote => 'Nota';

  @override
  String calendarTemperatureHeading(String unit) {
    return 'Temperatura, $unit';
  }

  @override
  String calendarTemperatureRange(String low, String high, String unit) {
    return 'Inserisci una temperatura tra $low e $high $unit';
  }

  @override
  String get calendarTemperatureHelper => 'Al risveglio, prima di alzarti';

  @override
  String get calendarTemperatureAffected => 'Qualcosa potrebbe averla alterata';

  @override
  String get calendarTemperatureAffectedHint =>
      'Malattia, poco sonno, alcol, misurata tardi';

  @override
  String get calendarMucus => 'Muco cervicale';

  @override
  String get calendarMucusFelt => 'Sensazione';

  @override
  String get calendarMucusLooked => 'Aspetto';

  @override
  String calendarLoggedRated(int rating, String ratingName) {
    return 'Voto $rating su 5, $ratingName';
  }

  @override
  String calendarLoggedFelt(String emoji, String feeling) {
    return 'Stato d’animo: $emoji $feeling';
  }

  @override
  String calendarLoggedFlow(String flow) {
    String _temp0 = intl.Intl.selectLogic(flow, {
      'spotting': 'Flusso: spotting',
      'light': 'Flusso: leggero',
      'medium': 'Flusso: medio',
      'other': 'Flusso: abbondante',
    });
    return '$_temp0';
  }

  @override
  String calendarLoggedTemperature(String temperature) {
    return 'Temperatura: $temperature';
  }

  @override
  String calendarLoggedTemperatureAffected(String temperature) {
    return 'Temperatura: $temperature, forse alterata';
  }

  @override
  String calendarLoggedMucus(String mucus) {
    return 'Muco cervicale: $mucus';
  }

  @override
  String calendarLoggedNote(String note) {
    return '«$note»';
  }

  @override
  String get calendarNothingLogged => 'Nulla di registrato in questo giorno.';

  @override
  String get calendarMoonNew => 'Luna nuova';

  @override
  String get calendarMoonFirstQuarter => 'Primo quarto';

  @override
  String get calendarMoonFull => 'Luna piena';

  @override
  String get calendarMoonLastQuarter => 'Ultimo quarto';

  @override
  String get dayFlowNone => 'Nessuno';

  @override
  String get dayFlowSpotting => 'Spotting';

  @override
  String get dayFlowLight => 'Leggero';

  @override
  String get dayFlowMedium => 'Medio';

  @override
  String get dayFlowHeavy => 'Abbondante';

  @override
  String get dayMucusNothing => 'Niente';

  @override
  String get dayMucusFeelDry => 'Asciutto';

  @override
  String get dayMucusFeelWet => 'Bagnato';

  @override
  String get dayMucusFeelSlippery => 'Scivoloso';

  @override
  String get dayMucusLookCreamy => 'Cremoso';

  @override
  String get dayMucusLookEggWhite => 'Come albume';

  @override
  String dayMucusFeelInline(String feel) {
    String _temp0 = intl.Intl.selectLogic(feel, {
      'dry': 'asciutto',
      'nothing': 'nessuna sensazione',
      'wet': 'bagnato',
      'other': 'scivoloso',
    });
    return '$_temp0';
  }

  @override
  String dayMucusLookInline(String look) {
    String _temp0 = intl.Intl.selectLogic(look, {
      'nothing': 'nulla di visibile',
      'creamy': 'cremoso',
      'other': 'simile ad albume',
    });
    return '$_temp0';
  }

  @override
  String get dayFeelingHappy => 'Felicità';

  @override
  String get dayFeelingCalm => 'Calma';

  @override
  String get dayFeelingLoving => 'Affetto';

  @override
  String get dayFeelingEnergetic => 'Energia';

  @override
  String get dayFeelingTired => 'Stanchezza';

  @override
  String get dayFeelingSad => 'Tristezza';

  @override
  String get dayFeelingAnxious => 'Ansia';

  @override
  String get dayFeelingIrritable => 'Irritabilità';

  @override
  String get dayFeelingAngry => 'Rabbia';

  @override
  String get dayFeelingConfused => 'Confusione';

  @override
  String get chartsTitle => 'Grafici';

  @override
  String get chartsDayRating => 'Voto della giornata';

  @override
  String get chartsNoRatings =>
      'Nessun giorno in questo intervallo ha ancora un voto.';

  @override
  String get chartsBars => 'Barre';

  @override
  String get chartsLine => 'Linea';

  @override
  String get chartsRatingCaptionBars =>
      'Ogni barra è il voto di un giorno, da 1 a 5. I giorni di mestruazioni sono ombreggiati.';

  @override
  String get chartsRatingCaptionLine =>
      'Ogni punto è il voto di un giorno, da 1 a 5, unito a quello del giorno dopo quando entrambi hanno un voto. I giorni di mestruazioni sono ombreggiati.';

  @override
  String get chartsRatingCaptionMoon =>
      'Le lune segnano le fasi lunari; su un intervallo lungo, solo la luna nuova e la luna piena, o solo la luna piena.';

  @override
  String get chartsTemperatureTitle => 'Temperatura e muco cervicale';

  @override
  String get chartsTemperatureEmpty =>
      'Ancora nulla di registrato in questo intervallo. Tocca un giorno nel calendario per aggiungere una temperatura o il muco cervicale.';

  @override
  String chartsTemperatureCaption(String unit) {
    return 'Ogni punto è la temperatura di un giorno, in $unit, unita a quella del giorno dopo quando sono state misurate entrambe. Un punto vuoto indica una misurazione forse alterata e non viene unito agli altri. Sotto, il muco cervicale: barre più alte significano più bagnato (sensazione) e più trasparente ed elastico (aspetto). I giorni di mestruazioni sono ombreggiati.';
  }

  @override
  String get chartsFeelings => 'Stati d’animo';

  @override
  String get chartsAroundPeriods => 'Intorno alle mestruazioni';

  @override
  String get chartsAroundMoon => 'Intorno alla luna';

  @override
  String get chartsFeelingsEmptyMoon =>
      'Quando avrai scelto come stavi in qualche giorno di questo intervallo, qui vedrai quali stati d’animo sono comparsi intorno alla luna piena e alla luna nuova.';

  @override
  String get chartsFeelingsEmptyPeriods =>
      'Quando avrai scelto come stavi in qualche giorno di questo intervallo, e da allora saranno iniziate delle mestruazioni, qui vedrai quali stati d’animo sono comparsi e quando.';

  @override
  String get chartsFeelingsCaptionMoon =>
      'In quanti giorni è stata scelta ogni faccina.';

  @override
  String get chartsFeelingsCaptionPeriods =>
      'In quanti giorni è stata scelta ogni faccina. I giorni dall’inizio delle ultime mestruazioni vengono contati solo quando iniziano le successive.';

  @override
  String get chartsNoneYet => 'Ancora nessuno.';

  @override
  String get chartsGroupDuringPeriod => 'Durante le mestruazioni';

  @override
  String get chartsGroupBeforePeriod => 'Poco prima delle mestruazioni';

  @override
  String get chartsGroupOtherDays => 'Altri giorni';

  @override
  String get chartsGroupFullMoon => 'Intorno alla luna piena';

  @override
  String get chartsGroupNewMoon => 'Intorno alla luna nuova';

  @override
  String get chartsDetailLoggedPeriodDays =>
      'giorni di mestruazioni registrati';

  @override
  String chartsDetailUsuallyDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'di solito $days giorni',
      one: 'di solito 1 giorno',
    );
    return '$_temp0';
  }

  @override
  String chartsDetailDaysBefore(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'i $days giorni prima',
      one: 'il giorno prima',
    );
    return '$_temp0';
  }

  @override
  String get chartsDetailRestOfCycle => 'il resto del ciclo';

  @override
  String get chartsDetailDayItself => 'solo quel giorno';

  @override
  String chartsDetailDayEitherSide(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'quel giorno, ±$days giorni',
      one: 'quel giorno, ±1 giorno',
    );
    return '$_temp0';
  }

  @override
  String get chartsDetailRestOfMonth => 'il resto del mese';

  @override
  String chartsFeelingCount(String feeling, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count giorni',
      one: '1 giorno',
    );
    return '$feeling in $_temp0';
  }

  @override
  String chartsFeelingGroupSummary(String group, String detail, String counts) {
    return '$group, $detail: $counts';
  }

  @override
  String get chartsFeelingGroupNone => 'ancora nessuno';

  @override
  String chartsRatingSummary(String from, String to, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count giorni con voto',
      one: '1 giorno con voto',
    );
    return 'Voti delle giornate dal $from al $to: $_temp0, con i giorni di mestruazioni ombreggiati.';
  }

  @override
  String chartsRatingSummaryMoons(String from, String to, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count giorni con voto',
      one: '1 giorno con voto',
    );
    return 'Voti delle giornate dal $from al $to: $_temp0, con i giorni di mestruazioni ombreggiati e le fasi lunari segnate.';
  }

  @override
  String chartsLanesSummary(String from, String to, String lanes) {
    return 'Mestruazioni dal $from al $to. $lanes.';
  }

  @override
  String chartsLane(String name, String periods) {
    return '$name: $periods';
  }

  @override
  String get chartsLaneNone => 'nessun giorno di mestruazioni';

  @override
  String chartsLaneRun(String from, String to) {
    return 'dal $from al $to';
  }

  @override
  String chartsLaneRunEstimated(String from, String to) {
    return 'dal $from al $to, stimate';
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
      other: '$mucusDays giorni',
      one: '1 giorno',
    );
    return 'Temperature dal $from al $to: $range, muco cervicale annotato in $_temp0, con i giorni di mestruazioni ombreggiati.';
  }

  @override
  String get chartsNoTemperatures => 'nessuna temperatura';

  @override
  String chartsTemperatureRange(int count, String low, String high) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count temperature',
      one: '1 temperatura',
    );
    return '$_temp0, da $low a $high';
  }

  @override
  String get chartsMucusFelt => 'Sens.';

  @override
  String get chartsMucusLooked => 'Asp.';

  @override
  String get faceRatingRough => 'Dura';

  @override
  String get faceRatingNotGreat => 'Così così';

  @override
  String get faceRatingOkay => 'Normale';

  @override
  String get faceRatingGood => 'Buona';

  @override
  String get faceRatingGreat => 'Ottima';

  @override
  String get faceRatingRoughInline => 'dura';

  @override
  String get faceRatingNotGreatInline => 'così così';

  @override
  String get faceRatingOkayInline => 'normale';

  @override
  String get faceRatingGoodInline => 'buona';

  @override
  String get faceRatingGreatInline => 'ottima';

  @override
  String faceRatingOption(int rating, String name) {
    return '$rating, $name';
  }

  @override
  String get faceMoreFaces => 'Altre faccine';

  @override
  String get faceDifferentFace => 'Un’altra faccina';

  @override
  String get faceOther => 'Altra faccina';

  @override
  String get faceSmilingCat => 'Gatto sorridente';

  @override
  String get faceGrinningCat => 'Gatto che ride';

  @override
  String get faceCatTearsOfJoy => 'Gatto con lacrime di gioia';

  @override
  String get faceCatHeartEyes => 'Gatto con occhi a cuore';

  @override
  String get faceSmirkingCat => 'Gatto con sorrisetto';

  @override
  String get faceKissingCat => 'Gatto che bacia';

  @override
  String get faceWearyCat => 'Gatto esausto';

  @override
  String get faceCryingCat => 'Gatto che piange';

  @override
  String get facePoutingCat => 'Gatto imbronciato';

  @override
  String get faceAlien => 'Alieno';

  @override
  String get faceSpaceInvader => 'Mostro alieno';

  @override
  String get faceRobot => 'Robot';

  @override
  String get faceGhost => 'Fantasma';

  @override
  String get faceSkull => 'Teschio';

  @override
  String get faceClown => 'Pagliaccio';

  @override
  String get faceDevil => 'Diavoletto';

  @override
  String get faceUnicorn => 'Unicorno';

  @override
  String get faceFrog => 'Rana';

  @override
  String get facePartying => 'Festa';

  @override
  String get faceCool => 'Occhiali da sole';

  @override
  String get faceNerdy => 'Nerd';

  @override
  String get faceAngelic => 'Angioletto';

  @override
  String get faceHugging => 'Abbraccio';

  @override
  String get faceSilly => 'Linguaccia';

  @override
  String get faceUpsideDown => 'Sottosopra';

  @override
  String get faceSmirking => 'Sorrisetto';

  @override
  String get faceGrimacing => 'Smorfia';

  @override
  String get faceEyeRoll => 'Occhi al cielo';

  @override
  String get faceSpeechless => 'Senza parole';

  @override
  String get facePleading => 'Occhi supplicanti';

  @override
  String get faceSobbing => 'Pianto a dirotto';

  @override
  String get faceScreaming => 'Urlo';

  @override
  String get faceFlushed => 'Guance rosse';

  @override
  String get faceOverwhelmed => 'Al limite';

  @override
  String get faceWoozy => 'Testa che gira';

  @override
  String get faceUnwell => 'Malessere';

  @override
  String get faceHurting => 'Dolore';

  @override
  String get faceQueasy => 'Nausea';

  @override
  String get faceTooHot => 'Troppo caldo';

  @override
  String get faceTooCold => 'Troppo freddo';

  @override
  String get faceSparklingHeart => 'Cuore scintillante';

  @override
  String get faceBrokenHeart => 'Cuore spezzato';

  @override
  String get faceFire => 'Fuoco';

  @override
  String get faceRainbow => 'Arcobaleno';

  @override
  String get faceSun => 'Sole';

  @override
  String get faceRain => 'Pioggia';

  @override
  String get faceStorm => 'Temporale';

  @override
  String get faceBlossom => 'Fiore';

  @override
  String get faceChocolate => 'Cioccolato';

  @override
  String get faceInBed => 'A letto';

  @override
  String get homeCalendar => 'Calendario';

  @override
  String get homeHistory => 'Storico';

  @override
  String get homeCharts => 'Grafici';

  @override
  String get homeSettings => 'Impostazioni';

  @override
  String homeCalendarOf(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Il tuo calendario',
      'other': 'Calendario di $name',
    });
    return '$_temp0';
  }

  @override
  String homeHistoryOf(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Il tuo storico',
      'other': 'Storico di $name',
    });
    return '$_temp0';
  }

  @override
  String homeChartsOf(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'I tuoi grafici',
      'other': 'Grafici di $name',
    });
    return '$_temp0';
  }

  @override
  String get homeWhenStarted => 'Quando sono iniziate?';

  @override
  String get homeWhenEnded => 'Quando sono finite?';

  @override
  String homePeriodEndedToday(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Le mie mestruazioni sono finite oggi',
      'other': 'Le mestruazioni di $name sono finite oggi',
    });
    return '$_temp0';
  }

  @override
  String homePeriodStartedToday(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Le mie mestruazioni sono iniziate oggi',
      'other': 'Le mestruazioni di $name sono iniziate oggi',
    });
    return '$_temp0';
  }

  @override
  String get homeEndedEarlier => 'Sono finite in un giorno precedente';

  @override
  String get homeStartedEarlier => 'Sono iniziate in un giorno precedente';

  @override
  String homeAddLastEnd(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Aggiungi quando sono finite le tue ultime mestruazioni',
      'other': 'Aggiungi quando sono finite le ultime mestruazioni di $name',
    });
    return '$_temp0';
  }

  @override
  String homeSharedCopy(String who, String name, String date) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you':
          'Importato dal tuo telefono il $date. Qui non si può modificare, e viene aggiornato quando lo invii di nuovo.',
      'other':
          'Importato dal telefono di $name il $date. Qui non si può modificare, e viene aggiornato quando $name lo invia di nuovo.',
    });
    return '$_temp0';
  }

  @override
  String homeNoPeriodSince(String date) {
    return 'Nessuna mestruazione registrata dal $date';
  }

  @override
  String get homeMissedOne =>
      'Ebb ha supposto che delle mestruazioni non siano state registrate e ha fatto la stima partendo da lì. Se ricordi quando sono iniziate, aggiungile per correggere la stima.';

  @override
  String get homeMissedSome =>
      'Ebb ha supposto che alcune mestruazioni non siano state registrate e ha fatto la stima partendo da lì. Se ricordi quando sono iniziate, aggiungile per correggere la stima.';

  @override
  String get homeWelcome => 'Ti diamo il benvenuto in Ebb';

  @override
  String get homeNothingYet => 'Ancora nulla di registrato';

  @override
  String homeFirstLog(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Registra il primo giorno delle tue prossime mestruazioni, o aggiungi quelle passate se le ricordi, ed Ebb inizierà a imparare il tuo ritmo. Tutto resta su questo telefono.',
      'other':
          'Registra il primo giorno delle prossime mestruazioni di $name, o aggiungi quelle passate se le ricordi, ed Ebb inizierà a imparare il ritmo. Tutto resta su questo telefono.',
    });
    return '$_temp0';
  }

  @override
  String homeDayOfPeriod(String who, String name, int day) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Giorno $day delle tue mestruazioni',
      'other': 'Giorno $day delle mestruazioni di $name',
    });
    return '$_temp0';
  }

  @override
  String homeDayOfCycle(String who, String name, int day) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Giorno $day del tuo ciclo',
      'other': 'Giorno $day del ciclo di $name',
    });
    return '$_temp0';
  }

  @override
  String get homeTellEnd =>
      'Fai sapere a Ebb quando finiscono, così la stima resta precisa.';

  @override
  String homeDaysUntil(String who, String name, int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Mancano circa $days giorni alle tue mestruazioni previste.',
    );
    String _temp1 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Mancano circa $days giorni alle mestruazioni previste di $name.',
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
      'you': 'Le tue mestruazioni sono previste per domani.',
      'other': 'Le mestruazioni di $name sono previste per domani.',
    });
    return '$_temp0';
  }

  @override
  String homeExpectedToday(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Le tue mestruazioni sono previste per oggi.',
      'other': 'Le mestruazioni di $name sono previste per oggi.',
    });
    return '$_temp0';
  }

  @override
  String homeDaysLate(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other:
          'In ritardo di $days giorni rispetto al previsto. I cicli variano per tanti motivi.',
      one: 'In ritardo di 1 giorno rispetto al previsto. I cicli variano per tanti motivi.',
    );
    return '$_temp0';
  }

  @override
  String get homeRingDay => 'GIORNO';

  @override
  String homeRingOfCycle(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'del tuo ciclo',
      'other': 'del ciclo di $name',
    });
    return '$_temp0';
  }

  @override
  String homeRingOfPeriod(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'delle tue mestruazioni',
      'other': 'delle mestruazioni di $name',
    });
    return '$_temp0';
  }

  @override
  String get homeKeyPeriod => 'Mestruazioni';

  @override
  String get homeKeyLikelyNext => 'Prossime probabili';

  @override
  String get homeKeyToday => 'Oggi';

  @override
  String get homeAddPastPeriods => 'Aggiungi mestruazioni passate';

  @override
  String get homeAddMissedPeriod => 'Aggiungi mestruazioni non registrate';

  @override
  String get homeNextPeriod => 'Prossime mestruazioni';

  @override
  String homeLikelyBetween(String from, String to) {
    return 'probabilmente tra $from e $to';
  }

  @override
  String get homeFertileWindow => 'Finestra fertile stimata';

  @override
  String get homeFertileWarning =>
      'Una stima basata solo sulla durata del ciclo. Non abbastanza affidabile da usare come contraccezione.';

  @override
  String homeConfidenceUnlogged(String date) {
    return 'Stima basata sulle ultime mestruazioni registrate, iniziate il $date, quindi potrebbe essere meno precisa del solito.';
  }

  @override
  String get homeConfidenceNone => 'Ancora nulla di registrato.';

  @override
  String get homeConfidenceTypical =>
      'Per ora basato su un ciclo tipico di 28 giorni. Diventerà più preciso man mano che registri.';

  @override
  String homeConfidenceFew(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Basato finora su $count cicli, quindi per ora potrebbe essere meno preciso.',
      one: 'Basato finora su 1 ciclo, quindi per ora potrebbe essere meno preciso.',
    );
    return '$_temp0';
  }

  @override
  String homeConfidenceIrregular(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'I tuoi cicli variano parecchio, quindi questa è una stima ampia e non una data certa.',
      'other':
          'I cicli di $name variano parecchio, quindi questa è una stima ampia e non una data certa.',
    });
    return '$_temp0';
  }

  @override
  String homeConfidenceLast(String who, String name, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Basato sui tuoi ultimi $count cicli.',
    );
    String _temp1 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Basato sugli ultimi $count cicli di $name.',
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
      other: 'Basato su $count cicli abbastanza regolari.',
    );
    return '$_temp0';
  }

  @override
  String get homeMilestoneFirstPeriod => 'Prime mestruazioni registrate';

  @override
  String get homeMilestoneFirstCycle => 'Primo ciclo completo';

  @override
  String get homeMilestoneThreeCycles => 'Tre cicli completi';

  @override
  String get homeMilestoneSixCycles => 'Sei cicli completi';

  @override
  String get homeMilestoneOneYear => 'Un anno di storico';

  @override
  String get homeMilestoneTwoYears => 'Due anni di storico';

  @override
  String get homeMilestoneFiveYears => 'Cinque anni di storico';

  @override
  String get homeMilestoneFirstBackup => 'Primo backup salvato';

  @override
  String homeMilestoneFirstPeriodMessage(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Le tue prime mestruazioni in Ebb.',
      'other': 'Le prime mestruazioni di $name in Ebb.',
    });
    return '$_temp0';
  }

  @override
  String homeMilestoneFirstCycleMessage(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you':
          'Un primo ciclo completo. Ebb può iniziare a imparare il tuo ritmo.',
      'other':
          'Un primo ciclo completo. Ebb può iniziare a imparare il ritmo di $name.',
    });
    return '$_temp0';
  }

  @override
  String get homeMilestoneThreeCyclesMessage =>
      'Tre cicli completi registrati. Ognuno dà a Ebb più informazioni su cui basarsi.';

  @override
  String get homeMilestoneSixCyclesMessage =>
      'Sei cicli completi registrati: tanti quanti Ebb ne considera per ogni stima.';

  @override
  String homeMilestoneOneYearMessage(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Un anno del tuo storico in Ebb.',
      'other': 'Un anno dello storico di $name in Ebb.',
    });
    return '$_temp0';
  }

  @override
  String homeMilestoneTwoYearsMessage(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Due anni del tuo storico in Ebb.',
      'other': 'Due anni dello storico di $name in Ebb.',
    });
    return '$_temp0';
  }

  @override
  String homeMilestoneFiveYearsMessage(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Cinque anni del tuo storico in Ebb.',
      'other': 'Cinque anni dello storico di $name in Ebb.',
    });
    return '$_temp0';
  }

  @override
  String get homeMilestoneFirstBackupMessage =>
      'Il tuo primo backup è salvato. Conservane una copia da qualche parte che non sia questo telefono.';

  @override
  String get homeProblemStartInFuture =>
      'La data di inizio non può essere nel futuro.';

  @override
  String get homeProblemEndInFuture =>
      'La data di fine non può essere nel futuro.';

  @override
  String get homeProblemEndBeforeStart =>
      'La data di fine è precedente alla data di inizio.';

  @override
  String get homeProblemDuplicateStart =>
      'Ci sono già mestruazioni registrate che iniziano in quel giorno.';

  @override
  String get homeProblemOverlapsPrevious =>
      'Si sovrappone alle mestruazioni precedenti. Controlla la data di fine della voce precedente.';

  @override
  String get homeProblemOverlapsNext =>
      'Si sovrappone alle mestruazioni successive. Controlla la data di fine.';

  @override
  String get homeDeleteCycleTitle => 'Eliminare questo ciclo?';

  @override
  String homeDeleteCycleBody(String date) {
    return 'La voce che inizia il $date verrà rimossa. Non si può annullare.';
  }

  @override
  String get homeFirstDayOfPeriod => 'Primo giorno delle mestruazioni';

  @override
  String get homeLastDayOfPeriod => 'Ultimo giorno delle mestruazioni';

  @override
  String get homeAddPastPeriodTitle => 'Aggiungi mestruazioni passate';

  @override
  String get homeEditPeriod => 'Modifica mestruazioni';

  @override
  String get homeStarted => 'Inizio';

  @override
  String get homeEnded => 'Fine';

  @override
  String get homeStillGoing => 'Ancora in corso';

  @override
  String get homeNotRecorded => 'Non registrata';

  @override
  String get homeClearEnd => 'Togli la data di fine';

  @override
  String get homeCountInPredictions => 'Conta questo ciclo nelle previsioni';

  @override
  String get homeCountInPredictionsHint =>
      'Disattivalo per un ciclo che non rispecchia il ritmo abituale: una malattia, un cambio di farmaci, un aborto spontaneo. Resta comunque nel tuo storico.';

  @override
  String get homeNote => 'Nota';

  @override
  String get homeNoteExcludedHint =>
      'Perché non viene conteggiato, così è facile ricordarlo in seguito.';

  @override
  String get homeNoteHint =>
      'Qualcosa che vale la pena ricordare su queste mestruazioni.';

  @override
  String get homeDeletePeriod => 'Elimina queste mestruazioni';

  @override
  String get homeAddPastPeriod => 'Aggiungi mestruazioni passate';

  @override
  String get homeHistoryEmpty =>
      'Ancora nessun ciclo registrato. Se ricordi quando sono iniziate le ultime mestruazioni, aggiungile: così Ebb avrà già una base da cui partire.';

  @override
  String get homeMilestones => 'Traguardi';

  @override
  String homePeriodLength(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Mestruazioni di $count giorni',
      one: 'Mestruazioni di 1 giorno',
    );
    return '$_temp0';
  }

  @override
  String get homePeriodInProgress => 'Mestruazioni in corso';

  @override
  String get homeEndNotRecorded => 'Fine non registrata';

  @override
  String get homeLongGap =>
      'Un lungo intervallo. Se qui ci sono mestruazioni non registrate, aggiungile con «Aggiungi mestruazioni passate».';

  @override
  String get homeNothingSince =>
      'Nulla di registrato da allora. Se mancano delle mestruazioni, aggiungile con «Aggiungi mestruazioni passate».';

  @override
  String homeNotCounted(String detail) {
    return '$detail · escluso dalle previsioni';
  }

  @override
  String get homeDayCycle => 'giorni di ciclo';

  @override
  String get homeLastLogged => 'Ultimo registrato';

  @override
  String get homeCurrent => 'In corso';

  @override
  String get homeSpanMonths3 => 'Ultimi 3 mesi';

  @override
  String get homeSpanMonths6 => 'Ultimi 6 mesi';

  @override
  String get homeSpanYear => 'Ultimo anno';

  @override
  String get homeSpanAll => 'Tutto';

  @override
  String get homeSpanCustom => 'Scegli le date…';

  @override
  String get settingsTitle => 'Impostazioni';

  @override
  String get settingsNotificationsOff =>
      'Le notifiche di Ebb sono disattivate nelle impostazioni di sistema.';

  @override
  String settingsNoBrowser(String website) {
    return 'Nessun browser per aprirlo. Visita $website.';
  }

  @override
  String get settingsNothingToBackUp => 'Ancora niente di cui fare il backup.';

  @override
  String get settingsBackupSaved =>
      'Backup salvato. Conservane una copia da qualche parte che non sia questo telefono.';

  @override
  String get settingsBackupNotSaved =>
      'Impossibile salvare il backup lì. Prova un’altra posizione.';

  @override
  String get settingsNoPicker =>
      'Questo telefono non ha un selettore di file che Ebb possa usare. L’invio a un altro telefono funziona anche senza.';

  @override
  String get settingsFileTooLarge =>
      'Questo file è troppo grande per essere un backup di Ebb.';

  @override
  String get settingsFileUnreadable => 'Impossibile leggere il file.';

  @override
  String get settingsNotABackup => 'Questo file non è un backup di Ebb.';

  @override
  String settingsPeriodCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mestruazioni',
      one: '$count mestruazione',
    );
    return '$_temp0';
  }

  @override
  String get settingsSetUpTitle => 'Iniziare con questo storico?';

  @override
  String settingsSetUpBody(String periods, String date) {
    return 'Storico inviato il $date, con $periods. Su questo telefono diventa il tuo storico.';
  }

  @override
  String settingsUpdateTitle(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Aggiornare il tuo storico?',
      'other': 'Aggiornare $name?',
    });
    return '$_temp0';
  }

  @override
  String settingsUpdateAction(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Aggiorna il tuo storico',
      'other': 'Aggiorna $name',
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
          'È di nuovo il tuo storico, inviato il $date: $periods. Sostituisce la copia su questo telefono.',
      'other':
          'È di nuovo lo storico di $name, inviato il $date: $periods. Sostituisce la copia su questo telefono.',
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
          'È il tuo storico, inviato il $date: $periods. Sostituisce ciò che c’è su questo telefono per te, compreso tutto ciò che hai registrato qui nel frattempo.',
      'other':
          'È lo storico di $name, inviato il $date: $periods. Sostituisce ciò che c’è su questo telefono per $name, compreso tutto ciò che è stato registrato qui nel frattempo.',
    });
    return '$_temp0';
  }

  @override
  String get settingsReplaceEverything => 'Sostituisci tutto';

  @override
  String settingsPersonUpdated(String name) {
    return '$name: storico aggiornato.';
  }

  @override
  String get settingsAddThisHistoryTitle => 'Aggiungere questo storico?';

  @override
  String settingsAddNamedTitle(String name) {
    return 'Aggiungere $name?';
  }

  @override
  String settingsAddBody(String periods) {
    return 'Contiene $periods. Puoi aggiungerlo accanto a ciò che c’è già, oppure sostituire con esso tutto ciò che c’è su questo telefono.';
  }

  @override
  String settingsAddNamedBody(String name, String periods) {
    return 'Lo storico di $name contiene $periods. Puoi aggiungerlo accanto a ciò che c’è già, oppure sostituire con esso tutto ciò che c’è su questo telefono.';
  }

  @override
  String get settingsAddAsNew => 'Aggiungi come nuova persona';

  @override
  String get settingsWhoIsThis => 'Chi è?';

  @override
  String get settingsWhoIsThisHint =>
      'Un nome per distinguere le persone su questo telefono.';

  @override
  String settingsPersonAdded(String name) {
    return 'Persona aggiunta: $name.';
  }

  @override
  String get settingsRestored => 'Fatto. Ebb è stata aggiornata.';

  @override
  String get settingsReplaceTitle => 'Sostituire ciò che c’è in Ebb?';

  @override
  String settingsReplaceSaved(String date, String periods) {
    return 'Salvato il $date, con $periods.';
  }

  @override
  String settingsReplaceSavedPeople(int people, String date, String periods) {
    String _temp0 = intl.Intl.pluralLogic(
      people,
      locale: localeName,
      other: 'Salvato il $date, con $periods per $people persone.',
    );
    return '$_temp0';
  }

  @override
  String settingsReplaceCurrent(String periods) {
    return 'Sostituisce tutto ciò che c’è ora in Ebb, tra cui $periods su questo telefono.';
  }

  @override
  String get settingsReplace => 'Sostituisci';

  @override
  String get settingsDeleteAllTitle => 'Eliminare tutti i dati?';

  @override
  String get settingsDeleteAllBody =>
      'Ogni ciclo e ogni nota verranno cancellati definitivamente. Ebb non ne conserva altre copie, quindi non si può annullare, a meno che tu non abbia salvato un file di backup.';

  @override
  String get settingsDeleteAllBodyEveryone =>
      'Ogni ciclo e ogni nota, per tutte le persone su questo telefono, verranno cancellati definitivamente. Ebb non ne conserva altre copie, quindi non si può annullare, a meno che tu non abbia salvato un file di backup.';

  @override
  String get settingsDeleteEverything => 'Elimina tutto';

  @override
  String get settingsAllDeleted => 'Tutti i dati sono stati eliminati.';

  @override
  String get settingsYourName => 'Il tuo nome';

  @override
  String get settingsRename => 'Rinomina';

  @override
  String get settingsYourNameHint =>
      'Compare nell’elenco delle persone. Lascia vuoto per comparire come «Tu».';

  @override
  String settingsRemoveTitle(String name) {
    return 'Rimuovere $name da questo telefono?';
  }

  @override
  String settingsRemoveBody(String name) {
    return 'Ogni ciclo e ogni nota di $name verranno cancellati definitivamente. Lo storico delle altre persone non viene toccato.';
  }

  @override
  String settingsPersonRemoved(String name) {
    return 'Persona rimossa: $name.';
  }

  @override
  String settingsRemovePerson(String name) {
    return 'Rimuovi $name da questo telefono';
  }

  @override
  String get settingsYourCycle => 'Il tuo ciclo';

  @override
  String get settingsYourSettings => 'Le tue impostazioni';

  @override
  String settingsSettingsFor(String name) {
    return 'Impostazioni per $name';
  }

  @override
  String get settingsName => 'Nome';

  @override
  String get settingsReminders => 'Promemoria';

  @override
  String settingsRemindersHint(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Un preavviso prima delle tue mestruazioni previste.',
      'other': 'Un preavviso prima delle mestruazioni previste di $name.',
    });
    return '$_temp0';
  }

  @override
  String get settingsRemindMe => 'Ricordamelo';

  @override
  String settingsDaysAhead(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count giorni prima',
      one: '$count giorno prima',
    );
    return '$_temp0';
  }

  @override
  String settingsDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count giorni',
      one: '$count giorno',
    );
    return '$_temp0';
  }

  @override
  String get settingsFertile => 'Mostra la stima della finestra fertile';

  @override
  String get settingsFertileHint =>
      'Disattivata di base. Una stima basata solo sulla durata del ciclo: non abbastanza affidabile da usare come contraccezione.';

  @override
  String get settingsMoon => 'Mostra le fasi lunari';

  @override
  String get settingsMoonHint =>
      'Luna nuova, primo quarto, luna piena e ultimo quarto, nel calendario e nei grafici.';

  @override
  String get settingsTemperature => 'Registra temperatura e muco cervicale';

  @override
  String get settingsTemperatureHint =>
      'In ogni giorno del calendario, con un grafico della temperatura. Vengono solo registrati e mostrati nel grafico, mai usati per le stime.';

  @override
  String get settingsTemperatureIn => 'Temperatura in';

  @override
  String get settingsCelebrate => 'Festeggia i traguardi';

  @override
  String settingsCelebrateHint(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Un piccolo festeggiamento per cose come il primo ciclo completo o un anno di storico, elencate nel tuo Storico.',
      'other':
          'Un piccolo festeggiamento per cose come il primo ciclo completo o un anno di storico, elencate nello Storico di $name.',
    });
    return '$_temp0';
  }

  @override
  String get settingsPeople => 'Persone';

  @override
  String get settingsAddSomeone => 'Aggiungi qualcuno';

  @override
  String get settingsTrackSomeoneElse => 'Segui anche un’altra persona';

  @override
  String get settingsTrackSomeoneElseHint =>
      'Per esempio, chi ha appena avuto le prime mestruazioni.';

  @override
  String get settingsBackupSection => 'Backup e trasferimento';

  @override
  String get settingsBackUp => 'Esegui il backup su un file';

  @override
  String get settingsBackUpHint =>
      'Salva il tuo storico in un file, dove scegli tu.';

  @override
  String get settingsBackUpHintEveryone =>
      'Salva lo storico di tutti in un file, dove scegli tu.';

  @override
  String get settingsRestore => 'Ripristina da un backup';

  @override
  String get settingsRestoreHint => 'Sostituisce ciò che c’è ora in Ebb.';

  @override
  String get settingsSend => 'Invia a un altro telefono';

  @override
  String get settingsSendHint =>
      'Mostra il tuo storico come codici da far scansionare a un altro telefono.';

  @override
  String get settingsSendHintEveryone =>
      'Mostra lo storico di tutti come codici da far scansionare a un altro telefono.';

  @override
  String get settingsReceive => 'Ricevi da un altro telefono';

  @override
  String get settingsReceiveHint =>
      'Scansiona i codici per aggiungere qualcuno, aggiornarlo o sostituire tutto.';

  @override
  String get settingsAdvanced => 'Avanzate';

  @override
  String get settingsGroups => 'Gruppi';

  @override
  String get settingsGroupsHint =>
      'Per cerchie e gruppi che tengono traccia insieme: riunisci delle persone sotto un nome. Disattivandolo, i gruppi vengono nascosti senza eliminarli.';

  @override
  String get settingsManageGroups => 'Gestisci i gruppi';

  @override
  String get settingsAboutEbb => 'Informazioni su Ebb';

  @override
  String get settingsHowEbbWorks => 'Come funziona Ebb';

  @override
  String get settingsHowEbbWorksHint => 'Registrazione, stime, backup e altro.';

  @override
  String get settingsYourData => 'I tuoi dati';

  @override
  String get settingsYourDataHint => 'Dove si trovano e chi può vederli.';

  @override
  String get settingsWebsite => 'Sito web';

  @override
  String get settingsSendFeedback => 'Invia un commento';

  @override
  String get settingsSendFeedbackHint =>
      'Un modulo sul sito web, nel tuo browser.';

  @override
  String get settingsDeleteAll => 'Elimina tutti i dati';

  @override
  String settingsVersion(String version) {
    return 'Ebb $version\nRealizzata da SuperDaveLab';
  }

  @override
  String get settingsDataHeadline => 'Il tuo ciclo è affar tuo.';

  @override
  String get settingsDataLede =>
      'Ebb è fatta in modo che la domanda «cosa fanno con i miei dati?» abbia una risposta noiosa: niente, perché non li riceviamo mai.';

  @override
  String get settingsDataTradeOff =>
      'Un compromesso da sapere: non c’è una copia nel cloud, quindi se perdi o resetti il telefono perdi lo storico. Se per te è importante, salva ogni tanto un file di backup dalle Impostazioni e conservalo da qualche parte che non sia questo telefono.';

  @override
  String get settingsWhereDataLives => 'Dove si trovano i tuoi dati';

  @override
  String get settingsWhereDataLivesHint => 'I tuoi dati e chi può vederli.';

  @override
  String get settingsDataStaysTitle => 'Resta sul tuo telefono';

  @override
  String get settingsDataStaysBody =>
      'Tutto ciò che registri viene scritto in un database su questo dispositivo. Non c’è nessun account da creare e nessun server con cui sincronizzarsi. Va altrove solo se lo sposti tu: un file di backup, o un altro telefono a cui lo invii.';

  @override
  String get settingsDataUnseenTitle => 'Noi non possiamo vederlo';

  @override
  String get settingsDataUnseenBody =>
      'Ebb è realizzata senza alcun permesso di usare internet. Lo garantisce Android, e puoi verificarlo nell’elenco dei permessi dell’app.';

  @override
  String get settingsDataPermissionsTitle => 'A cosa servono i permessi';

  @override
  String get settingsDataPermissionsBody =>
      'Notifiche, per i promemoria. Fotocamera, solo mentre ricevi lo storico da un altro telefono: legge i codici e nulla viene registrato o conservato. Ebb inoltre reimposta i promemoria quando il telefono si riavvia. L’elenco è tutto qui.';

  @override
  String get settingsDataNotForSaleTitle => 'Non c’è niente da vendere';

  @override
  String get settingsDataNotForSaleBody =>
      'Nessuna analisi statistica, nessuna pubblicità, nessuna libreria di terze parti che invia dati. Visto che i tuoi dati non ci raggiungono mai, non ne esiste una copia che qualcuno possa comprare, sequestrare o diffondere.';

  @override
  String get settingsDataEraseTitle => 'Puoi cancellarli all’istante';

  @override
  String get settingsDataEraseBody =>
      'Eliminando i dati nelle Impostazioni, o disinstallando Ebb, si rimuove tutto ciò che Ebb conserva. Ebb non ne tiene altre copie: le uniche sono i file di backup che hai salvato o i telefoni a cui li hai inviati tu.';

  @override
  String get settingsDataOpenSourceTitle => 'Puoi verificare il nostro lavoro';

  @override
  String get settingsDataOpenSourceBody =>
      'Ebb è open source, con licenza GNU General Public License. Chiunque può leggere esattamente cosa fa, e le versioni pubblicate sono compilate da quello stesso codice.';

  @override
  String get settingsHelpLoggingTitle => 'Registrare le mestruazioni';

  @override
  String get settingsHelpLoggingBody =>
      'Tocca «Le mie mestruazioni sono iniziate oggi» il primo giorno di sanguinamento, e «Le mie mestruazioni sono finite oggi» l’ultimo.\n\nHai dimenticato di registrarle? Usa invece «Sono iniziate in un giorno precedente». Qualsiasi mestruazione passata si può aggiungere o correggere nello Storico (l’icona dell’orologio): toccala per cambiarne le date o aggiungere una nota.\n\nSe entro due settimane non viene registrata la fine, Ebb smette di considerare le mestruazioni ancora in corso e propone invece di aggiungerne la fine.';

  @override
  String get settingsHelpEstimateTitle => 'Come funziona la stima';

  @override
  String get settingsHelpEstimateBody =>
      'Ebb guarda gli intervalli tra gli inizi delle tue ultime mestruazioni, fino alle ultime sei.\n\nCon poco storico si basa su un ciclo tipico di 28 giorni, e lo dice. Più registri, più la stima rispecchia il tuo ritmo.\n\nMostra un intervallo invece di una sola data, e ti dice quanto è sicura. Se i tuoi cicli variano molto, l’intervallo è più ampio.\n\nSe le mestruazioni sono in ritardo, Ebb dice di quanto. Se per quasi due cicli non viene registrato nulla, suppone che delle mestruazioni non siano state registrate, fa la stima partendo da lì, e lo dice. Lo Storico segnala i lunghi intervalli, e aggiungere delle mestruazioni mancanti corregge la stima.';

  @override
  String get settingsHelpExcludeTitle => 'Un ciclo che non dovrebbe contare';

  @override
  String get settingsHelpExcludeBody =>
      'Una malattia, un cambio di farmaci o un aborto spontaneo possono sballare completamente un ciclo, che si porterebbe dietro la stima.\n\nNello Storico, tocca quelle mestruazioni e disattiva «Conta questo ciclo nelle previsioni». Resta nel tuo storico; la stima semplicemente lo ignora. Aggiungi lì anche una nota, così ricorderai il perché.';

  @override
  String get settingsHelpGroupsTitle => 'Gruppi';

  @override
  String get settingsHelpGroupsBody =>
      'Per cerchie e gruppi che tengono traccia insieme. Attivali in Impostazioni → Avanzate, poi crea un gruppo e scegli chi ne fa parte. «Vedi … insieme» nell’elenco delle persone mostra tutti fianco a fianco, con la luna.\n\nUn gruppo può avere due tipi di membri. Chi viene aggiunto è seguito su questo telefono, e qui registri tu per quella persona. Chi viene importato continua a tenere traccia sul proprio telefono e fornisce il proprio storico al gruppo: resta suo, e non si può modificare sul telefono di nessun altro.\n\nPer farti importare, invia solo il tuo storico (Impostazioni → Invia a un altro telefono), tanto o poco quanto vuoi, con o senza le note giornaliere. L’altro telefono lo importa dal gruppo: Gestisci i gruppi → il gruppo → Importa dal suo telefono. Importarti di nuovo lo aggiorna.\n\nLo storico importato appartiene al suo gruppo. Togliere una persona importata dal suo ultimo gruppo, o eliminare quel gruppo, rimuove anche il suo storico dal telefono. E non si può inoltrare: si può inviare solo il proprio storico.';

  @override
  String get settingsHelpRatingsTitle => 'Voti, stati d’animo e grafici';

  @override
  String get settingsHelpRatingsBody =>
      'Tocca un giorno qualsiasi nel calendario per dargli un voto da 1 a 5 e scegliere una faccina per come stavi. Entrambi sono facoltativi; tocca di nuovo una scelta per toglierla.\n\nGrafici (l’icona del grafico) mostra il voto di ogni giorno nelle date che scegli, con le mestruazioni ombreggiate, e quali stati d’animo sono comparsi durante e prima delle mestruazioni. Con le fasi lunari attive nelle Impostazioni, c’è anche la luna.\n\nI grafici mostrano ciò che hai registrato. Non dicono cosa significa: quello sta a te giudicarlo.';

  @override
  String get settingsHelpTemperatureTitle => 'Temperatura e muco cervicale';

  @override
  String get settingsHelpTemperatureBody =>
      'Attiva «Registra temperatura e muco cervicale» nelle Impostazioni, e ogni giorno del calendario avrà spazio per la temperatura al risveglio e per la sensazione e l’aspetto del muco cervicale. Se qualcosa potrebbe aver alterato una misurazione (malattia, poco sonno, alcol, misurarla tardi), spunta la casella sotto.\n\nGrafici mostra le temperature come una linea, con il muco sotto e le mestruazioni ombreggiate, in °C o °F (Impostazioni).\n\nEbb li registra e li mostra nel grafico, e nient’altro. Non cerca un rialzo né ne ricava i giorni fertili, e la sua stima della finestra fertile si basa comunque solo sulla durata del ciclo. Se segui un metodo come il metodo sintotermico, il grafico è lì perché tu lo legga secondo le sue regole.';

  @override
  String get settingsHelpRemindersTitle => 'Promemoria';

  @override
  String get settingsHelpRemindersBody =>
      'Un preavviso qualche giorno prima delle mestruazioni previste, e un altro il giorno stesso. Scegli quanto prima nelle Impostazioni.\n\nVengono programmati sul telefono stesso, quindi arrivano anche senza segnale e in modalità aereo.\n\nEbb li imposta ogni volta che la apri, in base all’ultima stima. Il telefono li conserva anche dopo un riavvio, ma Ebb non può aggiornarli mentre è chiusa, quindi aprila ogni tanto: basta registrare delle mestruazioni.\n\nAndroid potrebbe consegnarli un po’ dopo il solito orario per risparmiare batteria. Se Ebb viene forzata all’arresto, o un risparmio energetico la limita, potrebbero non arrivare finché non riapri Ebb.';

  @override
  String get settingsHelpFertileTitle => 'La finestra fertile';

  @override
  String get settingsHelpFertileBody =>
      'Disattivata, a meno che tu non la attivi nelle Impostazioni. È stimata solo dalla durata del ciclo, che non è abbastanza affidabile da usare come contraccezione.';

  @override
  String get settingsHelpBackupTitle => 'Fare il backup';

  @override
  String get settingsHelpBackupBody =>
      'Non c’è una copia del tuo storico nel cloud, quindi se perdi o resetti il telefono perdi lo storico.\n\nImpostazioni → «Esegui il backup su un file» salva tutto in un file, dove scegli tu. Conservalo da qualche parte che non sia questo telefono. «Ripristina da un backup» lo riporta indietro.';

  @override
  String get settingsHelpMovingTitle => 'Passare a un nuovo telefono';

  @override
  String get settingsHelpMovingBody =>
      'Sul vecchio telefono: Impostazioni → «Invia a un altro telefono». Su quello nuovo: Impostazioni → «Ricevi da un altro telefono», e inquadra lo schermo con la fotocamera.\n\nGli storici più lunghi richiedono qualche codice, che cambia da solo; il nuovo telefono li raccoglie in qualsiasi ordine. Internet non c’entra: un telefono mostra, l’altro guarda.';

  @override
  String get settingsHelpSomeoneElseTitle => 'Seguire un’altra persona';

  @override
  String get settingsHelpSomeoneElseBody =>
      'Aiuti qualcun altro a tenere traccia, per esempio chi ha appena avuto le prime mestruazioni? Impostazioni → «Segui anche un’altra persona», e dalle un nome. Vanno bene un soprannome o un’iniziale.\n\nTocca il nome in cima alla schermata principale per passare da una persona all’altra. Ognuno ha i propri promemoria, che per le persone che aggiungi partono disattivati. La finestra fertile viene proposta solo per te.';

  @override
  String get settingsHelpHandoverTitle => 'Passare lo storico a qualcuno';

  @override
  String get settingsHelpHandoverBody =>
      'Quando una persona che segui ha un telefono suo: «Invia a un altro telefono», e scegli solo lei. Sul suo telefono, «Ricevi da un altro telefono». Su un’installazione nuova, il suo storico diventa semplicemente suo.\n\nDopo, Ebb chiede se rimuoverla dal tuo telefono. Non lo fa mai da sola.';

  @override
  String get settingsHelpDeletingTitle => 'Eliminare';

  @override
  String get settingsHelpDeletingBody =>
      'Impostazioni → «Elimina tutti i dati» cancella tutto ciò che c’è su questo telefono in un colpo solo.\n\nPer rimuovere una persona che hai aggiunto, apri le sue impostazioni e scegli «Rimuovi … da questo telefono». Lo storico delle altre persone non viene toccato.';

  @override
  String shareRemoveTitle(String name) {
    return 'Rimuovere $name da questo telefono?';
  }

  @override
  String shareRemoveBody(String name) {
    return 'Se lo storico di $name è arrivato sull’altro telefono, può essere tolto da questo. Puoi anche tenerlo qui.';
  }

  @override
  String get shareKeep => 'Tieni';

  @override
  String shareRemoved(String name) {
    return 'Persona rimossa: $name.';
  }

  @override
  String get shareTitle => 'Invia a un altro telefono';

  @override
  String get shareWhatToSend => 'Cosa vuoi inviare?';

  @override
  String get shareEveryone => 'Tutti';

  @override
  String get shareEveryoneHint => 'Per passare a un nuovo telefono.';

  @override
  String get shareJustOne => 'Una sola persona';

  @override
  String get shareJustYours => 'Solo il tuo storico';

  @override
  String shareJustName(String name) {
    return 'Solo $name';
  }

  @override
  String shareForTheirPhone(String name) {
    return 'Per il telefono di $name.';
  }

  @override
  String get shareCopiesNotOffered =>
      'Le persone importate da altri telefoni non compaiono qui: ognuno condivide solo il proprio storico.';

  @override
  String shareHowMuch(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Quanta parte del tuo storico?',
      'other': 'Quanta parte dello storico di $name?',
    });
    return '$_temp0';
  }

  @override
  String get shareHowMuchHint =>
      'Inviare tutto va bene per un nuovo telefono. Per condividere con un gruppo, potresti inviare meno. Niente viene rimosso da questo telefono.';

  @override
  String get shareHowFarBack => 'Da quando';

  @override
  String get shareSpanEverything => 'Tutto';

  @override
  String get shareSpanYear => 'L’ultimo anno';

  @override
  String shareSpanMonths(int months) {
    String _temp0 = intl.Intl.pluralLogic(
      months,
      locale: localeName,
      other: 'Gli ultimi $months mesi',
      one: 'L’ultimo mese',
    );
    return '$_temp0';
  }

  @override
  String get shareSpanLatest => 'Solo le ultime mestruazioni';

  @override
  String get shareWhatToInclude => 'Cosa includere';

  @override
  String get shareWithDays => 'Mestruazioni e voci giornaliere';

  @override
  String get shareWithDaysHint => 'Anche note, voti, stati d’animo e flusso.';

  @override
  String get sharePeriodsOnly => 'Solo le mestruazioni';

  @override
  String get sharePeriodsOnlyHint =>
      'Solo quando sono iniziate e finite le mestruazioni.';

  @override
  String get shareShowCodes => 'Mostra i codici';

  @override
  String get shareNothing => 'Ancora niente da inviare.';

  @override
  String get shareHowToReceive =>
      'Sull’altro telefono apri Ebb, vai in Impostazioni → Ricevi da un altro telefono, e inquadra questo schermo con la fotocamera.';

  @override
  String shareCodeOf(int index, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      total,
      locale: localeName,
      other: 'Codice $index di $total',
    );
    return '$_temp0';
  }

  @override
  String get sharePreviousCode => 'Codice precedente';

  @override
  String get sharePause => 'Pausa';

  @override
  String get sharePlay => 'Riprendi';

  @override
  String get shareNextCode => 'Codice successivo';

  @override
  String get shareCodesChange =>
      'I codici cambiano da soli. L’altro telefono li raccoglie in qualsiasi ordine.';

  @override
  String sharePeriodCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mestruazioni',
      one: '$count mestruazione',
    );
    return '$_temp0';
  }

  @override
  String shareSummaryEverything(String periods) {
    return 'Tutto ciò che c’è in Ebb: $periods.';
  }

  @override
  String shareSummaryEverythingPeople(String periods, int people) {
    String _temp0 = intl.Intl.pluralLogic(
      people,
      locale: localeName,
      other: 'Tutto ciò che c’è in Ebb: $periods per $people persone.',
    );
    return '$_temp0';
  }

  @override
  String shareSummaryHistoryAll(String who, String name, String periods) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Il tuo storico: $periods.',
      'other': 'Storico di $name: $periods.',
    });
    return '$_temp0';
  }

  @override
  String shareSummaryHistoryLatest(String who, String name, String periods) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Il tuo storico, solo le ultime mestruazioni: $periods.',
      'other': 'Storico di $name, solo le ultime mestruazioni: $periods.',
    });
    return '$_temp0';
  }

  @override
  String shareSummaryHistoryYear(String who, String name, String periods) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Il tuo storico dell’ultimo anno: $periods.',
      'other': 'Storico di $name dell’ultimo anno: $periods.',
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
      'you': 'Il tuo storico degli ultimi $months mesi: $periods.',
      'other': 'Storico di $name degli ultimi $months mesi: $periods.',
    });
    return '$_temp0';
  }

  @override
  String shareSummaryPeriodsAll(String who, String name, String periods) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Le tue mestruazioni: $periods.',
      'other': 'Mestruazioni di $name: $periods.',
    });
    return '$_temp0';
  }

  @override
  String shareSummaryPeriodsLatest(String who, String name, String periods) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Le tue mestruazioni, solo le ultime: $periods.',
      'other': 'Mestruazioni di $name, solo le ultime: $periods.',
    });
    return '$_temp0';
  }

  @override
  String shareSummaryPeriodsYear(String who, String name, String periods) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Le tue mestruazioni dell’ultimo anno: $periods.',
      'other': 'Mestruazioni di $name dell’ultimo anno: $periods.',
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
      'you': 'Le tue mestruazioni degli ultimi $months mesi: $periods.',
      'other': 'Mestruazioni di $name degli ultimi $months mesi: $periods.',
    });
    return '$_temp0';
  }

  @override
  String get shareNotEbb => 'Questo codice non è di Ebb.';

  @override
  String get shareNewerVersion =>
      'L’altro telefono ha una versione più recente di Ebb. Prima aggiorna questo.';

  @override
  String get shareRestarted =>
      'L’altro telefono è ripartito da capo. Raccolgo i nuovi codici.';

  @override
  String get shareUnreadable =>
      'Alcuni codici non sono stati letti bene. Scansioniamoli di nuovo.';

  @override
  String get shareNeedsCamera =>
      'Ebb ha bisogno della fotocamera per leggere i codici. Puoi consentirlo nelle impostazioni di sistema per Ebb.';

  @override
  String get sharePointCamera =>
      'Inquadra il codice sull’altro telefono con la fotocamera.';

  @override
  String get shareReading => 'Lettura…';

  @override
  String shareCodesReceived(int received, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      total,
      locale: localeName,
      other: '$received codici su $total ricevuti',
    );
    return '$_temp0';
  }

  @override
  String get shareReceiveTitle => 'Ricevi da un altro telefono';

  @override
  String shareStillNeeded(String codes) {
    return 'Mancano ancora: $codes';
  }

  @override
  String get groupsMoreThanOne => 'C’è più di una persona';

  @override
  String get groupsMoreThanOneBody =>
      'Questi codici contengono lo storico di un intero telefono. Per entrare in un gruppo, ognuno invia solo il proprio: sul suo telefono, Impostazioni → Invia a un altro telefono → Solo il tuo storico.';

  @override
  String groupsUpdateTitle(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Aggiornare il tuo storico?',
      'other': 'Aggiornare $name?',
    });
    return '$_temp0';
  }

  @override
  String groupsUpdateAction(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Aggiorna il tuo storico',
      'other': 'Aggiorna $name',
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
          'È di nuovo il tuo storico, inviato il $sent: $periods. Sostituisce la copia su questo telefono.',
      'other':
          'È di nuovo lo storico di $name, inviato il $sent: $periods. Sostituisce la copia su questo telefono.',
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
          'È il tuo storico, inviato il $sent: $periods. Sostituisce ciò che c’è su questo telefono per te, compreso tutto ciò che hai registrato qui nel frattempo.',
      'other':
          'È lo storico di $name, inviato il $sent: $periods. Sostituisce ciò che c’è su questo telefono per $name, compreso tutto ciò che è stato registrato qui nel frattempo.',
    });
    return '$_temp0';
  }

  @override
  String groupsUpdated(String name) {
    return '$name: storico aggiornato.';
  }

  @override
  String groupsImportInto(String group) {
    return 'Importa in $group';
  }

  @override
  String groupsImportHint(String periods, String sent) {
    return 'Storico inviato il $sent, con $periods. Importato in sola lettura: qui non si può modificare, e viene aggiornato quando viene inviato di nuovo.';
  }

  @override
  String groupsImported(String name, String group) {
    return 'Storico di $name importato in $group.';
  }

  @override
  String get groupsGroup => 'Gruppo';

  @override
  String get groupsNoMembers =>
      'Non c’è ancora nessuno in questo gruppo. Aggiungi persone in Impostazioni → Avanzate → Gestisci i gruppi: spunta le persone già presenti su questo telefono, o aggiungi qualcuno dal suo telefono.';

  @override
  String get groupsPeriods => 'Mestruazioni';

  @override
  String get groupsChartHint =>
      'Ogni barra rappresenta delle mestruazioni; se ha solo il contorno, la fine non è stata registrata e la barra ha la durata abituale. Le linee continue scendono da ogni luna piena, quelle tratteggiate da ogni luna nuova.';

  @override
  String get groupsNew => 'Nuovo gruppo';

  @override
  String get groupsRename => 'Rinomina il gruppo';

  @override
  String get groupsNameHint =>
      'Per esempio, il nome della tua cerchia o del tuo gruppo.';

  @override
  String get groupsNameTaken => 'Esiste già un gruppo con questo nome.';

  @override
  String get groupsNoOneYet => 'Ancora nessuno';

  @override
  String get groupsTitle => 'Gruppi';

  @override
  String get groupsIntro =>
      'Un gruppo riunisce delle persone su questo telefono sotto un unico nome: una cerchia o un gruppo che tiene traccia insieme. Una persona può far parte di più gruppi, ed eliminare un gruppo non elimina mai nessuno.';

  @override
  String groupsAddSomeoneTo(String group) {
    return 'Aggiungi qualcuno a $group';
  }

  @override
  String get groupsAddSomeoneHint =>
      'Persona seguita su questo telefono: registri e modifichi qui il suo storico. Chi tiene traccia sul proprio telefono può invece essere importato.';

  @override
  String groupsTakeOutTitle(String name, String group) {
    return 'Togliere $name da $group?';
  }

  @override
  String groupsTakeOutBody(String name) {
    return 'Lo storico di $name è stato importato dal suo telefono e $name non fa parte di nessun altro gruppo, quindi anche lo storico importato viene tolto da questo telefono. $name può inviarlo di nuovo per rientrare.';
  }

  @override
  String get groupsTakeOut => 'Togli';

  @override
  String groupsDeleteTitle(String group) {
    return 'Eliminare $group?';
  }

  @override
  String get groupsDeleteBodyNone =>
      'Viene eliminato solo il gruppo. Tutte le persone che ne fanno parte restano su questo telefono, con tutto il loro storico.';

  @override
  String groupsDeleteBodySome(String names) {
    return 'Anche le persone importate solo in questo gruppo vengono tolte da questo telefono: $names. Tutte le altre restano, con tutto il loro storico.';
  }

  @override
  String get groupsDeleteGroup => 'Elimina il gruppo';

  @override
  String get groupsRenameTooltip => 'Rinomina';

  @override
  String get groupsWhoIsIn => 'Chi ne fa parte';

  @override
  String groupsImportedAsOf(String date) {
    return 'Importato · sola lettura, aggiornato al $date';
  }

  @override
  String get groupsTrackedHere => 'Registrato su questo telefono';

  @override
  String get groupsAddTo => 'Aggiungi al gruppo';

  @override
  String get groupsAddNew => 'Aggiungi una nuova persona';

  @override
  String get groupsAddNewHint =>
      'Persona seguita su questo telefono: registri qui le sue mestruazioni.';

  @override
  String get groupsImportFromPhone => 'Importa dal suo telefono';

  @override
  String get groupsImportFromPhoneHint =>
      'Continua a tenere traccia sul proprio telefono e invia lo storico qui, in sola lettura. Importarlo di nuovo lo aggiorna.';

  @override
  String get groupsDeleteThis => 'Elimina questo gruppo';

  @override
  String get peopleNameTaken => 'Questo nome è già usato su questo telefono.';

  @override
  String get peopleName => 'Nome';

  @override
  String peopleSeeTogether(String group) {
    return 'Vedi $group insieme';
  }

  @override
  String get peopleNotInGroup => 'In nessun gruppo';

  @override
  String get peopleAddSomeone => 'Aggiungi qualcuno';

  @override
  String get peopleTrackSomeoneElse => 'Segui un’altra persona';

  @override
  String get peopleNameHint =>
      'Basta qualcosa per distinguere le persone: un nome, un soprannome o un’iniziale.';

  @override
  String backupUnnamedPerson(int number) {
    return 'Persona $number';
  }

  @override
  String get backupNotEbb => 'Questo file non è un backup di Ebb.';

  @override
  String get backupNewer =>
      'Questo backup è stato creato da una versione più recente di Ebb. Aggiorna Ebb e riprova.';

  @override
  String get backupNoOne => 'In questo backup non c’è nessuno.';

  @override
  String get backupSameId =>
      'Questo backup sembra danneggiato: due persone hanno lo stesso id.';

  @override
  String backupAfterExport(String date) {
    return '$date è successivo al giorno in cui è stato creato questo backup.';
  }

  @override
  String backupSameName(String name) {
    return 'In questo backup due persone si chiamano entrambe $name.';
  }

  @override
  String backupSameGroupName(String group) {
    return 'In questo backup due gruppi si chiamano entrambi $group.';
  }

  @override
  String backupEndsBefore(String date) {
    return 'Le mestruazioni che iniziano il $date finiscono prima di cominciare.';
  }

  @override
  String backupTwoStarts(String date) {
    return 'Per la stessa persona ci sono due mestruazioni che iniziano il $date.';
  }

  @override
  String backupDayTwice(String date) {
    return 'Il giorno $date compare due volte per la stessa persona.';
  }

  @override
  String backupOverlaps(String date) {
    return 'Le mestruazioni che iniziano il $date si sovrappongono a quelle precedenti.';
  }

  @override
  String get backupDamaged =>
      'Questo backup sembra danneggiato: impossibile leggere il backup.';

  @override
  String get backupDamagedExportDate =>
      'Questo backup sembra danneggiato: impossibile leggere la data di esportazione.';

  @override
  String get backupDamagedGroup =>
      'Questo backup sembra danneggiato: impossibile leggere un gruppo.';

  @override
  String get backupDamagedGroupName =>
      'Questo backup sembra danneggiato: impossibile leggere il nome di un gruppo.';

  @override
  String backupDamagedGroupPeople(String group) {
    return 'Questo backup sembra danneggiato: impossibile leggere le persone del gruppo $group.';
  }

  @override
  String get backupDamagedPerson =>
      'Questo backup sembra danneggiato: impossibile leggere i dati di una persona.';

  @override
  String get backupDamagedName =>
      'Questo backup sembra danneggiato: impossibile leggere un nome.';

  @override
  String get backupDamagedPersonId =>
      'Questo backup sembra danneggiato: impossibile leggere l’id di una persona.';

  @override
  String get backupDamagedSharedOn =>
      'Questo backup sembra danneggiato: impossibile leggere il giorno in cui uno storico è stato condiviso.';

  @override
  String get backupDamagedPeriod =>
      'Questo backup sembra danneggiato: impossibile leggere una voce delle mestruazioni.';

  @override
  String get backupDamagedPeriodStart =>
      'Questo backup sembra danneggiato: impossibile leggere l’inizio di una mestruazione.';

  @override
  String get backupDamagedPeriodEnd =>
      'Questo backup sembra danneggiato: impossibile leggere la fine di una mestruazione.';

  @override
  String get backupDamagedDay =>
      'Questo backup sembra danneggiato: impossibile leggere la voce di un giorno.';

  @override
  String backupDamagedFlow(String date) {
    return 'Questo backup sembra danneggiato: impossibile leggere il flusso del $date.';
  }

  @override
  String backupDamagedSymptom(String date) {
    return 'Questo backup sembra danneggiato: impossibile leggere un sintomo del $date.';
  }

  @override
  String backupDamagedRating(String date) {
    return 'Questo backup sembra danneggiato: impossibile leggere il voto del $date.';
  }

  @override
  String backupDamagedFeeling(String date) {
    return 'Questo backup sembra danneggiato: impossibile leggere lo stato d’animo del $date.';
  }

  @override
  String backupDamagedTemperature(String date) {
    return 'Questo backup sembra danneggiato: impossibile leggere la temperatura del $date.';
  }

  @override
  String backupDamagedMucus(String date) {
    return 'Questo backup sembra danneggiato: impossibile leggere il muco cervicale del $date.';
  }
}
