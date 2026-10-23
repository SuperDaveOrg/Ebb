// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get you => 'Eu';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Cancelar';

  @override
  String get save => 'Guardar';

  @override
  String get delete => 'Eliminar';

  @override
  String get remove => 'Remover';

  @override
  String get close => 'Fechar';

  @override
  String get done => 'Concluído';

  @override
  String get back => 'Voltar';

  @override
  String get next => 'Seguinte';

  @override
  String get edit => 'Editar';

  @override
  String get add => 'Adicionar';

  @override
  String get continueAction => 'Continuar';

  @override
  String get language => 'Idioma';

  @override
  String get languagePhone => 'Igual ao telemóvel';

  @override
  String languagePhoneIs(String language) {
    return 'Igual ao telemóvel ($language)';
  }

  @override
  String get notifChannelName => 'Lembretes do ciclo';

  @override
  String get notifChannelDescription =>
      'Um aviso antes da data prevista da menstruação e um lembrete para a registar.';

  @override
  String notifUpcomingTitle(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Menstruação prevista em breve',
      'other': 'Menstruação de $name prevista em breve',
    });
    return '$_temp0';
  }

  @override
  String notifUpcomingTomorrow(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'O Ebb prevê que a sua menstruação comece amanhã.',
      'other': 'O Ebb prevê que a menstruação de $name comece amanhã.',
    });
    return '$_temp0';
  }

  @override
  String notifUpcomingInDays(String who, String name, int days) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'O Ebb prevê a sua menstruação daqui a cerca de $days dias.',
      'other':
          'O Ebb prevê a menstruação de $name daqui a cerca de $days dias.',
    });
    return '$_temp0';
  }

  @override
  String notifTodayTitle(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Menstruação prevista para hoje',
      'other': 'Menstruação de $name prevista para hoje',
    });
    return '$_temp0';
  }

  @override
  String get notifTodayBody => 'Toque para registar como está a correr.';

  @override
  String get calendarTitle => 'Calendário';

  @override
  String get calendarCellToday => 'hoje';

  @override
  String get calendarCellPeriod => 'menstruação';

  @override
  String get calendarCellPeriodUnlogged => 'menstruação, fim não registado';

  @override
  String get calendarCellLikely => 'provável início da próxima menstruação';

  @override
  String get calendarCellFertile => 'janela fértil estimada';

  @override
  String calendarCellMoon(String phase) {
    String _temp0 = intl.Intl.selectLogic(phase, {
      'newMoon': 'lua nova',
      'firstQuarter': 'quarto crescente',
      'full': 'lua cheia',
      'other': 'quarto minguante',
    });
    return '$_temp0';
  }

  @override
  String calendarCellRated(int rating) {
    return 'classificação $rating';
  }

  @override
  String calendarCellFelt(String feeling) {
    return 'sentimento: $feeling';
  }

  @override
  String get calendarCellNote => 'tem uma nota';

  @override
  String get calendarKeyPeriod => 'Menstruação';

  @override
  String get calendarKeyEndNotLogged => 'Fim não registado';

  @override
  String get calendarKeyLikely => 'Início provável';

  @override
  String get calendarKeyFertile => 'Fértil (estimativa)';

  @override
  String get calendarKeyToday => 'Hoje';

  @override
  String calendarStatusWindow(String who, String name, String from, String to) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you':
          'É provável que a sua próxima menstruação comece entre $from e $to.',
      'other':
          'É provável que a próxima menstruação de $name comece entre $from e $to.',
    });
    return '$_temp0';
  }

  @override
  String calendarStatusPeriodDay(String who, String name, int day) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Dia $day da sua menstruação.',
      'other': 'Dia $day da menstruação de $name.',
    });
    return '$_temp0';
  }

  @override
  String calendarStatusPeriodDayExcluded(String who, String name, int day) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you':
          'Dia $day da sua menstruação, num ciclo que não conta para as previsões.',
      'other':
          'Dia $day da menstruação de $name, num ciclo que não conta para as previsões.',
    });
    return '$_temp0';
  }

  @override
  String calendarStatusUnlogged(String who, String name, int day) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you':
          'Dia $day do seu ciclo. O fim desta menstruação não foi registado, por isso é mostrada com a duração habitual.',
      'other':
          'Dia $day do ciclo de $name. O fim desta menstruação não foi registado, por isso é mostrada com a duração habitual.',
    });
    return '$_temp0';
  }

  @override
  String get calendarStatusFertile =>
      'Na janela fértil estimada. Não é suficientemente fiável para ser usada como contraceção.';

  @override
  String calendarStatusCycleDay(String who, String name, int day) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Dia $day do seu ciclo.',
      'other': 'Dia $day do ciclo de $name.',
    });
    return '$_temp0';
  }

  @override
  String calendarDayToday(String date) {
    return 'Hoje, $date';
  }

  @override
  String get calendarPreviousDay => 'Dia anterior';

  @override
  String get calendarNextDay => 'Dia seguinte';

  @override
  String calendarMoonAt(String phase, String time) {
    return '$phase, $time';
  }

  @override
  String get calendarFutureDay =>
      'Os dias que ainda não chegaram não podem ser registados.';

  @override
  String calendarMarkStarted(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Marcar como o dia em que a sua menstruação começou',
      'other': 'Marcar como o dia em que a menstruação de $name começou',
    });
    return '$_temp0';
  }

  @override
  String get calendarMoveStart => 'Fazer deste o primeiro dia da menstruação';

  @override
  String calendarMoveStartFrom(String date) {
    return 'Altera o início, que agora é $date';
  }

  @override
  String calendarMarkEnded(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Marcar como o dia em que a sua menstruação terminou',
      'other': 'Marcar como o dia em que a menstruação de $name terminou',
    });
    return '$_temp0';
  }

  @override
  String get calendarMakeLastDay => 'Fazer deste o último dia da menstruação';

  @override
  String get calendarEditPeriod => 'Editar esta menstruação';

  @override
  String calendarRateDay(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Avalie o seu dia, de 1 a 5',
      'other': 'Avalie o dia de $name, de 1 a 5',
    });
    return '$_temp0';
  }

  @override
  String calendarHowFelt(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Como se sentiu?',
      'other': 'Como se sentiu $name?',
    });
    return '$_temp0';
  }

  @override
  String get calendarFlow => 'Fluxo';

  @override
  String get calendarNote => 'Nota';

  @override
  String calendarTemperatureHeading(String unit) {
    return 'Temperatura, $unit';
  }

  @override
  String calendarTemperatureRange(String low, String high, String unit) {
    return 'Introduza uma temperatura entre $low e $high $unit';
  }

  @override
  String get calendarTemperatureHelper => 'Ao acordar, antes de se levantar';

  @override
  String get calendarTemperatureAffected => 'Algo pode tê-la afetado';

  @override
  String get calendarTemperatureAffectedHint =>
      'Doença, pouco sono, álcool, medida mais tarde';

  @override
  String get calendarMucus => 'Muco cervical';

  @override
  String get calendarMucusFelt => 'Sensação';

  @override
  String get calendarMucusLooked => 'Aspeto';

  @override
  String calendarLoggedRated(int rating, String ratingName) {
    return 'Classificação $rating de 5, $ratingName';
  }

  @override
  String calendarLoggedFelt(String emoji, String feeling) {
    return 'Sentimento: $emoji $feeling';
  }

  @override
  String calendarLoggedFlow(String flow) {
    String _temp0 = intl.Intl.selectLogic(flow, {
      'spotting': 'Fluxo: perdas',
      'light': 'Fluxo: ligeiro',
      'medium': 'Fluxo: moderado',
      'other': 'Fluxo: intenso',
    });
    return '$_temp0';
  }

  @override
  String calendarLoggedTemperature(String temperature) {
    return 'Temperatura: $temperature';
  }

  @override
  String calendarLoggedTemperatureAffected(String temperature) {
    return 'Temperatura: $temperature, possivelmente afetada';
  }

  @override
  String calendarLoggedMucus(String mucus) {
    return 'Muco cervical: $mucus';
  }

  @override
  String calendarLoggedNote(String note) {
    return '«$note»';
  }

  @override
  String get calendarNothingLogged => 'Nada registado neste dia.';

  @override
  String get calendarMoonNew => 'Lua nova';

  @override
  String get calendarMoonFirstQuarter => 'Quarto crescente';

  @override
  String get calendarMoonFull => 'Lua cheia';

  @override
  String get calendarMoonLastQuarter => 'Quarto minguante';

  @override
  String get dayFlowNone => 'Nenhum';

  @override
  String get dayFlowSpotting => 'Perdas';

  @override
  String get dayFlowLight => 'Ligeiro';

  @override
  String get dayFlowMedium => 'Moderado';

  @override
  String get dayFlowHeavy => 'Intenso';

  @override
  String get dayMucusNothing => 'Nada';

  @override
  String get dayMucusFeelDry => 'Seco';

  @override
  String get dayMucusFeelWet => 'Húmido';

  @override
  String get dayMucusFeelSlippery => 'Escorregadio';

  @override
  String get dayMucusLookCreamy => 'Cremoso';

  @override
  String get dayMucusLookEggWhite => 'Clara de ovo';

  @override
  String dayMucusFeelInline(String feel) {
    String _temp0 = intl.Intl.selectLogic(feel, {
      'dry': 'seco',
      'nothing': 'nada sentido',
      'wet': 'húmido',
      'other': 'escorregadio',
    });
    return '$_temp0';
  }

  @override
  String dayMucusLookInline(String look) {
    String _temp0 = intl.Intl.selectLogic(look, {
      'nothing': 'nada visto',
      'creamy': 'cremoso',
      'other': 'clara de ovo',
    });
    return '$_temp0';
  }

  @override
  String get dayFeelingHappy => 'Felicidade';

  @override
  String get dayFeelingCalm => 'Calma';

  @override
  String get dayFeelingLoving => 'Carinho';

  @override
  String get dayFeelingEnergetic => 'Energia';

  @override
  String get dayFeelingTired => 'Cansaço';

  @override
  String get dayFeelingSad => 'Tristeza';

  @override
  String get dayFeelingAnxious => 'Ansiedade';

  @override
  String get dayFeelingIrritable => 'Irritação';

  @override
  String get dayFeelingAngry => 'Raiva';

  @override
  String get dayFeelingConfused => 'Confusão';

  @override
  String get chartsTitle => 'Gráficos';

  @override
  String get chartsDayRating => 'Avaliação do dia';

  @override
  String get chartsNoRatings => 'Ainda não há dias avaliados neste intervalo.';

  @override
  String get chartsBars => 'Barras';

  @override
  String get chartsLine => 'Linha';

  @override
  String get chartsRatingCaptionBars =>
      'Cada barra é a avaliação de um dia, de 1 a 5. Os dias de menstruação estão sombreados.';

  @override
  String get chartsRatingCaptionLine =>
      'Cada ponto é a avaliação de um dia, de 1 a 5, ligado ao do dia seguinte quando ambos foram avaliados. Os dias de menstruação estão sombreados.';

  @override
  String get chartsRatingCaptionMoon =>
      'As luas marcam as fases da lua; num intervalo longo, só as luas novas e cheias, ou apenas as cheias.';

  @override
  String get chartsTemperatureTitle => 'Temperatura e muco cervical';

  @override
  String get chartsTemperatureEmpty =>
      'Ainda não há nada registado neste intervalo. Toque num dia do calendário para adicionar uma temperatura ou o muco cervical.';

  @override
  String chartsTemperatureCaption(String unit) {
    return 'Cada ponto é a temperatura de um dia, em $unit, ligado ao do dia seguinte quando ambas foram medidas. Um ponto vazio pode ter sido afetado e não é ligado. Por baixo, o muco cervical: barras mais altas indicam mais humidade (sensação) e muco mais transparente e elástico (aspeto). Os dias de menstruação estão sombreados.';
  }

  @override
  String get chartsFeelings => 'Sentimentos';

  @override
  String get chartsAroundPeriods => 'Em torno da menstruação';

  @override
  String get chartsAroundMoon => 'Em torno da lua';

  @override
  String get chartsFeelingsEmptyMoon =>
      'Quando tiver escolhido como se sentiu em alguns dias deste intervalo, aparecem aqui os sentimentos que surgiram perto das luas cheias e novas.';

  @override
  String get chartsFeelingsEmptyPeriods =>
      'Quando tiver escolhido como se sentiu em alguns dias deste intervalo, e uma menstruação tiver começado depois disso, aparece aqui que sentimentos surgiram e quando.';

  @override
  String get chartsFeelingsCaptionMoon =>
      'Em quantos dias foi escolhida cada cara.';

  @override
  String get chartsFeelingsCaptionPeriods =>
      'Em quantos dias foi escolhida cada cara. Os dias desde o início da última menstruação só contam quando começar a seguinte.';

  @override
  String get chartsNoneYet => 'Ainda nenhum.';

  @override
  String get chartsGroupDuringPeriod => 'Durante a menstruação';

  @override
  String get chartsGroupBeforePeriod => 'Pouco antes da menstruação';

  @override
  String get chartsGroupOtherDays => 'Outros dias';

  @override
  String get chartsGroupFullMoon => 'Perto da lua cheia';

  @override
  String get chartsGroupNewMoon => 'Perto da lua nova';

  @override
  String get chartsDetailLoggedPeriodDays => 'dias de menstruação registados';

  @override
  String chartsDetailUsuallyDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'normalmente $days dias',
      one: 'normalmente 1 dia',
      zero: 'normalmente $days dias',
    );
    return '$_temp0';
  }

  @override
  String chartsDetailDaysBefore(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'os $days dias anteriores',
      one: 'o dia anterior',
      zero: 'os $days dias anteriores',
    );
    return '$_temp0';
  }

  @override
  String get chartsDetailRestOfCycle => 'o resto do ciclo';

  @override
  String get chartsDetailDayItself => 'o próprio dia';

  @override
  String chartsDetailDayEitherSide(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'o dia, ±$days dias',
      one: 'o dia, ±1 dia',
      zero: 'o dia, ±$days dias',
    );
    return '$_temp0';
  }

  @override
  String get chartsDetailRestOfMonth => 'o resto do mês';

  @override
  String chartsFeelingCount(String feeling, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dias',
      one: '1 dia',
    );
    return '$feeling em $_temp0';
  }

  @override
  String chartsFeelingGroupSummary(String group, String detail, String counts) {
    return '$group, $detail: $counts';
  }

  @override
  String get chartsFeelingGroupNone => 'ainda nenhum';

  @override
  String chartsRatingSummary(String from, String to, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dias avaliados',
      one: '1 dia avaliado',
    );
    return 'Avaliações dos dias de $from a $to: $_temp0, com os dias de menstruação sombreados.';
  }

  @override
  String chartsRatingSummaryMoons(String from, String to, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dias avaliados',
      one: '1 dia avaliado',
    );
    return 'Avaliações dos dias de $from a $to: $_temp0, com os dias de menstruação sombreados e as fases da lua marcadas.';
  }

  @override
  String chartsLanesSummary(String from, String to, String lanes) {
    return 'Menstruações de $from a $to. $lanes.';
  }

  @override
  String chartsLane(String name, String periods) {
    return '$name: $periods';
  }

  @override
  String get chartsLaneNone => 'sem dias de menstruação';

  @override
  String chartsLaneRun(String from, String to) {
    return 'de $from a $to';
  }

  @override
  String chartsLaneRunEstimated(String from, String to) {
    return 'de $from a $to, estimada';
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
      other: '$mucusDays dias',
      one: '1 dia',
    );
    return 'Temperaturas de $from a $to: $range, muco cervical registado em $_temp0, com os dias de menstruação sombreados.';
  }

  @override
  String get chartsNoTemperatures => 'sem temperaturas';

  @override
  String chartsTemperatureRange(int count, String low, String high) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count temperaturas',
      one: '1 temperatura',
      zero: '$count temperaturas',
    );
    return '$_temp0, de $low a $high';
  }

  @override
  String get chartsMucusFelt => 'Sensação';

  @override
  String get chartsMucusLooked => 'Aspeto';

  @override
  String get faceRatingRough => 'Difícil';

  @override
  String get faceRatingNotGreat => 'Menos bom';

  @override
  String get faceRatingOkay => 'Razoável';

  @override
  String get faceRatingGood => 'Bom';

  @override
  String get faceRatingGreat => 'Ótimo';

  @override
  String get faceRatingRoughInline => 'difícil';

  @override
  String get faceRatingNotGreatInline => 'menos bom';

  @override
  String get faceRatingOkayInline => 'razoável';

  @override
  String get faceRatingGoodInline => 'bom';

  @override
  String get faceRatingGreatInline => 'ótimo';

  @override
  String faceRatingOption(int rating, String name) {
    return '$rating, $name';
  }

  @override
  String get faceMoreFaces => 'Mais caras';

  @override
  String get faceDifferentFace => 'Escolher outra cara';

  @override
  String get faceOther => 'Outra cara';

  @override
  String get faceSmilingCat => 'Gato sorridente';

  @override
  String get faceGrinningCat => 'Gato com um grande sorriso';

  @override
  String get faceCatTearsOfJoy => 'Gato com lágrimas de alegria';

  @override
  String get faceCatHeartEyes => 'Gato com olhos de coração';

  @override
  String get faceSmirkingCat => 'Gato com sorriso trocista';

  @override
  String get faceKissingCat => 'Gato a dar um beijo';

  @override
  String get faceWearyCat => 'Gato exausto';

  @override
  String get faceCryingCat => 'Gato a chorar';

  @override
  String get facePoutingCat => 'Gato amuado';

  @override
  String get faceAlien => 'Extraterrestre';

  @override
  String get faceSpaceInvader => 'Invasor espacial';

  @override
  String get faceRobot => 'Robô';

  @override
  String get faceGhost => 'Fantasma';

  @override
  String get faceSkull => 'Caveira';

  @override
  String get faceClown => 'Palhaço';

  @override
  String get faceDevil => 'Diabo';

  @override
  String get faceUnicorn => 'Unicórnio';

  @override
  String get faceFrog => 'Sapo';

  @override
  String get facePartying => 'Festa';

  @override
  String get faceCool => 'Fixe';

  @override
  String get faceNerdy => 'Nerd';

  @override
  String get faceAngelic => 'Angelical';

  @override
  String get faceHugging => 'Abraço';

  @override
  String get faceSilly => 'Parvoíce';

  @override
  String get faceUpsideDown => 'De pernas para o ar';

  @override
  String get faceSmirking => 'Sorriso trocista';

  @override
  String get faceGrimacing => 'Careta';

  @override
  String get faceEyeRoll => 'Revirar os olhos';

  @override
  String get faceSpeechless => 'Sem palavras';

  @override
  String get facePleading => 'Olhar suplicante';

  @override
  String get faceSobbing => 'Choro';

  @override
  String get faceScreaming => 'Grito';

  @override
  String get faceFlushed => 'Rubor';

  @override
  String get faceOverwhelmed => 'Sufoco';

  @override
  String get faceWoozy => 'Tonturas';

  @override
  String get faceUnwell => 'Mal-estar';

  @override
  String get faceHurting => 'Dor';

  @override
  String get faceQueasy => 'Enjoo';

  @override
  String get faceTooHot => 'Calor a mais';

  @override
  String get faceTooCold => 'Frio a mais';

  @override
  String get faceSparklingHeart => 'Coração brilhante';

  @override
  String get faceBrokenHeart => 'Coração partido';

  @override
  String get faceFire => 'Fogo';

  @override
  String get faceRainbow => 'Arco-íris';

  @override
  String get faceSun => 'Sol';

  @override
  String get faceRain => 'Chuva';

  @override
  String get faceStorm => 'Tempestade';

  @override
  String get faceBlossom => 'Flor';

  @override
  String get faceChocolate => 'Chocolate';

  @override
  String get faceInBed => 'Na cama';

  @override
  String get homeCalendar => 'Calendário';

  @override
  String get homeHistory => 'Histórico';

  @override
  String get homeCharts => 'Gráficos';

  @override
  String get homeSettings => 'Definições';

  @override
  String homeCalendarOf(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'O seu calendário',
      'other': 'Calendário de $name',
    });
    return '$_temp0';
  }

  @override
  String homeHistoryOf(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'O seu histórico',
      'other': 'Histórico de $name',
    });
    return '$_temp0';
  }

  @override
  String homeChartsOf(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Os seus gráficos',
      'other': 'Gráficos de $name',
    });
    return '$_temp0';
  }

  @override
  String get homeWhenStarted => 'Quando começou?';

  @override
  String get homeWhenEnded => 'Quando terminou?';

  @override
  String homePeriodEndedToday(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'A minha menstruação terminou hoje',
      'other': 'A menstruação de $name terminou hoje',
    });
    return '$_temp0';
  }

  @override
  String homePeriodStartedToday(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'A minha menstruação começou hoje',
      'other': 'A menstruação de $name começou hoje',
    });
    return '$_temp0';
  }

  @override
  String get homeEndedEarlier => 'Terminou num dia anterior';

  @override
  String get homeStartedEarlier => 'Começou num dia anterior';

  @override
  String homeAddLastEnd(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Adicionar quando terminou a sua última menstruação',
      'other': 'Adicionar quando terminou a última menstruação de $name',
    });
    return '$_temp0';
  }

  @override
  String homeSharedCopy(String who, String name, String date) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you':
          'Importado do seu telemóvel a $date. Não pode ser alterado aqui e é atualizado quando o voltar a enviar.',
      'other':
          'Importado do telemóvel de $name a $date. Não pode ser alterado aqui e é atualizado quando $name o voltar a enviar.',
    });
    return '$_temp0';
  }

  @override
  String homeNoPeriodSince(String date) {
    return 'Nenhuma menstruação registada desde $date';
  }

  @override
  String get homeMissedOne =>
      'O Ebb assumiu que uma menstruação ficou por registar e fez a estimativa a partir daí. Se se lembrar de quando começou, adicione-a para corrigir a estimativa.';

  @override
  String get homeMissedSome =>
      'O Ebb assumiu que algumas menstruações ficaram por registar e fez a estimativa a partir daí. Se se lembrar de quando alguma começou, adicione-as para corrigir a estimativa.';

  @override
  String get homeWelcome => 'Boas-vindas ao Ebb';

  @override
  String get homeNothingYet => 'Ainda nada registado';

  @override
  String homeFirstLog(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Registe o primeiro dia da sua próxima menstruação, ou adicione menstruações passadas se se lembrar delas, e o Ebb começa a conhecer o seu ritmo. Tudo fica neste telemóvel.',
      'other':
          'Registe o primeiro dia da próxima menstruação de $name, ou adicione menstruações passadas se se lembrar delas, e o Ebb começa a conhecer o ritmo. Tudo fica neste telemóvel.',
    });
    return '$_temp0';
  }

  @override
  String homeDayOfPeriod(String who, String name, int day) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Dia $day da sua menstruação',
      'other': 'Dia $day da menstruação de $name',
    });
    return '$_temp0';
  }

  @override
  String homeDayOfCycle(String who, String name, int day) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Dia $day do seu ciclo',
      'other': 'Dia $day do ciclo de $name',
    });
    return '$_temp0';
  }

  @override
  String get homeTellEnd =>
      'Avise o Ebb quando terminar, para que a estimativa continue precisa.';

  @override
  String homeDaysUntil(String who, String name, int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'A sua menstruação está prevista daqui a cerca de $days dias.',
    );
    String _temp1 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other:
          'A menstruação de $name está prevista daqui a cerca de $days dias.',
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
      'you': 'A sua menstruação está prevista para amanhã.',
      'other': 'A menstruação de $name está prevista para amanhã.',
    });
    return '$_temp0';
  }

  @override
  String homeExpectedToday(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'A sua menstruação está prevista para hoje.',
      'other': 'A menstruação de $name está prevista para hoje.',
    });
    return '$_temp0';
  }

  @override
  String homeDaysLate(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other:
          '$days dias depois do previsto. Os ciclos variam por todo o tipo de razões.',
      one: '1 dia depois do previsto. Os ciclos variam por todo o tipo de razões.',
      zero:
          '$days dias depois do previsto. Os ciclos variam por todo o tipo de razões.',
    );
    return '$_temp0';
  }

  @override
  String get homeRingDay => 'DIA';

  @override
  String homeRingOfCycle(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'do seu ciclo',
      'other': 'do ciclo de $name',
    });
    return '$_temp0';
  }

  @override
  String homeRingOfPeriod(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'da sua menstruação',
      'other': 'da menstruação de $name',
    });
    return '$_temp0';
  }

  @override
  String get homeKeyPeriod => 'Menstruação';

  @override
  String get homeKeyLikelyNext => 'Próxima provável';

  @override
  String get homeKeyToday => 'Hoje';

  @override
  String get homeAddPastPeriods => 'Adicionar menstruações passadas';

  @override
  String get homeAddMissedPeriod => 'Adicionar uma menstruação em falta';

  @override
  String get homeNextPeriod => 'Próxima menstruação';

  @override
  String homeLikelyBetween(String from, String to) {
    return 'provavelmente entre $from e $to';
  }

  @override
  String get homeFertileWindow => 'Janela fértil estimada';

  @override
  String get homeFertileWarning =>
      'Uma estimativa baseada apenas na duração dos ciclos. Não é suficientemente fiável para ser usada como contraceção.';

  @override
  String homeConfidenceUnlogged(String date) {
    return 'Estimada a partir da última menstruação registada, a $date, por isso pode ser menos precisa do que o habitual.';
  }

  @override
  String get homeConfidenceNone => 'Ainda nada registado.';

  @override
  String get homeConfidenceTypical =>
      'Por agora, baseada num ciclo típico de 28 dias. Vai ficando mais precisa à medida que regista.';

  @override
  String homeConfidenceFew(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Baseada em $count ciclos até agora, por isso pode ser menos precisa por enquanto.',
      one: 'Baseada em 1 ciclo até agora, por isso pode ser menos precisa por enquanto.',
      zero:
          'Baseada em $count ciclos até agora, por isso pode ser menos precisa por enquanto.',
    );
    return '$_temp0';
  }

  @override
  String homeConfidenceIrregular(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Os seus ciclos variam bastante, por isso isto é uma estimativa ampla e não uma data certa.',
      'other':
          'Os ciclos de $name variam bastante, por isso isto é uma estimativa ampla e não uma data certa.',
    });
    return '$_temp0';
  }

  @override
  String homeConfidenceLast(String who, String name, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Baseada nos seus últimos $count ciclos.',
    );
    String _temp1 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Baseada nos últimos $count ciclos de $name.',
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
      other: 'Baseada em $count ciclos bastante regulares.',
    );
    return '$_temp0';
  }

  @override
  String get homeMilestoneFirstPeriod => 'Primeira menstruação registada';

  @override
  String get homeMilestoneFirstCycle => 'Primeiro ciclo completo';

  @override
  String get homeMilestoneThreeCycles => 'Três ciclos completos';

  @override
  String get homeMilestoneSixCycles => 'Seis ciclos completos';

  @override
  String get homeMilestoneOneYear => 'Um ano de histórico';

  @override
  String get homeMilestoneTwoYears => 'Dois anos de histórico';

  @override
  String get homeMilestoneFiveYears => 'Cinco anos de histórico';

  @override
  String get homeMilestoneFirstBackup => 'Primeira cópia de segurança guardada';

  @override
  String homeMilestoneFirstPeriodMessage(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'A sua primeira menstruação no Ebb.',
      'other': 'A primeira menstruação de $name no Ebb.',
    });
    return '$_temp0';
  }

  @override
  String homeMilestoneFirstCycleMessage(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Um primeiro ciclo completo. O Ebb pode começar a conhecer o seu ritmo.',
      'other':
          'Um primeiro ciclo completo. O Ebb pode começar a conhecer o ritmo de $name.',
    });
    return '$_temp0';
  }

  @override
  String get homeMilestoneThreeCyclesMessage =>
      'Três ciclos completos registados. Cada um dá ao Ebb mais em que se basear.';

  @override
  String get homeMilestoneSixCyclesMessage =>
      'Seis ciclos completos registados: tantos quantos o Ebb tem em conta em cada estimativa.';

  @override
  String homeMilestoneOneYearMessage(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Um ano do seu histórico no Ebb.',
      'other': 'Um ano do histórico de $name no Ebb.',
    });
    return '$_temp0';
  }

  @override
  String homeMilestoneTwoYearsMessage(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Dois anos do seu histórico no Ebb.',
      'other': 'Dois anos do histórico de $name no Ebb.',
    });
    return '$_temp0';
  }

  @override
  String homeMilestoneFiveYearsMessage(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Cinco anos do seu histórico no Ebb.',
      'other': 'Cinco anos do histórico de $name no Ebb.',
    });
    return '$_temp0';
  }

  @override
  String get homeMilestoneFirstBackupMessage =>
      'A sua primeira cópia de segurança está guardada. Mantenha uma cópia noutro sítio que não este telemóvel.';

  @override
  String get homeProblemStartInFuture =>
      'A data de início não pode ser no futuro.';

  @override
  String get homeProblemEndInFuture => 'A data de fim não pode ser no futuro.';

  @override
  String get homeProblemEndBeforeStart =>
      'A data de fim é anterior à data de início.';

  @override
  String get homeProblemDuplicateStart =>
      'Já há uma menstruação registada que começa nesse dia.';

  @override
  String get homeProblemOverlapsPrevious =>
      'Sobrepõe-se à menstruação anterior. Verifique a data de fim do registo anterior.';

  @override
  String get homeProblemOverlapsNext =>
      'Sobrepõe-se à menstruação seguinte. Verifique a data de fim.';

  @override
  String get homeDeleteCycleTitle => 'Eliminar este ciclo?';

  @override
  String homeDeleteCycleBody(String date) {
    return 'O registo que começa a $date será removido. Não é possível anular.';
  }

  @override
  String get homeFirstDayOfPeriod => 'Primeiro dia da menstruação';

  @override
  String get homeLastDayOfPeriod => 'Último dia da menstruação';

  @override
  String get homeAddPastPeriodTitle => 'Adicionar uma menstruação passada';

  @override
  String get homeEditPeriod => 'Editar menstruação';

  @override
  String get homeStarted => 'Começou';

  @override
  String get homeEnded => 'Terminou';

  @override
  String get homeStillGoing => 'Ainda a decorrer';

  @override
  String get homeNotRecorded => 'Não registado';

  @override
  String get homeClearEnd => 'Remover a data de fim';

  @override
  String get homeCountInPredictions => 'Contar este ciclo nas previsões';

  @override
  String get homeCountInPredictionsHint =>
      'Desative para um ciclo que não reflete o ritmo habitual — uma doença, uma mudança de medicação, a perda de uma gravidez. Fica no seu histórico de qualquer forma.';

  @override
  String get homeNote => 'Nota';

  @override
  String get homeNoteExcludedHint =>
      'Porque não conta, para ser fácil de lembrar mais tarde.';

  @override
  String get homeNoteHint =>
      'Algo que valha a pena lembrar sobre esta menstruação.';

  @override
  String get homeDeletePeriod => 'Eliminar esta menstruação';

  @override
  String get homeAddPastPeriod => 'Adicionar menstruação passada';

  @override
  String get homeHistoryEmpty =>
      'Ainda não há ciclos registados. Se se lembrar de quando começaram as últimas menstruações, adicioná-las dá ao Ebb um ponto de partida.';

  @override
  String get homeMilestones => 'Marcos';

  @override
  String homePeriodLength(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Menstruação de $count dias',
      one: 'Menstruação de 1 dia',
      zero: 'Menstruação de $count dias',
    );
    return '$_temp0';
  }

  @override
  String get homePeriodInProgress => 'Menstruação a decorrer';

  @override
  String get homeEndNotRecorded => 'Fim não registado';

  @override
  String get homeLongGap =>
      'Um intervalo longo. Se uma menstruação aqui ficou por registar, adicione-a com «Adicionar menstruação passada».';

  @override
  String get homeNothingSince =>
      'Nada registado desde então. Se uma menstruação ficou por registar, adicione-a com «Adicionar menstruação passada».';

  @override
  String homeNotCounted(String detail) {
    return '$detail · não conta';
  }

  @override
  String get homeDayCycle => 'dias de ciclo';

  @override
  String get homeLastLogged => 'Último registado';

  @override
  String get homeCurrent => 'Atual';

  @override
  String get homeSpanMonths3 => 'Últimos 3 meses';

  @override
  String get homeSpanMonths6 => 'Últimos 6 meses';

  @override
  String get homeSpanYear => 'Último ano';

  @override
  String get homeSpanAll => 'Tudo';

  @override
  String get homeSpanCustom => 'Escolher datas…';

  @override
  String get settingsTitle => 'Definições';

  @override
  String get settingsNotificationsOff =>
      'As notificações do Ebb estão desativadas nas definições do sistema.';

  @override
  String settingsNoBrowser(String website) {
    return 'Não há nenhum navegador para o abrir. Visite $website.';
  }

  @override
  String get settingsNothingToBackUp =>
      'Ainda não há nada para guardar numa cópia de segurança.';

  @override
  String get settingsBackupSaved =>
      'Cópia de segurança guardada. Mantenha uma cópia noutro sítio que não este telemóvel.';

  @override
  String get settingsBackupNotSaved =>
      'Não foi possível guardar a cópia de segurança aí. Experimente outro local.';

  @override
  String get settingsNoPicker =>
      'Este telemóvel não tem um seletor de ficheiros que o Ebb possa usar. Enviar para outro telemóvel funciona sem ele.';

  @override
  String get settingsFileTooLarge =>
      'Esse ficheiro é demasiado grande para ser uma cópia de segurança do Ebb.';

  @override
  String get settingsFileUnreadable => 'Não foi possível ler esse ficheiro.';

  @override
  String get settingsNotABackup =>
      'Este ficheiro não é uma cópia de segurança do Ebb.';

  @override
  String settingsPeriodCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count menstruações',
      one: '$count menstruação',
      zero: '$count menstruações',
    );
    return '$_temp0';
  }

  @override
  String get settingsSetUpTitle => 'Começar com este histórico?';

  @override
  String settingsSetUpBody(String periods, String date) {
    return '$periods, enviado a $date. Neste telemóvel, passa a ser o seu histórico.';
  }

  @override
  String settingsUpdateTitle(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Atualizar o seu histórico?',
      'other': 'Atualizar $name?',
    });
    return '$_temp0';
  }

  @override
  String settingsUpdateAction(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Atualizar o seu histórico',
      'other': 'Atualizar $name',
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
          'É de novo o seu histórico, enviado a $date: $periods. Substitui a cópia que está neste telemóvel.',
      'other':
          'É de novo o histórico de $name, enviado a $date: $periods. Substitui a cópia que está neste telemóvel.',
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
          'É o seu histórico, enviado a $date: $periods. Substitui o que está neste telemóvel para si, incluindo o que tenha sido registado aqui desde então.',
      'other':
          'É o histórico de $name, enviado a $date: $periods. Substitui o que está neste telemóvel para $name, incluindo o que tenha sido registado aqui desde então.',
    });
    return '$_temp0';
  }

  @override
  String get settingsReplaceEverything => 'Substituir tudo';

  @override
  String settingsPersonUpdated(String name) {
    return '$name: histórico atualizado.';
  }

  @override
  String get settingsAddThisHistoryTitle => 'Adicionar este histórico?';

  @override
  String settingsAddNamedTitle(String name) {
    return 'Adicionar $name?';
  }

  @override
  String settingsAddBody(String periods) {
    return 'Tem $periods. Pode adicioná-lo ao que já está aqui, ou substituir tudo o que está neste telemóvel por ele.';
  }

  @override
  String settingsAddNamedBody(String name, String periods) {
    return 'O histórico de $name tem $periods. Pode adicioná-lo ao que já está aqui, ou substituir tudo o que está neste telemóvel por ele.';
  }

  @override
  String get settingsAddAsNew => 'Adicionar como outra pessoa';

  @override
  String get settingsWhoIsThis => 'Quem é?';

  @override
  String get settingsWhoIsThisHint =>
      'Um nome para distinguir as pessoas neste telemóvel.';

  @override
  String settingsPersonAdded(String name) {
    return '$name já está neste telemóvel.';
  }

  @override
  String get settingsRestored => 'Concluído. O Ebb foi atualizado.';

  @override
  String get settingsReplaceTitle => 'Substituir o que está no Ebb?';

  @override
  String settingsReplaceSaved(String date, String periods) {
    return 'Guardada a $date, com $periods.';
  }

  @override
  String settingsReplaceSavedPeople(int people, String date, String periods) {
    String _temp0 = intl.Intl.pluralLogic(
      people,
      locale: localeName,
      other: 'Guardada a $date, com $periods de $people pessoas.',
    );
    return '$_temp0';
  }

  @override
  String settingsReplaceCurrent(String periods) {
    return 'Substitui tudo o que está agora no Ebb, incluindo $periods neste telemóvel.';
  }

  @override
  String get settingsReplace => 'Substituir';

  @override
  String get settingsDeleteAllTitle => 'Eliminar todos os dados?';

  @override
  String get settingsDeleteAllBody =>
      'Todos os ciclos e notas serão apagados definitivamente. O Ebb não guarda mais nenhuma cópia, por isso não é possível anular, a não ser que tenha guardado um ficheiro de cópia de segurança.';

  @override
  String get settingsDeleteAllBodyEveryone =>
      'Todos os ciclos e notas, de todas as pessoas neste telemóvel, serão apagados definitivamente. O Ebb não guarda mais nenhuma cópia, por isso não é possível anular, a não ser que tenha guardado um ficheiro de cópia de segurança.';

  @override
  String get settingsDeleteEverything => 'Eliminar tudo';

  @override
  String get settingsAllDeleted => 'Todos os dados foram eliminados.';

  @override
  String get settingsYourName => 'O seu nome';

  @override
  String get settingsRename => 'Mudar o nome';

  @override
  String get settingsYourNameHint =>
      'Aparece na lista de pessoas. Deixe em branco para aparecer como «Eu».';

  @override
  String settingsRemoveTitle(String name) {
    return 'Remover $name deste telemóvel?';
  }

  @override
  String settingsRemoveBody(String name) {
    return 'Todos os ciclos e notas de $name serão apagados definitivamente. O histórico das outras pessoas não é afetado.';
  }

  @override
  String settingsPersonRemoved(String name) {
    return '$name já não está neste telemóvel.';
  }

  @override
  String settingsRemovePerson(String name) {
    return 'Remover $name deste telemóvel';
  }

  @override
  String get settingsYourCycle => 'O seu ciclo';

  @override
  String get settingsYourSettings => 'As suas definições';

  @override
  String settingsSettingsFor(String name) {
    return 'Definições de $name';
  }

  @override
  String get settingsName => 'Nome';

  @override
  String get settingsReminders => 'Lembretes';

  @override
  String settingsRemindersHint(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Um aviso antes da data prevista da sua menstruação.',
      'other': 'Um aviso antes da data prevista da menstruação de $name.',
    });
    return '$_temp0';
  }

  @override
  String get settingsRemindMe => 'Lembrar-me';

  @override
  String settingsDaysAhead(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dias antes',
      one: '$count dia antes',
      zero: '$count dias antes',
    );
    return '$_temp0';
  }

  @override
  String settingsDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dias',
      one: '$count dia',
      zero: '$count dias',
    );
    return '$_temp0';
  }

  @override
  String get settingsFertile => 'Mostrar a estimativa da janela fértil';

  @override
  String get settingsFertileHint =>
      'Desativado por predefinição. Uma estimativa feita apenas a partir da duração dos ciclos — não é suficientemente fiável para ser usada como contraceção.';

  @override
  String get settingsMoon => 'Mostrar as fases da lua';

  @override
  String get settingsMoonHint =>
      'Lua nova, quarto crescente, lua cheia e quarto minguante, no calendário e nos gráficos.';

  @override
  String get settingsTemperature => 'Registar a temperatura e o muco cervical';

  @override
  String get settingsTemperatureHint =>
      'Em cada dia do calendário, com um gráfico de temperatura. É registado e desenhado, mas nunca usado para estimar nada.';

  @override
  String get settingsTemperatureIn => 'Temperatura em';

  @override
  String get settingsCelebrate => 'Celebrar marcos';

  @override
  String settingsCelebrateHint(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Uma pequena celebração para coisas como um primeiro ciclo completo ou um ano de histórico, que ficam listadas no seu Histórico.',
      'other':
          'Uma pequena celebração para coisas como um primeiro ciclo completo ou um ano de histórico, que ficam listadas no Histórico de $name.',
    });
    return '$_temp0';
  }

  @override
  String get settingsPeople => 'Pessoas';

  @override
  String get settingsAddSomeone => 'Adicionar alguém';

  @override
  String get settingsTrackSomeoneElse => 'Acompanhar também outra pessoa';

  @override
  String get settingsTrackSomeoneElseHint =>
      'Por exemplo, uma criança que está a começar a ter a menstruação.';

  @override
  String get settingsBackupSection => 'Cópias de segurança e transferência';

  @override
  String get settingsBackUp => 'Fazer cópia de segurança num ficheiro';

  @override
  String get settingsBackUpHint =>
      'Guardar o seu histórico num ficheiro, onde escolher.';

  @override
  String get settingsBackUpHintEveryone =>
      'Guardar o histórico de todos num ficheiro, onde escolher.';

  @override
  String get settingsRestore => 'Restaurar uma cópia de segurança';

  @override
  String get settingsRestoreHint => 'Substitui o que está agora no Ebb.';

  @override
  String get settingsSend => 'Enviar para outro telemóvel';

  @override
  String get settingsSendHint =>
      'Mostrar o seu histórico em códigos para outro telemóvel ler.';

  @override
  String get settingsSendHintEveryone =>
      'Mostrar o histórico de todos em códigos para outro telemóvel ler.';

  @override
  String get settingsReceive => 'Receber de outro telemóvel';

  @override
  String get settingsReceiveHint =>
      'Ler os códigos para adicionar alguém, atualizar alguém ou substituir tudo.';

  @override
  String get settingsAdvanced => 'Avançado';

  @override
  String get settingsGroups => 'Grupos';

  @override
  String get settingsGroupsHint =>
      'Para círculos e clubes que acompanham o ciclo em conjunto: reúne pessoas sob um nome. Desativar esta opção oculta os grupos sem os eliminar.';

  @override
  String get settingsManageGroups => 'Gerir grupos';

  @override
  String get settingsAboutEbb => 'Acerca do Ebb';

  @override
  String get settingsHowEbbWorks => 'Como funciona o Ebb';

  @override
  String get settingsHowEbbWorksHint =>
      'Registos, estimativas, cópias de segurança e mais.';

  @override
  String get settingsYourData => 'Os seus dados';

  @override
  String get settingsYourDataHint => 'Onde ficam e quem os pode ver.';

  @override
  String get settingsWebsite => 'Site';

  @override
  String get settingsSendFeedback => 'Enviar comentários';

  @override
  String get settingsSendFeedbackHint =>
      'Um formulário no site, no seu navegador.';

  @override
  String get settingsDeleteAll => 'Eliminar todos os dados';

  @override
  String settingsVersion(String version) {
    return 'Ebb $version\nFeito pela SuperDaveLab';
  }

  @override
  String get settingsDataHeadline => 'O seu ciclo só a si diz respeito.';

  @override
  String get settingsDataLede =>
      'O Ebb foi feito para que a pergunta «o que fazem com os meus dados?» tenha uma resposta aborrecida: nada, porque nunca os recebemos.';

  @override
  String get settingsDataTradeOff =>
      'Há um compromisso que convém conhecer: como não há cópia na nuvem, se o telemóvel se perder ou for apagado, perde-se o histórico. Se isso for importante para si, guarde de vez em quando um ficheiro de cópia de segurança a partir das Definições, e mantenha-o noutro sítio que não este telemóvel.';

  @override
  String get settingsWhereDataLives => 'Onde ficam os seus dados';

  @override
  String get settingsWhereDataLivesHint => 'Os seus dados, e quem os pode ver.';

  @override
  String get settingsDataStaysTitle => 'Fica no seu telemóvel';

  @override
  String get settingsDataStaysBody =>
      'Tudo o que regista é guardado numa base de dados neste dispositivo. Não há conta para criar nem servidor com que sincronizar. Só vai para outro lado se o mover por iniciativa própria — um ficheiro de cópia de segurança, ou outro telemóvel para onde o envie.';

  @override
  String get settingsDataUnseenTitle => 'Não conseguimos vê-lo';

  @override
  String get settingsDataUnseenBody =>
      'O Ebb é feito sem qualquer permissão para usar a internet. O Android garante-o, e pode confirmá-lo na lista de permissões da aplicação.';

  @override
  String get settingsDataPermissionsTitle => 'Para que servem as permissões';

  @override
  String get settingsDataPermissionsBody =>
      'Notificações, para os lembretes. Câmara, só enquanto recebe um histórico de outro telemóvel — lê os códigos e nada é gravado nem guardado. O Ebb também volta a programar os lembretes quando o telemóvel reinicia. É a lista completa.';

  @override
  String get settingsDataNotForSaleTitle => 'Não há nada para vender';

  @override
  String get settingsDataNotForSaleBody =>
      'Sem estatísticas de utilização, sem publicidade, sem bibliotecas de terceiros a comunicar com o exterior. Como os seus dados nunca chegam até nós, não há nenhuma cópia que alguém possa comprar, exigir judicialmente ou deixar escapar.';

  @override
  String get settingsDataEraseTitle => 'Pode apagá-lo num instante';

  @override
  String get settingsDataEraseBody =>
      'Eliminar os dados nas Definições, ou desinstalar o Ebb, remove tudo o que o Ebb guarda. O Ebb não guarda mais nenhuma cópia — as únicas são os ficheiros de cópia de segurança que guardou ou os telemóveis para onde o enviou.';

  @override
  String get settingsDataOpenSourceTitle => 'Pode verificar o nosso trabalho';

  @override
  String get settingsDataOpenSourceBody =>
      'O Ebb é de código aberto, sob a Licença Pública Geral GNU. Qualquer pessoa pode ler exatamente o que faz, e as versões publicadas são feitas a partir desse mesmo código.';

  @override
  String get settingsHelpLoggingTitle => 'Registar uma menstruação';

  @override
  String get settingsHelpLoggingBody =>
      'Toque em «A minha menstruação começou hoje» no primeiro dia de sangramento e em «A minha menstruação terminou hoje» no último.\n\nEsqueceu-se de registar? Use antes «Começou num dia anterior». Qualquer menstruação passada pode ser adicionada ou corrigida no Histórico (o ícone do relógio): toque numa para alterar as datas ou adicionar uma nota.\n\nSe nenhum fim for registado em duas semanas, o Ebb deixa de considerar a menstruação ainda a decorrer e propõe adicionar o fim.';

  @override
  String get settingsHelpEstimateTitle => 'Como funciona a estimativa';

  @override
  String get settingsHelpEstimateBody =>
      'O Ebb olha para os intervalos entre os inícios das suas menstruações mais recentes — até às últimas seis.\n\nCom pouco histórico, apoia-se num ciclo típico de 28 dias, e di-lo. Quanto mais registar, mais a estimativa reflete o seu próprio ritmo.\n\nMostra um intervalo em vez de uma única data, e diz até que ponto tem certeza. Se os seus ciclos variam muito, o intervalo é mais largo.\n\nSe uma menstruação estiver atrasada, o Ebb diz quanto. Se não houver nada registado durante quase dois ciclos, assume que uma menstruação ficou por registar, faz a estimativa a partir daí e di-lo. O Histórico assinala os intervalos longos, e adicionar uma menstruação em falta corrige a estimativa.';

  @override
  String get settingsHelpExcludeTitle => 'Um ciclo que não deve contar';

  @override
  String get settingsHelpExcludeBody =>
      'Uma doença, uma mudança de medicação ou a perda de uma gravidez podem desregular completamente um ciclo, e a estimativa iria atrás dele.\n\nNo Histórico, toque nessa menstruação e desative «Contar este ciclo nas previsões». Fica no seu histórico; a estimativa apenas o ignora. Adicione também uma nota, para se lembrar porquê.';

  @override
  String get settingsHelpGroupsTitle => 'Grupos';

  @override
  String get settingsHelpGroupsBody =>
      'Para círculos e clubes que acompanham o ciclo em conjunto. Ative-os em Definições → Avançado, depois crie um grupo e escolha quem faz parte dele. «Ver … em conjunto», na lista de pessoas, mostra todos lado a lado, com a lua.\n\nUm grupo pode ter dois tipos de membros. Alguém adicionado é acompanhado neste telemóvel, e é aqui que regista por essa pessoa. Alguém importado continua a registar no próprio telemóvel e fornece o seu histórico ao grupo: esse histórico continua a pertencer-lhe e não pode ser alterado no telemóvel de mais ninguém.\n\nPara ser importado, envie só o seu histórico (Definições → Enviar para outro telemóvel) — tanto ou tão pouco quanto quiser, com ou sem os registos diários. O outro telemóvel importa-o a partir do grupo: Gerir grupos → o grupo → Importar do telemóvel da pessoa. Importar de novo atualiza-o.\n\nO histórico importado pertence ao seu grupo. Retirar alguém importado do último grupo em que está, ou eliminar esse grupo, também remove o seu histórico do telemóvel. E não pode ser reenviado: só o seu próprio histórico pode.';

  @override
  String get settingsHelpRatingsTitle => 'Avaliações, sentimentos e gráficos';

  @override
  String get settingsHelpRatingsBody =>
      'Toque em qualquer dia do calendário para o avaliar de 1 a 5 e escolher uma cara para como se sentiu. Ambos são opcionais; toque de novo numa opção para a limpar.\n\nOs Gráficos (o ícone do gráfico) mostram a avaliação de cada dia nas datas que escolher, com as menstruações sombreadas, e que sentimentos surgiram durante e antes das menstruações. Com as fases da lua ativadas nas Definições, a lua também aparece.\n\nOs gráficos mostram o que registou. Não dizem o que significa — isso cabe a si avaliar.';

  @override
  String get settingsHelpTemperatureTitle => 'Temperatura e muco cervical';

  @override
  String get settingsHelpTemperatureBody =>
      'Ative «Registar a temperatura e o muco cervical» nas Definições, e cada dia do calendário passa a ter espaço para a temperatura ao acordar e para a sensação e o aspeto do muco cervical. Se algo puder ter afetado uma medição — doença, pouco sono, álcool, medir mais tarde — marque a caixa por baixo.\n\nOs Gráficos mostram as temperaturas como uma linha, com o muco por baixo e as menstruações sombreadas, em °C ou °F (Definições).\n\nO Ebb regista e desenha estes dados, e mais nada. Não procura uma subida nem calcula dias férteis a partir deles, e a estimativa da janela fértil continua a vir apenas da duração dos ciclos. Se seguir um método como o sintotérmico, o gráfico está lá para o ler segundo as regras desse método.';

  @override
  String get settingsHelpRemindersTitle => 'Lembretes';

  @override
  String get settingsHelpRemindersBody =>
      'Um aviso alguns dias antes da data prevista da sua menstruação, e outro no próprio dia. Escolha com quanta antecedência nas Definições.\n\nSão programados no próprio telemóvel, por isso chegam sem rede e em modo de voo.\n\nO Ebb programa-os sempre que é aberto, a partir da estimativa mais recente. O telemóvel mantém-nos depois de reiniciar, mas o Ebb não os consegue atualizar enquanto está fechado, por isso abra-o de vez em quando — registar uma menstruação basta.\n\nO Android pode entregá-los um pouco depois da hora habitual para poupar bateria. Se o Ebb for forçado a parar, ou uma poupança de bateria o restringir, podem só chegar da próxima vez que abrir o Ebb.';

  @override
  String get settingsHelpFertileTitle => 'A janela fértil';

  @override
  String get settingsHelpFertileBody =>
      'Desativada, a não ser que a ative nas Definições. É estimada apenas a partir da duração dos ciclos, o que não é suficientemente fiável para ser usado como contraceção.';

  @override
  String get settingsHelpBackupTitle => 'Cópias de segurança';

  @override
  String get settingsHelpBackupBody =>
      'Não há cópia do seu histórico na nuvem, por isso, se o telemóvel se perder ou for apagado, perde-se o histórico.\n\nDefinições → «Fazer cópia de segurança num ficheiro» guarda tudo num ficheiro, onde escolher. Mantenha-o noutro sítio que não este telemóvel. «Restaurar uma cópia de segurança» recupera-o.';

  @override
  String get settingsHelpMovingTitle => 'Mudar para um telemóvel novo';

  @override
  String get settingsHelpMovingBody =>
      'No telemóvel antigo: Definições → «Enviar para outro telemóvel». No novo: Definições → «Receber de outro telemóvel», e aponte a câmara para o ecrã.\n\nHistóricos mais longos ocupam alguns códigos, que mudam sozinhos; o telemóvel novo recolhe-os por qualquer ordem. Não é usada a internet — um telemóvel mostra, o outro olha.';

  @override
  String get settingsHelpSomeoneElseTitle => 'Acompanhar outra pessoa';

  @override
  String get settingsHelpSomeoneElseBody =>
      'Está a ajudar outra pessoa a acompanhar o ciclo — uma criança que está a começar, por exemplo? Definições → «Acompanhar também outra pessoa», e dê-lhe um nome. Uma alcunha ou uma inicial chega.\n\nToque no nome no topo do ecrã inicial para trocar de pessoa. Cada pessoa tem os seus próprios lembretes, que começam desativados para as pessoas que adicionar. A janela fértil só é oferecida para si.';

  @override
  String get settingsHelpHandoverTitle =>
      'Passar alguém para o próprio telemóvel';

  @override
  String get settingsHelpHandoverBody =>
      'Quando alguém que acompanha passa a ter o seu próprio telemóvel: «Enviar para outro telemóvel», e escolha só essa pessoa. No telemóvel dela, «Receber de outro telemóvel». Numa instalação nova, o histórico passa simplesmente a ser dessa pessoa.\n\nDepois, o Ebb pergunta se quer remover essa pessoa do seu telemóvel. Nunca o faz por iniciativa própria.';

  @override
  String get settingsHelpDeletingTitle => 'Eliminar';

  @override
  String get settingsHelpDeletingBody =>
      'Definições → «Eliminar todos os dados» apaga tudo o que está neste telemóvel de uma só vez.\n\nPara remover uma pessoa que adicionou, abra as definições dessa pessoa e escolha «Remover … deste telemóvel». O histórico das outras pessoas não é tocado.';

  @override
  String shareRemoveTitle(String name) {
    return 'Remover $name deste telemóvel?';
  }

  @override
  String shareRemoveBody(String name) {
    return 'Se o histórico de $name chegou ao outro telemóvel, pode sair deste. Também o pode manter aqui.';
  }

  @override
  String get shareKeep => 'Manter';

  @override
  String shareRemoved(String name) {
    return '$name já não está neste telemóvel.';
  }

  @override
  String get shareTitle => 'Enviar para outro telemóvel';

  @override
  String get shareWhatToSend => 'O que quer enviar?';

  @override
  String get shareEveryone => 'Todos';

  @override
  String get shareEveryoneHint => 'Para mudar para um telemóvel novo.';

  @override
  String get shareJustOne => 'Só uma pessoa';

  @override
  String get shareJustYours => 'Só o seu histórico';

  @override
  String shareJustName(String name) {
    return 'Só $name';
  }

  @override
  String shareForTheirPhone(String name) {
    return 'Para o telemóvel de $name.';
  }

  @override
  String get shareCopiesNotOffered =>
      'As pessoas importadas de outros telemóveis não aparecem aqui: cada pessoa só partilha o seu próprio histórico.';

  @override
  String shareHowMuch(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Quanto do seu histórico?',
      'other': 'Quanto do histórico de $name?',
    });
    return '$_temp0';
  }

  @override
  String get shareHowMuchHint =>
      'Enviar tudo é o ideal para um telemóvel novo. Para partilhar com um grupo, talvez queira enviar menos. Nada é removido deste telemóvel.';

  @override
  String get shareHowFarBack => 'Desde quando';

  @override
  String get shareSpanEverything => 'Tudo';

  @override
  String get shareSpanYear => 'O último ano';

  @override
  String shareSpanMonths(int months) {
    String _temp0 = intl.Intl.pluralLogic(
      months,
      locale: localeName,
      other: 'Os últimos $months meses',
      one: 'O último mês',
      zero: 'Os últimos $months meses',
    );
    return '$_temp0';
  }

  @override
  String get shareSpanLatest => 'Só a última menstruação';

  @override
  String get shareWhatToInclude => 'O que incluir';

  @override
  String get shareWithDays => 'Menstruações e registos diários';

  @override
  String get shareWithDaysHint =>
      'Também notas, avaliações, sentimentos e fluxo.';

  @override
  String get sharePeriodsOnly => 'Só as menstruações';

  @override
  String get sharePeriodsOnlyHint =>
      'Só quando cada menstruação começou e terminou.';

  @override
  String get shareShowCodes => 'Mostrar os códigos';

  @override
  String get shareNothing => 'Ainda não há nada para enviar.';

  @override
  String get shareHowToReceive =>
      'No outro telemóvel, abra o Ebb, vá a Definições → Receber de outro telemóvel e aponte a câmara para este ecrã.';

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
  String get sharePlay => 'Continuar';

  @override
  String get shareNextCode => 'Código seguinte';

  @override
  String get shareCodesChange =>
      'Os códigos mudam sozinhos. O outro telemóvel recolhe-os por qualquer ordem.';

  @override
  String sharePeriodCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count menstruações',
      one: '$count menstruação',
      zero: '$count menstruações',
    );
    return '$_temp0';
  }

  @override
  String shareSummaryEverything(String periods) {
    return 'Tudo o que está no Ebb: $periods.';
  }

  @override
  String shareSummaryEverythingPeople(String periods, int people) {
    String _temp0 = intl.Intl.pluralLogic(
      people,
      locale: localeName,
      other: 'Tudo o que está no Ebb: $periods de $people pessoas.',
    );
    return '$_temp0';
  }

  @override
  String shareSummaryHistoryAll(String who, String name, String periods) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'O seu histórico: $periods.',
      'other': 'Histórico de $name: $periods.',
    });
    return '$_temp0';
  }

  @override
  String shareSummaryHistoryLatest(String who, String name, String periods) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'O seu histórico, só a última menstruação: $periods.',
      'other': 'Histórico de $name, só a última menstruação: $periods.',
    });
    return '$_temp0';
  }

  @override
  String shareSummaryHistoryYear(String who, String name, String periods) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'O seu histórico do último ano: $periods.',
      'other': 'Histórico de $name do último ano: $periods.',
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
      'you': 'O seu histórico dos últimos $months meses: $periods.',
      'other': 'Histórico de $name dos últimos $months meses: $periods.',
    });
    return '$_temp0';
  }

  @override
  String shareSummaryPeriodsAll(String who, String name, String periods) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'As suas menstruações: $periods.',
      'other': 'Menstruações de $name: $periods.',
    });
    return '$_temp0';
  }

  @override
  String shareSummaryPeriodsLatest(String who, String name, String periods) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'As suas menstruações, só a última: $periods.',
      'other': 'Menstruações de $name, só a última: $periods.',
    });
    return '$_temp0';
  }

  @override
  String shareSummaryPeriodsYear(String who, String name, String periods) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'As suas menstruações do último ano: $periods.',
      'other': 'Menstruações de $name do último ano: $periods.',
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
      'you': 'As suas menstruações dos últimos $months meses: $periods.',
      'other': 'Menstruações de $name dos últimos $months meses: $periods.',
    });
    return '$_temp0';
  }

  @override
  String get shareNotEbb => 'Esse código não é do Ebb.';

  @override
  String get shareNewerVersion =>
      'O outro telemóvel tem uma versão mais recente do Ebb. Atualize primeiro este.';

  @override
  String get shareRestarted =>
      'O outro telemóvel recomeçou. A recolher os novos códigos.';

  @override
  String get shareUnreadable =>
      'Alguns códigos não foram lidos corretamente. Vamos lê-los outra vez.';

  @override
  String get shareNeedsCamera =>
      'O Ebb precisa da câmara para ler os códigos. Pode permiti-lo nas definições do sistema para o Ebb.';

  @override
  String get sharePointCamera =>
      'Aponte a câmara para o código no outro telemóvel.';

  @override
  String get shareReading => 'A ler…';

  @override
  String shareCodesReceived(int received, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      total,
      locale: localeName,
      other: '$received de $total códigos recebidos',
    );
    return '$_temp0';
  }

  @override
  String get shareReceiveTitle => 'Receber de outro telemóvel';

  @override
  String shareStillNeeded(String codes) {
    return 'Ainda faltam: $codes';
  }

  @override
  String get groupsMoreThanOne => 'Isto é mais do que uma pessoa';

  @override
  String get groupsMoreThanOneBody =>
      'Estes códigos contêm o histórico de um telemóvel inteiro. Para entrar num grupo, cada pessoa envia só o seu: no telemóvel dela, Definições → Enviar para outro telemóvel → Só o seu histórico.';

  @override
  String groupsUpdateTitle(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Atualizar o seu histórico?',
      'other': 'Atualizar $name?',
    });
    return '$_temp0';
  }

  @override
  String groupsUpdateAction(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Atualizar o seu histórico',
      'other': 'Atualizar $name',
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
          'É de novo o seu histórico, enviado a $sent: $periods. Substitui a cópia que está neste telemóvel.',
      'other':
          'É de novo o histórico de $name, enviado a $sent: $periods. Substitui a cópia que está neste telemóvel.',
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
          'É o seu histórico, enviado a $sent: $periods. Substitui o que está neste telemóvel para si, incluindo o que tenha sido registado aqui desde então.',
      'other':
          'É o histórico de $name, enviado a $sent: $periods. Substitui o que está neste telemóvel para $name, incluindo o que tenha sido registado aqui desde então.',
    });
    return '$_temp0';
  }

  @override
  String groupsUpdated(String name) {
    return '$name: histórico atualizado.';
  }

  @override
  String groupsImportInto(String group) {
    return 'Importar para $group';
  }

  @override
  String groupsImportHint(String periods, String sent) {
    return '$periods, enviado a $sent. Importado só para leitura: não pode ser alterado aqui e é atualizado quando for enviado de novo.';
  }

  @override
  String groupsImported(String name, String group) {
    return 'Histórico de $name importado para $group.';
  }

  @override
  String get groupsGroup => 'Grupo';

  @override
  String get groupsNoMembers =>
      'Ainda não há ninguém neste grupo. Adicione pessoas em Definições → Avançado → Gerir grupos: marque pessoas que já estão neste telemóvel, ou adicione alguém a partir do telemóvel dessa pessoa.';

  @override
  String get groupsPeriods => 'Menstruações';

  @override
  String get groupsChartHint =>
      'Cada barra é uma menstruação; um contorno é uma cujo fim não foi registado, mostrada com a duração habitual. Linhas contínuas descem de cada lua cheia, e tracejadas de cada lua nova.';

  @override
  String get groupsNew => 'Novo grupo';

  @override
  String get groupsRename => 'Mudar o nome do grupo';

  @override
  String get groupsNameHint => 'Por exemplo, o nome do seu círculo ou clube.';

  @override
  String get groupsNameTaken => 'Já há um grupo com esse nome.';

  @override
  String get groupsNoOneYet => 'Ainda ninguém';

  @override
  String get groupsTitle => 'Grupos';

  @override
  String get groupsIntro =>
      'Um grupo reúne pessoas deste telemóvel sob um nome — um círculo ou clube que acompanha o ciclo em conjunto. Uma pessoa pode estar em mais do que um, e eliminar um grupo nunca elimina ninguém.';

  @override
  String groupsAddSomeoneTo(String group) {
    return 'Adicionar alguém a $group';
  }

  @override
  String get groupsAddSomeoneHint =>
      'Acompanhado neste telemóvel: é aqui que regista e altera o histórico dessa pessoa. Quem acompanha o ciclo no próprio telemóvel pode ser importado em vez disso.';

  @override
  String groupsTakeOutTitle(String name, String group) {
    return 'Retirar $name de $group?';
  }

  @override
  String groupsTakeOutBody(String name) {
    return 'O histórico de $name foi importado de outro telemóvel e não está em mais nenhum grupo, por isso o histórico importado também sai deste telemóvel. $name pode voltar a enviá-lo para regressar.';
  }

  @override
  String get groupsTakeOut => 'Retirar';

  @override
  String groupsDeleteTitle(String group) {
    return 'Eliminar $group?';
  }

  @override
  String get groupsDeleteBodyNone =>
      'Só o grupo é eliminado. Todas as pessoas que fazem parte dele continuam neste telemóvel, com todo o histórico.';

  @override
  String groupsDeleteBodySome(String names) {
    return 'As pessoas importadas só para este grupo também saem deste telemóvel: $names. Todas as outras ficam, com todo o histórico.';
  }

  @override
  String get groupsDeleteGroup => 'Eliminar grupo';

  @override
  String get groupsRenameTooltip => 'Mudar o nome';

  @override
  String get groupsWhoIsIn => 'Quem faz parte';

  @override
  String groupsImportedAsOf(String date) {
    return 'Importado · só para leitura, à data de $date';
  }

  @override
  String get groupsTrackedHere => 'Acompanhado neste telemóvel';

  @override
  String get groupsAddTo => 'Adicionar ao grupo';

  @override
  String get groupsAddNew => 'Adicionar outra pessoa';

  @override
  String get groupsAddNewHint =>
      'Acompanhado neste telemóvel: é aqui que regista as menstruações dessa pessoa.';

  @override
  String get groupsImportFromPhone => 'Importar do telemóvel da pessoa';

  @override
  String get groupsImportFromPhoneHint =>
      'A pessoa continua a registar no próprio telemóvel e envia o histórico para aqui, só para leitura. Importar de novo atualiza-o.';

  @override
  String get groupsDeleteThis => 'Eliminar este grupo';

  @override
  String get peopleNameTaken =>
      'Esse nome já está a ser usado neste telemóvel.';

  @override
  String get peopleName => 'Nome';

  @override
  String peopleSeeTogether(String group) {
    return 'Ver $group em conjunto';
  }

  @override
  String get peopleNotInGroup => 'Sem grupo';

  @override
  String get peopleAddSomeone => 'Adicionar alguém';

  @override
  String get peopleTrackSomeoneElse => 'Acompanhar outra pessoa';

  @override
  String get peopleNameHint =>
      'Só algo para distinguir as pessoas — um nome próprio, uma alcunha ou uma inicial.';

  @override
  String backupUnnamedPerson(int number) {
    return 'Pessoa $number';
  }

  @override
  String get backupNotEbb =>
      'Este ficheiro não é uma cópia de segurança do Ebb.';

  @override
  String get backupNewer =>
      'Esta cópia de segurança foi feita por uma versão mais recente do Ebb. Atualize o Ebb e tente novamente.';

  @override
  String get backupNoOne => 'Esta cópia de segurança não tem ninguém.';

  @override
  String get backupSameId =>
      'Esta cópia de segurança parece danificada: há duas pessoas com o mesmo identificador.';

  @override
  String backupAfterExport(String date) {
    return '$date é posterior ao dia em que esta cópia de segurança foi feita.';
  }

  @override
  String backupSameName(String name) {
    return 'Nesta cópia de segurança há duas pessoas com o nome $name.';
  }

  @override
  String backupSameGroupName(String group) {
    return 'Nesta cópia de segurança há dois grupos com o nome $group.';
  }

  @override
  String backupEndsBefore(String date) {
    return 'A menstruação que começa a $date termina antes de começar.';
  }

  @override
  String backupTwoStarts(String date) {
    return 'Há duas menstruações a começar a $date para a mesma pessoa.';
  }

  @override
  String backupDayTwice(String date) {
    return '$date aparece duas vezes para a mesma pessoa.';
  }

  @override
  String backupOverlaps(String date) {
    return 'A menstruação que começa a $date sobrepõe-se à anterior.';
  }

  @override
  String get backupDamaged =>
      'Esta cópia de segurança parece danificada: não foi possível lê-la.';

  @override
  String get backupDamagedExportDate =>
      'Esta cópia de segurança parece danificada: não foi possível ler a data de exportação.';

  @override
  String get backupDamagedGroup =>
      'Esta cópia de segurança parece danificada: não foi possível ler um grupo.';

  @override
  String get backupDamagedGroupName =>
      'Esta cópia de segurança parece danificada: não foi possível ler o nome de um grupo.';

  @override
  String backupDamagedGroupPeople(String group) {
    return 'Esta cópia de segurança parece danificada: não foi possível ler as pessoas do grupo $group.';
  }

  @override
  String get backupDamagedPerson =>
      'Esta cópia de segurança parece danificada: não foi possível ler o registo de uma pessoa.';

  @override
  String get backupDamagedName =>
      'Esta cópia de segurança parece danificada: não foi possível ler um nome.';

  @override
  String get backupDamagedPersonId =>
      'Esta cópia de segurança parece danificada: não foi possível ler o identificador de uma pessoa.';

  @override
  String get backupDamagedSharedOn =>
      'Esta cópia de segurança parece danificada: não foi possível ler o dia em que um histórico foi partilhado.';

  @override
  String get backupDamagedPeriod =>
      'Esta cópia de segurança parece danificada: não foi possível ler o registo de uma menstruação.';

  @override
  String get backupDamagedPeriodStart =>
      'Esta cópia de segurança parece danificada: não foi possível ler o início de uma menstruação.';

  @override
  String get backupDamagedPeriodEnd =>
      'Esta cópia de segurança parece danificada: não foi possível ler o fim de uma menstruação.';

  @override
  String get backupDamagedDay =>
      'Esta cópia de segurança parece danificada: não foi possível ler o registo de um dia.';

  @override
  String backupDamagedFlow(String date) {
    return 'Esta cópia de segurança parece danificada: não foi possível ler o fluxo de $date.';
  }

  @override
  String backupDamagedSymptom(String date) {
    return 'Esta cópia de segurança parece danificada: não foi possível ler um sintoma de $date.';
  }

  @override
  String backupDamagedRating(String date) {
    return 'Esta cópia de segurança parece danificada: não foi possível ler a avaliação de $date.';
  }

  @override
  String backupDamagedFeeling(String date) {
    return 'Esta cópia de segurança parece danificada: não foi possível ler o sentimento de $date.';
  }

  @override
  String backupDamagedTemperature(String date) {
    return 'Esta cópia de segurança parece danificada: não foi possível ler a temperatura de $date.';
  }

  @override
  String backupDamagedMucus(String date) {
    return 'Esta cópia de segurança parece danificada: não foi possível ler o muco cervical de $date.';
  }
}
