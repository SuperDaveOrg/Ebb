// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get you => 'Tú';

  @override
  String get ok => 'Aceptar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get save => 'Guardar';

  @override
  String get delete => 'Borrar';

  @override
  String get remove => 'Quitar';

  @override
  String get close => 'Cerrar';

  @override
  String get done => 'Listo';

  @override
  String get back => 'Atrás';

  @override
  String get next => 'Siguiente';

  @override
  String get edit => 'Editar';

  @override
  String get add => 'Añadir';

  @override
  String get continueAction => 'Continuar';

  @override
  String get language => 'Idioma';

  @override
  String get languagePhone => 'Igual que el teléfono';

  @override
  String languagePhoneIs(String language) {
    return 'Igual que el teléfono ($language)';
  }

  @override
  String get notifChannelName => 'Recordatorios del ciclo';

  @override
  String get notifChannelDescription =>
      'Un aviso antes de la fecha prevista de tu periodo y un recordatorio para registrarlo.';

  @override
  String notifUpcomingTitle(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Se espera tu periodo pronto',
      'other': 'Se espera pronto el periodo de $name',
    });
    return '$_temp0';
  }

  @override
  String notifUpcomingTomorrow(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Ebb prevé que tu periodo empiece mañana.',
      'other': 'Ebb prevé que el periodo de $name empiece mañana.',
    });
    return '$_temp0';
  }

  @override
  String notifUpcomingInDays(String who, String name, int days) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Ebb prevé tu periodo dentro de unos $days días.',
      'other': 'Ebb prevé el periodo de $name dentro de unos $days días.',
    });
    return '$_temp0';
  }

  @override
  String notifTodayTitle(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Se espera tu periodo hoy',
      'other': 'Se espera hoy el periodo de $name',
    });
    return '$_temp0';
  }

  @override
  String get notifTodayBody => 'Toca para registrar cómo va.';

  @override
  String get calendarTitle => 'Calendario';

  @override
  String get calendarCellToday => 'hoy';

  @override
  String get calendarCellPeriod => 'periodo';

  @override
  String get calendarCellPeriodUnlogged => 'periodo, fin no registrado';

  @override
  String get calendarCellLikely => 'probable inicio del próximo periodo';

  @override
  String get calendarCellFertile => 'ventana fértil estimada';

  @override
  String calendarCellMoon(String phase) {
    String _temp0 = intl.Intl.selectLogic(phase, {
      'newMoon': 'luna nueva',
      'firstQuarter': 'cuarto creciente',
      'full': 'luna llena',
      'other': 'cuarto menguante',
    });
    return '$_temp0';
  }

  @override
  String calendarCellRated(int rating) {
    return 'puntuación $rating';
  }

  @override
  String calendarCellFelt(String feeling) {
    return 'ánimo: $feeling';
  }

  @override
  String get calendarCellNote => 'tiene una nota';

  @override
  String get calendarKeyPeriod => 'Periodo';

  @override
  String get calendarKeyEndNotLogged => 'Fin no registrado';

  @override
  String get calendarKeyLikely => 'Inicio probable';

  @override
  String get calendarKeyFertile => 'Fértil (estimación)';

  @override
  String get calendarKeyToday => 'Hoy';

  @override
  String calendarStatusWindow(String who, String name, String from, String to) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you':
          'Es probable que tu próximo periodo empiece entre el $from y el $to.',
      'other':
          'Es probable que el próximo periodo de $name empiece entre el $from y el $to.',
    });
    return '$_temp0';
  }

  @override
  String calendarStatusPeriodDay(String who, String name, int day) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Día $day de tu periodo.',
      'other': 'Día $day del periodo de $name.',
    });
    return '$_temp0';
  }

  @override
  String calendarStatusPeriodDayExcluded(String who, String name, int day) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you':
          'Día $day de tu periodo, en un ciclo que no cuenta para las previsiones.',
      'other':
          'Día $day del periodo de $name, en un ciclo que no cuenta para las previsiones.',
    });
    return '$_temp0';
  }

  @override
  String calendarStatusUnlogged(String who, String name, int day) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you':
          'Día $day de tu ciclo. El fin de este periodo no se registró, así que se dibuja con la duración habitual.',
      'other':
          'Día $day del ciclo de $name. El fin de este periodo no se registró, así que se dibuja con la duración habitual.',
    });
    return '$_temp0';
  }

  @override
  String get calendarStatusFertile =>
      'En la ventana fértil estimada. No es lo bastante fiable como método anticonceptivo.';

  @override
  String calendarStatusCycleDay(String who, String name, int day) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Día $day de tu ciclo.',
      'other': 'Día $day del ciclo de $name.',
    });
    return '$_temp0';
  }

  @override
  String calendarDayToday(String date) {
    return 'Hoy, $date';
  }

  @override
  String get calendarPreviousDay => 'Día anterior';

  @override
  String get calendarNextDay => 'Día siguiente';

  @override
  String calendarMoonAt(String phase, String time) {
    return '$phase, $time';
  }

  @override
  String get calendarFutureDay =>
      'Los días que aún no han llegado no se pueden registrar todavía.';

  @override
  String calendarMarkStarted(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Marcar como el día en que empezó tu periodo',
      'other': 'Marcar como el día en que empezó el periodo de $name',
    });
    return '$_temp0';
  }

  @override
  String get calendarMoveStart => 'Hacer de este el primer día del periodo';

  @override
  String calendarMoveStartFrom(String date) {
    return 'Mueve su inicio desde el $date';
  }

  @override
  String calendarMarkEnded(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Marcar como el día en que terminó tu periodo',
      'other': 'Marcar como el día en que terminó el periodo de $name',
    });
    return '$_temp0';
  }

  @override
  String get calendarMakeLastDay => 'Hacer de este el último día del periodo';

  @override
  String get calendarEditPeriod => 'Editar este periodo';

  @override
  String calendarRateDay(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Puntúa tu día, 1–5',
      'other': 'Puntúa el día de $name, 1–5',
    });
    return '$_temp0';
  }

  @override
  String calendarHowFelt(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': '¿Cómo te sentiste?',
      'other': '¿Cómo se sintió $name?',
    });
    return '$_temp0';
  }

  @override
  String get calendarFlow => 'Sangrado';

  @override
  String get calendarNote => 'Nota';

  @override
  String calendarTemperatureHeading(String unit) {
    return 'Temperatura, $unit';
  }

  @override
  String calendarTemperatureRange(String low, String high, String unit) {
    return 'Escribe una temperatura entre $low y $high $unit';
  }

  @override
  String get calendarTemperatureHelper => 'Al despertar, antes de levantarte';

  @override
  String get calendarTemperatureAffected => 'Algo puede haberla alterado';

  @override
  String get calendarTemperatureAffectedHint =>
      'Enfermedad, poco sueño, alcohol, tomada tarde';

  @override
  String get calendarMucus => 'Moco cervical';

  @override
  String get calendarMucusFelt => 'Sensación';

  @override
  String get calendarMucusLooked => 'Aspecto';

  @override
  String calendarLoggedRated(int rating, String ratingName) {
    return 'Puntuación: $rating de 5, $ratingName';
  }

  @override
  String calendarLoggedFelt(String emoji, String feeling) {
    return 'Ánimo: $emoji $feeling';
  }

  @override
  String calendarLoggedFlow(String flow) {
    String _temp0 = intl.Intl.selectLogic(flow, {
      'spotting': 'Sangrado: manchado',
      'light': 'Sangrado: ligero',
      'medium': 'Sangrado: moderado',
      'other': 'Sangrado: abundante',
    });
    return '$_temp0';
  }

  @override
  String calendarLoggedTemperature(String temperature) {
    return 'Temperatura: $temperature';
  }

  @override
  String calendarLoggedTemperatureAffected(String temperature) {
    return 'Temperatura: $temperature, puede haberse alterado';
  }

  @override
  String calendarLoggedMucus(String mucus) {
    return 'Moco cervical: $mucus';
  }

  @override
  String calendarLoggedNote(String note) {
    return '«$note»';
  }

  @override
  String get calendarNothingLogged => 'No hay nada registrado este día.';

  @override
  String get calendarMoonNew => 'Luna nueva';

  @override
  String get calendarMoonFirstQuarter => 'Cuarto creciente';

  @override
  String get calendarMoonFull => 'Luna llena';

  @override
  String get calendarMoonLastQuarter => 'Cuarto menguante';

  @override
  String get dayFlowNone => 'Ninguno';

  @override
  String get dayFlowSpotting => 'Manchado';

  @override
  String get dayFlowLight => 'Ligero';

  @override
  String get dayFlowMedium => 'Moderado';

  @override
  String get dayFlowHeavy => 'Abundante';

  @override
  String get dayMucusNothing => 'Nada';

  @override
  String get dayMucusFeelDry => 'Seca';

  @override
  String get dayMucusFeelWet => 'Húmeda';

  @override
  String get dayMucusFeelSlippery => 'Resbaladiza';

  @override
  String get dayMucusLookCreamy => 'Cremoso';

  @override
  String get dayMucusLookEggWhite => 'Clara de huevo';

  @override
  String dayMucusFeelInline(String feel) {
    String _temp0 = intl.Intl.selectLogic(feel, {
      'dry': 'sensación seca',
      'nothing': 'sin sensación',
      'wet': 'sensación húmeda',
      'other': 'sensación resbaladiza',
    });
    return '$_temp0';
  }

  @override
  String dayMucusLookInline(String look) {
    String _temp0 = intl.Intl.selectLogic(look, {
      'nothing': 'no se ve nada',
      'creamy': 'cremoso',
      'other': 'como clara de huevo',
    });
    return '$_temp0';
  }

  @override
  String get dayFeelingHappy => 'Alegría';

  @override
  String get dayFeelingCalm => 'Calma';

  @override
  String get dayFeelingLoving => 'Cariño';

  @override
  String get dayFeelingEnergetic => 'Energía';

  @override
  String get dayFeelingTired => 'Cansancio';

  @override
  String get dayFeelingSad => 'Tristeza';

  @override
  String get dayFeelingAnxious => 'Ansiedad';

  @override
  String get dayFeelingIrritable => 'Irritabilidad';

  @override
  String get dayFeelingAngry => 'Enfado';

  @override
  String get dayFeelingConfused => 'Confusión';

  @override
  String get chartsTitle => 'Gráficos';

  @override
  String get chartsDayRating => 'Puntuación del día';

  @override
  String get chartsNoRatings =>
      'Todavía no hay días puntuados en este intervalo.';

  @override
  String get chartsBars => 'Barras';

  @override
  String get chartsLine => 'Línea';

  @override
  String get chartsRatingCaptionBars =>
      'Cada barra es la puntuación de un día, de 1 a 5. Los días de periodo aparecen sombreados.';

  @override
  String get chartsRatingCaptionLine =>
      'Cada punto es la puntuación de un día, de 1 a 5, unida a la del día siguiente cuando ambos tienen puntuación. Los días de periodo aparecen sombreados.';

  @override
  String get chartsRatingCaptionMoon =>
      'Las lunas marcan las fases lunares; en un intervalo largo, solo las lunas nuevas y llenas, o solo las llenas.';

  @override
  String get chartsTemperatureTitle => 'Temperatura y moco cervical';

  @override
  String get chartsTemperatureEmpty =>
      'Todavía no hay nada registrado en este intervalo. Toca un día del calendario para añadir una temperatura o el moco cervical.';

  @override
  String chartsTemperatureCaption(String unit) {
    return 'Cada punto es la temperatura de un día, en $unit, unida a la del día siguiente cuando se tomaron ambas. Un punto hueco puede estar alterado y no se une. Debajo, el moco cervical: las barras más altas son más húmedas (sensación) y más claras y elásticas (aspecto). Los días de periodo aparecen sombreados.';
  }

  @override
  String get chartsFeelings => 'Estados de ánimo';

  @override
  String get chartsAroundPeriods => 'Según el periodo';

  @override
  String get chartsAroundMoon => 'Según la luna';

  @override
  String get chartsFeelingsEmptyMoon =>
      'Cuando hayas elegido cómo te sentiste algunos días de este intervalo, aquí verás qué estados de ánimo aparecieron en torno a las lunas llenas y nuevas.';

  @override
  String get chartsFeelingsEmptyPeriods =>
      'Cuando hayas elegido cómo te sentiste algunos días de este intervalo, y haya empezado un periodo después, aquí verás qué estados de ánimo aparecieron y cuándo.';

  @override
  String get chartsFeelingsCaptionMoon => 'Cuántos días se eligió cada cara.';

  @override
  String get chartsFeelingsCaptionPeriods =>
      'Cuántos días se eligió cada cara. Los días desde que empezó el último periodo no se cuentan hasta que empiece el siguiente.';

  @override
  String get chartsNoneYet => 'Ninguno todavía.';

  @override
  String get chartsGroupDuringPeriod => 'Durante un periodo';

  @override
  String get chartsGroupBeforePeriod => 'Justo antes de un periodo';

  @override
  String get chartsGroupOtherDays => 'Otros días';

  @override
  String get chartsGroupFullMoon => 'En torno a la luna llena';

  @override
  String get chartsGroupNewMoon => 'En torno a la luna nueva';

  @override
  String get chartsDetailLoggedPeriodDays => 'días de periodo registrados';

  @override
  String chartsDetailUsuallyDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'normalmente $days días',
      one: 'normalmente 1 día',
    );
    return '$_temp0';
  }

  @override
  String chartsDetailDaysBefore(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'los $days días anteriores',
      one: 'el día anterior',
    );
    return '$_temp0';
  }

  @override
  String get chartsDetailRestOfCycle => 'el resto del ciclo';

  @override
  String get chartsDetailDayItself => 'el propio día';

  @override
  String chartsDetailDayEitherSide(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'el día, ±$days días',
      one: 'el día, ±1 día',
    );
    return '$_temp0';
  }

  @override
  String get chartsDetailRestOfMonth => 'el resto del mes';

  @override
  String chartsFeelingCount(String feeling, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count días',
      one: '1 día',
    );
    return '$feeling: $_temp0';
  }

  @override
  String chartsFeelingGroupSummary(String group, String detail, String counts) {
    return '$group, $detail: $counts';
  }

  @override
  String get chartsFeelingGroupNone => 'ninguno todavía';

  @override
  String chartsRatingSummary(String from, String to, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count días puntuados',
      one: '1 día puntuado',
    );
    return 'Puntuaciones del día del $from al $to: $_temp0, con los días de periodo sombreados.';
  }

  @override
  String chartsRatingSummaryMoons(String from, String to, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count días puntuados',
      one: '1 día puntuado',
    );
    return 'Puntuaciones del día del $from al $to: $_temp0, con los días de periodo sombreados y las fases lunares marcadas.';
  }

  @override
  String chartsLanesSummary(String from, String to, String lanes) {
    return 'Periodos del $from al $to. $lanes.';
  }

  @override
  String chartsLane(String name, String periods) {
    return '$name: $periods';
  }

  @override
  String get chartsLaneNone => 'sin días de periodo';

  @override
  String chartsLaneRun(String from, String to) {
    return 'del $from al $to';
  }

  @override
  String chartsLaneRunEstimated(String from, String to) {
    return 'del $from al $to, estimado';
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
      other: '$mucusDays días',
      one: '1 día',
    );
    return 'Temperaturas del $from al $to: $range; moco cervical anotado $_temp0, con los días de periodo sombreados.';
  }

  @override
  String get chartsNoTemperatures => 'ninguna temperatura';

  @override
  String chartsTemperatureRange(int count, String low, String high) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count temperaturas',
      one: '1 temperatura',
    );
    return '$_temp0, de $low a $high';
  }

  @override
  String get chartsMucusFelt => 'Sensac.';

  @override
  String get chartsMucusLooked => 'Aspecto';

  @override
  String get faceRatingRough => 'Muy mal';

  @override
  String get faceRatingNotGreat => 'No muy bien';

  @override
  String get faceRatingOkay => 'Normal';

  @override
  String get faceRatingGood => 'Bien';

  @override
  String get faceRatingGreat => 'Genial';

  @override
  String get faceRatingRoughInline => 'muy mal';

  @override
  String get faceRatingNotGreatInline => 'no muy bien';

  @override
  String get faceRatingOkayInline => 'normal';

  @override
  String get faceRatingGoodInline => 'bien';

  @override
  String get faceRatingGreatInline => 'genial';

  @override
  String faceRatingOption(int rating, String name) {
    return '$rating, $name';
  }

  @override
  String get faceMoreFaces => 'Más caras';

  @override
  String get faceDifferentFace => 'Otra cara';

  @override
  String get faceOther => 'Otra cara';

  @override
  String get faceSmilingCat => 'Gato sonriente';

  @override
  String get faceGrinningCat => 'Gato con gran sonrisa';

  @override
  String get faceCatTearsOfJoy => 'Gato llorando de risa';

  @override
  String get faceCatHeartEyes => 'Gato con ojos de corazón';

  @override
  String get faceSmirkingCat => 'Gato con sonrisa pícara';

  @override
  String get faceKissingCat => 'Gato dando un beso';

  @override
  String get faceWearyCat => 'Gato agotado';

  @override
  String get faceCryingCat => 'Gato llorando';

  @override
  String get facePoutingCat => 'Gato enfurruñado';

  @override
  String get faceAlien => 'Extraterrestre';

  @override
  String get faceSpaceInvader => 'Invasor espacial';

  @override
  String get faceRobot => 'Robot';

  @override
  String get faceGhost => 'Fantasma';

  @override
  String get faceSkull => 'Calavera';

  @override
  String get faceClown => 'Payaso';

  @override
  String get faceDevil => 'Diablillo';

  @override
  String get faceUnicorn => 'Unicornio';

  @override
  String get faceFrog => 'Rana';

  @override
  String get facePartying => 'De fiesta';

  @override
  String get faceCool => 'Con gafas de sol';

  @override
  String get faceNerdy => 'Cerebrito';

  @override
  String get faceAngelic => 'Angelical';

  @override
  String get faceHugging => 'Abrazo';

  @override
  String get faceSilly => 'Bromista';

  @override
  String get faceUpsideDown => 'Al revés';

  @override
  String get faceSmirking => 'Sonrisa pícara';

  @override
  String get faceGrimacing => 'Mueca';

  @override
  String get faceEyeRoll => 'Ojos en blanco';

  @override
  String get faceSpeechless => 'Sin palabras';

  @override
  String get facePleading => 'Suplicante';

  @override
  String get faceSobbing => 'Llanto';

  @override
  String get faceScreaming => 'Grito';

  @override
  String get faceFlushed => 'Sonrojo';

  @override
  String get faceOverwhelmed => 'Agobio';

  @override
  String get faceWoozy => 'Mareo';

  @override
  String get faceUnwell => 'Malestar';

  @override
  String get faceHurting => 'Dolor';

  @override
  String get faceQueasy => 'Náuseas';

  @override
  String get faceTooHot => 'Mucho calor';

  @override
  String get faceTooCold => 'Mucho frío';

  @override
  String get faceSparklingHeart => 'Corazón brillante';

  @override
  String get faceBrokenHeart => 'Corazón roto';

  @override
  String get faceFire => 'Fuego';

  @override
  String get faceRainbow => 'Arcoíris';

  @override
  String get faceSun => 'Sol';

  @override
  String get faceRain => 'Lluvia';

  @override
  String get faceStorm => 'Tormenta';

  @override
  String get faceBlossom => 'Flor';

  @override
  String get faceChocolate => 'Chocolate';

  @override
  String get faceInBed => 'En la cama';

  @override
  String get homeCalendar => 'Calendario';

  @override
  String get homeHistory => 'Historial';

  @override
  String get homeCharts => 'Gráficos';

  @override
  String get homeSettings => 'Ajustes';

  @override
  String homeCalendarOf(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Tu calendario',
      'other': 'Calendario de $name',
    });
    return '$_temp0';
  }

  @override
  String homeHistoryOf(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Tu historial',
      'other': 'Historial de $name',
    });
    return '$_temp0';
  }

  @override
  String homeChartsOf(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Tus gráficos',
      'other': 'Gráficos de $name',
    });
    return '$_temp0';
  }

  @override
  String get homeWhenStarted => '¿Cuándo empezó?';

  @override
  String get homeWhenEnded => '¿Cuándo terminó?';

  @override
  String homePeriodEndedToday(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Mi periodo terminó hoy',
      'other': 'El periodo de $name terminó hoy',
    });
    return '$_temp0';
  }

  @override
  String homePeriodStartedToday(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Mi periodo empezó hoy',
      'other': 'El periodo de $name empezó hoy',
    });
    return '$_temp0';
  }

  @override
  String get homeEndedEarlier => 'Terminó un día anterior';

  @override
  String get homeStartedEarlier => 'Empezó un día anterior';

  @override
  String homeAddLastEnd(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Añadir cuándo terminó tu último periodo',
      'other': 'Añadir cuándo terminó el último periodo de $name',
    });
    return '$_temp0';
  }

  @override
  String homeSharedCopy(String who, String name, String date) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you':
          'Importado desde tu teléfono el $date. Aquí no se puede cambiar, y se pone al día cuando vuelves a enviarlo.',
      'other':
          'Importado desde el teléfono de $name el $date. Aquí no se puede cambiar, y se pone al día cuando $name vuelve a enviarlo.',
    });
    return '$_temp0';
  }

  @override
  String homeNoPeriodSince(String date) {
    return 'No hay ningún periodo registrado desde el $date';
  }

  @override
  String get homeMissedOne =>
      'Ebb ha supuesto que un periodo quedó sin registrar y ha hecho la estimación a partir de ahí. Si recuerdas cuándo empezó, añádelo para corregir la estimación.';

  @override
  String get homeMissedSome =>
      'Ebb ha supuesto que algunos periodos quedaron sin registrar y ha hecho la estimación a partir de ahí. Si recuerdas cuándo empezó alguno, añádelo para corregir la estimación.';

  @override
  String get homeWelcome => 'Te damos la bienvenida a Ebb';

  @override
  String get homeNothingYet => 'Todavía no hay nada registrado';

  @override
  String homeFirstLog(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Registra el primer día de tu próximo periodo, o añade periodos anteriores si los recuerdas, y Ebb empezará a conocer tu ritmo. Todo se queda en este teléfono.',
      'other':
          'Registra el primer día del próximo periodo de $name, o añade periodos anteriores si los recuerdas, y Ebb empezará a conocer su ritmo. Todo se queda en este teléfono.',
    });
    return '$_temp0';
  }

  @override
  String homeDayOfPeriod(String who, String name, int day) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Día $day de tu periodo',
      'other': 'Día $day del periodo de $name',
    });
    return '$_temp0';
  }

  @override
  String homeDayOfCycle(String who, String name, int day) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Día $day de tu ciclo',
      'other': 'Día $day del ciclo de $name',
    });
    return '$_temp0';
  }

  @override
  String get homeTellEnd =>
      'Indica a Ebb cuándo termina para que la estimación siga siendo precisa.';

  @override
  String homeDaysUntil(String who, String name, int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Faltan unos $days días para la fecha prevista de tu periodo.',
    );
    String _temp1 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other:
          'Faltan unos $days días para la fecha prevista del periodo de $name.',
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
      'you': 'Tu periodo se espera mañana.',
      'other': 'El periodo de $name se espera mañana.',
    });
    return '$_temp0';
  }

  @override
  String homeExpectedToday(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Tu periodo se espera hoy.',
      'other': 'El periodo de $name se espera hoy.',
    });
    return '$_temp0';
  }

  @override
  String homeDaysLate(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other:
          '$days días más tarde de lo previsto. Los ciclos varían por todo tipo de motivos.',
      one: '1 día más tarde de lo previsto. Los ciclos varían por todo tipo de motivos.',
    );
    return '$_temp0';
  }

  @override
  String get homeRingDay => 'DÍA';

  @override
  String homeRingOfCycle(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'de tu ciclo',
      'other': 'del ciclo de $name',
    });
    return '$_temp0';
  }

  @override
  String homeRingOfPeriod(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'de tu periodo',
      'other': 'del periodo de $name',
    });
    return '$_temp0';
  }

  @override
  String get homeKeyPeriod => 'Periodo';

  @override
  String get homeKeyLikelyNext => 'Próximo probable';

  @override
  String get homeKeyToday => 'Hoy';

  @override
  String get homeAddPastPeriods => 'Añadir periodos anteriores';

  @override
  String get homeAddMissedPeriod => 'Añadir un periodo no registrado';

  @override
  String get homeNextPeriod => 'Próximo periodo';

  @override
  String homeLikelyBetween(String from, String to) {
    return 'probablemente entre el $from y el $to';
  }

  @override
  String get homeFertileWindow => 'Ventana fértil estimada';

  @override
  String get homeFertileWarning =>
      'Una estimación basada solo en las fechas del ciclo. No es lo bastante fiable como método anticonceptivo.';

  @override
  String homeConfidenceUnlogged(String date) {
    return 'Estimado a partir del último periodo registrado, el $date, así que puede ser menos preciso de lo habitual.';
  }

  @override
  String get homeConfidenceNone => 'Todavía no hay nada registrado.';

  @override
  String get homeConfidenceTypical =>
      'Basado por ahora en un ciclo típico de 28 días. Será más preciso a medida que registres.';

  @override
  String homeConfidenceFew(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Basado en $count ciclos hasta ahora, así que de momento puede ser menos preciso.',
      one: 'Basado en 1 ciclo hasta ahora, así que de momento puede ser menos preciso.',
    );
    return '$_temp0';
  }

  @override
  String homeConfidenceIrregular(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Tus ciclos varían bastante, así que esto es una estimación amplia y no una fecha segura.',
      'other':
          'Los ciclos de $name varían bastante, así que esto es una estimación amplia y no una fecha segura.',
    });
    return '$_temp0';
  }

  @override
  String homeConfidenceLast(String who, String name, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Basado en tus últimos $count ciclos.',
    );
    String _temp1 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Basado en los últimos $count ciclos de $name.',
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
      other: 'Basado en $count ciclos bastante regulares.',
    );
    return '$_temp0';
  }

  @override
  String get homeMilestoneFirstPeriod => 'Primer periodo registrado';

  @override
  String get homeMilestoneFirstCycle => 'Primer ciclo completo';

  @override
  String get homeMilestoneThreeCycles => 'Tres ciclos completos';

  @override
  String get homeMilestoneSixCycles => 'Seis ciclos completos';

  @override
  String get homeMilestoneOneYear => 'Un año de historial';

  @override
  String get homeMilestoneTwoYears => 'Dos años de historial';

  @override
  String get homeMilestoneFiveYears => 'Cinco años de historial';

  @override
  String get homeMilestoneFirstBackup => 'Primera copia de seguridad guardada';

  @override
  String homeMilestoneFirstPeriodMessage(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Tu primer periodo en Ebb.',
      'other': 'El primer periodo de $name en Ebb.',
    });
    return '$_temp0';
  }

  @override
  String homeMilestoneFirstCycleMessage(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Un primer ciclo completo. Ebb puede empezar a conocer tu ritmo.',
      'other':
          'Un primer ciclo completo. Ebb puede empezar a conocer el ritmo de $name.',
    });
    return '$_temp0';
  }

  @override
  String get homeMilestoneThreeCyclesMessage =>
      'Tres ciclos completos registrados. Cada uno le da a Ebb más información.';

  @override
  String get homeMilestoneSixCyclesMessage =>
      'Seis ciclos completos registrados: todos los que Ebb tiene en cuenta para cada estimación.';

  @override
  String homeMilestoneOneYearMessage(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Un año de tu historial en Ebb.',
      'other': 'Un año del historial de $name en Ebb.',
    });
    return '$_temp0';
  }

  @override
  String homeMilestoneTwoYearsMessage(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Dos años de tu historial en Ebb.',
      'other': 'Dos años del historial de $name en Ebb.',
    });
    return '$_temp0';
  }

  @override
  String homeMilestoneFiveYearsMessage(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Cinco años de tu historial en Ebb.',
      'other': 'Cinco años del historial de $name en Ebb.',
    });
    return '$_temp0';
  }

  @override
  String get homeMilestoneFirstBackupMessage =>
      'Tu primera copia de seguridad está guardada. Guarda una copia en otro sitio que no sea este teléfono.';

  @override
  String get homeProblemStartInFuture =>
      'La fecha de inicio no puede ser futura.';

  @override
  String get homeProblemEndInFuture => 'La fecha de fin no puede ser futura.';

  @override
  String get homeProblemEndBeforeStart =>
      'La fecha de fin es anterior a la de inicio.';

  @override
  String get homeProblemDuplicateStart =>
      'Ya hay registrado un periodo que empieza ese día.';

  @override
  String get homeProblemOverlapsPrevious =>
      'Se solapa con el periodo anterior. Revisa la fecha de fin de esa entrada.';

  @override
  String get homeProblemOverlapsNext =>
      'Se solapa con el periodo siguiente. Revisa la fecha de fin.';

  @override
  String get homeDeleteCycleTitle => '¿Borrar este ciclo?';

  @override
  String homeDeleteCycleBody(String date) {
    return 'Se quitará la entrada que empieza el $date. No se puede deshacer.';
  }

  @override
  String get homeFirstDayOfPeriod => 'Primer día del periodo';

  @override
  String get homeLastDayOfPeriod => 'Último día del periodo';

  @override
  String get homeAddPastPeriodTitle => 'Añadir un periodo anterior';

  @override
  String get homeEditPeriod => 'Editar periodo';

  @override
  String get homeStarted => 'Inicio';

  @override
  String get homeEnded => 'Fin';

  @override
  String get homeStillGoing => 'Sigue en curso';

  @override
  String get homeNotRecorded => 'No registrado';

  @override
  String get homeClearEnd => 'Quitar la fecha de fin';

  @override
  String get homeCountInPredictions => 'Contar este ciclo en las previsiones';

  @override
  String get homeCountInPredictionsHint =>
      'Desactívalo para un ciclo que no refleja el ritmo habitual: una enfermedad, un cambio de medicación, una pérdida del embarazo. Se queda en tu historial de todos modos.';

  @override
  String get homeNote => 'Nota';

  @override
  String get homeNoteExcludedHint =>
      'Por qué no se cuenta, para que sea fácil recordarlo después.';

  @override
  String get homeNoteHint =>
      'Cualquier cosa que valga la pena recordar sobre este.';

  @override
  String get homeDeletePeriod => 'Borrar este periodo';

  @override
  String get homeAddPastPeriod => 'Añadir periodo anterior';

  @override
  String get homeHistoryEmpty =>
      'Todavía no hay ciclos registrados. Si recuerdas cuándo empezaron tus últimos periodos, añadirlos le da ventaja a Ebb.';

  @override
  String get homeMilestones => 'Hitos';

  @override
  String homePeriodLength(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Periodo de $count días',
      one: 'Periodo de 1 día',
    );
    return '$_temp0';
  }

  @override
  String get homePeriodInProgress => 'Periodo en curso';

  @override
  String get homeEndNotRecorded => 'Fin no registrado';

  @override
  String get homeLongGap =>
      'Un intervalo largo. Si aquí hubo un periodo sin registrar, añádelo con «Añadir periodo anterior».';

  @override
  String get homeNothingSince =>
      'No hay nada registrado desde entonces. Si falta algún periodo, añádelo con «Añadir periodo anterior».';

  @override
  String homeNotCounted(String detail) {
    return '$detail · no se cuenta';
  }

  @override
  String get homeDayCycle => 'días de ciclo';

  @override
  String get homeLastLogged => 'Último registrado';

  @override
  String get homeCurrent => 'Actual';

  @override
  String get homeSpanMonths3 => 'Últimos 3 meses';

  @override
  String get homeSpanMonths6 => 'Últimos 6 meses';

  @override
  String get homeSpanYear => 'Último año';

  @override
  String get homeSpanAll => 'Todo';

  @override
  String get homeSpanCustom => 'Elegir fechas…';

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get settingsNotificationsOff =>
      'Las notificaciones de Ebb están desactivadas en los ajustes del sistema.';

  @override
  String settingsNoBrowser(String website) {
    return 'No hay ningún navegador para abrirlo. Visita $website.';
  }

  @override
  String get settingsNothingToBackUp => 'Todavía no hay nada que copiar.';

  @override
  String get settingsBackupSaved =>
      'Copia de seguridad guardada. Guarda una copia en otro sitio que no sea este teléfono.';

  @override
  String get settingsBackupNotSaved =>
      'No se pudo guardar la copia de seguridad ahí. Prueba en otro sitio.';

  @override
  String get settingsNoPicker =>
      'Este teléfono no tiene un selector de archivos que Ebb pueda usar. Enviar a otro teléfono funciona sin él.';

  @override
  String get settingsFileTooLarge =>
      'Ese archivo es demasiado grande para ser una copia de seguridad de Ebb.';

  @override
  String get settingsFileUnreadable => 'No se pudo leer ese archivo.';

  @override
  String get settingsNotABackup =>
      'Este archivo no es una copia de seguridad de Ebb.';

  @override
  String settingsPeriodCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count periodos',
      one: '$count periodo',
    );
    return '$_temp0';
  }

  @override
  String get settingsSetUpTitle => '¿Empezar con este historial?';

  @override
  String settingsSetUpBody(String periods, String date) {
    return '$periods, enviado el $date. En este teléfono pasa a ser tu historial.';
  }

  @override
  String settingsUpdateTitle(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': '¿Actualizar tu historial?',
      'other': '¿Actualizar a $name?',
    });
    return '$_temp0';
  }

  @override
  String settingsUpdateAction(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Actualizar tu historial',
      'other': 'Actualizar a $name',
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
          'Es de nuevo tu historial, enviado el $date: $periods. Sustituye la copia de este teléfono.',
      'other':
          'Es de nuevo el historial de $name, enviado el $date: $periods. Sustituye la copia de este teléfono.',
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
          'Es tu historial, enviado el $date: $periods. Sustituye lo que hay en este teléfono para ti, incluido todo lo registrado aquí desde entonces.',
      'other':
          'Es el historial de $name, enviado el $date: $periods. Sustituye lo que hay en este teléfono para $name, incluido todo lo registrado aquí desde entonces.',
    });
    return '$_temp0';
  }

  @override
  String get settingsReplaceEverything => 'Sustituirlo todo';

  @override
  String settingsPersonUpdated(String name) {
    return '$name: historial actualizado.';
  }

  @override
  String get settingsAddThisHistoryTitle => '¿Añadir este historial?';

  @override
  String settingsAddNamedTitle(String name) {
    return '¿Añadir a $name?';
  }

  @override
  String settingsAddBody(String periods) {
    return 'Tiene $periods. Puedes añadirlo junto a lo que ya hay aquí, o sustituir todo lo de este teléfono por él.';
  }

  @override
  String settingsAddNamedBody(String name, String periods) {
    return 'El historial de $name tiene $periods. Puedes añadirlo junto a lo que ya hay aquí, o sustituir todo lo de este teléfono por él.';
  }

  @override
  String get settingsAddAsNew => 'Añadir como alguien nuevo';

  @override
  String get settingsWhoIsThis => '¿Quién es?';

  @override
  String get settingsWhoIsThisHint =>
      'Un nombre para distinguir a cada persona en este teléfono.';

  @override
  String settingsPersonAdded(String name) {
    return 'Se añadió a $name.';
  }

  @override
  String get settingsRestored => 'Listo. Ebb se ha actualizado.';

  @override
  String get settingsReplaceTitle => '¿Sustituir lo que hay en Ebb?';

  @override
  String settingsReplaceSaved(String date, String periods) {
    return 'Guardada el $date, con $periods.';
  }

  @override
  String settingsReplaceSavedPeople(int people, String date, String periods) {
    String _temp0 = intl.Intl.pluralLogic(
      people,
      locale: localeName,
      other: 'Guardada el $date, con $periods de $people personas.',
    );
    return '$_temp0';
  }

  @override
  String settingsReplaceCurrent(String periods) {
    return 'Sustituye todo lo que hay ahora en Ebb, incluidos $periods en este teléfono.';
  }

  @override
  String get settingsReplace => 'Sustituir';

  @override
  String get settingsDeleteAllTitle => '¿Borrar todos los datos?';

  @override
  String get settingsDeleteAllBody =>
      'Se borrarán para siempre todos los ciclos y notas. Ebb no guarda ninguna otra copia, así que no se puede deshacer a menos que hayas guardado una copia de seguridad.';

  @override
  String get settingsDeleteAllBodyEveryone =>
      'Se borrarán para siempre todos los ciclos y notas de todas las personas de este teléfono. Ebb no guarda ninguna otra copia, así que no se puede deshacer a menos que hayas guardado una copia de seguridad.';

  @override
  String get settingsDeleteEverything => 'Borrarlo todo';

  @override
  String get settingsAllDeleted => 'Se han borrado todos los datos.';

  @override
  String get settingsYourName => 'Tu nombre';

  @override
  String get settingsRename => 'Cambiar nombre';

  @override
  String get settingsYourNameHint =>
      'Se muestra en la lista de personas. Déjalo vacío para aparecer como «Tú».';

  @override
  String settingsRemoveTitle(String name) {
    return '¿Quitar a $name de este teléfono?';
  }

  @override
  String settingsRemoveBody(String name) {
    return 'Se borrarán para siempre todos los ciclos y notas de $name. El historial de las demás personas no se ve afectado.';
  }

  @override
  String settingsPersonRemoved(String name) {
    return 'Se quitó a $name.';
  }

  @override
  String settingsRemovePerson(String name) {
    return 'Quitar a $name de este teléfono';
  }

  @override
  String get settingsYourCycle => 'Tu ciclo';

  @override
  String get settingsYourSettings => 'Tus ajustes';

  @override
  String settingsSettingsFor(String name) {
    return 'Ajustes de $name';
  }

  @override
  String get settingsName => 'Nombre';

  @override
  String get settingsReminders => 'Recordatorios';

  @override
  String settingsRemindersHint(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Un aviso antes de la fecha prevista de tu periodo.',
      'other': 'Un aviso antes de la fecha prevista del periodo de $name.',
    });
    return '$_temp0';
  }

  @override
  String get settingsRemindMe => 'Recordármelo';

  @override
  String settingsDaysAhead(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count días antes',
      one: '$count día antes',
    );
    return '$_temp0';
  }

  @override
  String settingsDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count días',
      one: '$count día',
    );
    return '$_temp0';
  }

  @override
  String get settingsFertile => 'Mostrar la ventana fértil estimada';

  @override
  String get settingsFertileHint =>
      'Desactivado de forma predeterminada. Una estimación basada solo en las fechas del ciclo: no es lo bastante fiable como método anticonceptivo.';

  @override
  String get settingsMoon => 'Mostrar las fases lunares';

  @override
  String get settingsMoonHint =>
      'Luna nueva, cuarto creciente, luna llena y cuarto menguante, en el calendario y los gráficos.';

  @override
  String get settingsTemperature => 'Registrar temperatura y moco cervical';

  @override
  String get settingsTemperatureHint =>
      'En cada día del calendario, con un gráfico de temperatura. Se registra y se dibuja, pero nunca se usa para estimar nada.';

  @override
  String get settingsTemperatureIn => 'Temperatura en';

  @override
  String get settingsCelebrate => 'Celebrar los hitos';

  @override
  String settingsCelebrateHint(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Una pequeña celebración por cosas como un primer ciclo completo o un año de historial, que aparecen en tu Historial.',
      'other':
          'Una pequeña celebración por cosas como un primer ciclo completo o un año de historial, que aparecen en el Historial de $name.',
    });
    return '$_temp0';
  }

  @override
  String get settingsPeople => 'Personas';

  @override
  String get settingsAddSomeone => 'Añadir a alguien';

  @override
  String get settingsTrackSomeoneElse => 'Registrar también a otra persona';

  @override
  String get settingsTrackSomeoneElseHint =>
      'Por ejemplo, alguien joven que acaba de empezar a tener el periodo.';

  @override
  String get settingsBackupSection => 'Copias y traspaso';

  @override
  String get settingsBackUp => 'Hacer una copia en un archivo';

  @override
  String get settingsBackUpHint =>
      'Guarda tu historial en un archivo, donde elijas.';

  @override
  String get settingsBackUpHintEveryone =>
      'Guarda el historial de todas las personas en un archivo, donde elijas.';

  @override
  String get settingsRestore => 'Restaurar una copia de seguridad';

  @override
  String get settingsRestoreHint => 'Sustituye lo que hay ahora en Ebb.';

  @override
  String get settingsSend => 'Enviar a otro teléfono';

  @override
  String get settingsSendHint =>
      'Muestra tu historial como códigos para que otro teléfono los escanee.';

  @override
  String get settingsSendHintEveryone =>
      'Muestra el historial de todas las personas como códigos para que otro teléfono los escanee.';

  @override
  String get settingsReceive => 'Recibir de otro teléfono';

  @override
  String get settingsReceiveHint =>
      'Escanea los códigos para añadir a alguien, actualizarlo o sustituirlo todo.';

  @override
  String get settingsAdvanced => 'Avanzado';

  @override
  String get settingsGroups => 'Grupos';

  @override
  String get settingsGroupsHint =>
      'Para círculos y clubes que llevan el registro juntos: reúne a personas bajo un nombre. Al desactivarlo, los grupos se ocultan sin borrarse.';

  @override
  String get settingsManageGroups => 'Gestionar grupos';

  @override
  String get settingsAboutEbb => 'Acerca de Ebb';

  @override
  String get settingsHowEbbWorks => 'Cómo funciona Ebb';

  @override
  String get settingsHowEbbWorksHint =>
      'Registro, estimaciones, copias de seguridad y más.';

  @override
  String get settingsYourData => 'Tus datos';

  @override
  String get settingsYourDataHint => 'Dónde están y quién puede verlos.';

  @override
  String get settingsWebsite => 'Sitio web';

  @override
  String get settingsSendFeedback => 'Enviar comentarios';

  @override
  String get settingsSendFeedbackHint =>
      'Un formulario en el sitio web, en tu navegador.';

  @override
  String get settingsDeleteAll => 'Borrar todos los datos';

  @override
  String settingsVersion(String version) {
    return 'Ebb $version\nHecho por SuperDaveLab';
  }

  @override
  String get settingsDataHeadline => 'Tu ciclo es cosa tuya.';

  @override
  String get settingsDataLede =>
      'Ebb está hecho para que la pregunta «¿qué hacen con mis datos?» tenga una respuesta aburrida: nada, porque nunca los recibimos.';

  @override
  String get settingsDataTradeOff =>
      'Algo que conviene saber: como no hay copia en la nube, si pierdes o borras el teléfono, pierdes el historial. Si eso te importa, guarda de vez en cuando una copia de seguridad desde Ajustes y tenla en otro sitio que no sea este teléfono.';

  @override
  String get settingsWhereDataLives => 'Dónde están tus datos';

  @override
  String get settingsWhereDataLivesHint => 'Tus datos y quién puede verlos.';

  @override
  String get settingsDataStaysTitle => 'Se queda en tu teléfono';

  @override
  String get settingsDataStaysBody =>
      'Todo lo que registras se guarda en una base de datos en este dispositivo. No hay que crear ninguna cuenta ni hay servidor con el que sincronizar. Solo va a otro sitio si tú lo mueves: a una copia de seguridad o a otro teléfono al que lo envíes.';

  @override
  String get settingsDataUnseenTitle => 'No podemos verlo';

  @override
  String get settingsDataUnseenBody =>
      'Ebb está hecho sin ningún permiso para usar internet. Android lo garantiza, y puedes comprobarlo tú en la lista de permisos de la aplicación.';

  @override
  String get settingsDataPermissionsTitle => 'Para qué son los permisos';

  @override
  String get settingsDataPermissionsBody =>
      'Notificaciones, para los recordatorios. Cámara, solo mientras recibes un historial de otro teléfono: lee los códigos y no se graba ni se guarda nada. Ebb también vuelve a programar tus recordatorios cuando el teléfono se reinicia. Esa es la lista completa.';

  @override
  String get settingsDataNotForSaleTitle => 'No hay nada que vender';

  @override
  String get settingsDataNotForSaleBody =>
      'Sin analíticas, sin publicidad, sin bibliotecas de terceros que envíen datos a casa. Como tus datos nunca nos llegan, no existe ninguna copia que alguien pueda comprar, reclamar por vía judicial o filtrar.';

  @override
  String get settingsDataEraseTitle => 'Puedes borrarlo al instante';

  @override
  String get settingsDataEraseBody =>
      'Borrar tus datos en Ajustes, o desinstalar Ebb, elimina todo lo que Ebb guarda. Ebb no guarda ninguna otra copia: las únicas son las copias de seguridad que hayas guardado o los teléfonos a los que tú lo hayas enviado.';

  @override
  String get settingsDataOpenSourceTitle => 'Puedes revisar nuestro trabajo';

  @override
  String get settingsDataOpenSourceBody =>
      'Ebb es de código abierto bajo la Licencia Pública General de GNU. Cualquiera puede leer exactamente lo que hace, y las versiones publicadas se compilan a partir de ese mismo código.';

  @override
  String get settingsHelpLoggingTitle => 'Registrar un periodo';

  @override
  String get settingsHelpLoggingBody =>
      'Toca «Mi periodo empezó hoy» el primer día de sangrado y «Mi periodo terminó hoy» el último.\n\n¿Se te olvidó registrarlo? Usa «Empezó un día anterior». Cualquier periodo pasado se puede añadir o corregir en el Historial (el icono del reloj): toca uno para cambiar sus fechas o añadir una nota.\n\nSi no se registra el fin en dos semanas, Ebb deja de considerar que el periodo sigue en curso y te ofrece añadir el fin.';

  @override
  String get settingsHelpEstimateTitle => 'Cómo funciona la estimación';

  @override
  String get settingsHelpEstimateBody =>
      'Ebb mira el tiempo entre los inicios de tus últimos periodos, hasta los seis últimos.\n\nCon poco historial se apoya en un ciclo típico de 28 días, y lo dice. Cuanto más registras, más refleja la estimación tu propio ritmo.\n\nMuestra un intervalo en lugar de una sola fecha, y te dice cuánta seguridad tiene. Si tus ciclos varían mucho, el intervalo es más amplio.\n\nSi un periodo se retrasa, Ebb dice cuánto. Si no se registra nada durante casi dos ciclos, supone que un periodo quedó sin registrar, hace la estimación a partir de ahí y lo dice. El Historial señala los intervalos largos, y añadir un periodo que falta corrige la estimación.';

  @override
  String get settingsHelpExcludeTitle => 'Un ciclo que no debería contar';

  @override
  String get settingsHelpExcludeBody =>
      'Una enfermedad, un cambio de medicación o una pérdida del embarazo pueden alterar mucho un ciclo, y arrastrarían la estimación con él.\n\nEn el Historial, toca ese periodo y desactiva «Contar este ciclo en las previsiones». Se queda en tu historial; la estimación simplemente lo ignora. Añade también una nota, para recordar por qué.';

  @override
  String get settingsHelpGroupsTitle => 'Grupos';

  @override
  String get settingsHelpGroupsBody =>
      'Para círculos y clubes que llevan el registro juntos. Actívalos en Ajustes → Avanzado, crea un grupo y elige quién está en él. «Ver … en conjunto», en la lista de personas, muestra a todos a la vez, con la luna.\n\nUn grupo puede tener dos tipos de miembro. A quien se añade se le registra en este teléfono, y tú registras por esa persona aquí. Quien se importa sigue registrando en su propio teléfono y aporta su historial al grupo: sigue siendo suyo, y no se puede cambiar en el teléfono de nadie más.\n\nPara que te importen, envía solo tu historial (Ajustes → Enviar a otro teléfono), tanto o tan poco como quieras, con o sin tus notas diarias. El otro teléfono lo importa desde el grupo: Gestionar grupos → el grupo → Importar desde su teléfono. Volver a importarte lo pone al día.\n\nEl historial importado pertenece a su grupo. Sacar a una persona importada de su último grupo, o borrar ese grupo, quita también su historial del teléfono. Y no se puede reenviar: solo puedes enviar tu propio historial.';

  @override
  String get settingsHelpRatingsTitle =>
      'Puntuaciones, estados de ánimo y gráficos';

  @override
  String get settingsHelpRatingsBody =>
      'Toca cualquier día del calendario para puntuarlo del 1 al 5 y para elegir una cara según cómo te sentiste. Las dos cosas son opcionales; vuelve a tocar una opción para quitarla.\n\nGráficos (el icono del gráfico) muestra la puntuación de cada día en las fechas que elijas, con los periodos sombreados, y qué estados de ánimo aparecieron durante y antes de los periodos. Si activas las fases lunares en Ajustes, también aparece la luna.\n\nLos gráficos muestran lo que registraste. No dicen qué significa: eso lo juzgas tú.';

  @override
  String get settingsHelpTemperatureTitle => 'Temperatura y moco cervical';

  @override
  String get settingsHelpTemperatureBody =>
      'Activa «Registrar temperatura y moco cervical» en Ajustes, y cada día del calendario tendrá sitio para tu temperatura al despertar y para la sensación y el aspecto del moco cervical. Si algo puede haber alterado una medición (una enfermedad, poco sueño, alcohol, tomarla tarde), marca la casilla que hay debajo.\n\nGráficos muestra las temperaturas como una línea, con el moco debajo y los periodos sombreados, en °C o °F (Ajustes).\n\nEbb registra y dibuja estos datos, y nada más. No busca una subida ni calcula los días fértiles a partir de ellos, y su estimación de la ventana fértil sigue basándose solo en las fechas del ciclo. Si sigues un método como el sintotérmico, el gráfico está ahí para que lo leas según sus reglas.';

  @override
  String get settingsHelpRemindersTitle => 'Recordatorios';

  @override
  String get settingsHelpRemindersBody =>
      'Un aviso unos días antes de la fecha prevista de tu periodo, y otro ese mismo día. Elige con cuánta antelación en Ajustes.\n\nSe programan en el propio teléfono, así que llegan sin cobertura y en modo avión.\n\nEbb los programa cada vez que lo abres, a partir de la última estimación. El teléfono los conserva al reiniciarse, pero Ebb no puede actualizarlos mientras está cerrado, así que ábrelo de vez en cuando: basta con registrar un periodo.\n\nAndroid puede entregarlos un poco más tarde de lo habitual para ahorrar batería. Si se fuerza la detención de Ebb, o un ahorro de batería lo restringe, puede que no lleguen hasta que vuelvas a abrir Ebb.';

  @override
  String get settingsHelpFertileTitle => 'La ventana fértil';

  @override
  String get settingsHelpFertileBody =>
      'Está desactivada salvo que la actives en Ajustes. Se estima solo a partir de las fechas del ciclo, lo cual no es lo bastante fiable como método anticonceptivo.';

  @override
  String get settingsHelpBackupTitle => 'Copias de seguridad';

  @override
  String get settingsHelpBackupBody =>
      'No hay copia de tu historial en la nube, así que si pierdes o borras el teléfono, pierdes el historial.\n\nAjustes → «Hacer una copia en un archivo» lo guarda todo en un archivo, donde elijas. Tenlo en otro sitio que no sea este teléfono. «Restaurar una copia de seguridad» lo recupera.';

  @override
  String get settingsHelpMovingTitle => 'Pasar a un teléfono nuevo';

  @override
  String get settingsHelpMovingBody =>
      'En el teléfono antiguo: Ajustes → «Enviar a otro teléfono». En el nuevo: Ajustes → «Recibir de otro teléfono», y apunta la cámara a la pantalla.\n\nLos historiales más largos ocupan varios códigos, que cambian solos; el teléfono nuevo los recoge en cualquier orden. No interviene internet: un teléfono muestra y el otro mira.';

  @override
  String get settingsHelpSomeoneElseTitle => 'Registrar a otra persona';

  @override
  String get settingsHelpSomeoneElseBody =>
      '¿Ayudas a otra persona a llevar el registro, por ejemplo a alguien joven que acaba de empezar? Ajustes → «Registrar también a otra persona», y ponle un nombre. Basta con un apodo o una inicial.\n\nToca el nombre en la parte superior de la pantalla de inicio para cambiar de persona. Cada persona tiene sus propios recordatorios, que empiezan desactivados para las personas que añades. La ventana fértil solo se ofrece para ti.';

  @override
  String get settingsHelpHandoverTitle => 'Pasarle el registro a alguien';

  @override
  String get settingsHelpHandoverBody =>
      'Cuando alguien a quien registras tiene su propio teléfono: «Enviar a otro teléfono», y elige solo a esa persona. En su teléfono, «Recibir de otro teléfono». En una instalación nueva, su historial pasa a ser suyo sin más.\n\nDespués, Ebb pregunta si quitarla de tu teléfono. Nunca lo hace por su cuenta.';

  @override
  String get settingsHelpDeletingTitle => 'Borrar';

  @override
  String get settingsHelpDeletingBody =>
      'Ajustes → «Borrar todos los datos» borra de una vez todo lo que hay en este teléfono.\n\nPara quitar a una persona que hayas añadido, abre sus ajustes y elige «Quitar a … de este teléfono». El historial de las demás personas no se toca.';

  @override
  String shareRemoveTitle(String name) {
    return '¿Quitar a $name de este teléfono?';
  }

  @override
  String shareRemoveBody(String name) {
    return 'Si el historial de $name llegó al otro teléfono, se puede quitar de este. También puedes conservarlo aquí.';
  }

  @override
  String get shareKeep => 'Conservar';

  @override
  String shareRemoved(String name) {
    return 'Se quitó a $name.';
  }

  @override
  String get shareTitle => 'Enviar a otro teléfono';

  @override
  String get shareWhatToSend => '¿Qué quieres enviar?';

  @override
  String get shareEveryone => 'Todas las personas';

  @override
  String get shareEveryoneHint => 'Para pasar a un teléfono nuevo.';

  @override
  String get shareJustOne => 'Solo una persona';

  @override
  String get shareJustYours => 'Solo tu historial';

  @override
  String shareJustName(String name) {
    return 'Solo $name';
  }

  @override
  String shareForTheirPhone(String name) {
    return 'Para el teléfono de $name.';
  }

  @override
  String get shareCopiesNotOffered =>
      'Las personas importadas desde otros teléfonos no aparecen aquí: cada persona comparte solo su propio historial.';

  @override
  String shareHowMuch(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': '¿Cuánto de tu historial?',
      'other': '¿Cuánto del historial de $name?',
    });
    return '$_temp0';
  }

  @override
  String get shareHowMuchHint =>
      'Enviarlo todo es lo adecuado para un teléfono nuevo. Para compartir con un grupo, quizá envíes menos. No se quita nada de este teléfono.';

  @override
  String get shareHowFarBack => 'Desde cuándo';

  @override
  String get shareSpanEverything => 'Todo';

  @override
  String get shareSpanYear => 'El último año';

  @override
  String shareSpanMonths(int months) {
    String _temp0 = intl.Intl.pluralLogic(
      months,
      locale: localeName,
      other: 'Los últimos $months meses',
      one: 'El último mes',
    );
    return '$_temp0';
  }

  @override
  String get shareSpanLatest => 'Solo el último periodo';

  @override
  String get shareWhatToInclude => 'Qué incluir';

  @override
  String get shareWithDays => 'Periodos y entradas diarias';

  @override
  String get shareWithDaysHint =>
      'También notas, puntuaciones, estados de ánimo y sangrado.';

  @override
  String get sharePeriodsOnly => 'Solo periodos';

  @override
  String get sharePeriodsOnlyHint =>
      'Solo cuándo empezó y terminó cada periodo.';

  @override
  String get shareShowCodes => 'Mostrar los códigos';

  @override
  String get shareNothing => 'Todavía no hay nada que enviar.';

  @override
  String get shareHowToReceive =>
      'En el otro teléfono, abre Ebb, ve a Ajustes → Recibir de otro teléfono y apunta la cámara a esta pantalla.';

  @override
  String shareCodeOf(int index, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      total,
      locale: localeName,
      other: 'Código $index de $total',
    );
    return '$_temp0';
  }

  @override
  String get sharePreviousCode => 'Código anterior';

  @override
  String get sharePause => 'Pausa';

  @override
  String get sharePlay => 'Reanudar';

  @override
  String get shareNextCode => 'Código siguiente';

  @override
  String get shareCodesChange =>
      'Los códigos cambian solos. El otro teléfono los recoge en cualquier orden.';

  @override
  String sharePeriodCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count periodos',
      one: '$count periodo',
    );
    return '$_temp0';
  }

  @override
  String shareSummaryEverything(String periods) {
    return 'Todo lo que hay en Ebb: $periods.';
  }

  @override
  String shareSummaryEverythingPeople(String periods, int people) {
    String _temp0 = intl.Intl.pluralLogic(
      people,
      locale: localeName,
      other: 'Todo lo que hay en Ebb: $periods de $people personas.',
    );
    return '$_temp0';
  }

  @override
  String shareSummaryHistoryAll(String who, String name, String periods) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Tu historial: $periods.',
      'other': 'Historial de $name: $periods.',
    });
    return '$_temp0';
  }

  @override
  String shareSummaryHistoryLatest(String who, String name, String periods) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Tu historial, solo el último periodo: $periods.',
      'other': 'Historial de $name, solo el último periodo: $periods.',
    });
    return '$_temp0';
  }

  @override
  String shareSummaryHistoryYear(String who, String name, String periods) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Tu historial del último año: $periods.',
      'other': 'Historial de $name del último año: $periods.',
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
      'you': 'Tu historial de los últimos $months meses: $periods.',
      'other': 'Historial de $name de los últimos $months meses: $periods.',
    });
    return '$_temp0';
  }

  @override
  String shareSummaryPeriodsAll(String who, String name, String periods) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Tus periodos: $periods.',
      'other': 'Periodos de $name: $periods.',
    });
    return '$_temp0';
  }

  @override
  String shareSummaryPeriodsLatest(String who, String name, String periods) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Tus periodos, solo el último: $periods.',
      'other': 'Periodos de $name, solo el último: $periods.',
    });
    return '$_temp0';
  }

  @override
  String shareSummaryPeriodsYear(String who, String name, String periods) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Tus periodos del último año: $periods.',
      'other': 'Periodos de $name del último año: $periods.',
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
      'you': 'Tus periodos de los últimos $months meses: $periods.',
      'other': 'Periodos de $name de los últimos $months meses: $periods.',
    });
    return '$_temp0';
  }

  @override
  String get shareNotEbb => 'Ese código no es de Ebb.';

  @override
  String get shareNewerVersion =>
      'El otro teléfono tiene una versión más reciente de Ebb. Actualiza primero este.';

  @override
  String get shareRestarted =>
      'El otro teléfono ha vuelto a empezar. Recogiendo los códigos nuevos.';

  @override
  String get shareUnreadable =>
      'Algunos códigos no se leyeron bien. Vamos a escanearlos otra vez.';

  @override
  String get shareNeedsCamera =>
      'Ebb necesita la cámara para leer los códigos. Puedes permitirlo en los ajustes del sistema para Ebb.';

  @override
  String get sharePointCamera =>
      'Apunta la cámara al código del otro teléfono.';

  @override
  String get shareReading => 'Leyendo…';

  @override
  String shareCodesReceived(int received, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      total,
      locale: localeName,
      other: '$received de $total códigos recibidos',
    );
    return '$_temp0';
  }

  @override
  String get shareReceiveTitle => 'Recibir de otro teléfono';

  @override
  String shareStillNeeded(String codes) {
    return 'Faltan: $codes';
  }

  @override
  String get groupsMoreThanOne => 'Eso es más de una persona';

  @override
  String get groupsMoreThanOneBody =>
      'Estos códigos contienen el historial de todo un teléfono. Para unirse a un grupo, cada persona envía solo el suyo: en su teléfono, Ajustes → Enviar a otro teléfono → Solo tu historial.';

  @override
  String groupsUpdateTitle(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': '¿Actualizar tu historial?',
      'other': '¿Actualizar a $name?',
    });
    return '$_temp0';
  }

  @override
  String groupsUpdateAction(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Actualizar tu historial',
      'other': 'Actualizar a $name',
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
          'Es de nuevo tu historial, enviado el $sent: $periods. Sustituye la copia de este teléfono.',
      'other':
          'Es de nuevo el historial de $name, enviado el $sent: $periods. Sustituye la copia de este teléfono.',
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
          'Es tu historial, enviado el $sent: $periods. Sustituye lo que hay en este teléfono para ti, incluido todo lo registrado aquí desde entonces.',
      'other':
          'Es el historial de $name, enviado el $sent: $periods. Sustituye lo que hay en este teléfono para $name, incluido todo lo registrado aquí desde entonces.',
    });
    return '$_temp0';
  }

  @override
  String groupsUpdated(String name) {
    return '$name: historial actualizado.';
  }

  @override
  String groupsImportInto(String group) {
    return 'Importar a $group';
  }

  @override
  String groupsImportHint(String periods, String sent) {
    return '$periods, enviado el $sent. Se importa en solo lectura: aquí no se puede cambiar, y se pone al día cuando se vuelve a enviar.';
  }

  @override
  String groupsImported(String name, String group) {
    return 'Se importó a $name en $group.';
  }

  @override
  String get groupsGroup => 'Grupo';

  @override
  String get groupsNoMembers =>
      'Todavía no hay nadie en este grupo. Añade personas en Ajustes → Avanzado → Gestionar grupos: marca a personas que ya están en este teléfono, o añade a alguien desde su teléfono.';

  @override
  String get groupsPeriods => 'Periodos';

  @override
  String get groupsChartHint =>
      'Cada barra es un periodo; un contorno es uno cuyo fin no se registró, dibujado con la duración habitual. Las líneas continuas bajan desde cada luna llena, y las discontinuas desde cada luna nueva.';

  @override
  String get groupsNew => 'Nuevo grupo';

  @override
  String get groupsRename => 'Cambiar nombre del grupo';

  @override
  String get groupsNameHint => 'Por ejemplo, el nombre de tu círculo o club.';

  @override
  String get groupsNameTaken => 'Ya hay un grupo con ese nombre.';

  @override
  String get groupsNoOneYet => 'Nadie todavía';

  @override
  String get groupsTitle => 'Grupos';

  @override
  String get groupsIntro =>
      'Un grupo reúne a personas de este teléfono bajo un nombre: un círculo o club que lleva el registro junto. Alguien puede estar en más de uno, y borrar un grupo nunca borra a nadie.';

  @override
  String groupsAddSomeoneTo(String group) {
    return 'Añadir a alguien a $group';
  }

  @override
  String get groupsAddSomeoneHint =>
      'Se registra en este teléfono: registras y cambias su historial aquí. A alguien que lleva el registro en su propio teléfono se le puede importar en su lugar.';

  @override
  String groupsTakeOutTitle(String name, String group) {
    return '¿Sacar a $name de $group?';
  }

  @override
  String groupsTakeOutBody(String name) {
    return '$name se importó desde su teléfono y no está en ningún otro grupo, así que el historial importado también se quita de este teléfono. $name puede volver a enviarlo para unirse de nuevo.';
  }

  @override
  String get groupsTakeOut => 'Sacar';

  @override
  String groupsDeleteTitle(String group) {
    return '¿Borrar $group?';
  }

  @override
  String get groupsDeleteBodyNone =>
      'Solo se borra el grupo. Todas las personas que están en él se quedan en este teléfono, con todo su historial.';

  @override
  String groupsDeleteBodySome(String names) {
    return 'Las personas importadas solo a este grupo también se quitan de este teléfono: $names. Las demás se quedan, con todo su historial.';
  }

  @override
  String get groupsDeleteGroup => 'Borrar grupo';

  @override
  String get groupsRenameTooltip => 'Cambiar nombre';

  @override
  String get groupsWhoIsIn => 'Quién está';

  @override
  String groupsImportedAsOf(String date) {
    return 'Importación · solo lectura, a fecha de $date';
  }

  @override
  String get groupsTrackedHere => 'Se registra en este teléfono';

  @override
  String get groupsAddTo => 'Añadir al grupo';

  @override
  String get groupsAddNew => 'Añadir a alguien nuevo';

  @override
  String get groupsAddNewHint =>
      'Se registra en este teléfono: registras sus periodos aquí.';

  @override
  String get groupsImportFromPhone => 'Importar desde su teléfono';

  @override
  String get groupsImportFromPhoneHint =>
      'Sigue llevando el registro en su propio teléfono y lo envía aquí, en solo lectura. Volver a importarlo lo pone al día.';

  @override
  String get groupsDeleteThis => 'Borrar este grupo';

  @override
  String get peopleNameTaken => 'Ese nombre ya se usa en este teléfono.';

  @override
  String get peopleName => 'Nombre';

  @override
  String peopleSeeTogether(String group) {
    return 'Ver $group en conjunto';
  }

  @override
  String get peopleNotInGroup => 'Sin grupo';

  @override
  String get peopleAddSomeone => 'Añadir a alguien';

  @override
  String get peopleTrackSomeoneElse => 'Registrar a otra persona';

  @override
  String get peopleNameHint =>
      'Solo algo para distinguir a las personas: un nombre, un apodo o una inicial.';

  @override
  String backupUnnamedPerson(int number) {
    return 'Persona $number';
  }

  @override
  String get backupNotEbb =>
      'Este archivo no es una copia de seguridad de Ebb.';

  @override
  String get backupNewer =>
      'Esta copia de seguridad es de una versión más reciente de Ebb. Actualiza Ebb y vuelve a intentarlo.';

  @override
  String get backupNoOne => 'En esta copia de seguridad no hay nadie.';

  @override
  String get backupSameId =>
      'Esta copia de seguridad parece dañada: hay dos personas con el mismo identificador.';

  @override
  String backupAfterExport(String date) {
    return '$date es posterior al día en que se hizo esta copia de seguridad.';
  }

  @override
  String backupSameName(String name) {
    return 'En esta copia de seguridad hay dos personas que se llaman $name.';
  }

  @override
  String backupSameGroupName(String group) {
    return 'En esta copia de seguridad hay dos grupos que se llaman $group.';
  }

  @override
  String backupEndsBefore(String date) {
    return 'El periodo que empieza el $date termina antes de empezar.';
  }

  @override
  String backupTwoStarts(String date) {
    return 'Hay dos periodos que empiezan el $date para la misma persona.';
  }

  @override
  String backupDayTwice(String date) {
    return '$date aparece dos veces para la misma persona.';
  }

  @override
  String backupOverlaps(String date) {
    return 'El periodo que empieza el $date se solapa con el anterior.';
  }

  @override
  String get backupDamaged =>
      'Esta copia de seguridad parece dañada: no se pudo leer la copia.';

  @override
  String get backupDamagedExportDate =>
      'Esta copia de seguridad parece dañada: no se pudo leer la fecha de exportación.';

  @override
  String get backupDamagedGroup =>
      'Esta copia de seguridad parece dañada: no se pudo leer un grupo.';

  @override
  String get backupDamagedGroupName =>
      'Esta copia de seguridad parece dañada: no se pudo leer el nombre de un grupo.';

  @override
  String backupDamagedGroupPeople(String group) {
    return 'Esta copia de seguridad parece dañada: no se pudieron leer las personas del grupo $group.';
  }

  @override
  String get backupDamagedPerson =>
      'Esta copia de seguridad parece dañada: no se pudo leer la entrada de una persona.';

  @override
  String get backupDamagedName =>
      'Esta copia de seguridad parece dañada: no se pudo leer un nombre.';

  @override
  String get backupDamagedPersonId =>
      'Esta copia de seguridad parece dañada: no se pudo leer el identificador de una persona.';

  @override
  String get backupDamagedSharedOn =>
      'Esta copia de seguridad parece dañada: no se pudo leer el día en que se compartió un historial.';

  @override
  String get backupDamagedPeriod =>
      'Esta copia de seguridad parece dañada: no se pudo leer la entrada de un periodo.';

  @override
  String get backupDamagedPeriodStart =>
      'Esta copia de seguridad parece dañada: no se pudo leer el inicio de un periodo.';

  @override
  String get backupDamagedPeriodEnd =>
      'Esta copia de seguridad parece dañada: no se pudo leer el fin de un periodo.';

  @override
  String get backupDamagedDay =>
      'Esta copia de seguridad parece dañada: no se pudo leer la entrada de un día.';

  @override
  String backupDamagedFlow(String date) {
    return 'Esta copia de seguridad parece dañada: no se pudo leer el sangrado del $date.';
  }

  @override
  String backupDamagedSymptom(String date) {
    return 'Esta copia de seguridad parece dañada: no se pudo leer un síntoma del $date.';
  }

  @override
  String backupDamagedRating(String date) {
    return 'Esta copia de seguridad parece dañada: no se pudo leer la puntuación del $date.';
  }

  @override
  String backupDamagedFeeling(String date) {
    return 'Esta copia de seguridad parece dañada: no se pudo leer el estado de ánimo del $date.';
  }

  @override
  String backupDamagedTemperature(String date) {
    return 'Esta copia de seguridad parece dañada: no se pudo leer la temperatura del $date.';
  }

  @override
  String backupDamagedMucus(String date) {
    return 'Esta copia de seguridad parece dañada: no se pudo leer el moco cervical del $date.';
  }
}
