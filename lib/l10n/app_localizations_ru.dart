// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get you => 'Вы';

  @override
  String get ok => 'ОК';

  @override
  String get cancel => 'Отмена';

  @override
  String get save => 'Сохранить';

  @override
  String get delete => 'Удалить';

  @override
  String get remove => 'Убрать';

  @override
  String get close => 'Закрыть';

  @override
  String get done => 'Готово';

  @override
  String get back => 'Назад';

  @override
  String get next => 'Далее';

  @override
  String get edit => 'Изменить';

  @override
  String get add => 'Добавить';

  @override
  String get continueAction => 'Продолжить';

  @override
  String get language => 'Язык';

  @override
  String get languagePhone => 'Как на телефоне';

  @override
  String languagePhoneIs(String language) {
    return 'Как на телефоне: $language';
  }

  @override
  String get notifChannelName => 'Напоминания о цикле';

  @override
  String get notifChannelDescription =>
      'Предупреждение перед ожидаемой менструацией и напоминание её отметить.';

  @override
  String notifUpcomingTitle(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Скоро ожидается менструация',
      'other': '$name: скоро ожидается менструация',
    });
    return '$_temp0';
  }

  @override
  String notifUpcomingTomorrow(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'По оценке Ebb, ваша менструация начнётся завтра.',
      'other': '$name: по оценке Ebb, менструация начнётся завтра.',
    });
    return '$_temp0';
  }

  @override
  String notifUpcomingInDays(String who, String name, int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other:
          'По оценке Ebb, ваша менструация начнётся примерно через $days дня.',
      many:
          'По оценке Ebb, ваша менструация начнётся примерно через $days дней.',
      few: 'По оценке Ebb, ваша менструация начнётся примерно через $days дня.',
      one:
          'По оценке Ebb, ваша менструация начнётся примерно через $days день.',
    );
    String _temp1 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other:
          '$name: по оценке Ebb, менструация начнётся примерно через $days дня.',
      many:
          '$name: по оценке Ebb, менструация начнётся примерно через $days дней.',
      few:
          '$name: по оценке Ebb, менструация начнётся примерно через $days дня.',
      one:
          '$name: по оценке Ebb, менструация начнётся примерно через $days день.',
    );
    String _temp2 = intl.Intl.selectLogic(who, {
      'you': '$_temp0',
      'other': '$_temp1',
    });
    return '$_temp2';
  }

  @override
  String notifTodayTitle(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Менструация ожидается сегодня',
      'other': '$name: менструация ожидается сегодня',
    });
    return '$_temp0';
  }

  @override
  String get notifTodayBody => 'Нажмите, чтобы отметить, как дела.';

  @override
  String get calendarTitle => 'Календарь';

  @override
  String get calendarCellToday => 'сегодня';

  @override
  String get calendarCellPeriod => 'менструация';

  @override
  String get calendarCellPeriodUnlogged => 'менструация, конец не отмечен';

  @override
  String get calendarCellLikely => 'вероятное начало следующей менструации';

  @override
  String get calendarCellFertile => 'примерное фертильное окно';

  @override
  String calendarCellMoon(String phase) {
    String _temp0 = intl.Intl.selectLogic(phase, {
      'newMoon': 'новолуние',
      'firstQuarter': 'первая четверть',
      'full': 'полнолуние',
      'other': 'последняя четверть',
    });
    return '$_temp0';
  }

  @override
  String calendarCellRated(int rating) {
    return 'оценка $rating';
  }

  @override
  String calendarCellFelt(String feeling) {
    return 'настроение: $feeling';
  }

  @override
  String get calendarCellNote => 'есть заметка';

  @override
  String get calendarKeyPeriod => 'Менструация';

  @override
  String get calendarKeyEndNotLogged => 'Конец не отмечен';

  @override
  String get calendarKeyLikely => 'Вероятное начало';

  @override
  String get calendarKeyFertile => 'Фертильность (оценка)';

  @override
  String get calendarKeyToday => 'Сегодня';

  @override
  String calendarStatusWindow(String who, String name, String from, String to) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you':
          'Следующая менструация, скорее всего, начнётся в период с $from по $to.',
      'other':
          '$name: следующая менструация, скорее всего, начнётся в период с $from по $to.',
    });
    return '$_temp0';
  }

  @override
  String calendarStatusPeriodDay(String who, String name, int day) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'День $day вашей менструации.',
      'other': '$name: день $day менструации.',
    });
    return '$_temp0';
  }

  @override
  String calendarStatusPeriodDayExcluded(String who, String name, int day) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you':
          'День $day вашей менструации, в цикле, который не учитывается в прогнозах.',
      'other':
          '$name: день $day менструации, в цикле, который не учитывается в прогнозах.',
    });
    return '$_temp0';
  }

  @override
  String calendarStatusUnlogged(String who, String name, int day) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you':
          'День $day вашего цикла. Конец этой менструации не отмечен, поэтому она показана обычной длины.',
      'other':
          '$name: день $day цикла. Конец этой менструации не отмечен, поэтому она показана обычной длины.',
    });
    return '$_temp0';
  }

  @override
  String get calendarStatusFertile =>
      'В примерном фертильном окне. Эта оценка недостаточно надёжна, чтобы использовать её для контрацепции.';

  @override
  String calendarStatusCycleDay(String who, String name, int day) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'День $day вашего цикла.',
      'other': '$name: день $day цикла.',
    });
    return '$_temp0';
  }

  @override
  String calendarDayToday(String date) {
    return 'Сегодня, $date';
  }

  @override
  String get calendarPreviousDay => 'Предыдущий день';

  @override
  String get calendarNextDay => 'Следующий день';

  @override
  String calendarMoonAt(String phase, String time) {
    return '$phase, $time';
  }

  @override
  String get calendarFutureDay =>
      'Дни, которые ещё не наступили, пока нельзя отмечать.';

  @override
  String calendarMarkStarted(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Отметить как день начала менструации',
      'other': '$name: отметить как день начала менструации',
    });
    return '$_temp0';
  }

  @override
  String get calendarMoveStart => 'Сделать этот день первым днём менструации';

  @override
  String calendarMoveStartFrom(String date) {
    return 'Начало переносится с $date';
  }

  @override
  String calendarMarkEnded(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Отметить как день окончания менструации',
      'other': '$name: отметить как день окончания менструации',
    });
    return '$_temp0';
  }

  @override
  String get calendarMakeLastDay =>
      'Сделать этот день последним днём менструации';

  @override
  String get calendarEditPeriod => 'Изменить эту менструацию';

  @override
  String calendarRateDay(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Оцените свой день, 1–5',
      'other': '$name: оценка дня, 1–5',
    });
    return '$_temp0';
  }

  @override
  String calendarHowFelt(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Какое у вас было настроение?',
      'other': '$name: какое было настроение?',
    });
    return '$_temp0';
  }

  @override
  String get calendarFlow => 'Выделения';

  @override
  String get calendarNote => 'Заметка';

  @override
  String calendarTemperatureHeading(String unit) {
    return 'Температура, $unit';
  }

  @override
  String calendarTemperatureRange(String low, String high, String unit) {
    return 'Введите температуру от $low до $high $unit';
  }

  @override
  String get calendarTemperatureHelper => 'Сразу после пробуждения, не вставая';

  @override
  String get calendarTemperatureAffected =>
      'Что-то могло повлиять на результат';

  @override
  String get calendarTemperatureAffectedHint =>
      'Болезнь, недосып, алкоголь, измерение позже обычного';

  @override
  String get calendarMucus => 'Цервикальная слизь';

  @override
  String get calendarMucusFelt => 'Ощущение';

  @override
  String get calendarMucusLooked => 'Внешний вид';

  @override
  String calendarLoggedRated(int rating, String ratingName) {
    return 'Оценка $rating из 5, $ratingName';
  }

  @override
  String calendarLoggedFelt(String emoji, String feeling) {
    return 'Настроение: $emoji $feeling';
  }

  @override
  String calendarLoggedFlow(String flow) {
    String _temp0 = intl.Intl.selectLogic(flow, {
      'spotting': 'Выделения: мажущие',
      'light': 'Выделения: скудные',
      'medium': 'Выделения: умеренные',
      'other': 'Выделения: обильные',
    });
    return '$_temp0';
  }

  @override
  String calendarLoggedTemperature(String temperature) {
    return 'Температура: $temperature';
  }

  @override
  String calendarLoggedTemperatureAffected(String temperature) {
    return 'Температура: $temperature, на результат могло что-то повлиять';
  }

  @override
  String calendarLoggedMucus(String mucus) {
    return 'Цервикальная слизь: $mucus';
  }

  @override
  String calendarLoggedNote(String note) {
    return '«$note»';
  }

  @override
  String get calendarNothingLogged => 'В этот день ничего не отмечено.';

  @override
  String get calendarMoonNew => 'Новолуние';

  @override
  String get calendarMoonFirstQuarter => 'Первая четверть';

  @override
  String get calendarMoonFull => 'Полнолуние';

  @override
  String get calendarMoonLastQuarter => 'Последняя четверть';

  @override
  String get dayFlowNone => 'Нет';

  @override
  String get dayFlowSpotting => 'Мажущие';

  @override
  String get dayFlowLight => 'Скудные';

  @override
  String get dayFlowMedium => 'Умеренные';

  @override
  String get dayFlowHeavy => 'Обильные';

  @override
  String get dayMucusNothing => 'Ничего';

  @override
  String get dayMucusFeelDry => 'Сухо';

  @override
  String get dayMucusFeelWet => 'Влажно';

  @override
  String get dayMucusFeelSlippery => 'Скользко';

  @override
  String get dayMucusLookCreamy => 'Кремообразная';

  @override
  String get dayMucusLookEggWhite => 'Яичный белок';

  @override
  String dayMucusFeelInline(String feel) {
    String _temp0 = intl.Intl.selectLogic(feel, {
      'dry': 'сухо',
      'nothing': 'ничего не ощущается',
      'wet': 'влажно',
      'other': 'скользко',
    });
    return '$_temp0';
  }

  @override
  String dayMucusLookInline(String look) {
    String _temp0 = intl.Intl.selectLogic(look, {
      'nothing': 'ничего не видно',
      'creamy': 'кремообразная',
      'other': 'как яичный белок',
    });
    return '$_temp0';
  }

  @override
  String get dayFeelingHappy => 'Радость';

  @override
  String get dayFeelingCalm => 'Спокойствие';

  @override
  String get dayFeelingLoving => 'Нежность';

  @override
  String get dayFeelingEnergetic => 'Бодрость';

  @override
  String get dayFeelingTired => 'Усталость';

  @override
  String get dayFeelingSad => 'Грусть';

  @override
  String get dayFeelingAnxious => 'Тревога';

  @override
  String get dayFeelingIrritable => 'Раздражение';

  @override
  String get dayFeelingAngry => 'Злость';

  @override
  String get dayFeelingConfused => 'Растерянность';

  @override
  String get chartsTitle => 'Графики';

  @override
  String get chartsDayRating => 'Оценка дня';

  @override
  String get chartsNoRatings => 'В этом периоде пока нет оценённых дней.';

  @override
  String get chartsBars => 'Столбцы';

  @override
  String get chartsLine => 'Линия';

  @override
  String get chartsRatingCaptionBars =>
      'Каждый столбец — оценка одного дня от 1 до 5. Дни менструации затенены.';

  @override
  String get chartsRatingCaptionLine =>
      'Каждая точка — оценка одного дня от 1 до 5; она соединена со следующим днём, если оценены оба. Дни менструации затенены.';

  @override
  String get chartsRatingCaptionMoon =>
      'Луны отмечают фазы Луны; на длинном отрезке — только новолуния и полнолуния или только полнолуния.';

  @override
  String get chartsTemperatureTitle => 'Температура и цервикальная слизь';

  @override
  String get chartsTemperatureEmpty =>
      'В этом периоде пока ничего не отмечено. Нажмите на день в календаре, чтобы добавить температуру или цервикальную слизь.';

  @override
  String chartsTemperatureCaption(String unit) {
    return 'Каждая точка — температура одного дня в $unit; она соединена со следующим днём, если измерения есть за оба. Полая точка означает, что на результат могло что-то повлиять, и она не соединяется. Ниже — цервикальная слизь: чем выше столбец, тем влажнее (ощущение) и тем прозрачнее и тягучее (внешний вид). Дни менструации затенены.';
  }

  @override
  String get chartsFeelings => 'Настроение';

  @override
  String get chartsAroundPeriods => 'Вокруг менструаций';

  @override
  String get chartsAroundMoon => 'Вокруг Луны';

  @override
  String get chartsFeelingsEmptyMoon =>
      'Когда вы отметите настроение за несколько дней в этом периоде, здесь будет видно, какие настроения приходились на полнолуния и новолуния.';

  @override
  String get chartsFeelingsEmptyPeriods =>
      'Когда вы отметите настроение за несколько дней в этом периоде и после этого начнётся менструация, здесь будет видно, какие настроения когда приходились.';

  @override
  String get chartsFeelingsCaptionMoon =>
      'Сколько дней выбиралось каждое лицо.';

  @override
  String get chartsFeelingsCaptionPeriods =>
      'Сколько дней выбиралось каждое лицо. Дни после начала последней менструации не учитываются, пока не начнётся следующая.';

  @override
  String get chartsNoneYet => 'Пока ничего.';

  @override
  String get chartsGroupDuringPeriod => 'Во время менструации';

  @override
  String get chartsGroupBeforePeriod => 'Незадолго до менструации';

  @override
  String get chartsGroupOtherDays => 'Другие дни';

  @override
  String get chartsGroupFullMoon => 'Около полнолуния';

  @override
  String get chartsGroupNewMoon => 'Около новолуния';

  @override
  String get chartsDetailLoggedPeriodDays => 'отмеченные дни менструации';

  @override
  String chartsDetailUsuallyDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'обычно $days дня',
      many: 'обычно $days дней',
      few: 'обычно $days дня',
      one: 'обычно $days день',
    );
    return '$_temp0';
  }

  @override
  String chartsDetailDaysBefore(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'за $days дня до неё',
      many: 'за $days дней до неё',
      few: 'за $days дня до неё',
      one: 'за $days день до неё',
    );
    return '$_temp0';
  }

  @override
  String get chartsDetailRestOfCycle => 'остальная часть цикла';

  @override
  String get chartsDetailDayItself => 'только сам день';

  @override
  String chartsDetailDayEitherSide(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'сам день ±$days дня',
      many: 'сам день ±$days дней',
      few: 'сам день ±$days дня',
      one: 'сам день ±$days день',
    );
    return '$_temp0';
  }

  @override
  String get chartsDetailRestOfMonth => 'остальная часть месяца';

  @override
  String chartsFeelingCount(String feeling, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count дня',
      many: '$count дней',
      few: '$count дня',
      one: '$count день',
    );
    return '$feeling: $_temp0';
  }

  @override
  String chartsFeelingGroupSummary(String group, String detail, String counts) {
    return '$group, $detail: $counts';
  }

  @override
  String get chartsFeelingGroupNone => 'пока ничего';

  @override
  String chartsRatingSummary(String from, String to, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count оценённого дня',
      many: '$count оценённых дней',
      few: '$count оценённых дня',
      one: '$count оценённый день',
    );
    return 'Оценки дней с $from по $to: $_temp0, дни менструации затенены.';
  }

  @override
  String chartsRatingSummaryMoons(String from, String to, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count оценённого дня',
      many: '$count оценённых дней',
      few: '$count оценённых дня',
      one: '$count оценённый день',
    );
    return 'Оценки дней с $from по $to: $_temp0, дни менструации затенены, фазы Луны отмечены.';
  }

  @override
  String chartsLanesSummary(String from, String to, String lanes) {
    return 'Менструации с $from по $to. $lanes.';
  }

  @override
  String chartsLane(String name, String periods) {
    return '$name: $periods';
  }

  @override
  String get chartsLaneNone => 'нет дней менструации';

  @override
  String chartsLaneRun(String from, String to) {
    return 'с $from по $to';
  }

  @override
  String chartsLaneRunEstimated(String from, String to) {
    return 'с $from по $to, примерно';
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
      other: 'в $mucusDays дня',
      many: 'в $mucusDays дней',
      few: 'в $mucusDays дня',
      one: 'в $mucusDays день',
    );
    return 'Температура с $from по $to: $range; цервикальная слизь отмечена $_temp0; дни менструации затенены.';
  }

  @override
  String get chartsNoTemperatures => 'измерений нет';

  @override
  String chartsTemperatureRange(int count, String low, String high) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count измерения',
      many: '$count измерений',
      few: '$count измерения',
      one: '$count измерение',
    );
    return '$_temp0, от $low до $high';
  }

  @override
  String get chartsMucusFelt => 'Ощущ.';

  @override
  String get chartsMucusLooked => 'Вид';

  @override
  String get faceRatingRough => 'Тяжело';

  @override
  String get faceRatingNotGreat => 'Так себе';

  @override
  String get faceRatingOkay => 'Нормально';

  @override
  String get faceRatingGood => 'Хорошо';

  @override
  String get faceRatingGreat => 'Отлично';

  @override
  String get faceRatingRoughInline => 'тяжело';

  @override
  String get faceRatingNotGreatInline => 'так себе';

  @override
  String get faceRatingOkayInline => 'нормально';

  @override
  String get faceRatingGoodInline => 'хорошо';

  @override
  String get faceRatingGreatInline => 'отлично';

  @override
  String faceRatingOption(int rating, String name) {
    return '$rating, $name';
  }

  @override
  String get faceMoreFaces => 'Другие лица';

  @override
  String get faceDifferentFace => 'Выбрать другое лицо';

  @override
  String get faceOther => 'Другое лицо';

  @override
  String get faceSmilingCat => 'Улыбающийся кот';

  @override
  String get faceGrinningCat => 'Кот с широкой улыбкой';

  @override
  String get faceCatTearsOfJoy => 'Кот со слезами радости';

  @override
  String get faceCatHeartEyes => 'Кот с глазами-сердечками';

  @override
  String get faceSmirkingCat => 'Ухмыляющийся кот';

  @override
  String get faceKissingCat => 'Целующий кот';

  @override
  String get faceWearyCat => 'Измученный кот';

  @override
  String get faceCryingCat => 'Плачущий кот';

  @override
  String get facePoutingCat => 'Надутый кот';

  @override
  String get faceAlien => 'Инопланетянин';

  @override
  String get faceSpaceInvader => 'Космический пришелец';

  @override
  String get faceRobot => 'Робот';

  @override
  String get faceGhost => 'Привидение';

  @override
  String get faceSkull => 'Череп';

  @override
  String get faceClown => 'Клоун';

  @override
  String get faceDevil => 'Чертёнок';

  @override
  String get faceUnicorn => 'Единорог';

  @override
  String get faceFrog => 'Лягушка';

  @override
  String get facePartying => 'Праздник';

  @override
  String get faceCool => 'Круто';

  @override
  String get faceNerdy => 'Ботаник';

  @override
  String get faceAngelic => 'Ангелочек';

  @override
  String get faceHugging => 'Обнимашки';

  @override
  String get faceSilly => 'Дурачество';

  @override
  String get faceUpsideDown => 'Вверх ногами';

  @override
  String get faceSmirking => 'Ухмылка';

  @override
  String get faceGrimacing => 'Гримаса';

  @override
  String get faceEyeRoll => 'Закатывание глаз';

  @override
  String get faceSpeechless => 'Нет слов';

  @override
  String get facePleading => 'Мольба';

  @override
  String get faceSobbing => 'Рыдания';

  @override
  String get faceScreaming => 'Крик';

  @override
  String get faceFlushed => 'Смущение';

  @override
  String get faceOverwhelmed => 'Перегрузка';

  @override
  String get faceWoozy => 'Голова кругом';

  @override
  String get faceUnwell => 'Нездоровится';

  @override
  String get faceHurting => 'Больно';

  @override
  String get faceQueasy => 'Подташнивает';

  @override
  String get faceTooHot => 'Жарко';

  @override
  String get faceTooCold => 'Холодно';

  @override
  String get faceSparklingHeart => 'Сверкающее сердце';

  @override
  String get faceBrokenHeart => 'Разбитое сердце';

  @override
  String get faceFire => 'Огонь';

  @override
  String get faceRainbow => 'Радуга';

  @override
  String get faceSun => 'Солнце';

  @override
  String get faceRain => 'Дождь';

  @override
  String get faceStorm => 'Гроза';

  @override
  String get faceBlossom => 'Цветок';

  @override
  String get faceChocolate => 'Шоколад';

  @override
  String get faceInBed => 'В постели';

  @override
  String get homeCalendar => 'Календарь';

  @override
  String get homeHistory => 'История';

  @override
  String get homeCharts => 'Графики';

  @override
  String get homeSettings => 'Настройки';

  @override
  String homeCalendarOf(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Ваш календарь',
      'other': 'Календарь: $name',
    });
    return '$_temp0';
  }

  @override
  String homeHistoryOf(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Ваша история',
      'other': 'История: $name',
    });
    return '$_temp0';
  }

  @override
  String homeChartsOf(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Ваши графики',
      'other': 'Графики: $name',
    });
    return '$_temp0';
  }

  @override
  String get homeWhenStarted => 'Когда она началась?';

  @override
  String get homeWhenEnded => 'Когда она закончилась?';

  @override
  String homePeriodEndedToday(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'У меня сегодня закончилась менструация',
      'other': '$name: менструация сегодня закончилась',
    });
    return '$_temp0';
  }

  @override
  String homePeriodStartedToday(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'У меня сегодня началась менструация',
      'other': '$name: менструация сегодня началась',
    });
    return '$_temp0';
  }

  @override
  String get homeEndedEarlier => 'Она закончилась раньше';

  @override
  String get homeStartedEarlier => 'Она началась раньше';

  @override
  String homeAddLastEnd(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Добавить, когда закончилась ваша последняя менструация',
      'other': '$name: добавить, когда закончилась последняя менструация',
    });
    return '$_temp0';
  }

  @override
  String homeSharedCopy(String who, String name, String date) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you':
          'Импортировано с вашего телефона $date. Здесь это нельзя изменить; данные обновятся, когда вы отправите их снова.',
      'other':
          '$name: импортировано с другого телефона $date. Здесь это нельзя изменить; данные обновятся, когда $name отправит их снова.',
    });
    return '$_temp0';
  }

  @override
  String homeNoPeriodSince(String date) {
    return 'Менструация не отмечалась с $date';
  }

  @override
  String get homeMissedOne =>
      'Ebb предполагает, что одна менструация не была отмечена, и строит оценку с учётом этого. Если вы помните, когда она началась, добавьте её, чтобы уточнить оценку.';

  @override
  String get homeMissedSome =>
      'Ebb предполагает, что несколько менструаций не были отмечены, и строит оценку с учётом этого. Если вы помните, когда какая-то из них началась, добавьте её, чтобы уточнить оценку.';

  @override
  String get homeWelcome => 'Добро пожаловать в Ebb';

  @override
  String get homeNothingYet => 'Пока ничего не отмечено';

  @override
  String homeFirstLog(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Отметьте первый день следующей менструации или добавьте прошлые, если помните их, — и Ebb начнёт узнавать ваш ритм. Всё остаётся на этом телефоне.',
      'other':
          '$name: отметьте первый день следующей менструации или добавьте прошлые, если помните их, — и Ebb начнёт узнавать ритм. Всё остаётся на этом телефоне.',
    });
    return '$_temp0';
  }

  @override
  String homeDayOfPeriod(String who, String name, int day) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'День $day вашей менструации',
      'other': '$name: день $day менструации',
    });
    return '$_temp0';
  }

  @override
  String homeDayOfCycle(String who, String name, int day) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'День $day вашего цикла',
      'other': '$name: день $day цикла',
    });
    return '$_temp0';
  }

  @override
  String get homeTellEnd =>
      'Отметьте, когда она закончится, чтобы оценка оставалась точной.';

  @override
  String homeDaysUntil(String who, String name, int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Ваша менструация ожидается примерно через $days дня.',
      many: 'Ваша менструация ожидается примерно через $days дней.',
      few: 'Ваша менструация ожидается примерно через $days дня.',
      one: 'Ваша менструация ожидается примерно через $days день.',
    );
    String _temp1 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$name: менструация ожидается примерно через $days дня.',
      many: '$name: менструация ожидается примерно через $days дней.',
      few: '$name: менструация ожидается примерно через $days дня.',
      one: '$name: менструация ожидается примерно через $days день.',
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
      'you': 'Ваша менструация ожидается завтра.',
      'other': '$name: менструация ожидается завтра.',
    });
    return '$_temp0';
  }

  @override
  String homeExpectedToday(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Ваша менструация ожидается сегодня.',
      'other': '$name: менструация ожидается сегодня.',
    });
    return '$_temp0';
  }

  @override
  String homeDaysLate(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other:
          'На $days дня позже ожидаемого. Циклы сдвигаются по самым разным причинам.',
      many:
          'На $days дней позже ожидаемого. Циклы сдвигаются по самым разным причинам.',
      few:
          'На $days дня позже ожидаемого. Циклы сдвигаются по самым разным причинам.',
      one:
          'На $days день позже ожидаемого. Циклы сдвигаются по самым разным причинам.',
    );
    return '$_temp0';
  }

  @override
  String get homeRingDay => 'ДЕНЬ';

  @override
  String homeRingOfCycle(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'вашего цикла',
      'other': 'цикла · $name',
    });
    return '$_temp0';
  }

  @override
  String homeRingOfPeriod(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'вашей менструации',
      'other': 'менструации · $name',
    });
    return '$_temp0';
  }

  @override
  String get homeKeyPeriod => 'Менструация';

  @override
  String get homeKeyLikelyNext => 'Вероятно, следующая';

  @override
  String get homeKeyToday => 'Сегодня';

  @override
  String get homeAddPastPeriods => 'Добавить прошлые менструации';

  @override
  String get homeAddMissedPeriod => 'Добавить пропущенную менструацию';

  @override
  String get homeNextPeriod => 'Следующая менструация';

  @override
  String homeLikelyBetween(String from, String to) {
    return 'скорее всего, в период с $from по $to';
  }

  @override
  String get homeFertileWindow => 'Примерное фертильное окно';

  @override
  String get homeFertileWarning =>
      'Оценка только по срокам цикла. Она недостаточно надёжна, чтобы использовать её для контрацепции.';

  @override
  String homeConfidenceUnlogged(String date) {
    return 'Оценка по последней отмеченной менструации ($date), поэтому она может быть менее точной, чем обычно.';
  }

  @override
  String get homeConfidenceNone => 'Пока ничего не отмечено.';

  @override
  String get homeConfidenceTypical =>
      'Пока за основу взят типичный 28-дневный цикл. Чем больше вы отмечаете, тем точнее оценка.';

  @override
  String homeConfidenceFew(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Пока учтено $count цикла, поэтому оценка может быть менее точной.',
      many:
          'Пока учтено $count циклов, поэтому оценка может быть менее точной.',
      few: 'Пока учтено $count цикла, поэтому оценка может быть менее точной.',
      one: 'Пока учтён $count цикл, поэтому оценка может быть менее точной.',
    );
    return '$_temp0';
  }

  @override
  String homeConfidenceIrregular(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Ваши циклы заметно различаются, поэтому это широкая оценка, а не точная дата.',
      'other':
          '$name: циклы заметно различаются, поэтому это широкая оценка, а не точная дата.',
    });
    return '$_temp0';
  }

  @override
  String homeConfidenceLast(String who, String name, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Учтены ваши последние циклы: $count.',
      many: 'Учтены ваши последние циклы: $count.',
      few: 'Учтены ваши последние циклы: $count.',
      one: 'Учтены ваши последние циклы: $count.',
    );
    String _temp1 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$name: учтены последние циклы: $count.',
      many: '$name: учтены последние циклы: $count.',
      few: '$name: учтены последние циклы: $count.',
      one: '$name: учтены последние циклы: $count.',
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
      other: 'Оценка по $count довольно регулярного цикла.',
      many: 'Оценка по $count довольно регулярным циклам.',
      few: 'Оценка по $count довольно регулярным циклам.',
      one: 'Оценка по $count довольно регулярному циклу.',
    );
    return '$_temp0';
  }

  @override
  String get homeMilestoneFirstPeriod => 'Первая менструация отмечена';

  @override
  String get homeMilestoneFirstCycle => 'Первый полный цикл';

  @override
  String get homeMilestoneThreeCycles => 'Три полных цикла';

  @override
  String get homeMilestoneSixCycles => 'Шесть полных циклов';

  @override
  String get homeMilestoneOneYear => 'Год истории';

  @override
  String get homeMilestoneTwoYears => 'Два года истории';

  @override
  String get homeMilestoneFiveYears => 'Пять лет истории';

  @override
  String get homeMilestoneFirstBackup => 'Первая резервная копия сохранена';

  @override
  String homeMilestoneFirstPeriodMessage(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Ваша первая менструация, отмеченная в Ebb.',
      'other': '$name: первая менструация, отмеченная в Ebb.',
    });
    return '$_temp0';
  }

  @override
  String homeMilestoneFirstCycleMessage(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Первый полный цикл. Ebb может начать узнавать ваш ритм.',
      'other': '$name: первый полный цикл. Ebb может начать узнавать ритм.',
    });
    return '$_temp0';
  }

  @override
  String get homeMilestoneThreeCyclesMessage =>
      'Отмечено три полных цикла. С каждым у Ebb больше данных для оценки.';

  @override
  String get homeMilestoneSixCyclesMessage =>
      'Отмечено шесть полных циклов — столько Ebb и учитывает в каждой оценке.';

  @override
  String homeMilestoneOneYearMessage(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Год вашей истории в Ebb.',
      'other': '$name: год истории в Ebb.',
    });
    return '$_temp0';
  }

  @override
  String homeMilestoneTwoYearsMessage(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Два года вашей истории в Ebb.',
      'other': '$name: два года истории в Ebb.',
    });
    return '$_temp0';
  }

  @override
  String homeMilestoneFiveYearsMessage(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Пять лет вашей истории в Ebb.',
      'other': '$name: пять лет истории в Ebb.',
    });
    return '$_temp0';
  }

  @override
  String get homeMilestoneFirstBackupMessage =>
      'Ваша первая резервная копия сохранена. Храните копию где-нибудь, кроме этого телефона.';

  @override
  String get homeProblemStartInFuture => 'Дата начала не может быть в будущем.';

  @override
  String get homeProblemEndInFuture =>
      'Дата окончания не может быть в будущем.';

  @override
  String get homeProblemEndBeforeStart => 'Дата окончания раньше даты начала.';

  @override
  String get homeProblemDuplicateStart =>
      'Менструация, начавшаяся в этот день, уже записана.';

  @override
  String get homeProblemOverlapsPrevious =>
      'Это пересекается с предыдущей менструацией. Проверьте дату окончания предыдущей записи.';

  @override
  String get homeProblemOverlapsNext =>
      'Это пересекается со следующей менструацией. Проверьте дату окончания.';

  @override
  String get homeDeleteCycleTitle => 'Удалить этот цикл?';

  @override
  String homeDeleteCycleBody(String date) {
    return 'Запись, начинающаяся $date, будет удалена. Это нельзя отменить.';
  }

  @override
  String get homeFirstDayOfPeriod => 'Первый день менструации';

  @override
  String get homeLastDayOfPeriod => 'Последний день менструации';

  @override
  String get homeAddPastPeriodTitle => 'Добавить прошлую менструацию';

  @override
  String get homeEditPeriod => 'Изменить менструацию';

  @override
  String get homeStarted => 'Началась';

  @override
  String get homeEnded => 'Закончилась';

  @override
  String get homeStillGoing => 'Продолжается';

  @override
  String get homeNotRecorded => 'Не записано';

  @override
  String get homeClearEnd => 'Убрать дату окончания';

  @override
  String get homeCountInPredictions => 'Учитывать этот цикл в прогнозах';

  @override
  String get homeCountInPredictionsHint =>
      'Выключите для цикла, который не отражает обычный ритм, — болезнь, смена лекарств, потеря беременности. В истории он останется в любом случае.';

  @override
  String get homeNote => 'Заметка';

  @override
  String get homeNoteExcludedHint =>
      'Почему он не учитывается — чтобы потом было легко вспомнить.';

  @override
  String get homeNoteHint => 'Всё, что стоит запомнить об этом цикле.';

  @override
  String get homeDeletePeriod => 'Удалить эту менструацию';

  @override
  String get homeAddPastPeriod => 'Добавить прошлую менструацию';

  @override
  String get homeHistoryEmpty =>
      'Циклов пока нет. Если вы помните, когда начинались недавние менструации, добавьте их — так Ebb быстрее начнёт давать оценки.';

  @override
  String get homeMilestones => 'Достижения';

  @override
  String homePeriodLength(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Менструация: $count дня',
      many: 'Менструация: $count дней',
      few: 'Менструация: $count дня',
      one: 'Менструация: $count день',
    );
    return '$_temp0';
  }

  @override
  String get homePeriodInProgress => 'Менструация продолжается';

  @override
  String get homeEndNotRecorded => 'Окончание не записано';

  @override
  String get homeLongGap =>
      'Долгий перерыв. Если здесь была неотмеченная менструация, добавьте её кнопкой «Добавить прошлую менструацию».';

  @override
  String get homeNothingSince =>
      'С тех пор ничего не отмечено. Если менструация была пропущена, добавьте её кнопкой «Добавить прошлую менструацию».';

  @override
  String homeNotCounted(String detail) {
    return '$detail · не учитывается';
  }

  @override
  String get homeDayCycle => 'дн. в цикле';

  @override
  String get homeLastLogged => 'Последний отмеченный';

  @override
  String get homeCurrent => 'Текущий';

  @override
  String get homeSpanMonths3 => 'Последние 3 месяца';

  @override
  String get homeSpanMonths6 => 'Последние 6 месяцев';

  @override
  String get homeSpanYear => 'Последний год';

  @override
  String get homeSpanAll => 'Всё';

  @override
  String get homeSpanCustom => 'Выбрать даты…';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get settingsNotificationsOff =>
      'Уведомления для Ebb выключены в настройках системы.';

  @override
  String settingsNoBrowser(String website) {
    return 'Нет браузера, чтобы открыть ссылку. Откройте $website вручную.';
  }

  @override
  String get settingsNothingToBackUp => 'Пока нечего сохранять.';

  @override
  String get settingsBackupSaved =>
      'Резервная копия сохранена. Храните копию где-нибудь, кроме этого телефона.';

  @override
  String get settingsBackupNotSaved =>
      'Не удалось сохранить резервную копию в это место. Попробуйте другое.';

  @override
  String get settingsNoPicker =>
      'На этом телефоне нет средства выбора файлов, которым мог бы воспользоваться Ebb. Отправка на другой телефон работает и без него.';

  @override
  String get settingsFileTooLarge =>
      'Этот файл слишком большой для резервной копии Ebb.';

  @override
  String get settingsFileUnreadable => 'Не удалось прочитать этот файл.';

  @override
  String get settingsNotABackup =>
      'Этот файл не является резервной копией Ebb.';

  @override
  String settingsPeriodCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count менструации',
      many: '$count менструаций',
      few: '$count менструации',
      one: '$count менструация',
    );
    return '$_temp0';
  }

  @override
  String get settingsSetUpTitle => 'Начать с этой истории?';

  @override
  String settingsSetUpBody(String periods, String date) {
    return '$periods, отправлено $date. На этом телефоне это станет вашей историей.';
  }

  @override
  String settingsUpdateTitle(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Обновить вашу историю?',
      'other': 'Обновить: $name?',
    });
    return '$_temp0';
  }

  @override
  String settingsUpdateAction(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Обновить вашу историю',
      'other': 'Обновить: $name',
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
          'Это снова ваша история, отправлено $date: $periods. Она заменит копию на этом телефоне.',
      'other':
          '$name: это снова та же история, отправлено $date: $periods. Она заменит копию на этом телефоне.',
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
          'Это ваша история, отправлено $date: $periods. Она заменит ваши данные на этом телефоне, включая всё, что было отмечено здесь с тех пор.',
      'other':
          '$name: эта история отправлена $date: $periods. Она заменит данные этого человека на этом телефоне, включая всё, что было отмечено здесь с тех пор.',
    });
    return '$_temp0';
  }

  @override
  String get settingsReplaceEverything => 'Заменить всё';

  @override
  String settingsPersonUpdated(String name) {
    return 'Обновлено: $name.';
  }

  @override
  String get settingsAddThisHistoryTitle => 'Добавить эту историю?';

  @override
  String settingsAddNamedTitle(String name) {
    return 'Добавить: $name?';
  }

  @override
  String settingsAddBody(String periods) {
    return 'В ней: $periods. Её можно добавить к тому, что уже есть, или заменить ею всё на этом телефоне.';
  }

  @override
  String settingsAddNamedBody(String name, String periods) {
    return '$name: в истории $periods. Её можно добавить к тому, что уже есть, или заменить ею всё на этом телефоне.';
  }

  @override
  String get settingsAddAsNew => 'Добавить как нового человека';

  @override
  String get settingsWhoIsThis => 'Кто это?';

  @override
  String get settingsWhoIsThisHint =>
      'Имя, чтобы различать людей на этом телефоне.';

  @override
  String settingsPersonAdded(String name) {
    return 'Добавлено: $name.';
  }

  @override
  String get settingsRestored => 'Готово. Данные в Ebb обновлены.';

  @override
  String get settingsReplaceTitle => 'Заменить данные в Ebb?';

  @override
  String settingsReplaceSaved(String date, String periods) {
    return 'Сохранено $date; в копии: $periods.';
  }

  @override
  String settingsReplaceSavedPeople(int people, String date, String periods) {
    String _temp0 = intl.Intl.pluralLogic(
      people,
      locale: localeName,
      other: 'Сохранено $date; в копии: $periods для $people человека.',
      many: 'Сохранено $date; в копии: $periods для $people человек.',
      few: 'Сохранено $date; в копии: $periods для $people человек.',
      one: 'Сохранено $date; в копии: $periods для $people человека.',
    );
    return '$_temp0';
  }

  @override
  String settingsReplaceCurrent(String periods) {
    return 'Она заменит всё, что сейчас есть в Ebb. Сейчас на этом телефоне: $periods.';
  }

  @override
  String get settingsReplace => 'Заменить';

  @override
  String get settingsDeleteAllTitle => 'Удалить все данные?';

  @override
  String get settingsDeleteAllBody =>
      'Все циклы и заметки будут удалены навсегда. Других копий у Ebb нет, поэтому это нельзя отменить, если вы не сохранили резервную копию в файл.';

  @override
  String get settingsDeleteAllBodyEveryone =>
      'Все циклы и заметки всех людей на этом телефоне будут удалены навсегда. Других копий у Ebb нет, поэтому это нельзя отменить, если вы не сохранили резервную копию в файл.';

  @override
  String get settingsDeleteEverything => 'Удалить всё';

  @override
  String get settingsAllDeleted => 'Все данные удалены.';

  @override
  String get settingsYourName => 'Ваше имя';

  @override
  String get settingsRename => 'Переименовать';

  @override
  String get settingsYourNameHint =>
      'Показывается в списке людей. Оставьте пустым, чтобы отображалось «Вы».';

  @override
  String settingsRemoveTitle(String name) {
    return 'Удалить с этого телефона: $name?';
  }

  @override
  String settingsRemoveBody(String name) {
    return '$name: все циклы и заметки будут удалены навсегда. Истории других людей это не затронет.';
  }

  @override
  String settingsPersonRemoved(String name) {
    return 'Удалено: $name.';
  }

  @override
  String settingsRemovePerson(String name) {
    return 'Удалить с этого телефона: $name';
  }

  @override
  String get settingsYourCycle => 'Ваш цикл';

  @override
  String get settingsYourSettings => 'Ваши настройки';

  @override
  String settingsSettingsFor(String name) {
    return 'Настройки: $name';
  }

  @override
  String get settingsName => 'Имя';

  @override
  String get settingsReminders => 'Напоминания';

  @override
  String settingsRemindersHint(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Предупреждение перед ожидаемой менструацией.',
      'other': '$name: предупреждение перед ожидаемой менструацией.',
    });
    return '$_temp0';
  }

  @override
  String get settingsRemindMe => 'Напоминать';

  @override
  String settingsDaysAhead(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'за $count дня',
      many: 'за $count дней',
      few: 'за $count дня',
      one: 'за $count день',
    );
    return '$_temp0';
  }

  @override
  String settingsDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count дня',
      many: '$count дней',
      few: '$count дня',
      one: '$count день',
    );
    return '$_temp0';
  }

  @override
  String get settingsFertile => 'Показывать оценку фертильного окна';

  @override
  String get settingsFertileHint =>
      'По умолчанию выключено. Оценка только по срокам цикла — недостаточно надёжна, чтобы использовать её для контрацепции.';

  @override
  String get settingsMoon => 'Показывать фазы Луны';

  @override
  String get settingsMoonHint =>
      'Новолуние, первая четверть, полнолуние и последняя четверть — в календаре и на графиках.';

  @override
  String get settingsTemperature =>
      'Отслеживать температуру и цервикальную слизь';

  @override
  String get settingsTemperatureHint =>
      'В каждом дне календаря, с графиком температуры. Только записывается и показывается, ни для каких оценок не используется.';

  @override
  String get settingsTemperatureIn => 'Температура в';

  @override
  String get settingsCelebrate => 'Отмечать достижения';

  @override
  String settingsCelebrateHint(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Небольшое поздравление, например, с первым полным циклом или годом истории; все они видны в вашей Истории.',
      'other':
          '$name: небольшое поздравление, например, с первым полным циклом или годом истории; все они видны в Истории.',
    });
    return '$_temp0';
  }

  @override
  String get settingsPeople => 'Люди';

  @override
  String get settingsAddSomeone => 'Добавить человека';

  @override
  String get settingsTrackSomeoneElse => 'Отслеживать ещё кого-то';

  @override
  String get settingsTrackSomeoneElseHint =>
      'Например, ребёнка, у которого только начались менструации.';

  @override
  String get settingsBackupSection => 'Резервные копии и перенос';

  @override
  String get settingsBackUp => 'Сохранить резервную копию в файл';

  @override
  String get settingsBackUpHint =>
      'Ваша история — в файл, в выбранное вами место.';

  @override
  String get settingsBackUpHintEveryone =>
      'История всех людей — в файл, в выбранное вами место.';

  @override
  String get settingsRestore => 'Восстановить из резервной копии';

  @override
  String get settingsRestoreHint => 'Заменяет то, что сейчас есть в Ebb.';

  @override
  String get settingsSend => 'Отправить на другой телефон';

  @override
  String get settingsSendHint =>
      'Показать вашу историю в виде кодов, чтобы другой телефон их отсканировал.';

  @override
  String get settingsSendHintEveryone =>
      'Показать историю всех людей в виде кодов, чтобы другой телефон их отсканировал.';

  @override
  String get settingsReceive => 'Получить с другого телефона';

  @override
  String get settingsReceiveHint =>
      'Отсканируйте коды, чтобы добавить человека, обновить его данные или заменить всё.';

  @override
  String get settingsAdvanced => 'Дополнительно';

  @override
  String get settingsGroups => 'Группы';

  @override
  String get settingsGroupsHint =>
      'Для кругов и клубов, которые ведут учёт вместе: объедините людей под одним названием. Если выключить, группы скроются, но не удалятся.';

  @override
  String get settingsManageGroups => 'Управление группами';

  @override
  String get settingsAboutEbb => 'О Ebb';

  @override
  String get settingsHowEbbWorks => 'Как работает Ebb';

  @override
  String get settingsHowEbbWorksHint =>
      'Отметки, оценки, резервные копии и не только.';

  @override
  String get settingsYourData => 'Ваши данные';

  @override
  String get settingsYourDataHint => 'Где они хранятся и кто может их видеть.';

  @override
  String get settingsWebsite => 'Сайт';

  @override
  String get settingsSendFeedback => 'Отправить отзыв';

  @override
  String get settingsSendFeedbackHint => 'Форма на сайте, в вашем браузере.';

  @override
  String get settingsDeleteAll => 'Удалить все данные';

  @override
  String settingsVersion(String version) {
    return 'Ebb $version\nСоздано SuperDaveLab';
  }

  @override
  String get settingsDataHeadline => 'Ваш цикл — ваше дело.';

  @override
  String get settingsDataLede =>
      'Ebb устроен так, что у вопроса «что они делают с моими данными?» скучный ответ: ничего, потому что мы их никогда не получаем.';

  @override
  String get settingsDataTradeOff =>
      'Один компромисс, о котором стоит знать: копии в облаке нет, поэтому если телефон потеряется или будет сброшен, история пропадёт. Если это для вас важно, время от времени сохраняйте резервную копию в файл в Настройках и храните её где-нибудь, кроме этого телефона.';

  @override
  String get settingsWhereDataLives => 'Где хранятся ваши данные';

  @override
  String get settingsWhereDataLivesHint => 'Ваши данные и кто может их видеть.';

  @override
  String get settingsDataStaysTitle => 'Всё остаётся на вашем телефоне';

  @override
  String get settingsDataStaysBody =>
      'Всё, что вы отмечаете, хранится в базе данных на этом устройстве. Нет ни аккаунта, ни сервера для синхронизации. Данные попадают куда-то ещё, только если вы сами их переносите, — в файл резервной копии или на другой телефон, на который вы их отправили.';

  @override
  String get settingsDataUnseenTitle => 'Мы не можем их видеть';

  @override
  String get settingsDataUnseenBody =>
      'У Ebb вообще нет разрешения на доступ к интернету. Android это гарантирует, и вы можете сами проверить это в списке разрешений приложения.';

  @override
  String get settingsDataPermissionsTitle => 'Для чего нужны разрешения';

  @override
  String get settingsDataPermissionsBody =>
      'Уведомления — для напоминаний. Камера — только пока вы получаете историю с другого телефона: она считывает коды, и ничего не записывается и не сохраняется. Ещё Ebb заново устанавливает напоминания после перезагрузки телефона. Вот и весь список.';

  @override
  String get settingsDataNotForSaleTitle => 'Продавать нечего';

  @override
  String get settingsDataNotForSaleBody =>
      'Никакой аналитики, никакой рекламы, никаких сторонних библиотек, которые что-то куда-то отправляют. Ваши данные к нам никогда не попадают, поэтому нет и копии, которую кто-то мог бы купить, затребовать по суду или слить.';

  @override
  String get settingsDataEraseTitle => 'Их можно мгновенно стереть';

  @override
  String get settingsDataEraseBody =>
      'Удаление данных в Настройках или удаление Ebb стирает всё, что хранит Ebb. Других копий у Ebb нет — есть только файлы резервных копий, которые вы сохранили, или телефоны, на которые вы сами их отправили.';

  @override
  String get settingsDataOpenSourceTitle => 'Нашу работу можно проверить';

  @override
  String get settingsDataOpenSourceBody =>
      'Ebb — программа с открытым исходным кодом под лицензией GNU General Public License. Любой может точно прочитать, что она делает, а опубликованные сборки собраны из того же кода.';

  @override
  String get settingsHelpLoggingTitle => 'Как отметить менструацию';

  @override
  String get settingsHelpLoggingBody =>
      'Нажмите «У меня сегодня началась менструация» в первый день кровотечения и «У меня сегодня закончилась менструация» в последний.\n\nЗабыли отметить? Тогда нажмите «Она началась раньше». Любую прошлую менструацию можно добавить или исправить в Истории (значок часов): нажмите на неё, чтобы изменить даты или добавить заметку.\n\nЕсли окончание не отмечено в течение двух недель, Ebb перестаёт считать, что менструация продолжается, и предлагает добавить окончание.';

  @override
  String get settingsHelpEstimateTitle => 'Как строится оценка';

  @override
  String get settingsHelpEstimateBody =>
      'Ebb смотрит на промежутки между началами ваших недавних менструаций — до шести последних.\n\nПока истории мало, он опирается на типичный 28-дневный цикл и прямо об этом говорит. Чем больше вы отмечаете, тем больше оценка отражает ваш собственный ритм.\n\nОн показывает диапазон, а не одну дату, и говорит, насколько уверен. Если ваши циклы сильно различаются, диапазон шире.\n\nЕсли менструация задерживается, Ebb говорит, на сколько. Если почти два цикла ничего не отмечено, он предполагает, что менструация не была отмечена, строит оценку с учётом этого и сообщает об этом. История показывает долгие перерывы, а добавленная пропущенная менструация уточняет оценку.';

  @override
  String get settingsHelpExcludeTitle => 'Цикл, который не стоит учитывать';

  @override
  String get settingsHelpExcludeBody =>
      'Болезнь, смена лекарств или потеря беременности могут сильно сбить один цикл, а вместе с ним и оценку.\n\nВ Истории нажмите на эту менструацию и выключите «Учитывать этот цикл в прогнозах». Он останется в истории, просто оценка будет его пропускать. Добавьте там же заметку, чтобы помнить почему.';

  @override
  String get settingsHelpGroupsTitle => 'Группы';

  @override
  String get settingsHelpGroupsBody =>
      'Для кругов и клубов, которые ведут учёт вместе. Включите их в Настройки → Дополнительно, затем создайте группу и выберите, кто в неё входит. Пункт «Группа …: все вместе» в списке людей показывает всех рядом, вместе с Луной.\n\nВ группе бывают участники двух видов. Добавленный человек отслеживается на этом телефоне, и вы отмечаете за него здесь. Импортированный человек продолжает вести учёт на своём телефоне и предоставляет группе свою историю: она остаётся его собственной, и её нельзя изменить на чужом телефоне.\n\nЧтобы вас импортировали, отправьте только свою историю (Настройки → Отправить на другой телефон) — сколько хотите, с ежедневными заметками или без них. Другой телефон импортирует её из группы: Управление группами → группа → Импорт с другого телефона. Повторный импорт обновляет данные.\n\nИмпортированная история принадлежит своей группе. Если убрать импортированного человека из последней его группы или удалить эту группу, его история тоже удалится с телефона. И её нельзя переслать дальше: отправлять можно только свою историю.';

  @override
  String get settingsHelpRatingsTitle => 'Оценки дней, настроение и графики';

  @override
  String get settingsHelpRatingsBody =>
      'Нажмите на любой день в календаре, чтобы оценить его от 1 до 5 и выбрать лицо, которое отражает ваше настроение. И то и другое необязательно; нажмите на выбранный вариант ещё раз, чтобы снять его.\n\nГрафики (значок графика) показывают оценку каждого дня за выбранные даты с затенёнными менструациями, а также какие настроения были во время менструаций и перед ними. Если в Настройках включены фазы Луны, Луна тоже там.\n\nГрафики показывают то, что вы отметили. Они не говорят, что это значит, — судить вам.';

  @override
  String get settingsHelpTemperatureTitle => 'Температура и цервикальная слизь';

  @override
  String get settingsHelpTemperatureBody =>
      'Включите «Отслеживать температуру и цервикальную слизь» в Настройках, и в каждом дне календаря появится место для температуры после пробуждения и для того, какой была цервикальная слизь на ощупь и на вид. Если что-то могло исказить результат — болезнь, недосып, алкоголь, измерение позже обычного, — поставьте галочку под ним.\n\nГрафики показывают температуру линией, слизь под ней и затенённые менструации, в °C или °F (Настройки).\n\nEbb записывает и показывает эти данные — и только. Он не ищет подъём температуры и не вычисляет по ним фертильные дни, а его оценка фертильного окна по-прежнему строится только по срокам цикла. Если вы следуете методу, например симптотермальному, график к вашим услугам — читайте его по правилам этого метода.';

  @override
  String get settingsHelpRemindersTitle => 'Напоминания';

  @override
  String get settingsHelpRemindersBody =>
      'Предупреждение за несколько дней до ожидаемой менструации и ещё одно в сам день. Насколько заранее, выбирается в Настройках.\n\nОни назначаются на самом телефоне, поэтому приходят без сети и в режиме полёта.\n\nEbb назначает их каждый раз, когда вы его открываете, по последней оценке. Телефон сохраняет их после перезагрузки, но пока Ebb закрыт, он не может их обновить, поэтому открывайте его время от времени — достаточно отметить менструацию.\n\nAndroid может доставлять их чуть позже обычного, чтобы экономить заряд. Если Ebb принудительно остановлен или его ограничивает режим энергосбережения, они могут не прийти, пока вы снова не откроете Ebb.';

  @override
  String get settingsHelpFertileTitle => 'Фертильное окно';

  @override
  String get settingsHelpFertileBody =>
      'Выключено, пока вы не включите его в Настройках. Оно оценивается только по срокам цикла, а это недостаточно надёжно, чтобы использовать для контрацепции.';

  @override
  String get settingsHelpBackupTitle => 'Резервные копии';

  @override
  String get settingsHelpBackupBody =>
      'Копии вашей истории в облаке нет, поэтому если телефон потеряется или будет сброшен, история пропадёт.\n\nНастройки → «Сохранить резервную копию в файл» сохраняет всё в файл, в выбранное вами место. Храните его где-нибудь, кроме этого телефона. «Восстановить из резервной копии» возвращает всё обратно.';

  @override
  String get settingsHelpMovingTitle => 'Переход на новый телефон';

  @override
  String get settingsHelpMovingBody =>
      'На старом телефоне: Настройки → «Отправить на другой телефон». На новом: Настройки → «Получить с другого телефона», и наведите камеру на экран.\n\nДлинная история занимает несколько кодов, которые сменяются сами; новый телефон собирает их в любом порядке. Интернет не нужен — один телефон показывает, другой смотрит.';

  @override
  String get settingsHelpSomeoneElseTitle => 'Учёт за другого человека';

  @override
  String get settingsHelpSomeoneElseBody =>
      'Помогаете кому-то вести учёт — например, ребёнку, у которого только начались менструации? Настройки → «Отслеживать ещё кого-то» и укажите имя. Подойдёт и прозвище или инициал.\n\nНажмите на имя вверху главного экрана, чтобы переключаться между людьми. У каждого свои напоминания; для добавленных людей они сначала выключены. Фертильное окно предлагается только для вас.';

  @override
  String get settingsHelpHandoverTitle => 'Передача на свой телефон';

  @override
  String get settingsHelpHandoverBody =>
      'Когда у человека, за которого вы ведёте учёт, появляется свой телефон: «Отправить на другой телефон» и выберите только этого человека. На его телефоне — «Получить с другого телефона». При новой установке его история просто становится его собственной.\n\nПосле этого Ebb спросит, удалить ли этого человека с вашего телефона. Сам он этого никогда не делает.';

  @override
  String get settingsHelpDeletingTitle => 'Удаление';

  @override
  String get settingsHelpDeletingBody =>
      'Настройки → «Удалить все данные» стирает сразу всё на этом телефоне.\n\nЧтобы удалить одного добавленного человека, откройте его настройки и выберите «Удалить с этого телефона: …». Истории других людей это не затронет.';

  @override
  String shareRemoveTitle(String name) {
    return 'Удалить с этого телефона: $name?';
  }

  @override
  String shareRemoveBody(String name) {
    return '$name: если история дошла до другого телефона, с этого её можно удалить. А можно и оставить здесь тоже.';
  }

  @override
  String get shareKeep => 'Оставить';

  @override
  String shareRemoved(String name) {
    return 'Удалено: $name.';
  }

  @override
  String get shareTitle => 'Отправить на другой телефон';

  @override
  String get shareWhatToSend => 'Что вы хотите отправить?';

  @override
  String get shareEveryone => 'Всех';

  @override
  String get shareEveryoneHint => 'Переход на новый телефон.';

  @override
  String get shareJustOne => 'Только одного человека';

  @override
  String get shareJustYours => 'Только ваша история';

  @override
  String shareJustName(String name) {
    return 'Только $name';
  }

  @override
  String shareForTheirPhone(String name) {
    return '$name: на собственный телефон.';
  }

  @override
  String get shareCopiesNotOffered =>
      'Люди, импортированные с других телефонов, здесь не предлагаются: каждый делится только своей историей.';

  @override
  String shareHowMuch(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Какую часть вашей истории?',
      'other': '$name: какую часть истории?',
    });
    return '$_temp0';
  }

  @override
  String get shareHowMuchHint =>
      'Для нового телефона подходит всё. Для группы можно отправить меньше. С этого телефона ничего не удаляется.';

  @override
  String get shareHowFarBack => 'За какой срок';

  @override
  String get shareSpanEverything => 'Всё';

  @override
  String get shareSpanYear => 'Последний год';

  @override
  String shareSpanMonths(int months) {
    String _temp0 = intl.Intl.pluralLogic(
      months,
      locale: localeName,
      other: 'Последние $months месяца',
      many: 'Последние $months месяцев',
      few: 'Последние $months месяца',
      one: 'Последний $months месяц',
    );
    return '$_temp0';
  }

  @override
  String get shareSpanLatest => 'Только последняя менструация';

  @override
  String get shareWhatToInclude => 'Что включить';

  @override
  String get shareWithDays => 'Менструации и ежедневные записи';

  @override
  String get shareWithDaysHint =>
      'А также заметки, оценки, настроение и выделения.';

  @override
  String get sharePeriodsOnly => 'Только менструации';

  @override
  String get sharePeriodsOnlyHint =>
      'Только когда каждая менструация началась и закончилась.';

  @override
  String get shareShowCodes => 'Показать коды';

  @override
  String get shareNothing => 'Пока нечего отправить.';

  @override
  String get shareHowToReceive =>
      'На другом телефоне откройте Ebb, перейдите в Настройки → Получить с другого телефона и наведите камеру на этот экран.';

  @override
  String shareCodeOf(int index, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      total,
      locale: localeName,
      other: 'Код $index из $total',
      many: 'Код $index из $total',
      few: 'Код $index из $total',
      one: 'Код $index из $total',
    );
    return '$_temp0';
  }

  @override
  String get sharePreviousCode => 'Предыдущий код';

  @override
  String get sharePause => 'Пауза';

  @override
  String get sharePlay => 'Продолжить';

  @override
  String get shareNextCode => 'Следующий код';

  @override
  String get shareCodesChange =>
      'Коды сменяются сами. Другой телефон собирает их в любом порядке.';

  @override
  String sharePeriodCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count менструации',
      many: '$count менструаций',
      few: '$count менструации',
      one: '$count менструация',
    );
    return '$_temp0';
  }

  @override
  String shareSummaryEverything(String periods) {
    return 'Всё в Ebb: $periods.';
  }

  @override
  String shareSummaryEverythingPeople(String periods, int people) {
    String _temp0 = intl.Intl.pluralLogic(
      people,
      locale: localeName,
      other: 'Всё в Ebb: $periods для $people человека.',
      many: 'Всё в Ebb: $periods для $people человек.',
      few: 'Всё в Ebb: $periods для $people человек.',
      one: 'Всё в Ebb: $periods для $people человека.',
    );
    return '$_temp0';
  }

  @override
  String shareSummaryHistoryAll(String who, String name, String periods) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Ваша история: $periods.',
      'other': '$name: история — $periods.',
    });
    return '$_temp0';
  }

  @override
  String shareSummaryHistoryLatest(String who, String name, String periods) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Ваша история, только последняя менструация: $periods.',
      'other': '$name: история, только последняя менструация — $periods.',
    });
    return '$_temp0';
  }

  @override
  String shareSummaryHistoryYear(String who, String name, String periods) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Ваша история за последний год: $periods.',
      'other': '$name: история за последний год — $periods.',
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
    String _temp0 = intl.Intl.pluralLogic(
      months,
      locale: localeName,
      other: 'Ваша история за последние $months месяца: $periods.',
      many: 'Ваша история за последние $months месяцев: $periods.',
      few: 'Ваша история за последние $months месяца: $periods.',
      one: 'Ваша история за последний $months месяц: $periods.',
    );
    String _temp1 = intl.Intl.pluralLogic(
      months,
      locale: localeName,
      other: '$name: история за последние $months месяца — $periods.',
      many: '$name: история за последние $months месяцев — $periods.',
      few: '$name: история за последние $months месяца — $periods.',
      one: '$name: история за последний $months месяц — $periods.',
    );
    String _temp2 = intl.Intl.selectLogic(who, {
      'you': '$_temp0',
      'other': '$_temp1',
    });
    return '$_temp2';
  }

  @override
  String shareSummaryPeriodsAll(String who, String name, String periods) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Ваши менструации: $periods.',
      'other': '$name: менструации — $periods.',
    });
    return '$_temp0';
  }

  @override
  String shareSummaryPeriodsLatest(String who, String name, String periods) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Ваши менструации, только последняя: $periods.',
      'other': '$name: менструации, только последняя — $periods.',
    });
    return '$_temp0';
  }

  @override
  String shareSummaryPeriodsYear(String who, String name, String periods) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Ваши менструации за последний год: $periods.',
      'other': '$name: менструации за последний год — $periods.',
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
    String _temp0 = intl.Intl.pluralLogic(
      months,
      locale: localeName,
      other: 'Ваши менструации за последние $months месяца: $periods.',
      many: 'Ваши менструации за последние $months месяцев: $periods.',
      few: 'Ваши менструации за последние $months месяца: $periods.',
      one: 'Ваши менструации за последний $months месяц: $periods.',
    );
    String _temp1 = intl.Intl.pluralLogic(
      months,
      locale: localeName,
      other: '$name: менструации за последние $months месяца — $periods.',
      many: '$name: менструации за последние $months месяцев — $periods.',
      few: '$name: менструации за последние $months месяца — $periods.',
      one: '$name: менструации за последний $months месяц — $periods.',
    );
    String _temp2 = intl.Intl.selectLogic(who, {
      'you': '$_temp0',
      'other': '$_temp1',
    });
    return '$_temp2';
  }

  @override
  String get shareNotEbb => 'Этот код не от Ebb.';

  @override
  String get shareNewerVersion =>
      'На другом телефоне более новая версия Ebb. Сначала обновите приложение на этом.';

  @override
  String get shareRestarted =>
      'Другой телефон начал заново. Собираем новые коды.';

  @override
  String get shareUnreadable =>
      'Некоторые коды не считались как следует. Давайте отсканируем их ещё раз.';

  @override
  String get shareNeedsCamera =>
      'Ebb нужна камера, чтобы считать коды. Разрешить доступ можно в системных настройках для Ebb.';

  @override
  String get sharePointCamera => 'Наведите камеру на код на другом телефоне.';

  @override
  String get shareReading => 'Считывание…';

  @override
  String shareCodesReceived(int received, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      total,
      locale: localeName,
      other: 'Получено кодов: $received из $total',
      many: 'Получено кодов: $received из $total',
      few: 'Получено кодов: $received из $total',
      one: 'Получено кодов: $received из $total',
    );
    return '$_temp0';
  }

  @override
  String get shareReceiveTitle => 'Получить с другого телефона';

  @override
  String shareStillNeeded(String codes) {
    return 'Ещё нужны: $codes';
  }

  @override
  String get groupsMoreThanOne => 'Здесь больше одного человека';

  @override
  String get groupsMoreThanOneBody =>
      'В этих кодах история целого телефона. Чтобы присоединиться к группе, каждый отправляет только свою: на своём телефоне — Настройки → Отправить на другой телефон → Только ваша история.';

  @override
  String groupsUpdateTitle(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Обновить вашу историю?',
      'other': 'Обновить: $name?',
    });
    return '$_temp0';
  }

  @override
  String groupsUpdateAction(String who, String name) {
    String _temp0 = intl.Intl.selectLogic(who, {
      'you': 'Обновить вашу историю',
      'other': 'Обновить: $name',
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
          'Это снова ваша история, отправлено $sent: $periods. Она заменит копию на этом телефоне.',
      'other':
          '$name: это снова та же история, отправлено $sent: $periods. Она заменит копию на этом телефоне.',
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
          'Это ваша история, отправлено $sent: $periods. Она заменит ваши данные на этом телефоне, включая всё, что было отмечено здесь с тех пор.',
      'other':
          '$name: эта история отправлена $sent: $periods. Она заменит данные этого человека на этом телефоне, включая всё, что было отмечено здесь с тех пор.',
    });
    return '$_temp0';
  }

  @override
  String groupsUpdated(String name) {
    return 'Обновлено: $name.';
  }

  @override
  String groupsImportInto(String group) {
    return 'Импорт в группу «$group»';
  }

  @override
  String groupsImportHint(String periods, String sent) {
    return '$periods, отправлено $sent. Импортируется только для чтения: здесь это нельзя изменить, а данные обновятся, когда их отправят снова.';
  }

  @override
  String groupsImported(String name, String group) {
    return 'Импортировано в группу «$group»: $name.';
  }

  @override
  String get groupsGroup => 'Группа';

  @override
  String get groupsNoMembers =>
      'В этой группе пока никого нет. Добавьте людей в Настройки → Дополнительно → Управление группами: отметьте тех, кто уже есть на этом телефоне, или добавьте кого-то с его телефона.';

  @override
  String get groupsPeriods => 'Менструации';

  @override
  String get groupsChartHint =>
      'Каждая полоса — менструация; контур — менструация, конец которой не отмечен, показана обычной длины. Сплошные линии идут вниз от каждого полнолуния, пунктирные — от каждого новолуния.';

  @override
  String get groupsNew => 'Новая группа';

  @override
  String get groupsRename => 'Переименовать группу';

  @override
  String get groupsNameHint => 'Например, название вашего круга или клуба.';

  @override
  String get groupsNameTaken => 'Группа с таким названием уже есть.';

  @override
  String get groupsNoOneYet => 'Пока никого';

  @override
  String get groupsTitle => 'Группы';

  @override
  String get groupsIntro =>
      'Группа объединяет людей на этом телефоне под одним названием — круг или клуб, которые ведут учёт вместе. Один человек может быть в нескольких группах, а удаление группы никогда никого не удаляет.';

  @override
  String groupsAddSomeoneTo(String group) {
    return 'Добавить человека в группу «$group»';
  }

  @override
  String get groupsAddSomeoneHint =>
      'Учёт на этом телефоне: вы отмечаете и меняете историю этого человека здесь. Того, кто ведёт учёт на своём телефоне, можно вместо этого импортировать.';

  @override
  String groupsTakeOutTitle(String name, String group) {
    return 'Убрать из группы «$group»: $name?';
  }

  @override
  String groupsTakeOutBody(String name) {
    return '$name: история импортирована с другого телефона и не входит ни в одну другую группу, поэтому импортированная история тоже удалится с этого телефона. Чтобы вернуться, её можно отправить снова.';
  }

  @override
  String get groupsTakeOut => 'Убрать';

  @override
  String groupsDeleteTitle(String group) {
    return 'Удалить группу «$group»?';
  }

  @override
  String get groupsDeleteBodyNone =>
      'Удалится только группа. Все её участники останутся на этом телефоне со всей своей историей.';

  @override
  String groupsDeleteBodySome(String names) {
    return 'Люди, импортированные только в эту группу, тоже удалятся с этого телефона: $names. Все остальные останутся со всей своей историей.';
  }

  @override
  String get groupsDeleteGroup => 'Удалить группу';

  @override
  String get groupsRenameTooltip => 'Переименовать';

  @override
  String get groupsWhoIsIn => 'Кто в группе';

  @override
  String groupsImportedAsOf(String date) {
    return 'Импортировано · только чтение, по состоянию на $date';
  }

  @override
  String get groupsTrackedHere => 'Учёт на этом телефоне';

  @override
  String get groupsAddTo => 'Добавить в группу';

  @override
  String get groupsAddNew => 'Добавить нового человека';

  @override
  String get groupsAddNewHint =>
      'Учёт на этом телефоне: вы отмечаете менструации этого человека здесь.';

  @override
  String get groupsImportFromPhone => 'Импорт с другого телефона';

  @override
  String get groupsImportFromPhoneHint =>
      'Человек продолжает вести учёт на своём телефоне и отправляет историю сюда, только для чтения. Повторный импорт обновляет данные.';

  @override
  String get groupsDeleteThis => 'Удалить эту группу';

  @override
  String get peopleNameTaken => 'Это имя уже используется на этом телефоне.';

  @override
  String get peopleName => 'Имя';

  @override
  String peopleSeeTogether(String group) {
    return 'Группа «$group»: все вместе';
  }

  @override
  String get peopleNotInGroup => 'Не в группе';

  @override
  String get peopleAddSomeone => 'Добавить человека';

  @override
  String get peopleTrackSomeoneElse => 'Отслеживать ещё кого-то';

  @override
  String get peopleNameHint =>
      'Просто чтобы различать людей — имя, прозвище или инициал.';

  @override
  String backupUnnamedPerson(int number) {
    return 'Человек $number';
  }

  @override
  String get backupNotEbb => 'Этот файл не является резервной копией Ebb.';

  @override
  String get backupNewer =>
      'Эта резервная копия создана более новой версией Ebb. Обновите Ebb и попробуйте снова.';

  @override
  String get backupNoOne => 'В этой резервной копии никого нет.';

  @override
  String get backupSameId =>
      'Похоже, резервная копия повреждена: у двух людей в ней одинаковый идентификатор.';

  @override
  String backupAfterExport(String date) {
    return '$date — позже дня, когда была создана эта резервная копия.';
  }

  @override
  String backupSameName(String name) {
    return 'В этой резервной копии два человека с именем $name.';
  }

  @override
  String backupSameGroupName(String group) {
    return 'В этой резервной копии две группы с названием «$group».';
  }

  @override
  String backupEndsBefore(String date) {
    return 'Менструация, начинающаяся $date, заканчивается раньше, чем начинается.';
  }

  @override
  String backupTwoStarts(String date) {
    return 'У одного человека две менструации начинаются $date.';
  }

  @override
  String backupDayTwice(String date) {
    return '$date встречается у одного человека дважды.';
  }

  @override
  String backupOverlaps(String date) {
    return 'Менструация, начинающаяся $date, пересекается с предыдущей.';
  }

  @override
  String get backupDamaged =>
      'Похоже, резервная копия повреждена: не удалось её прочитать.';

  @override
  String get backupDamagedExportDate =>
      'Похоже, резервная копия повреждена: не удалось прочитать дату экспорта.';

  @override
  String get backupDamagedGroup =>
      'Похоже, резервная копия повреждена: не удалось прочитать группу.';

  @override
  String get backupDamagedGroupName =>
      'Похоже, резервная копия повреждена: не удалось прочитать название группы.';

  @override
  String backupDamagedGroupPeople(String group) {
    return 'Похоже, резервная копия повреждена: не удалось прочитать участников группы «$group».';
  }

  @override
  String get backupDamagedPerson =>
      'Похоже, резервная копия повреждена: не удалось прочитать запись о человеке.';

  @override
  String get backupDamagedName =>
      'Похоже, резервная копия повреждена: не удалось прочитать имя.';

  @override
  String get backupDamagedPersonId =>
      'Похоже, резервная копия повреждена: не удалось прочитать идентификатор человека.';

  @override
  String get backupDamagedSharedOn =>
      'Похоже, резервная копия повреждена: не удалось прочитать день, когда история была отправлена.';

  @override
  String get backupDamagedPeriod =>
      'Похоже, резервная копия повреждена: не удалось прочитать запись о менструации.';

  @override
  String get backupDamagedPeriodStart =>
      'Похоже, резервная копия повреждена: не удалось прочитать начало менструации.';

  @override
  String get backupDamagedPeriodEnd =>
      'Похоже, резервная копия повреждена: не удалось прочитать окончание менструации.';

  @override
  String get backupDamagedDay =>
      'Похоже, резервная копия повреждена: не удалось прочитать запись о дне.';

  @override
  String backupDamagedFlow(String date) {
    return 'Похоже, резервная копия повреждена: не удалось прочитать выделения за $date.';
  }

  @override
  String backupDamagedSymptom(String date) {
    return 'Похоже, резервная копия повреждена: не удалось прочитать симптом за $date.';
  }

  @override
  String backupDamagedRating(String date) {
    return 'Похоже, резервная копия повреждена: не удалось прочитать оценку за $date.';
  }

  @override
  String backupDamagedFeeling(String date) {
    return 'Похоже, резервная копия повреждена: не удалось прочитать настроение за $date.';
  }

  @override
  String backupDamagedTemperature(String date) {
    return 'Похоже, резервная копия повреждена: не удалось прочитать температуру за $date.';
  }

  @override
  String backupDamagedMucus(String date) {
    return 'Похоже, резервная копия повреждена: не удалось прочитать цервикальную слизь за $date.';
  }
}
