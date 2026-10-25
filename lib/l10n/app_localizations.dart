import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
    Locale('pt'),
    Locale('ru'),
  ];

  /// How the phone's owner is labelled in the list of people, until they set a name.
  ///
  /// In en, this message translates to:
  /// **'You'**
  String get you;

  /// Button that dismisses a plain notice, such as the dialog saying the scanned codes hold more than one person.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// Button that closes a dialog or editor without doing anything: used in every dialog in the app.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Button that keeps what was entered: in the period editor, the calendar day's sheet and the name dialogs.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// Button in the 'Delete this cycle?' dialog that confirms deleting it.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// Button that confirms taking someone off this phone: in that person's Settings, and after sending their history to their own phone.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// Button at the foot of a day's sheet for an imported, read-only copy of someone's history, which only shows what was logged.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// Button at the foot of the Send screen, under the codes, for when the other phone has scanned them.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// Generic button label. Not used on any screen at present.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// Generic button label. Not used on any screen at present.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// Generic button label. Not used on any screen at present.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// Generic button label. Not used on any screen at present.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// A button that goes on to the next step.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueAction;

  /// Settings item to choose the language the app shows.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// The Language setting's choice to follow the phone's language rather than picking one.
  ///
  /// In en, this message translates to:
  /// **'Phone\'s language'**
  String get languagePhone;

  /// Shown under Language when following the phone. language is the language's own name, e.g. Deutsch.
  ///
  /// In en, this message translates to:
  /// **'Phone\'s language ({language})'**
  String languagePhoneIs(String language);

  /// Name of the Android notification channel, shown in the phone's notification settings.
  ///
  /// In en, this message translates to:
  /// **'Cycle reminders'**
  String get notifChannelName;

  /// Description of the Android notification channel, shown under notifChannelName in the phone's notification settings.
  ///
  /// In en, this message translates to:
  /// **'Heads-up before your period is expected, and a nudge to log it.'**
  String get notifChannelDescription;

  /// Reminder title a few days before a period is expected. who is 'you' for the phone's owner or 'other' for someone else they track; name is that person's name.
  ///
  /// In en, this message translates to:
  /// **'{who, select, you{Period expected soon} other{{name}’s period expected soon}}'**
  String notifUpcomingTitle(String who, String name);

  /// Reminder body the day before a period is expected, used when the heads-up is set to 1 day ahead. who is 'you' for the phone's owner or 'other' for someone else they track; name is that person's name.
  ///
  /// In en, this message translates to:
  /// **'{who, select, you{Ebb expects your period to start tomorrow.} other{Ebb expects {name}’s period to start tomorrow.}}'**
  String notifUpcomingTomorrow(String who, String name);

  /// days is always 2 or more.
  ///
  /// In en, this message translates to:
  /// **'{who, select, you{Ebb expects your period in about {days} days.} other{Ebb expects {name}’s period in about {days} days.}}'**
  String notifUpcomingInDays(String who, String name, int days);

  /// Reminder title on the day a period is expected. who is 'you' for the phone's owner or 'other' for someone else they track; name is that person's name.
  ///
  /// In en, this message translates to:
  /// **'{who, select, you{Period expected today} other{{name}’s period expected today}}'**
  String notifTodayTitle(String who, String name);

  /// Reminder body on the day a period is expected; tapping the notification opens Ebb.
  ///
  /// In en, this message translates to:
  /// **'Tap to log how things are going.'**
  String get notifTodayBody;

  /// Title of the calendar screen.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get calendarTitle;

  /// Screen reader only. One of the comma-separated descriptions read after a calendar day's date, e.g. 'Monday, June 10, today, period, rated 4'.
  ///
  /// In en, this message translates to:
  /// **'today'**
  String get calendarCellToday;

  /// Screen reader only, after a calendar day's date: the day is in a logged period.
  ///
  /// In en, this message translates to:
  /// **'period'**
  String get calendarCellPeriod;

  /// Screen reader only, after a calendar day's date: a period day whose end wasn't logged, so drawn as an estimate.
  ///
  /// In en, this message translates to:
  /// **'period, end not logged'**
  String get calendarCellPeriodUnlogged;

  /// Screen reader only, after a calendar day's date: the next period is likely to start around this day.
  ///
  /// In en, this message translates to:
  /// **'next period likely'**
  String get calendarCellLikely;

  /// Screen reader only, after a calendar day's date.
  ///
  /// In en, this message translates to:
  /// **'estimated fertile window'**
  String get calendarCellFertile;

  /// Screen reader only, after a calendar day's date: the moon phase that falls on that day, mid-sentence.
  ///
  /// In en, this message translates to:
  /// **'{phase, select, newMoon{new moon} firstQuarter{first quarter} full{full moon} other{last quarter}}'**
  String calendarCellMoon(String phase);

  /// Screen reader only, after a calendar day's date: how the day was rated, 1 to 5.
  ///
  /// In en, this message translates to:
  /// **'rated {rating}'**
  String calendarCellRated(int rating);

  /// Screen reader only, after a calendar day's date. feeling is the feeling's name in lower case, e.g. 'anxious'.
  ///
  /// In en, this message translates to:
  /// **'felt {feeling}'**
  String calendarCellFelt(String feeling);

  /// Screen reader only, after a calendar day's date: a note was written for the day.
  ///
  /// In en, this message translates to:
  /// **'has a note'**
  String get calendarCellNote;

  /// Key under the calendar explaining the colours: a logged period.
  ///
  /// In en, this message translates to:
  /// **'Period'**
  String get calendarKeyPeriod;

  /// Key under the calendar: an outlined band for a period whose end wasn't logged.
  ///
  /// In en, this message translates to:
  /// **'End not logged'**
  String get calendarKeyEndNotLogged;

  /// Key under the calendar: when the next period is likely to start.
  ///
  /// In en, this message translates to:
  /// **'Likely start'**
  String get calendarKeyLikely;

  /// Key under the calendar: the estimated fertile window.
  ///
  /// In en, this message translates to:
  /// **'Fertile (estimate)'**
  String get calendarKeyFertile;

  /// Key under the calendar: the circle marking today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get calendarKeyToday;

  /// On a day's sheet. who is 'you' for the phone's owner or 'other' for someone else they track; name is that person's name. from and to are short dates, e.g. 'Jun 3'.
  ///
  /// In en, this message translates to:
  /// **'{who, select, you{Your next period is likely to start between {from} and {to}.} other{{name}’s next period is likely to start between {from} and {to}.}}'**
  String calendarStatusWindow(String who, String name, String from, String to);

  /// On a day's sheet: which day of the period this is.
  ///
  /// In en, this message translates to:
  /// **'{who, select, you{Day {day} of your period.} other{Day {day} of {name}’s period.}}'**
  String calendarStatusPeriodDay(String who, String name, int day);

  /// As calendarStatusPeriodDay, for a cycle the user chose to leave out of the estimates.
  ///
  /// In en, this message translates to:
  /// **'{who, select, you{Day {day} of your period, in a cycle not counted in predictions.} other{Day {day} of {name}’s period, in a cycle not counted in predictions.}}'**
  String calendarStatusPeriodDayExcluded(String who, String name, int day);

  /// On a day's sheet: a day of a period whose end was never logged, so Ebb draws it at the usual period length. day counts from the period's first day. who is 'you' for the phone's owner or 'other' for someone else they track; name is that person's name.
  ///
  /// In en, this message translates to:
  /// **'{who, select, you{Day {day} of your cycle. The end of this period wasn’t logged, so it’s drawn at the usual length.} other{Day {day} of {name}’s cycle. The end of this period wasn’t logged, so it’s drawn at the usual length.}}'**
  String calendarStatusUnlogged(String who, String name, int day);

  /// On a day's sheet: the day falls in the estimated fertile window. Keep the caution: the estimate is from cycle timing alone and must never read as reliable contraception.
  ///
  /// In en, this message translates to:
  /// **'In the estimated fertile window. Not reliable enough to use as contraception.'**
  String get calendarStatusFertile;

  /// On a day's sheet: which day of the cycle this is, counted from the period's first day.
  ///
  /// In en, this message translates to:
  /// **'{who, select, you{Day {day} of your cycle.} other{Day {day} of {name}’s cycle.}}'**
  String calendarStatusCycleDay(String who, String name, int day);

  /// Heading of the day sheet when the day is today. date is e.g. 'Monday, June 10'.
  ///
  /// In en, this message translates to:
  /// **'Today, {date}'**
  String calendarDayToday(String date);

  /// Tooltip of the arrow on a day's sheet that moves to the day before.
  ///
  /// In en, this message translates to:
  /// **'Previous day'**
  String get calendarPreviousDay;

  /// Tooltip of the arrow on a day's sheet that moves to the day after.
  ///
  /// In en, this message translates to:
  /// **'Next day'**
  String get calendarNextDay;

  /// On a day's sheet: the moon phase and the time it happens, e.g. 'Full moon, 3:14 PM'.
  ///
  /// In en, this message translates to:
  /// **'{phase}, {time}'**
  String calendarMoonAt(String phase, String time);

  /// On a day's sheet for a day after today, in place of the logging controls.
  ///
  /// In en, this message translates to:
  /// **'Days still to come can’t be logged yet.'**
  String get calendarFutureDay;

  /// A button on a day's sheet. Worded as something to do, not a fact about the day.
  ///
  /// In en, this message translates to:
  /// **'{who, select, you{Mark as the day your period started} other{Mark as the day {name}’s period started}}'**
  String calendarMarkStarted(String who, String name);

  /// A button on a day's sheet just before a period: moves that period's start back to this day.
  ///
  /// In en, this message translates to:
  /// **'Make this the first day of the period'**
  String get calendarMoveStart;

  /// Under calendarMoveStart. date is the period's current first day, e.g. 'Tue, Jun 11'.
  ///
  /// In en, this message translates to:
  /// **'Moves its start from {date}'**
  String calendarMoveStartFrom(String date);

  /// A button on a day's sheet. Worded as something to do, not a fact about the day.
  ///
  /// In en, this message translates to:
  /// **'{who, select, you{Mark as the day your period ended} other{Mark as the day {name}’s period ended}}'**
  String calendarMarkEnded(String who, String name);

  /// A button on a day's sheet: moves an already-logged period end to this day.
  ///
  /// In en, this message translates to:
  /// **'Make this the last day of the period'**
  String get calendarMakeLastDay;

  /// Button on a day's sheet, on a period day: opens the editor for that period.
  ///
  /// In en, this message translates to:
  /// **'Edit this period'**
  String get calendarEditPeriod;

  /// Heading above five buttons to rate the day from 1 to 5.
  ///
  /// In en, this message translates to:
  /// **'{who, select, you{Rate your day, 1–5} other{Rate {name}’s day, 1–5}}'**
  String calendarRateDay(String who, String name);

  /// Heading above a row of feeling faces to choose from.
  ///
  /// In en, this message translates to:
  /// **'{who, select, you{How did you feel?} other{How did {name} feel?}}'**
  String calendarHowFelt(String who, String name);

  /// Heading above the choices for how heavy the bleeding was.
  ///
  /// In en, this message translates to:
  /// **'Flow'**
  String get calendarFlow;

  /// Label of the text field for a note about the day.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get calendarNote;

  /// Heading of the waking temperature field. unit is °C or °F.
  ///
  /// In en, this message translates to:
  /// **'Temperature, {unit}'**
  String calendarTemperatureHeading(String unit);

  /// Error under the temperature field. low and high are numbers like 34.00; unit is °C or °F.
  ///
  /// In en, this message translates to:
  /// **'Enter a temperature from {low} to {high} {unit}'**
  String calendarTemperatureRange(String low, String high, String unit);

  /// Hint under the temperature field: when to take it.
  ///
  /// In en, this message translates to:
  /// **'On waking, before getting up'**
  String get calendarTemperatureHelper;

  /// Checkbox: the temperature reading may be off.
  ///
  /// In en, this message translates to:
  /// **'Something may have affected it'**
  String get calendarTemperatureAffected;

  /// Examples under calendarTemperatureAffected.
  ///
  /// In en, this message translates to:
  /// **'Illness, little sleep, alcohol, taken late'**
  String get calendarTemperatureAffectedHint;

  /// Heading on a day's sheet above the cervical mucus choices ('How it felt', 'How it looked'). Use the usual term in the language, as a doctor or a fertility-awareness guide would.
  ///
  /// In en, this message translates to:
  /// **'Cervical mucus'**
  String get calendarMucus;

  /// Above the choices for how cervical mucus felt (dry, wet…).
  ///
  /// In en, this message translates to:
  /// **'How it felt'**
  String get calendarMucusFelt;

  /// Above the choices for how cervical mucus looked (creamy, egg white…).
  ///
  /// In en, this message translates to:
  /// **'How it looked'**
  String get calendarMucusLooked;

  /// A shared copy's day, read-only. ratingName is the rating's name in lower case, e.g. 'good'.
  ///
  /// In en, this message translates to:
  /// **'Rated {rating} of 5, {ratingName}'**
  String calendarLoggedRated(int rating, String ratingName);

  /// A shared copy's day, read-only. emoji is the face chosen; feeling its name in lower case.
  ///
  /// In en, this message translates to:
  /// **'Felt {emoji} {feeling}'**
  String calendarLoggedFelt(String emoji, String feeling);

  /// A shared copy's day, read-only: how heavy the bleeding was.
  ///
  /// In en, this message translates to:
  /// **'{flow, select, spotting{Flow: spotting} light{Flow: light} medium{Flow: medium} other{Flow: heavy}}'**
  String calendarLoggedFlow(String flow);

  /// A shared copy's day, read-only. temperature is e.g. '36.45 °C'.
  ///
  /// In en, this message translates to:
  /// **'Temperature: {temperature}'**
  String calendarLoggedTemperature(String temperature);

  /// As calendarLoggedTemperature, when something may have thrown the reading off.
  ///
  /// In en, this message translates to:
  /// **'Temperature: {temperature}, may have been affected'**
  String calendarLoggedTemperatureAffected(String temperature);

  /// A shared copy's day, read-only. mucus is how it felt and/or looked, from dayMucusFeelInline and dayMucusLookInline, joined by a comma.
  ///
  /// In en, this message translates to:
  /// **'Cervical mucus: {mucus}'**
  String calendarLoggedMucus(String mucus);

  /// A shared copy's day, read-only: the note written that day, in this language's quotation marks.
  ///
  /// In en, this message translates to:
  /// **'“{note}”'**
  String calendarLoggedNote(String note);

  /// On a day's sheet for an imported, read-only copy of someone's history: no entry was made for that day.
  ///
  /// In en, this message translates to:
  /// **'Nothing logged this day.'**
  String get calendarNothingLogged;

  /// The moon phase, on a day's sheet beside the time it happens and wherever phases are named.
  ///
  /// In en, this message translates to:
  /// **'New moon'**
  String get calendarMoonNew;

  /// The moon phase.
  ///
  /// In en, this message translates to:
  /// **'First quarter'**
  String get calendarMoonFirstQuarter;

  /// The moon phase, on a day's sheet beside the time it happens and wherever phases are named.
  ///
  /// In en, this message translates to:
  /// **'Full moon'**
  String get calendarMoonFull;

  /// The moon phase.
  ///
  /// In en, this message translates to:
  /// **'Last quarter'**
  String get calendarMoonLastQuarter;

  /// Bleeding on a day: none.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get dayFlowNone;

  /// Bleeding on a day, lightest to heaviest: spotting, light, medium, heavy. Short: four share one row of chips.
  ///
  /// In en, this message translates to:
  /// **'Spotting'**
  String get dayFlowSpotting;

  /// Bleeding on a day. Short: four share one row of chips.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get dayFlowLight;

  /// Bleeding on a day. Short: four share one row of chips.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get dayFlowMedium;

  /// Bleeding on a day. Short: four share one row of chips.
  ///
  /// In en, this message translates to:
  /// **'Heavy'**
  String get dayFlowHeavy;

  /// A chip under 'How it felt' or 'How it looked': no cervical mucus felt or seen. Short: chips share one row.
  ///
  /// In en, this message translates to:
  /// **'Nothing'**
  String get dayMucusNothing;

  /// How cervical mucus felt. Short: four chips share one row.
  ///
  /// In en, this message translates to:
  /// **'Dry'**
  String get dayMucusFeelDry;

  /// How cervical mucus felt. Short: four chips share one row.
  ///
  /// In en, this message translates to:
  /// **'Wet'**
  String get dayMucusFeelWet;

  /// How cervical mucus felt. Short: four chips share one row.
  ///
  /// In en, this message translates to:
  /// **'Slippery'**
  String get dayMucusFeelSlippery;

  /// How cervical mucus looked. Short: three chips share one row.
  ///
  /// In en, this message translates to:
  /// **'Creamy'**
  String get dayMucusLookCreamy;

  /// How cervical mucus looked: clear and stretchy, like raw egg white. Short: three chips share one row.
  ///
  /// In en, this message translates to:
  /// **'Egg white'**
  String get dayMucusLookEggWhite;

  /// How cervical mucus felt, mid-sentence after 'Cervical mucus:'.
  ///
  /// In en, this message translates to:
  /// **'{feel, select, dry{dry} nothing{nothing felt} wet{wet} other{slippery}}'**
  String dayMucusFeelInline(String feel);

  /// How cervical mucus looked, mid-sentence after 'Cervical mucus:'.
  ///
  /// In en, this message translates to:
  /// **'{look, select, nothing{nothing seen} creamy{creamy} other{egg white}}'**
  String dayMucusLookInline(String look);

  /// A named feeling, shown with a face. Each is a kind of feeling, not a score.
  ///
  /// In en, this message translates to:
  /// **'Happy'**
  String get dayFeelingHappy;

  /// A named feeling, shown with its face on the calendar day's 'How did you feel?' row and counted in the feelings chart. A kind of feeling, not a score.
  ///
  /// In en, this message translates to:
  /// **'Calm'**
  String get dayFeelingCalm;

  /// A named feeling, shown with its face on the calendar day's 'How did you feel?' row and counted in the feelings chart. A kind of feeling, not a score.
  ///
  /// In en, this message translates to:
  /// **'Loving'**
  String get dayFeelingLoving;

  /// A named feeling, shown with its face on the calendar day's 'How did you feel?' row and counted in the feelings chart. A kind of feeling, not a score.
  ///
  /// In en, this message translates to:
  /// **'Energetic'**
  String get dayFeelingEnergetic;

  /// A named feeling, shown with its face on the calendar day's 'How did you feel?' row and counted in the feelings chart. A kind of feeling, not a score.
  ///
  /// In en, this message translates to:
  /// **'Tired'**
  String get dayFeelingTired;

  /// A named feeling, shown with its face on the calendar day's 'How did you feel?' row and counted in the feelings chart. A kind of feeling, not a score.
  ///
  /// In en, this message translates to:
  /// **'Sad'**
  String get dayFeelingSad;

  /// A named feeling, shown with its face on the calendar day's 'How did you feel?' row and counted in the feelings chart. A kind of feeling, not a score.
  ///
  /// In en, this message translates to:
  /// **'Anxious'**
  String get dayFeelingAnxious;

  /// A named feeling, shown with its face on the calendar day's 'How did you feel?' row and counted in the feelings chart. A kind of feeling, not a score. Irritable: easily annoyed.
  ///
  /// In en, this message translates to:
  /// **'Irritable'**
  String get dayFeelingIrritable;

  /// A named feeling, shown with its face on the calendar day's 'How did you feel?' row and counted in the feelings chart. A kind of feeling, not a score.
  ///
  /// In en, this message translates to:
  /// **'Angry'**
  String get dayFeelingAngry;

  /// A named feeling, shown with its face on the calendar day's 'How did you feel?' row and counted in the feelings chart. A kind of feeling, not a score.
  ///
  /// In en, this message translates to:
  /// **'Confused'**
  String get dayFeelingConfused;

  /// Title of the charts screen.
  ///
  /// In en, this message translates to:
  /// **'Charts'**
  String get chartsTitle;

  /// Heading of the chart of how each day went, rated 1 to 5.
  ///
  /// In en, this message translates to:
  /// **'Day rating'**
  String get chartsDayRating;

  /// In the day-rating section of the Charts screen, when no day in the chosen date range has a rating.
  ///
  /// In en, this message translates to:
  /// **'No days in this range have a rating yet.'**
  String get chartsNoRatings;

  /// Toggle: draw the day ratings as a bar chart.
  ///
  /// In en, this message translates to:
  /// **'Bars'**
  String get chartsBars;

  /// Toggle: draw the day ratings as a line chart.
  ///
  /// In en, this message translates to:
  /// **'Line'**
  String get chartsLine;

  /// Caption under the day-rating chart when it is drawn as bars.
  ///
  /// In en, this message translates to:
  /// **'Each bar is one day’s rating, 1 to 5. Period days are shaded.'**
  String get chartsRatingCaptionBars;

  /// Caption under the day-rating chart when it is drawn as a line.
  ///
  /// In en, this message translates to:
  /// **'Each point is one day’s rating, joined to the next day’s when both were rated, 1 to 5. Period days are shaded.'**
  String get chartsRatingCaptionLine;

  /// Added after the rating chart's caption when moon phases are shown.
  ///
  /// In en, this message translates to:
  /// **'Moons mark the moon’s phases; over a long range, only the new and full moons, or just the full ones.'**
  String get chartsRatingCaptionMoon;

  /// Heading of the chart of waking (basal body) temperature and cervical mucus.
  ///
  /// In en, this message translates to:
  /// **'Temperature and cervical mucus'**
  String get chartsTemperatureTitle;

  /// In the temperature section of the Charts screen, when no temperature or cervical mucus was logged in the chosen range.
  ///
  /// In en, this message translates to:
  /// **'Nothing logged in this range yet. Tap a day on the calendar to add a temperature or cervical mucus.'**
  String get chartsTemperatureEmpty;

  /// unit is °C or °F. 'Affected' means the person ticked that something, such as illness or little sleep, may have thrown the reading off. 'Felt' and 'looked' are the two rows of mucus bars.
  ///
  /// In en, this message translates to:
  /// **'Each point is one day’s temperature, in {unit}, joined to the next day’s when both were taken. A hollow point may have been affected, and isn’t joined. Below, cervical mucus: taller bars are wetter (felt) and clearer and stretchier (looked). Period days are shaded.'**
  String chartsTemperatureCaption(String unit);

  /// Heading of the section counting which feelings (faces) were picked on which days.
  ///
  /// In en, this message translates to:
  /// **'Feelings'**
  String get chartsFeelings;

  /// Toggle: group feelings by where the day fell in the cycle.
  ///
  /// In en, this message translates to:
  /// **'Around periods'**
  String get chartsAroundPeriods;

  /// Toggle: group feelings by the moon's phase.
  ///
  /// In en, this message translates to:
  /// **'Around the moon'**
  String get chartsAroundMoon;

  /// In the feelings section of the Charts screen, grouped around the moon, when no day in the range has a feeling yet.
  ///
  /// In en, this message translates to:
  /// **'Once you’ve picked how you felt on some days in this range, this shows which feelings came around full and new moons.'**
  String get chartsFeelingsEmptyMoon;

  /// In the feelings section, grouped around periods, when there is nothing to count yet: no feelings picked, or none before a period that has started since.
  ///
  /// In en, this message translates to:
  /// **'Once you’ve picked how you felt on some days in this range, and a period has started since, this shows which feelings came when.'**
  String get chartsFeelingsEmptyPeriods;

  /// Caption under the feelings chart when it is grouped around the moon.
  ///
  /// In en, this message translates to:
  /// **'How many days each face was picked.'**
  String get chartsFeelingsCaptionMoon;

  /// Caption under the feelings chart when it is grouped around periods. Days after the latest period started wait until the next period shows where they fall.
  ///
  /// In en, this message translates to:
  /// **'How many days each face was picked. Days since the latest period started aren’t counted until the next one does.'**
  String get chartsFeelingsCaptionPeriods;

  /// Under a feelings group that has no feelings picked.
  ///
  /// In en, this message translates to:
  /// **'None yet.'**
  String get chartsNoneYet;

  /// A group of days in the feelings chart.
  ///
  /// In en, this message translates to:
  /// **'During a period'**
  String get chartsGroupDuringPeriod;

  /// A group of days in the feelings chart.
  ///
  /// In en, this message translates to:
  /// **'Just before a period'**
  String get chartsGroupBeforePeriod;

  /// A group of days in the feelings chart: days in none of the other groups.
  ///
  /// In en, this message translates to:
  /// **'Other days'**
  String get chartsGroupOtherDays;

  /// A group of days in the feelings chart.
  ///
  /// In en, this message translates to:
  /// **'Around a full moon'**
  String get chartsGroupFullMoon;

  /// A group of days in the feelings chart.
  ///
  /// In en, this message translates to:
  /// **'Around a new moon'**
  String get chartsGroupNewMoon;

  /// Shown in brackets after 'During a period', saying which days it covers.
  ///
  /// In en, this message translates to:
  /// **'logged period days'**
  String get chartsDetailLoggedPeriodDays;

  /// Shown in brackets after 'During a period': how long a period usually lasts.
  ///
  /// In en, this message translates to:
  /// **'{days, plural, =1{usually 1 day} other{usually {days} days}}'**
  String chartsDetailUsuallyDays(int days);

  /// Shown in brackets after 'Just before a period'.
  ///
  /// In en, this message translates to:
  /// **'{days, plural, =1{the day before} other{the {days} days before}}'**
  String chartsDetailDaysBefore(int days);

  /// Shown in brackets after 'Other days', when grouping around periods.
  ///
  /// In en, this message translates to:
  /// **'the rest of the cycle'**
  String get chartsDetailRestOfCycle;

  /// Shown in brackets after 'Around a full moon': only the day of the phase.
  ///
  /// In en, this message translates to:
  /// **'the day itself'**
  String get chartsDetailDayItself;

  /// Shown in brackets after 'Around a full moon': the day of the phase and this many days either side.
  ///
  /// In en, this message translates to:
  /// **'{days, plural, =1{the day, ±1 day} other{the day, ±{days} days}}'**
  String chartsDetailDayEitherSide(int days);

  /// Shown in brackets after 'Other days', when grouping around the moon.
  ///
  /// In en, this message translates to:
  /// **'the rest of the month'**
  String get chartsDetailRestOfMonth;

  /// For screen readers: a feeling and on how many days it was picked, e.g. 'Tired on 3 days'.
  ///
  /// In en, this message translates to:
  /// **'{feeling} on {count, plural, =1{1 day} other{{count} days}}'**
  String chartsFeelingCount(String feeling, int count);

  /// For screen readers, one feelings group: e.g. 'Just before a period, the 5 days before: Tired on 3 days, Sad on 1 day'.
  ///
  /// In en, this message translates to:
  /// **'{group}, {detail}: {counts}'**
  String chartsFeelingGroupSummary(String group, String detail, String counts);

  /// For screen readers, after a feelings group with no feelings picked.
  ///
  /// In en, this message translates to:
  /// **'none yet'**
  String get chartsFeelingGroupNone;

  /// For screen readers, describing the rating chart. from and to are dates.
  ///
  /// In en, this message translates to:
  /// **'Day ratings from {from} to {to}: {count, plural, =1{1 rated day} other{{count} rated days}}, with period days shaded.'**
  String chartsRatingSummary(String from, String to, int count);

  /// For screen readers, describing the rating chart with moon phases. from and to are dates.
  ///
  /// In en, this message translates to:
  /// **'Day ratings from {from} to {to}: {count, plural, =1{1 rated day} other{{count} rated days}}, with period days shaded and moon phases marked.'**
  String chartsRatingSummaryMoons(String from, String to, int count);

  /// For screen readers, describing a chart of several people's periods side by side. lanes is each person's line, joined with '. '.
  ///
  /// In en, this message translates to:
  /// **'Periods from {from} to {to}. {lanes}.'**
  String chartsLanesSummary(String from, String to, String lanes);

  /// For screen readers, one person's line in the periods chart. periods is a list of date ranges joined with '; '.
  ///
  /// In en, this message translates to:
  /// **'{name}: {periods}'**
  String chartsLane(String name, String periods);

  /// For screen readers: a person with no period days in the chart's range.
  ///
  /// In en, this message translates to:
  /// **'no period days'**
  String get chartsLaneNone;

  /// A period's date range, for screen readers.
  ///
  /// In en, this message translates to:
  /// **'{from} to {to}'**
  String chartsLaneRun(String from, String to);

  /// An estimated period's date range, for screen readers.
  ///
  /// In en, this message translates to:
  /// **'{from} to {to}, estimated'**
  String chartsLaneRunEstimated(String from, String to);

  /// For screen readers, describing the temperature chart. range is either 'no temperatures' or the count and lowest and highest reading.
  ///
  /// In en, this message translates to:
  /// **'Temperatures from {from} to {to}: {range}, cervical mucus noted on {mucusDays, plural, =1{1 day} other{{mucusDays} days}}, with period days shaded.'**
  String chartsTemperatureSummary(
    String from,
    String to,
    String range,
    int mucusDays,
  );

  /// For screen readers, within the temperature chart's description.
  ///
  /// In en, this message translates to:
  /// **'no temperatures'**
  String get chartsNoTemperatures;

  /// For screen readers, within the temperature chart's description. low and high include the unit, e.g. 36.4 °C.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 temperature} other{{count} temperatures}}, from {low} to {high}'**
  String chartsTemperatureRange(int count, String low, String high);

  /// Short label on the chart's row for how cervical mucus felt (dry to wet). Very little room.
  ///
  /// In en, this message translates to:
  /// **'Felt'**
  String get chartsMucusFelt;

  /// Short label on the chart's row for how cervical mucus looked. Very little room.
  ///
  /// In en, this message translates to:
  /// **'Looked'**
  String get chartsMucusLooked;

  /// Day rating 1 of 5, the worst. Shown at the low end of the rating picker.
  ///
  /// In en, this message translates to:
  /// **'Rough'**
  String get faceRatingRough;

  /// Day rating 2 of 5.
  ///
  /// In en, this message translates to:
  /// **'Not great'**
  String get faceRatingNotGreat;

  /// Day rating 3 of 5.
  ///
  /// In en, this message translates to:
  /// **'Okay'**
  String get faceRatingOkay;

  /// Day rating 4 of 5.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get faceRatingGood;

  /// Day rating 5 of 5, the best. Shown at the high end of the rating picker.
  ///
  /// In en, this message translates to:
  /// **'Great'**
  String get faceRatingGreat;

  /// Day rating 1 of 5, as it reads mid-sentence for a screen reader, e.g. '1, rough'.
  ///
  /// In en, this message translates to:
  /// **'rough'**
  String get faceRatingRoughInline;

  /// Day rating 2 of 5, mid-sentence.
  ///
  /// In en, this message translates to:
  /// **'not great'**
  String get faceRatingNotGreatInline;

  /// Day rating 3 of 5, mid-sentence.
  ///
  /// In en, this message translates to:
  /// **'okay'**
  String get faceRatingOkayInline;

  /// Day rating 4 of 5, mid-sentence.
  ///
  /// In en, this message translates to:
  /// **'good'**
  String get faceRatingGoodInline;

  /// Day rating 5 of 5, mid-sentence.
  ///
  /// In en, this message translates to:
  /// **'great'**
  String get faceRatingGreatInline;

  /// For screen readers, a button in the rating picker: e.g. '2, not great'.
  ///
  /// In en, this message translates to:
  /// **'{rating}, {name}'**
  String faceRatingOption(int rating, String name);

  /// Button and dialog title: pick a face beyond the named feelings.
  ///
  /// In en, this message translates to:
  /// **'More faces'**
  String get faceMoreFaces;

  /// Button: pick another face instead of the one chosen.
  ///
  /// In en, this message translates to:
  /// **'A different face'**
  String get faceDifferentFace;

  /// For screen readers: a face with no name.
  ///
  /// In en, this message translates to:
  /// **'Other face'**
  String get faceOther;

  /// Screen-reader name of an emoji face someone can pick for how they felt.
  ///
  /// In en, this message translates to:
  /// **'Smiling cat'**
  String get faceSmilingCat;

  /// Screen-reader name of the 😸 emoji face, in the 'More faces' dialog, which someone can pick for how they felt.
  ///
  /// In en, this message translates to:
  /// **'Grinning cat'**
  String get faceGrinningCat;

  /// Screen-reader name of the 😹 emoji face, in the 'More faces' dialog, which someone can pick for how they felt.
  ///
  /// In en, this message translates to:
  /// **'Cat with tears of joy'**
  String get faceCatTearsOfJoy;

  /// Screen-reader name of the 😻 emoji face, in the 'More faces' dialog, which someone can pick for how they felt.
  ///
  /// In en, this message translates to:
  /// **'Cat with heart eyes'**
  String get faceCatHeartEyes;

  /// Screen-reader name of the 😼 emoji face, in the 'More faces' dialog, which someone can pick for how they felt.
  ///
  /// In en, this message translates to:
  /// **'Smirking cat'**
  String get faceSmirkingCat;

  /// Screen-reader name of the 😽 emoji face, in the 'More faces' dialog, which someone can pick for how they felt.
  ///
  /// In en, this message translates to:
  /// **'Kissing cat'**
  String get faceKissingCat;

  /// Screen-reader name of the 🙀 emoji face, in the 'More faces' dialog, which someone can pick for how they felt.
  ///
  /// In en, this message translates to:
  /// **'Weary cat'**
  String get faceWearyCat;

  /// Screen-reader name of the 😿 emoji face, in the 'More faces' dialog, which someone can pick for how they felt.
  ///
  /// In en, this message translates to:
  /// **'Crying cat'**
  String get faceCryingCat;

  /// Screen-reader name of the 😾 emoji face, in the 'More faces' dialog, which someone can pick for how they felt.
  ///
  /// In en, this message translates to:
  /// **'Pouting cat'**
  String get facePoutingCat;

  /// Screen-reader name of the 👽 emoji face, in the 'More faces' dialog, which someone can pick for how they felt.
  ///
  /// In en, this message translates to:
  /// **'Alien'**
  String get faceAlien;

  /// Screen-reader name of the 👾 emoji face, in the 'More faces' dialog, which someone can pick for how they felt.
  ///
  /// In en, this message translates to:
  /// **'Space invader'**
  String get faceSpaceInvader;

  /// Screen-reader name of the 🤖 emoji face, in the 'More faces' dialog, which someone can pick for how they felt.
  ///
  /// In en, this message translates to:
  /// **'Robot'**
  String get faceRobot;

  /// Screen-reader name of the 👻 emoji face, in the 'More faces' dialog, which someone can pick for how they felt.
  ///
  /// In en, this message translates to:
  /// **'Ghost'**
  String get faceGhost;

  /// Screen-reader name of the 💀 emoji face, in the 'More faces' dialog, which someone can pick for how they felt.
  ///
  /// In en, this message translates to:
  /// **'Skull'**
  String get faceSkull;

  /// Screen-reader name of the 🤡 emoji face, in the 'More faces' dialog, which someone can pick for how they felt.
  ///
  /// In en, this message translates to:
  /// **'Clown'**
  String get faceClown;

  /// Screen-reader name of the 😈 emoji face, in the 'More faces' dialog, which someone can pick for how they felt.
  ///
  /// In en, this message translates to:
  /// **'Devil'**
  String get faceDevil;

  /// Screen-reader name of the 🦄 emoji face, in the 'More faces' dialog, which someone can pick for how they felt.
  ///
  /// In en, this message translates to:
  /// **'Unicorn'**
  String get faceUnicorn;

  /// Screen-reader name of the 🐸 emoji face, in the 'More faces' dialog, which someone can pick for how they felt.
  ///
  /// In en, this message translates to:
  /// **'Frog'**
  String get faceFrog;

  /// Screen-reader name of the 🥳 emoji face, in the 'More faces' dialog, which someone can pick for how they felt.
  ///
  /// In en, this message translates to:
  /// **'Partying'**
  String get facePartying;

  /// Screen-reader name of the 😎 emoji face, in the 'More faces' dialog, which someone can pick for how they felt.
  ///
  /// In en, this message translates to:
  /// **'Cool'**
  String get faceCool;

  /// Screen-reader name of the 🤓 emoji face, in the 'More faces' dialog, which someone can pick for how they felt.
  ///
  /// In en, this message translates to:
  /// **'Nerdy'**
  String get faceNerdy;

  /// Screen-reader name of the 😇 emoji face, in the 'More faces' dialog, which someone can pick for how they felt.
  ///
  /// In en, this message translates to:
  /// **'Angelic'**
  String get faceAngelic;

  /// Screen-reader name of the 🤗 emoji face, in the 'More faces' dialog, which someone can pick for how they felt.
  ///
  /// In en, this message translates to:
  /// **'Hugging'**
  String get faceHugging;

  /// Screen-reader name of the 🤪 emoji face, in the 'More faces' dialog, which someone can pick for how they felt.
  ///
  /// In en, this message translates to:
  /// **'Silly'**
  String get faceSilly;

  /// Screen-reader name of the 🙃 emoji face, in the 'More faces' dialog, which someone can pick for how they felt.
  ///
  /// In en, this message translates to:
  /// **'Upside down'**
  String get faceUpsideDown;

  /// Screen-reader name of the 😏 emoji face, in the 'More faces' dialog, which someone can pick for how they felt.
  ///
  /// In en, this message translates to:
  /// **'Smirking'**
  String get faceSmirking;

  /// Screen-reader name of the 😬 emoji face, in the 'More faces' dialog, which someone can pick for how they felt.
  ///
  /// In en, this message translates to:
  /// **'Grimacing'**
  String get faceGrimacing;

  /// Screen-reader name of the 🙄 emoji face, in the 'More faces' dialog, which someone can pick for how they felt.
  ///
  /// In en, this message translates to:
  /// **'Eye roll'**
  String get faceEyeRoll;

  /// Screen-reader name of the 😶 emoji face, in the 'More faces' dialog, which someone can pick for how they felt.
  ///
  /// In en, this message translates to:
  /// **'Speechless'**
  String get faceSpeechless;

  /// Screen-reader name of the 🥺 emoji face, in the 'More faces' dialog, which someone can pick for how they felt.
  ///
  /// In en, this message translates to:
  /// **'Pleading'**
  String get facePleading;

  /// Screen-reader name of the 😭 emoji face, in the 'More faces' dialog, which someone can pick for how they felt.
  ///
  /// In en, this message translates to:
  /// **'Sobbing'**
  String get faceSobbing;

  /// Screen-reader name of the 😱 emoji face, in the 'More faces' dialog, which someone can pick for how they felt.
  ///
  /// In en, this message translates to:
  /// **'Screaming'**
  String get faceScreaming;

  /// Screen-reader name of the 😳 emoji face, in the 'More faces' dialog, which someone can pick for how they felt.
  ///
  /// In en, this message translates to:
  /// **'Flushed'**
  String get faceFlushed;

  /// Screen-reader name of the 🤯 emoji face, in the 'More faces' dialog, which someone can pick for how they felt.
  ///
  /// In en, this message translates to:
  /// **'Overwhelmed'**
  String get faceOverwhelmed;

  /// Screen-reader name of the 🥴 emoji face, in the 'More faces' dialog, which someone can pick for how they felt.
  ///
  /// In en, this message translates to:
  /// **'Woozy'**
  String get faceWoozy;

  /// Screen-reader name of the 🤒 emoji face, in the 'More faces' dialog, which someone can pick for how they felt.
  ///
  /// In en, this message translates to:
  /// **'Unwell'**
  String get faceUnwell;

  /// Screen-reader name of the 🤕 emoji face, in the 'More faces' dialog, which someone can pick for how they felt.
  ///
  /// In en, this message translates to:
  /// **'Hurting'**
  String get faceHurting;

  /// Screen-reader name of the 🤢 emoji face, in the 'More faces' dialog, which someone can pick for how they felt.
  ///
  /// In en, this message translates to:
  /// **'Queasy'**
  String get faceQueasy;

  /// Screen-reader name of the 🥵 emoji face, in the 'More faces' dialog, which someone can pick for how they felt.
  ///
  /// In en, this message translates to:
  /// **'Too hot'**
  String get faceTooHot;

  /// Screen-reader name of the 🥶 emoji face, in the 'More faces' dialog, which someone can pick for how they felt.
  ///
  /// In en, this message translates to:
  /// **'Too cold'**
  String get faceTooCold;

  /// Screen-reader name of the 💖 emoji face, in the 'More faces' dialog, which someone can pick for how they felt.
  ///
  /// In en, this message translates to:
  /// **'Sparkling heart'**
  String get faceSparklingHeart;

  /// Screen-reader name of the 💔 emoji face, in the 'More faces' dialog, which someone can pick for how they felt.
  ///
  /// In en, this message translates to:
  /// **'Broken heart'**
  String get faceBrokenHeart;

  /// Screen-reader name of the 🔥 emoji face, in the 'More faces' dialog, which someone can pick for how they felt.
  ///
  /// In en, this message translates to:
  /// **'Fire'**
  String get faceFire;

  /// Screen-reader name of the 🌈 emoji face, in the 'More faces' dialog, which someone can pick for how they felt.
  ///
  /// In en, this message translates to:
  /// **'Rainbow'**
  String get faceRainbow;

  /// Screen-reader name of the ☀️ emoji face, in the 'More faces' dialog, which someone can pick for how they felt.
  ///
  /// In en, this message translates to:
  /// **'Sun'**
  String get faceSun;

  /// Screen-reader name of the 🌧️ emoji face, in the 'More faces' dialog, which someone can pick for how they felt.
  ///
  /// In en, this message translates to:
  /// **'Rain'**
  String get faceRain;

  /// Screen-reader name of the ⛈️ emoji face, in the 'More faces' dialog, which someone can pick for how they felt.
  ///
  /// In en, this message translates to:
  /// **'Storm'**
  String get faceStorm;

  /// Screen-reader name of the 🌸 emoji face, in the 'More faces' dialog, which someone can pick for how they felt.
  ///
  /// In en, this message translates to:
  /// **'Blossom'**
  String get faceBlossom;

  /// Screen-reader name of the 🍫 emoji face, in the 'More faces' dialog, which someone can pick for how they felt.
  ///
  /// In en, this message translates to:
  /// **'Chocolate'**
  String get faceChocolate;

  /// Screen-reader name of the 🛌 emoji face, in the 'More faces' dialog, which someone can pick for how they felt.
  ///
  /// In en, this message translates to:
  /// **'In bed'**
  String get faceInBed;

  /// Button and screen title: the calendar of logged days.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get homeCalendar;

  /// Button and screen title: the list of every recorded cycle.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get homeHistory;

  /// Tooltip and menu item on the home screen that opens the charts screen.
  ///
  /// In en, this message translates to:
  /// **'Charts'**
  String get homeCharts;

  /// Tooltip of the home screen button that opens Settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get homeSettings;

  /// Calendar screen title when more than one person is tracked. who is 'you' for the phone's owner or 'other' for someone else they track; name is that person's name.
  ///
  /// In en, this message translates to:
  /// **'{who, select, you{Your calendar} other{{name}’s calendar}}'**
  String homeCalendarOf(String who, String name);

  /// who is 'you' for the phone's owner or 'other' for someone else they track; name is that person's name.
  ///
  /// In en, this message translates to:
  /// **'{who, select, you{Your history} other{{name}’s history}}'**
  String homeHistoryOf(String who, String name);

  /// who is 'you' for the phone's owner or 'other' for someone else they track; name is that person's name.
  ///
  /// In en, this message translates to:
  /// **'{who, select, you{Your charts} other{{name}’s charts}}'**
  String homeChartsOf(String who, String name);

  /// Date picker title: when the period started.
  ///
  /// In en, this message translates to:
  /// **'When did it start?'**
  String get homeWhenStarted;

  /// Date picker title: when the period ended.
  ///
  /// In en, this message translates to:
  /// **'When did it end?'**
  String get homeWhenEnded;

  /// Main button, in first person for the owner, as if she is saying it. who is 'you' for the phone's owner or 'other' for someone else they track; name is that person's name.
  ///
  /// In en, this message translates to:
  /// **'{who, select, you{My period ended today} other{{name}’s period ended today}}'**
  String homePeriodEndedToday(String who, String name);

  /// Main button, in first person for the owner, as if she is saying it. who is 'you' for the phone's owner or 'other' for someone else they track; name is that person's name.
  ///
  /// In en, this message translates to:
  /// **'{who, select, you{My period started today} other{{name}’s period started today}}'**
  String homePeriodStartedToday(String who, String name);

  /// Small button under 'My period ended today' on the home screen: opens a date picker for the day it ended.
  ///
  /// In en, this message translates to:
  /// **'It ended on an earlier day'**
  String get homeEndedEarlier;

  /// Small button under 'My period started today' on the home screen: opens a date picker for the day it started.
  ///
  /// In en, this message translates to:
  /// **'It started on an earlier day'**
  String get homeStartedEarlier;

  /// who is 'you' for the phone's owner or 'other' for someone else they track; name is that person's name.
  ///
  /// In en, this message translates to:
  /// **'{who, select, you{Add when your last period ended} other{Add when {name}’s last period ended}}'**
  String homeAddLastEnd(String who, String name);

  /// A read-only copy of someone's history, sent from their own phone. date is the day it was sent. who is 'you' for the phone's owner or 'other' for someone else they track; name is that person's name.
  ///
  /// In en, this message translates to:
  /// **'{who, select, you{Imported from your phone on {date}. It can’t be changed here, and is brought up to date when you send it again.} other{Imported from {name}’s phone on {date}. It can’t be changed here, and is brought up to date when {name} sends it again.}}'**
  String homeSharedCopy(String who, String name, String date);

  /// Headline when Ebb assumes periods went unlogged.
  ///
  /// In en, this message translates to:
  /// **'No period logged since {date}'**
  String homeNoPeriodSince(String date);

  /// Detail in the home screen's cycle card, under homeNoPeriodSince, when the gap is long enough for one period to have gone unlogged.
  ///
  /// In en, this message translates to:
  /// **'Ebb has assumed a period went unlogged and estimated from there. If you remember when it started, add it to put the estimate right.'**
  String get homeMissedOne;

  /// Detail in the home screen's cycle card, under homeNoPeriodSince, when the gap is long enough for two or more periods to have gone unlogged.
  ///
  /// In en, this message translates to:
  /// **'Ebb has assumed some periods went unlogged and estimated from there. If you remember when any started, add them to put the estimate right.'**
  String get homeMissedSome;

  /// Headline of the cycle card for the phone's owner when nothing is logged yet (homeNothingYet for someone else they track).
  ///
  /// In en, this message translates to:
  /// **'Welcome to Ebb'**
  String get homeWelcome;

  /// Headline for someone else the owner tracks, with nothing logged.
  ///
  /// In en, this message translates to:
  /// **'Nothing logged yet'**
  String get homeNothingYet;

  /// who is 'you' for the phone's owner or 'other' for someone else they track; name is that person's name.
  ///
  /// In en, this message translates to:
  /// **'{who, select, you{Log the first day of your next period, or add past periods if you remember them, and Ebb will start learning your rhythm. Everything stays on this phone.} other{Log the first day of {name}’s next period, or add past periods if you remember them, and Ebb will start learning the rhythm. Everything stays on this phone.}}'**
  String homeFirstLog(String who, String name);

  /// who is 'you' for the phone's owner or 'other' for someone else they track; name is that person's name.
  ///
  /// In en, this message translates to:
  /// **'{who, select, you{Day {day} of your period} other{Day {day} of {name}’s period}}'**
  String homeDayOfPeriod(String who, String name, int day);

  /// who is 'you' for the phone's owner or 'other' for someone else they track; name is that person's name.
  ///
  /// In en, this message translates to:
  /// **'{who, select, you{Day {day} of your cycle} other{Day {day} of {name}’s cycle}}'**
  String homeDayOfCycle(String who, String name, int day);

  /// Detail under 'Day N of your period' in the cycle card while a period is in progress.
  ///
  /// In en, this message translates to:
  /// **'Let Ebb know when it ends so the estimate stays accurate.'**
  String get homeTellEnd;

  /// days is always 2 or more. who is 'you' for the phone's owner or 'other' for someone else they track; name is that person's name.
  ///
  /// In en, this message translates to:
  /// **'{who, select, you{{days, plural, other{About {days} days until your period is expected.}}} other{{days, plural, other{About {days} days until {name}’s period is expected.}}}}'**
  String homeDaysUntil(String who, String name, int days);

  /// who is 'you' for the phone's owner or 'other' for someone else they track; name is that person's name.
  ///
  /// In en, this message translates to:
  /// **'{who, select, you{Your period is expected tomorrow.} other{{name}’s period is expected tomorrow.}}'**
  String homeExpectedTomorrow(String who, String name);

  /// who is 'you' for the phone's owner or 'other' for someone else they track; name is that person's name.
  ///
  /// In en, this message translates to:
  /// **'{who, select, you{Your period is expected today.} other{{name}’s period is expected today.}}'**
  String homeExpectedToday(String who, String name);

  /// The period hasn't started yet and is this many days past the estimate. Calm, never alarming.
  ///
  /// In en, this message translates to:
  /// **'{days, plural, =1{1 day later than expected. Cycles shift for all sorts of reasons.} other{{days} days later than expected. Cycles shift for all sorts of reasons.}}'**
  String homeDaysLate(int days);

  /// Small capitals above the big day number in the cycle ring.
  ///
  /// In en, this message translates to:
  /// **'DAY'**
  String get homeRingDay;

  /// Under the big day number in the ring: read together as 'DAY 12 of your cycle'. who is 'you' for the phone's owner or 'other' for someone else they track; name is that person's name.
  ///
  /// In en, this message translates to:
  /// **'{who, select, you{of your cycle} other{of {name}’s cycle}}'**
  String homeRingOfCycle(String who, String name);

  /// Under the big day number in the ring: read together as 'DAY 3 of your period'. who is 'you' for the phone's owner or 'other' for someone else they track; name is that person's name.
  ///
  /// In en, this message translates to:
  /// **'{who, select, you{of your period} other{of {name}’s period}}'**
  String homeRingOfPeriod(String who, String name);

  /// Key under the cycle ring: the colour for period days.
  ///
  /// In en, this message translates to:
  /// **'Period'**
  String get homeKeyPeriod;

  /// Key under the cycle ring: the colour for when the next period is likely to start.
  ///
  /// In en, this message translates to:
  /// **'Likely next'**
  String get homeKeyLikelyNext;

  /// Key under the cycle ring: the dot for today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get homeKeyToday;

  /// Button in the cycle card when no period is recorded yet: opens the editor for a past period.
  ///
  /// In en, this message translates to:
  /// **'Add past periods'**
  String get homeAddPastPeriods;

  /// Button in the cycle card when Ebb assumes a period went unlogged: opens the editor to add it.
  ///
  /// In en, this message translates to:
  /// **'Add a missed period'**
  String get homeAddMissedPeriod;

  /// Heading over the estimated date of the next period.
  ///
  /// In en, this message translates to:
  /// **'Next period'**
  String get homeNextPeriod;

  /// Under the estimated date: the range it will probably fall in.
  ///
  /// In en, this message translates to:
  /// **'likely between {from} and {to}'**
  String homeLikelyBetween(String from, String to);

  /// Heading in the 'Next period' card over the estimated fertile window's dates, shown only when the setting is on.
  ///
  /// In en, this message translates to:
  /// **'Estimated fertile window'**
  String get homeFertileWindow;

  /// Under the fertile window dates. Keep the caution: not reliable as contraception.
  ///
  /// In en, this message translates to:
  /// **'An estimate based on cycle timing alone. Not reliable enough to use as contraception.'**
  String get homeFertileWarning;

  /// Note under the next-period estimate when Ebb assumes periods went unlogged. date is the last logged period's start, already formatted short, e.g. 'Jun 3'.
  ///
  /// In en, this message translates to:
  /// **'Estimated from the last period logged, on {date}, so it may be less accurate than usual.'**
  String homeConfidenceUnlogged(String date);

  /// Note under the next-period estimate when there is no history to go on.
  ///
  /// In en, this message translates to:
  /// **'Nothing logged yet.'**
  String get homeConfidenceNone;

  /// Note under the estimate when only one period is logged, so no cycle length has been measured yet.
  ///
  /// In en, this message translates to:
  /// **'Based on a typical 28-day cycle for now. This will get more accurate as you log.'**
  String get homeConfidenceTypical;

  /// Note under the estimate when only a few cycles have been measured. count is 1 or more.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Based on 1 cycle so far, so it may be less accurate for now.} other{Based on {count} cycles so far, so it may be less accurate for now.}}'**
  String homeConfidenceFew(int count);

  /// who is 'you' for the phone's owner or 'other' for someone else they track; name is that person's name.
  ///
  /// In en, this message translates to:
  /// **'{who, select, you{Your cycles vary quite a bit, so this is a wide estimate rather than a firm date.} other{{name}’s cycles vary quite a bit, so this is a wide estimate rather than a firm date.}}'**
  String homeConfidenceIrregular(String who, String name);

  /// count is always 2 or more. who is 'you' for the phone's owner or 'other' for someone else they track; name is that person's name.
  ///
  /// In en, this message translates to:
  /// **'{who, select, you{{count, plural, other{Based on your last {count} cycles.}}} other{{count, plural, other{Based on {name}’s last {count} cycles.}}}}'**
  String homeConfidenceLast(String who, String name, int count);

  /// count is always 2 or more.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, other{Based on {count} fairly consistent cycles.}}'**
  String homeConfidenceGood(int count);

  /// Milestone name, in History and on the celebration.
  ///
  /// In en, this message translates to:
  /// **'First period logged'**
  String get homeMilestoneFirstPeriod;

  /// Milestone name, in History and on the celebration: the first full cycle, start to start, logged.
  ///
  /// In en, this message translates to:
  /// **'First full cycle'**
  String get homeMilestoneFirstCycle;

  /// Milestone name, in History and on the celebration: three full cycles logged.
  ///
  /// In en, this message translates to:
  /// **'Three full cycles'**
  String get homeMilestoneThreeCycles;

  /// Milestone name, in History and on the celebration: six full cycles logged.
  ///
  /// In en, this message translates to:
  /// **'Six full cycles'**
  String get homeMilestoneSixCycles;

  /// Milestone name, in History and on the celebration: a year of history in Ebb.
  ///
  /// In en, this message translates to:
  /// **'A year of history'**
  String get homeMilestoneOneYear;

  /// Milestone name, in History and on the celebration: two years of history in Ebb.
  ///
  /// In en, this message translates to:
  /// **'Two years of history'**
  String get homeMilestoneTwoYears;

  /// Milestone name, in History and on the celebration: five years of history in Ebb.
  ///
  /// In en, this message translates to:
  /// **'Five years of history'**
  String get homeMilestoneFiveYears;

  /// Milestone name, in History and on the celebration: the first backup file saved.
  ///
  /// In en, this message translates to:
  /// **'First backup saved'**
  String get homeMilestoneFirstBackup;

  /// Said when the milestone is reached. About the record, never the body. who is 'you' for the phone's owner or 'other' for someone else they track; name is that person's name.
  ///
  /// In en, this message translates to:
  /// **'{who, select, you{Your first period in Ebb.} other{{name}’s first period in Ebb.}}'**
  String homeMilestoneFirstPeriodMessage(String who, String name);

  /// who is 'you' for the phone's owner or 'other' for someone else they track; name is that person's name.
  ///
  /// In en, this message translates to:
  /// **'{who, select, you{A first full cycle. Ebb can start learning your rhythm.} other{A first full cycle. Ebb can start learning {name}’s rhythm.}}'**
  String homeMilestoneFirstCycleMessage(String who, String name);

  /// Said on the celebration when the milestone is reached. About the record, never the body.
  ///
  /// In en, this message translates to:
  /// **'Three full cycles logged. Each one gives Ebb more to go on.'**
  String get homeMilestoneThreeCyclesMessage;

  /// Said when the milestone is reached. Six is how many recent cycles the estimate looks at, so this is a fact about the count, not a promise the estimate is now right.
  ///
  /// In en, this message translates to:
  /// **'Six full cycles logged: as many as Ebb looks at for each estimate.'**
  String get homeMilestoneSixCyclesMessage;

  /// who is 'you' for the phone's owner or 'other' for someone else they track; name is that person's name.
  ///
  /// In en, this message translates to:
  /// **'{who, select, you{A year of your history in Ebb.} other{A year of {name}’s history in Ebb.}}'**
  String homeMilestoneOneYearMessage(String who, String name);

  /// who is 'you' for the phone's owner or 'other' for someone else they track; name is that person's name.
  ///
  /// In en, this message translates to:
  /// **'{who, select, you{Two years of your history in Ebb.} other{Two years of {name}’s history in Ebb.}}'**
  String homeMilestoneTwoYearsMessage(String who, String name);

  /// who is 'you' for the phone's owner or 'other' for someone else they track; name is that person's name.
  ///
  /// In en, this message translates to:
  /// **'{who, select, you{Five years of your history in Ebb.} other{Five years of {name}’s history in Ebb.}}'**
  String homeMilestoneFiveYearsMessage(String who, String name);

  /// Said when the first backup file is saved, in place of the usual settingsBackupSaved message; give the same advice.
  ///
  /// In en, this message translates to:
  /// **'Your first backup is saved. Keep a copy somewhere other than this phone.'**
  String get homeMilestoneFirstBackupMessage;

  /// Error in red in the period editor when the start date picked is after today; Save stays disabled.
  ///
  /// In en, this message translates to:
  /// **'The start date can\'t be in the future.'**
  String get homeProblemStartInFuture;

  /// Error in red in the period editor when the end date picked is after today; Save stays disabled.
  ///
  /// In en, this message translates to:
  /// **'The end date can\'t be in the future.'**
  String get homeProblemEndInFuture;

  /// Error in red in the period editor when the end date is earlier than the start; Save stays disabled.
  ///
  /// In en, this message translates to:
  /// **'The end date is before the start date.'**
  String get homeProblemEndBeforeStart;

  /// Error in red in the period editor when another period already starts on that day; Save stays disabled.
  ///
  /// In en, this message translates to:
  /// **'A period starting on that day is already recorded.'**
  String get homeProblemDuplicateStart;

  /// Error in red in the period editor when this period starts before the one before it ended; Save stays disabled.
  ///
  /// In en, this message translates to:
  /// **'This overlaps the period before it. Check the earlier entry’s end date.'**
  String get homeProblemOverlapsPrevious;

  /// Error in red in the period editor when this period runs into the next one's start; Save stays disabled.
  ///
  /// In en, this message translates to:
  /// **'This overlaps the period after it. Check the end date.'**
  String get homeProblemOverlapsNext;

  /// Title of the dialog asking before a period is deleted from History or the calendar.
  ///
  /// In en, this message translates to:
  /// **'Delete this cycle?'**
  String get homeDeleteCycleTitle;

  /// Body of the dialog asking before a period is deleted. date is the period's start, already formatted, e.g. 'Jun 3, 2026'.
  ///
  /// In en, this message translates to:
  /// **'The entry starting {date} will be removed. This cannot be undone.'**
  String homeDeleteCycleBody(String date);

  /// Date picker title.
  ///
  /// In en, this message translates to:
  /// **'First day of the period'**
  String get homeFirstDayOfPeriod;

  /// Date picker title.
  ///
  /// In en, this message translates to:
  /// **'Last day of the period'**
  String get homeLastDayOfPeriod;

  /// Title of the sheet for entering an earlier period.
  ///
  /// In en, this message translates to:
  /// **'Add a past period'**
  String get homeAddPastPeriodTitle;

  /// Title of the period editor sheet for an existing period (homeAddPastPeriodTitle is for a new one).
  ///
  /// In en, this message translates to:
  /// **'Edit period'**
  String get homeEditPeriod;

  /// Label over the day the period started.
  ///
  /// In en, this message translates to:
  /// **'Started'**
  String get homeStarted;

  /// Label over the day the period ended.
  ///
  /// In en, this message translates to:
  /// **'Ended'**
  String get homeEnded;

  /// The period has no end date because it hasn't ended yet.
  ///
  /// In en, this message translates to:
  /// **'Still going'**
  String get homeStillGoing;

  /// The period's end date was never entered.
  ///
  /// In en, this message translates to:
  /// **'Not recorded'**
  String get homeNotRecorded;

  /// Tooltip of the × beside the end date in the period editor: forgets the end date.
  ///
  /// In en, this message translates to:
  /// **'Clear end date'**
  String get homeClearEnd;

  /// Switch in the period editor, on by default: whether this cycle feeds the estimates.
  ///
  /// In en, this message translates to:
  /// **'Count this cycle in predictions'**
  String get homeCountInPredictions;

  /// Under the 'Count this cycle in predictions' switch. Name the examples plainly, no euphemism.
  ///
  /// In en, this message translates to:
  /// **'Turn off for a cycle that doesn’t reflect the usual rhythm — illness, a medication change, a pregnancy loss. It stays in your history either way.'**
  String get homeCountInPredictionsHint;

  /// Label of the note field when editing a period from the home screen.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get homeNote;

  /// Helper under the period editor's note field when the cycle is switched out of predictions.
  ///
  /// In en, this message translates to:
  /// **'Why it isn’t counted, so it’s easy to remember later.'**
  String get homeNoteExcludedHint;

  /// Helper under the period editor's note field.
  ///
  /// In en, this message translates to:
  /// **'Anything worth remembering about this one.'**
  String get homeNoteHint;

  /// Button at the foot of the period editor, for an existing period.
  ///
  /// In en, this message translates to:
  /// **'Delete this period'**
  String get homeDeletePeriod;

  /// Button in History. homeLongGap and homeNothingSince quote it, so keep them the same.
  ///
  /// In en, this message translates to:
  /// **'Add past period'**
  String get homeAddPastPeriod;

  /// The History screen when no cycle is recorded.
  ///
  /// In en, this message translates to:
  /// **'No cycles recorded yet. If you remember when recent periods started, adding them gives Ebb a head start.'**
  String get homeHistoryEmpty;

  /// Heading in History over the milestones reached.
  ///
  /// In en, this message translates to:
  /// **'Milestones'**
  String get homeMilestones;

  /// How long a period in History lasted.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1-day period} other{{count}-day period}}'**
  String homePeriodLength(int count);

  /// In History, in place of the period length, for the current period that has not ended.
  ///
  /// In en, this message translates to:
  /// **'Period in progress'**
  String get homePeriodInProgress;

  /// In History, in place of the period length, for a past period whose end was never logged.
  ///
  /// In en, this message translates to:
  /// **'End not recorded'**
  String get homeEndNotRecorded;

  /// Quotes the button homeAddPastPeriod.
  ///
  /// In en, this message translates to:
  /// **'A long gap. If a period here wasn’t logged, add it with “Add past period”.'**
  String get homeLongGap;

  /// Quotes the button homeAddPastPeriod.
  ///
  /// In en, this message translates to:
  /// **'Nothing logged since. If a period was missed, add it with “Add past period”.'**
  String get homeNothingSince;

  /// A cycle left out of predictions. detail is e.g. '5-day period'.
  ///
  /// In en, this message translates to:
  /// **'{detail} · not counted'**
  String homeNotCounted(String detail);

  /// Small text under a big number of days in History: the cycle's length, e.g. '28' over 'day cycle'.
  ///
  /// In en, this message translates to:
  /// **'day cycle'**
  String get homeDayCycle;

  /// In History: the latest cycle logged, when Ebb assumes later periods went unlogged.
  ///
  /// In en, this message translates to:
  /// **'Last logged'**
  String get homeLastLogged;

  /// In History: the cycle going on now.
  ///
  /// In en, this message translates to:
  /// **'Current'**
  String get homeCurrent;

  /// Menu of date ranges for charts and sending.
  ///
  /// In en, this message translates to:
  /// **'Last 3 months'**
  String get homeSpanMonths3;

  /// Menu of date ranges for charts and sending: the last 6 months.
  ///
  /// In en, this message translates to:
  /// **'Last 6 months'**
  String get homeSpanMonths6;

  /// The last 12 months, not the previous calendar year.
  ///
  /// In en, this message translates to:
  /// **'Last year'**
  String get homeSpanYear;

  /// How far back the home screen's charts and history go: all of it.
  ///
  /// In en, this message translates to:
  /// **'Everything'**
  String get homeSpanAll;

  /// Menu of date ranges: opens Android's date-range picker, so it ends with an ellipsis like any menu item that asks more.
  ///
  /// In en, this message translates to:
  /// **'Choose dates…'**
  String get homeSpanCustom;

  /// Title of the Settings screen.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// Message when turning reminders on and the phone refuses notification permission.
  ///
  /// In en, this message translates to:
  /// **'Notifications are turned off for Ebb in system settings.'**
  String get settingsNotificationsOff;

  /// website is the address of Ebb's website.
  ///
  /// In en, this message translates to:
  /// **'No browser to open it with. Visit {website} instead.'**
  String settingsNoBrowser(String website);

  /// Message when 'Back up to a file' is tapped with nothing logged for anyone.
  ///
  /// In en, this message translates to:
  /// **'Nothing to back up yet.'**
  String get settingsNothingToBackUp;

  /// Message after a backup file is saved. homeMilestoneFirstBackupMessage gives the same advice the first time.
  ///
  /// In en, this message translates to:
  /// **'Backup saved. Keep a copy somewhere other than this phone.'**
  String get settingsBackupSaved;

  /// Message when the phone could not write the backup where it was pointed.
  ///
  /// In en, this message translates to:
  /// **'The backup couldn\'t be saved there. Try another location.'**
  String get settingsBackupNotSaved;

  /// Message when the phone has no file picker, so a backup can't be saved or opened; sending by codes needs none.
  ///
  /// In en, this message translates to:
  /// **'This phone has no file picker for Ebb to use. Sending to another phone works without one.'**
  String get settingsNoPicker;

  /// Message when the file picked to restore is far bigger than any Ebb backup could be.
  ///
  /// In en, this message translates to:
  /// **'That file is too large to be an Ebb backup.'**
  String get settingsFileTooLarge;

  /// Message when the file picked to restore could not be opened at all.
  ///
  /// In en, this message translates to:
  /// **'That file couldn\'t be read.'**
  String get settingsFileUnreadable;

  /// Message shown in Settings after picking a file to restore that isn't an Ebb backup.
  ///
  /// In en, this message translates to:
  /// **'This file isn\'t an Ebb backup.'**
  String get settingsNotABackup;

  /// A number of periods (menstrual periods), used inside other messages.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} period} other{{count} periods}}'**
  String settingsPeriodCount(int count);

  /// Asked when one person's history arrives on a phone with nothing on it yet.
  ///
  /// In en, this message translates to:
  /// **'Set up with this history?'**
  String get settingsSetUpTitle;

  /// periods is a count of periods, worded by settingsPeriodCount, e.g. "3 periods". date is a date, written the local way, e.g. "Oct 22, 2026".
  ///
  /// In en, this message translates to:
  /// **'{periods}, sent {date}. On this phone it becomes your history.'**
  String settingsSetUpBody(String periods, String date);

  /// Asked when history arrives for someone already on this phone. who is "you" for the phone's owner, "other" for someone else they track; name is that person's name.
  ///
  /// In en, this message translates to:
  /// **'{who, select, you{Update your history?} other{Update {name}?}}'**
  String settingsUpdateTitle(String who, String name);

  /// Button. who is "you" for the phone's owner, "other" for someone else they track; name is that person's name.
  ///
  /// In en, this message translates to:
  /// **'{who, select, you{Update your history} other{Update {name}}}'**
  String settingsUpdateAction(String who, String name);

  /// For a copy of someone else's history, imported into a group. who is "you" for the phone's owner, "other" for someone else they track; name is that person's name. date is a date, written the local way, e.g. "Oct 22, 2026". periods is a count of periods, worded by settingsPeriodCount, e.g. "3 periods".
  ///
  /// In en, this message translates to:
  /// **'{who, select, you{This is your history again, sent {date}: {periods}. It replaces the copy on this phone.} other{This is {name}’s history again, sent {date}: {periods}. It replaces the copy on this phone.}}'**
  String settingsUpdateSharedBody(
    String who,
    String name,
    String date,
    String periods,
  );

  /// who is "you" for the phone's owner, "other" for someone else they track; name is that person's name. date is a date, written the local way, e.g. "Oct 22, 2026". periods is a count of periods, worded by settingsPeriodCount, e.g. "3 periods".
  ///
  /// In en, this message translates to:
  /// **'{who, select, you{This is your history, sent {date}: {periods}. It replaces what’s on this phone for you, including anything logged here since.} other{This is {name}’s history, sent {date}: {periods}. It replaces what’s on this phone for {name}, including anything logged here since.}}'**
  String settingsUpdateBody(
    String who,
    String name,
    String date,
    String periods,
  );

  /// Button: replace everything on this phone with what arrived.
  ///
  /// In en, this message translates to:
  /// **'Replace everything'**
  String get settingsReplaceEverything;

  /// name is a person's name, or "You".
  ///
  /// In en, this message translates to:
  /// **'{name} updated.'**
  String settingsPersonUpdated(String name);

  /// Title of the dialog when a backup of one unnamed person arrives on a phone that already has history (settingsAddNamedTitle when they have a name).
  ///
  /// In en, this message translates to:
  /// **'Add this history?'**
  String get settingsAddThisHistoryTitle;

  /// name is the name of the person whose history arrived.
  ///
  /// In en, this message translates to:
  /// **'Add {name}?'**
  String settingsAddNamedTitle(String name);

  /// periods is a count of periods, worded by settingsPeriodCount, e.g. "3 periods".
  ///
  /// In en, this message translates to:
  /// **'It has {periods}. You can add it alongside what’s already here, or replace everything on this phone with it.'**
  String settingsAddBody(String periods);

  /// name is the name of the person whose history arrived. periods is a count of periods, worded by settingsPeriodCount, e.g. "3 periods".
  ///
  /// In en, this message translates to:
  /// **'{name}’s history has {periods}. You can add it alongside what’s already here, or replace everything on this phone with it.'**
  String settingsAddNamedBody(String name, String periods);

  /// Button in that dialog: add the arrived person alongside everyone already here.
  ///
  /// In en, this message translates to:
  /// **'Add as someone new'**
  String get settingsAddAsNew;

  /// Title of the name dialog after choosing to add an arrived person as someone new.
  ///
  /// In en, this message translates to:
  /// **'Who is this?'**
  String get settingsWhoIsThis;

  /// Helper under the name field in that dialog.
  ///
  /// In en, this message translates to:
  /// **'A name to tell them apart on this phone.'**
  String get settingsWhoIsThisHint;

  /// Message after adding an arrived person. name is what the user typed.
  ///
  /// In en, this message translates to:
  /// **'{name} added.'**
  String settingsPersonAdded(String name);

  /// Message after a backup replaced everything in Ebb.
  ///
  /// In en, this message translates to:
  /// **'Done. Ebb has been updated.'**
  String get settingsRestored;

  /// Title of the dialog asking before a backup replaces everything in Ebb.
  ///
  /// In en, this message translates to:
  /// **'Replace what’s in Ebb?'**
  String get settingsReplaceTitle;

  /// About the backup being restored. date is a date, written the local way, e.g. "Oct 22, 2026". periods is a count of periods, worded by settingsPeriodCount, e.g. "3 periods".
  ///
  /// In en, this message translates to:
  /// **'Saved {date}, with {periods}.'**
  String settingsReplaceSaved(String date, String periods);

  /// About the backup being restored; people is always 2 or more. date is a date, written the local way, e.g. "Oct 22, 2026". periods is a count of periods, worded by settingsPeriodCount, e.g. "3 periods".
  ///
  /// In en, this message translates to:
  /// **'{people, plural, other{Saved {date}, with {periods} for {people} people.}}'**
  String settingsReplaceSavedPeople(int people, String date, String periods);

  /// periods is a count of periods, worded by settingsPeriodCount, e.g. "3 periods".
  ///
  /// In en, this message translates to:
  /// **'It replaces everything in Ebb now, including {periods} on this phone.'**
  String settingsReplaceCurrent(String periods);

  /// Button that confirms replacing everything with a backup.
  ///
  /// In en, this message translates to:
  /// **'Replace'**
  String get settingsReplace;

  /// Title of the dialog asking before all data is deleted.
  ///
  /// In en, this message translates to:
  /// **'Delete all data?'**
  String get settingsDeleteAllTitle;

  /// Body of the 'Delete all data?' dialog when only the owner is tracked.
  ///
  /// In en, this message translates to:
  /// **'Every cycle and note will be permanently erased. Ebb keeps no other copy, so this cannot be undone unless you have saved a backup file.'**
  String get settingsDeleteAllBody;

  /// Body of the 'Delete all data?' dialog when more than one person is tracked on the phone.
  ///
  /// In en, this message translates to:
  /// **'Every cycle and note, for everyone on this phone, will be permanently erased. Ebb keeps no other copy, so this cannot be undone unless you have saved a backup file.'**
  String get settingsDeleteAllBodyEveryone;

  /// Button that confirms deleting all data.
  ///
  /// In en, this message translates to:
  /// **'Delete everything'**
  String get settingsDeleteEverything;

  /// Message after all data was deleted.
  ///
  /// In en, this message translates to:
  /// **'All data deleted.'**
  String get settingsAllDeleted;

  /// Settings item, and the title of the name dialog it opens, for the owner's own name (settingsName and settingsRename are for someone else).
  ///
  /// In en, this message translates to:
  /// **'Your name'**
  String get settingsYourName;

  /// Settings item that renames a person you track (not yourself).
  ///
  /// In en, this message translates to:
  /// **'Rename'**
  String get settingsRename;

  /// “You” must match how the owner is labelled in the list of people (the "you" message).
  ///
  /// In en, this message translates to:
  /// **'Shown in the list of people. Leave empty to appear as “You”.'**
  String get settingsYourNameHint;

  /// Title of the question before removing a tracked person and their history from this phone. {name} is typed by the user.
  ///
  /// In en, this message translates to:
  /// **'Remove {name} from this phone?'**
  String settingsRemoveTitle(String name);

  /// Body of the dialog asking before someone you track is removed from this phone. name is that person's name, as typed by the user.
  ///
  /// In en, this message translates to:
  /// **'Every cycle and note for {name} will be permanently erased. Nobody else’s history is affected.'**
  String settingsRemoveBody(String name);

  /// Confirmation in Settings after a tracked person was removed. {name} is typed by the user.
  ///
  /// In en, this message translates to:
  /// **'{name} removed.'**
  String settingsPersonRemoved(String name);

  /// Settings item, on that person's settings.
  ///
  /// In en, this message translates to:
  /// **'Remove {name} from this phone'**
  String settingsRemovePerson(String name);

  /// Settings section heading, when only the owner is tracked.
  ///
  /// In en, this message translates to:
  /// **'Your cycle'**
  String get settingsYourCycle;

  /// Settings section heading for the owner, when others are tracked too.
  ///
  /// In en, this message translates to:
  /// **'Your settings'**
  String get settingsYourSettings;

  /// Settings section heading for someone else being tracked.
  ///
  /// In en, this message translates to:
  /// **'Settings for {name}'**
  String settingsSettingsFor(String name);

  /// Label of the name field in Settings for a person you track.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get settingsName;

  /// Settings item that opens the reminder settings.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get settingsReminders;

  /// who is "you" for the phone's owner, "other" for someone else they track; name is that person's name.
  ///
  /// In en, this message translates to:
  /// **'{who, select, you{A heads-up before your period is expected.} other{A heads-up before {name}’s period is expected.}}'**
  String settingsRemindersHint(String who, String name);

  /// Followed by how many days ahead of the expected period.
  ///
  /// In en, this message translates to:
  /// **'Remind me'**
  String get settingsRemindMe;

  /// How far ahead of the expected period the reminder comes.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} day ahead} other{{count} days ahead}}'**
  String settingsDaysAhead(int count);

  /// A choice in the "Remind me" list.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} day} other{{count} days}}'**
  String settingsDays(int count);

  /// Switch in Settings, offered only to the phone's owner; off by default.
  ///
  /// In en, this message translates to:
  /// **'Show fertile window estimate'**
  String get settingsFertile;

  /// Under the 'Show fertile window estimate' switch. Keep the caution: not reliable as contraception.
  ///
  /// In en, this message translates to:
  /// **'Off by default. An estimate from cycle timing only — not reliable enough to use as contraception.'**
  String get settingsFertileHint;

  /// Switch in Settings: draw moon phases on the calendar and charts.
  ///
  /// In en, this message translates to:
  /// **'Show moon phases'**
  String get settingsMoon;

  /// Under the 'Show moon phases' switch, naming the four phases: use the same words as calendarMoonNew, calendarMoonFirstQuarter, calendarMoonFull and calendarMoonLastQuarter.
  ///
  /// In en, this message translates to:
  /// **'New, first quarter, full and last quarter, on the calendar and charts.'**
  String get settingsMoonHint;

  /// Basal body temperature on waking, and cervical mucus, as in fertility-awareness charting.
  ///
  /// In en, this message translates to:
  /// **'Track temperature and cervical mucus'**
  String get settingsTemperature;

  /// Under the 'Track temperature and cervical mucus' switch. Temperature is only recorded and charted; it never feeds the estimate.
  ///
  /// In en, this message translates to:
  /// **'On each day of the calendar, with a temperature chart. Recorded and drawn, never used to estimate anything.'**
  String get settingsTemperatureHint;

  /// Followed by a choice of °C or °F.
  ///
  /// In en, this message translates to:
  /// **'Temperature in'**
  String get settingsTemperatureIn;

  /// Switch in Settings: the small on-screen celebration when a milestone is reached.
  ///
  /// In en, this message translates to:
  /// **'Celebrate milestones'**
  String get settingsCelebrate;

  /// History is the name of a screen. who is "you" for the phone's owner, "other" for someone else they track; name is that person's name.
  ///
  /// In en, this message translates to:
  /// **'{who, select, you{A small celebration for things like a first full cycle or a year of history, listed in your History.} other{A small celebration for things like a first full cycle or a year of history, listed in {name}’s History.}}'**
  String settingsCelebrateHint(String who, String name);

  /// Settings section heading: the people tracked on this phone.
  ///
  /// In en, this message translates to:
  /// **'People'**
  String get settingsPeople;

  /// Settings item: start tracking another person on this phone.
  ///
  /// In en, this message translates to:
  /// **'Add someone'**
  String get settingsAddSomeone;

  /// Settings item, while only the owner is tracked, that adds a second person (settingsAddSomeone once there are more).
  ///
  /// In en, this message translates to:
  /// **'Track someone else too'**
  String get settingsTrackSomeoneElse;

  /// Starting to have periods.
  ///
  /// In en, this message translates to:
  /// **'For example, a child who’s just starting.'**
  String get settingsTrackSomeoneElseHint;

  /// Settings section heading: backups, and moving history to another phone.
  ///
  /// In en, this message translates to:
  /// **'Backup & moving'**
  String get settingsBackupSection;

  /// Settings item that saves a backup file through the phone's own Save picker.
  ///
  /// In en, this message translates to:
  /// **'Back up to a file'**
  String get settingsBackUp;

  /// Under 'Back up to a file' when only the owner is tracked.
  ///
  /// In en, this message translates to:
  /// **'Save your history to a file, wherever you choose.'**
  String get settingsBackUpHint;

  /// Under 'Back up to a file' when more than one person is tracked.
  ///
  /// In en, this message translates to:
  /// **'Save everyone’s history to a file, wherever you choose.'**
  String get settingsBackUpHintEveryone;

  /// Settings item that opens a backup file.
  ///
  /// In en, this message translates to:
  /// **'Restore from a backup'**
  String get settingsRestore;

  /// Under 'Restore from a backup'. A backup normally replaces everything; only a file holding a single person is also offered as an addition or update.
  ///
  /// In en, this message translates to:
  /// **'Replaces what is in Ebb now.'**
  String get settingsRestoreHint;

  /// Settings item that opens the Send to another phone screen (history as QR codes).
  ///
  /// In en, this message translates to:
  /// **'Send to another phone'**
  String get settingsSend;

  /// The codes are QR codes.
  ///
  /// In en, this message translates to:
  /// **'Show your history as codes for another phone to scan.'**
  String get settingsSendHint;

  /// The codes are QR codes.
  ///
  /// In en, this message translates to:
  /// **'Show everyone’s history as codes for another phone to scan.'**
  String get settingsSendHintEveryone;

  /// Settings item that opens the Receive from another phone screen.
  ///
  /// In en, this message translates to:
  /// **'Receive from another phone'**
  String get settingsReceive;

  /// Under 'Receive from another phone': what scanning the codes can do.
  ///
  /// In en, this message translates to:
  /// **'Scan the codes to add someone, update them, or replace everything.'**
  String get settingsReceiveHint;

  /// Settings section heading, holding the groups option.
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get settingsAdvanced;

  /// Settings item that opens the Groups screen.
  ///
  /// In en, this message translates to:
  /// **'Groups'**
  String get settingsGroups;

  /// Under the Groups switch, which is phone-wide and off by default.
  ///
  /// In en, this message translates to:
  /// **'For circles and clubs that track together: gather people under a name. Turning this off hides groups without deleting them.'**
  String get settingsGroupsHint;

  /// Settings item under the Groups switch, shown while it is on: opens the Groups screen.
  ///
  /// In en, this message translates to:
  /// **'Manage groups'**
  String get settingsManageGroups;

  /// Settings section heading: help, your data, website and feedback.
  ///
  /// In en, this message translates to:
  /// **'About Ebb'**
  String get settingsAboutEbb;

  /// Settings item, and the title of the help screen it opens.
  ///
  /// In en, this message translates to:
  /// **'How Ebb works'**
  String get settingsHowEbbWorks;

  /// Under 'How Ebb works': what the help screen covers.
  ///
  /// In en, this message translates to:
  /// **'Logging, estimates, backups and more.'**
  String get settingsHowEbbWorksHint;

  /// Settings item, and the title of the 'Your data' screen it opens, which explains where the data lives.
  ///
  /// In en, this message translates to:
  /// **'Your data'**
  String get settingsYourData;

  /// Under the 'Your data' item in Settings.
  ///
  /// In en, this message translates to:
  /// **'Where it lives and who can see it.'**
  String get settingsYourDataHint;

  /// Settings item that opens Ebb's website in the phone's browser; the address is shown under it.
  ///
  /// In en, this message translates to:
  /// **'Website'**
  String get settingsWebsite;

  /// Settings item that opens the feedback form on Ebb's website in the phone's browser.
  ///
  /// In en, this message translates to:
  /// **'Send feedback'**
  String get settingsSendFeedback;

  /// Under 'Send feedback': the form is on the website, not in Ebb, so only what is typed there is sent.
  ///
  /// In en, this message translates to:
  /// **'A form on the website, in your browser.'**
  String get settingsSendFeedbackHint;

  /// Settings item, in red, at the foot of Settings.
  ///
  /// In en, this message translates to:
  /// **'Delete all data'**
  String get settingsDeleteAll;

  /// At the foot of Settings. version is like "0.9.0 (900)".
  ///
  /// In en, this message translates to:
  /// **'Ebb {version}\nMade by SuperDaveLab'**
  String settingsVersion(String version);

  /// Heading of the "Your data" screen. Warm, ordinary, not secretive.
  ///
  /// In en, this message translates to:
  /// **'Your cycle is your business.'**
  String get settingsDataHeadline;

  /// Opening paragraph of the "Your data" screen, under settingsDataHeadline. The quoted question is one a user might ask; the answer is deliberately boring. Calm, not secretive.
  ///
  /// In en, this message translates to:
  /// **'Ebb is built so that the question \"what do they do with my data?\" has a boring answer: nothing, because we never receive it.'**
  String get settingsDataLede;

  /// Closing note on the "Your data" screen: the honest cost of having no cloud backup, and what to do about it.
  ///
  /// In en, this message translates to:
  /// **'One trade-off worth knowing: because there is no cloud backup, a lost or wiped phone means lost history. If that matters to you, save a backup file from Settings now and then, and keep it somewhere other than this phone.'**
  String get settingsDataTradeOff;

  /// Item at the foot of the help screen that opens the "Your data" screen.
  ///
  /// In en, this message translates to:
  /// **'Where your data lives'**
  String get settingsWhereDataLives;

  /// Under that item at the foot of the help screen.
  ///
  /// In en, this message translates to:
  /// **'Your data, and who can see it.'**
  String get settingsWhereDataLivesHint;

  /// Heading of one point on the "Your data" screen, which says plainly where the data lives; its body is settingsDataStaysBody.
  ///
  /// In en, this message translates to:
  /// **'It stays on your phone'**
  String get settingsDataStaysTitle;

  /// One point on the "Your data" screen, which says plainly where the data lives. Calm and matter-of-fact; tracking a cycle is ordinary.
  ///
  /// In en, this message translates to:
  /// **'Everything you log is written to a database on this device. There is no account to create and no server to sync with. It only goes anywhere else if you move it yourself — a backup file, or another phone you send it to.'**
  String get settingsDataStaysBody;

  /// Heading of one point on the "Your data" screen, which says plainly where the data lives; its body is settingsDataUnseenBody.
  ///
  /// In en, this message translates to:
  /// **'We cannot see it'**
  String get settingsDataUnseenTitle;

  /// One point on the "Your data" screen, which says plainly where the data lives. Calm and matter-of-fact; tracking a cycle is ordinary.
  ///
  /// In en, this message translates to:
  /// **'Ebb is built without permission to use the internet at all. Android enforces that, and you can verify it yourself in the app\'s permission list.'**
  String get settingsDataUnseenBody;

  /// Heading of one point on the "Your data" screen, which says plainly where the data lives; its body is settingsDataPermissionsBody.
  ///
  /// In en, this message translates to:
  /// **'What the permissions are for'**
  String get settingsDataPermissionsTitle;

  /// One point on the "Your data" screen, which says plainly where the data lives. Calm and matter-of-fact; tracking a cycle is ordinary.
  ///
  /// In en, this message translates to:
  /// **'Notifications, for reminders. Camera, only while you receive history from another phone — it reads the codes and nothing is recorded or kept. Ebb also re-arms your reminders when the phone restarts. That is the whole list.'**
  String get settingsDataPermissionsBody;

  /// Heading of one point on the "Your data" screen, which says plainly where the data lives; its body is settingsDataNotForSaleBody.
  ///
  /// In en, this message translates to:
  /// **'There is nothing to sell'**
  String get settingsDataNotForSaleTitle;

  /// One point on the "Your data" screen, which says plainly where the data lives. Calm and matter-of-fact; tracking a cycle is ordinary.
  ///
  /// In en, this message translates to:
  /// **'No analytics, no advertising, no third-party libraries phoning home. Since your data never reaches us, there is no copy of it for anyone to buy, subpoena, or leak.'**
  String get settingsDataNotForSaleBody;

  /// Heading of one point on the "Your data" screen, which says plainly where the data lives; its body is settingsDataEraseBody.
  ///
  /// In en, this message translates to:
  /// **'You can erase it instantly'**
  String get settingsDataEraseTitle;

  /// One point on the "Your data" screen, which says plainly where the data lives. Calm and matter-of-fact; tracking a cycle is ordinary.
  ///
  /// In en, this message translates to:
  /// **'Deleting your data in Settings, or uninstalling Ebb, removes everything Ebb holds. Ebb keeps no other copy — the only ones are backup files you saved or phones you sent it to yourself.'**
  String get settingsDataEraseBody;

  /// Heading of one point on the "Your data" screen, which says plainly where the data lives; its body is settingsDataOpenSourceBody.
  ///
  /// In en, this message translates to:
  /// **'You can check our work'**
  String get settingsDataOpenSourceTitle;

  /// One point on the "Your data" screen, which says plainly where the data lives. Calm and matter-of-fact; tracking a cycle is ordinary.
  ///
  /// In en, this message translates to:
  /// **'Ebb is open source under the GNU General Public License. Anyone can read exactly what it does, and the published builds are made from that same code.'**
  String get settingsDataOpenSourceBody;

  /// Heading of the help topic about logging a period.
  ///
  /// In en, this message translates to:
  /// **'Logging a period'**
  String get settingsHelpLoggingTitle;

  /// A topic on the "How Ebb works" help screen. Words in quotation marks name buttons and settings elsewhere in the app: use exactly the same translation as those.
  ///
  /// In en, this message translates to:
  /// **'Tap “My period started today” on the first day of bleeding, and “My period ended today” on the last.\n\nForgot to log it? Use “It started on an earlier day” instead. Any past period can be added or corrected in History (the clock icon): tap one to change its dates or add a note.\n\nIf no end is logged within two weeks, Ebb stops treating the period as still going and offers to add the end instead.'**
  String get settingsHelpLoggingBody;

  /// Heading of the help topic about how the next-period estimate is made.
  ///
  /// In en, this message translates to:
  /// **'How the estimate works'**
  String get settingsHelpEstimateTitle;

  /// A topic on the "How Ebb works" help screen. Words in quotation marks name buttons and settings elsewhere in the app: use exactly the same translation as those.
  ///
  /// In en, this message translates to:
  /// **'Ebb looks at the gaps between the starts of your recent periods — up to the last six.\n\nWith only a little history it leans on a typical 28-day cycle, and says so. The more you log, the more the estimate is your own rhythm.\n\nIt shows a range rather than a single date, and tells you how sure it is. If your cycles vary a lot, the range is wider.\n\nIf a period is late, Ebb says how late. If nothing is logged for nearly two cycles, it assumes a period went unlogged, estimates from there, and says so. History points out long gaps, and adding a missed period puts the estimate right.'**
  String get settingsHelpEstimateBody;

  /// Heading of the help topic about leaving a cycle out of predictions.
  ///
  /// In en, this message translates to:
  /// **'A cycle that shouldn’t count'**
  String get settingsHelpExcludeTitle;

  /// A topic on the "How Ebb works" help screen. Words in quotation marks name buttons and settings elsewhere in the app: use exactly the same translation as those.
  ///
  /// In en, this message translates to:
  /// **'Illness, a medication change or a pregnancy loss can throw one cycle right off, and it would pull the estimate with it.\n\nIn History, tap that period and turn off “Count this cycle in predictions”. It stays in your history; the estimate just ignores it. Add a note there too, so you remember why.'**
  String get settingsHelpExcludeBody;

  /// Heading of the help topic about groups.
  ///
  /// In en, this message translates to:
  /// **'Groups'**
  String get settingsHelpGroupsTitle;

  /// A topic on the "How Ebb works" help screen. Words in quotation marks name buttons and settings elsewhere in the app: use exactly the same translation as those.
  ///
  /// In en, this message translates to:
  /// **'For circles and clubs that track together. Turn them on in Settings → Advanced, then make a group and choose who’s in it. “See … together” in the list of people shows everyone side by side, with the moon.\n\nA group can have two kinds of member. Someone added to it is tracked on this phone, and you log for them here. Someone imported keeps tracking on their own phone and provides their history to the group: it stays theirs, and can’t be changed on anyone else’s phone.\n\nTo be imported, send just your history (Settings → Send to another phone) — as much or as little as you like, with or without your daily notes. The other phone imports it from the group: Manage groups → the group → Import from their phone. Importing you again brings it up to date.\n\nImported history belongs to its group. Taking someone imported out of their last group, or deleting that group, takes their history off the phone too. And it can’t be sent on: only your own history can.'**
  String get settingsHelpGroupsBody;

  /// Heading of the help topic about day ratings, feelings and charts.
  ///
  /// In en, this message translates to:
  /// **'Day ratings, feelings and charts'**
  String get settingsHelpRatingsTitle;

  /// A topic on the "How Ebb works" help screen. Words in quotation marks name buttons and settings elsewhere in the app: use exactly the same translation as those.
  ///
  /// In en, this message translates to:
  /// **'Tap any day on the calendar to rate it from 1 to 5, and to pick a face for how you felt. Both are optional; tap a choice again to clear it.\n\nCharts (the chart icon) shows each day’s rating over the dates you choose, with periods shaded, and which feelings came during and before periods. With moon phases turned on in Settings, the moon is there too.\n\nThe charts show what you logged. They don’t say what it means — that’s yours to judge.'**
  String get settingsHelpRatingsBody;

  /// Heading of the help topic about waking temperature and cervical mucus.
  ///
  /// In en, this message translates to:
  /// **'Temperature and cervical mucus'**
  String get settingsHelpTemperatureTitle;

  /// A topic on the "How Ebb works" help screen. Words in quotation marks name buttons and settings elsewhere in the app: use exactly the same translation as those.
  ///
  /// In en, this message translates to:
  /// **'Turn on “Track temperature and cervical mucus” in Settings, and each day on the calendar has room for your waking temperature and how cervical mucus felt and looked. If something may have thrown a reading off — illness, little sleep, alcohol, taking it late — tick the box under it.\n\nCharts shows the temperatures as a line, with mucus underneath and periods shaded, in °C or °F (Settings).\n\nEbb records and draws these, and that’s all. It doesn’t look for a rise or work out fertile days from them, and its fertile-window estimate still comes from cycle timing alone. If you follow a method such as the sympto-thermal method, the chart is there for you to read by its rules.'**
  String get settingsHelpTemperatureBody;

  /// Heading of the help topic about reminders.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get settingsHelpRemindersTitle;

  /// A topic on the "How Ebb works" help screen. Words in quotation marks name buttons and settings elsewhere in the app: use exactly the same translation as those.
  ///
  /// In en, this message translates to:
  /// **'A heads-up a few days before your period is expected, and another on the day. Choose how far ahead in Settings.\n\nThey’re scheduled on the phone itself, so they arrive with no signal and in airplane mode.\n\nEbb sets them each time you open it, from the latest estimate. The phone keeps them through restarts, but Ebb can’t update them while it’s closed, so open it now and then — logging a period is enough.\n\nAndroid may deliver them a little after the usual time to save battery. If Ebb is force-stopped, or a battery saver restricts it, they may not arrive until you next open Ebb.'**
  String get settingsHelpRemindersBody;

  /// Heading of the help topic about the fertile window estimate.
  ///
  /// In en, this message translates to:
  /// **'The fertile window'**
  String get settingsHelpFertileTitle;

  /// A topic on the "How Ebb works" help screen. Words in quotation marks name buttons and settings elsewhere in the app: use exactly the same translation as those.
  ///
  /// In en, this message translates to:
  /// **'Off unless you turn it on in Settings. It’s estimated from cycle timing alone, which is not reliable enough to use as contraception.'**
  String get settingsHelpFertileBody;

  /// Heading of the help topic about backup files.
  ///
  /// In en, this message translates to:
  /// **'Backing up'**
  String get settingsHelpBackupTitle;

  /// A topic on the "How Ebb works" help screen. Words in quotation marks name buttons and settings elsewhere in the app: use exactly the same translation as those.
  ///
  /// In en, this message translates to:
  /// **'There’s no cloud copy of your history, so a lost or wiped phone means lost history.\n\nSettings → “Back up to a file” saves everything as a file, wherever you choose. Keep it somewhere other than this phone. “Restore from a backup” brings it back.'**
  String get settingsHelpBackupBody;

  /// Heading of the help topic about moving history to a new phone.
  ///
  /// In en, this message translates to:
  /// **'Moving to a new phone'**
  String get settingsHelpMovingTitle;

  /// A topic on the "How Ebb works" help screen. Words in quotation marks name buttons and settings elsewhere in the app: use exactly the same translation as those.
  ///
  /// In en, this message translates to:
  /// **'On the old phone: Settings → “Send to another phone”. On the new one: Settings → “Receive from another phone”, and point the camera at the screen.\n\nLonger histories take a few codes, which change on their own; the new phone collects them in any order. No internet is involved — one phone shows, the other looks.'**
  String get settingsHelpMovingBody;

  /// Heading of the help topic about tracking another person on this phone.
  ///
  /// In en, this message translates to:
  /// **'Tracking someone else'**
  String get settingsHelpSomeoneElseTitle;

  /// A topic on the "How Ebb works" help screen. Words in quotation marks name buttons and settings elsewhere in the app: use exactly the same translation as those.
  ///
  /// In en, this message translates to:
  /// **'Helping someone else keep track — a child who’s just starting, say? Settings → “Track someone else too”, and give them a name. A nickname or initial is fine.\n\nTap the name at the top of the home screen to switch between people. Everyone has their own reminders, which start off for people you add. The fertile window is only ever offered for you.'**
  String get settingsHelpSomeoneElseBody;

  /// Heading of the help topic about sending someone's history to their own phone.
  ///
  /// In en, this message translates to:
  /// **'Handing someone over'**
  String get settingsHelpHandoverTitle;

  /// A topic on the "How Ebb works" help screen. Words in quotation marks name buttons and settings elsewhere in the app: use exactly the same translation as those.
  ///
  /// In en, this message translates to:
  /// **'When someone you track gets their own phone: “Send to another phone”, and choose just them. On their phone, “Receive from another phone”. On a fresh install their history simply becomes theirs.\n\nAfterwards Ebb asks whether to remove them from your phone. It never does that on its own.'**
  String get settingsHelpHandoverBody;

  /// Heading of the help topic about deleting data.
  ///
  /// In en, this message translates to:
  /// **'Deleting'**
  String get settingsHelpDeletingTitle;

  /// A topic on the "How Ebb works" help screen. Words in quotation marks name buttons and settings elsewhere in the app: use exactly the same translation as those.
  ///
  /// In en, this message translates to:
  /// **'Settings → “Delete all data” erases everything on this phone at once.\n\nTo remove one person you’ve added, open their settings and choose “Remove … from this phone”. Nobody else’s history is touched.'**
  String get settingsHelpDeletingBody;

  /// After sending one person's history to their own phone.
  ///
  /// In en, this message translates to:
  /// **'Remove {name} from this phone?'**
  String shareRemoveTitle(String name);

  /// Body of the dialog after Done on the codes screen, when one person other than the owner was sent. It offers, never assumes. name is that person's name.
  ///
  /// In en, this message translates to:
  /// **'If {name}’s history arrived on the other phone, it can come off this one. You can also keep it here as well.'**
  String shareRemoveBody(String name);

  /// Button: keep the person on this phone rather than removing them.
  ///
  /// In en, this message translates to:
  /// **'Keep'**
  String get shareKeep;

  /// Confirmation on the Send screen after a person's history was removed, having been sent to their own phone. {name} is typed by the user.
  ///
  /// In en, this message translates to:
  /// **'{name} removed.'**
  String shareRemoved(String name);

  /// Screen title. History is shown as QR codes for another phone running Ebb to scan.
  ///
  /// In en, this message translates to:
  /// **'Send to another phone'**
  String get shareTitle;

  /// Heading of the Send screen's first step: choosing whose history to send.
  ///
  /// In en, this message translates to:
  /// **'What would you like to send?'**
  String get shareWhatToSend;

  /// Send choice: everyone on this phone.
  ///
  /// In en, this message translates to:
  /// **'Everyone'**
  String get shareEveryone;

  /// Under the 'Everyone on this phone' send choice: what it is for.
  ///
  /// In en, this message translates to:
  /// **'Moving to a new phone.'**
  String get shareEveryoneHint;

  /// Section heading.
  ///
  /// In en, this message translates to:
  /// **'Just one person'**
  String get shareJustOne;

  /// Send choice: only the owner's history.
  ///
  /// In en, this message translates to:
  /// **'Just your history'**
  String get shareJustYours;

  /// Send choice: only this person’s history.
  ///
  /// In en, this message translates to:
  /// **'Just {name}'**
  String shareJustName(String name);

  /// Under the send choice for one person the owner tracks: what it is for. name is that person's name.
  ///
  /// In en, this message translates to:
  /// **'For {name}’s own phone.'**
  String shareForTheirPhone(String name);

  /// Note at the foot of the send choices when an imported copy is on the phone, saying why it is not listed.
  ///
  /// In en, this message translates to:
  /// **'People imported from other phones aren’t offered here: each person shares only their own history.'**
  String get shareCopiesNotOffered;

  /// who is 'you' for the phone's owner or 'other' for someone else tracked on the phone; name is that person's name.
  ///
  /// In en, this message translates to:
  /// **'{who, select, you{How much of your history?} other{How much of {name}’s history?}}'**
  String shareHowMuch(String who, String name);

  /// Under the 'How much of your history?' heading on the Send screen.
  ///
  /// In en, this message translates to:
  /// **'Sending everything suits a new phone. Sharing with a group, you might send less. Nothing is removed from this phone.'**
  String get shareHowMuchHint;

  /// Section heading for choosing how much history to send.
  ///
  /// In en, this message translates to:
  /// **'How far back'**
  String get shareHowFarBack;

  /// How far back: all of the history.
  ///
  /// In en, this message translates to:
  /// **'Everything'**
  String get shareSpanEverything;

  /// How far back to send: the last 12 months.
  ///
  /// In en, this message translates to:
  /// **'The last year'**
  String get shareSpanYear;

  /// How far back. months is 3 or 6.
  ///
  /// In en, this message translates to:
  /// **'{months, plural, one{The last {months} month} other{The last {months} months}}'**
  String shareSpanMonths(int months);

  /// How far back to send: only the most recent period.
  ///
  /// In en, this message translates to:
  /// **'Just the latest period'**
  String get shareSpanLatest;

  /// Section heading.
  ///
  /// In en, this message translates to:
  /// **'What to include'**
  String get shareWhatToInclude;

  /// What to include when sending: periods and daily entries, one of two choices.
  ///
  /// In en, this message translates to:
  /// **'Periods and daily entries'**
  String get shareWithDays;

  /// Under the 'Periods and daily entries' choice: what a daily entry holds.
  ///
  /// In en, this message translates to:
  /// **'Notes, ratings, feelings and flow too.'**
  String get shareWithDaysHint;

  /// What to include when sending: periods only, no daily entries.
  ///
  /// In en, this message translates to:
  /// **'Periods only'**
  String get sharePeriodsOnly;

  /// Under the 'Periods only' choice.
  ///
  /// In en, this message translates to:
  /// **'Just when each period started and ended.'**
  String get sharePeriodsOnlyHint;

  /// Button at the foot of the 'How much' step: shows the QR codes.
  ///
  /// In en, this message translates to:
  /// **'Show the codes'**
  String get shareShowCodes;

  /// On the codes screen when the chosen history has nothing in it.
  ///
  /// In en, this message translates to:
  /// **'Nothing to send yet.'**
  String get shareNothing;

  /// Settings → Receive from another phone must match those screens’ names.
  ///
  /// In en, this message translates to:
  /// **'On the other phone, open Ebb, go to Settings → Receive from another phone, and point the camera at this screen.'**
  String get shareHowToReceive;

  /// Which QR code is showing. total is 2 or more.
  ///
  /// In en, this message translates to:
  /// **'{total, plural, other{Code {index} of {total}}}'**
  String shareCodeOf(int index, int total);

  /// Tooltip.
  ///
  /// In en, this message translates to:
  /// **'Previous code'**
  String get sharePreviousCode;

  /// Tooltip: stop the codes changing.
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get sharePause;

  /// Tooltip: let the codes change on their own again.
  ///
  /// In en, this message translates to:
  /// **'Play'**
  String get sharePlay;

  /// Tooltip.
  ///
  /// In en, this message translates to:
  /// **'Next code'**
  String get shareNextCode;

  /// Under the codes when there is more than one: they cycle on their own, and scanning order does not matter.
  ///
  /// In en, this message translates to:
  /// **'The codes change on their own. The other phone collects them in any order.'**
  String get shareCodesChange;

  /// A number of periods, filled into other messages.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} period} other{{count} periods}}'**
  String sharePeriodCount(int count);

  /// periods is a count like “3 periods”.
  ///
  /// In en, this message translates to:
  /// **'Everything in Ebb: {periods}.'**
  String shareSummaryEverything(String periods);

  /// periods is a count like “3 periods”; people is always 2 or more.
  ///
  /// In en, this message translates to:
  /// **'{people, plural, other{Everything in Ebb: {periods} for {people} people.}}'**
  String shareSummaryEverythingPeople(String periods, int people);

  /// What is being sent: this person’s whole history (periods and daily entries). who is 'you' for the phone's owner or 'other' for someone else tracked on the phone; name is that person's name. periods is a count like “3 periods”.
  ///
  /// In en, this message translates to:
  /// **'{who, select, you{Your history: {periods}.} other{{name}’s history: {periods}.}}'**
  String shareSummaryHistoryAll(String who, String name, String periods);

  /// What is being sent: this person’s whole history (periods and daily entries). who is 'you' for the phone's owner or 'other' for someone else tracked on the phone; name is that person's name. periods is a count like “3 periods”.
  ///
  /// In en, this message translates to:
  /// **'{who, select, you{Your history, latest period only: {periods}.} other{{name}’s history, latest period only: {periods}.}}'**
  String shareSummaryHistoryLatest(String who, String name, String periods);

  /// What is being sent: this person’s whole history (periods and daily entries). who is 'you' for the phone's owner or 'other' for someone else tracked on the phone; name is that person's name. periods is a count like “3 periods”.
  ///
  /// In en, this message translates to:
  /// **'{who, select, you{Your history from the last year: {periods}.} other{{name}’s history from the last year: {periods}.}}'**
  String shareSummaryHistoryYear(String who, String name, String periods);

  /// What is being sent: this person’s whole history (periods and daily entries). who is 'you' for the phone's owner or 'other' for someone else tracked on the phone; name is that person's name. periods is a count like “3 periods”. months is 3 or 6.
  ///
  /// In en, this message translates to:
  /// **'{who, select, you{Your history from the last {months} months: {periods}.} other{{name}’s history from the last {months} months: {periods}.}}'**
  String shareSummaryHistoryMonths(
    String who,
    String name,
    String periods,
    int months,
  );

  /// What is being sent: this person’s periods only. who is 'you' for the phone's owner or 'other' for someone else tracked on the phone; name is that person's name. periods is a count like “3 periods”.
  ///
  /// In en, this message translates to:
  /// **'{who, select, you{Your periods: {periods}.} other{{name}’s periods: {periods}.}}'**
  String shareSummaryPeriodsAll(String who, String name, String periods);

  /// What is being sent: this person’s periods only. who is 'you' for the phone's owner or 'other' for someone else tracked on the phone; name is that person's name. periods is a count like “3 periods”.
  ///
  /// In en, this message translates to:
  /// **'{who, select, you{Your periods, latest period only: {periods}.} other{{name}’s periods, latest period only: {periods}.}}'**
  String shareSummaryPeriodsLatest(String who, String name, String periods);

  /// What is being sent: this person’s periods only. who is 'you' for the phone's owner or 'other' for someone else tracked on the phone; name is that person's name. periods is a count like “3 periods”.
  ///
  /// In en, this message translates to:
  /// **'{who, select, you{Your periods from the last year: {periods}.} other{{name}’s periods from the last year: {periods}.}}'**
  String shareSummaryPeriodsYear(String who, String name, String periods);

  /// What is being sent: this person’s periods only. who is 'you' for the phone's owner or 'other' for someone else tracked on the phone; name is that person's name. periods is a count like “3 periods”. months is 3 or 6.
  ///
  /// In en, this message translates to:
  /// **'{who, select, you{Your periods from the last {months} months: {periods}.} other{{name}’s periods from the last {months} months: {periods}.}}'**
  String shareSummaryPeriodsMonths(
    String who,
    String name,
    String periods,
    int months,
  );

  /// On the Receive screen after scanning a QR code that is not Ebb's.
  ///
  /// In en, this message translates to:
  /// **'That code isn\'t from Ebb.'**
  String get shareNotEbb;

  /// On the Receive screen when the codes come from a newer Ebb than this one.
  ///
  /// In en, this message translates to:
  /// **'The other phone has a newer version of Ebb. Update this one first.'**
  String get shareNewerVersion;

  /// On the Receive screen when the sender started a new transfer part way through, so the codes collected so far are dropped.
  ///
  /// In en, this message translates to:
  /// **'The other phone started over. Collecting the new codes.'**
  String get shareRestarted;

  /// On the Receive screen when the collected codes did not assemble into a readable backup; scanning starts again.
  ///
  /// In en, this message translates to:
  /// **'Some codes didn\'t read cleanly. Let\'s scan them again.'**
  String get shareUnreadable;

  /// On the Receive screen in place of the camera view when camera permission was refused.
  ///
  /// In en, this message translates to:
  /// **'Ebb needs the camera to read the codes. You can allow it in the system settings for Ebb.'**
  String get shareNeedsCamera;

  /// Status at the top of the Receive screen before any code is read.
  ///
  /// In en, this message translates to:
  /// **'Point the camera at the code on the other phone.'**
  String get sharePointCamera;

  /// Status on the Receive screen while a single-code transfer is being read; with more codes a count shows instead.
  ///
  /// In en, this message translates to:
  /// **'Reading…'**
  String get shareReading;

  /// total is 2 or more.
  ///
  /// In en, this message translates to:
  /// **'{total, plural, other{{received} of {total} codes received}}'**
  String shareCodesReceived(int received, int total);

  /// Screen title, and the Settings item that opens it.
  ///
  /// In en, this message translates to:
  /// **'Receive from another phone'**
  String get shareReceiveTitle;

  /// codes is a list of code numbers, like “2, 5”.
  ///
  /// In en, this message translates to:
  /// **'Still needed: {codes}'**
  String shareStillNeeded(String codes);

  /// Title of the dialog when codes scanned into a group hold a whole phone's history rather than one person's.
  ///
  /// In en, this message translates to:
  /// **'That’s more than one person'**
  String get groupsMoreThanOne;

  /// The path must match the names of those screens and choices.
  ///
  /// In en, this message translates to:
  /// **'These codes hold a whole phone’s history. To join a group, each person sends just their own: on their phone, Settings → Send to another phone → Just your history.'**
  String get groupsMoreThanOneBody;

  /// who is 'you' for the phone's owner or 'other' for someone else tracked on the phone; name is that person's name.
  ///
  /// In en, this message translates to:
  /// **'{who, select, you{Update your history?} other{Update {name}?}}'**
  String groupsUpdateTitle(String who, String name);

  /// who is 'you' for the phone's owner or 'other' for someone else tracked on the phone; name is that person's name.
  ///
  /// In en, this message translates to:
  /// **'{who, select, you{Update your history} other{Update {name}}}'**
  String groupsUpdateAction(String who, String name);

  /// who is 'you' for the phone's owner or 'other' for someone else tracked on the phone; name is that person's name. sent is a date; periods is a count like “3 periods”.
  ///
  /// In en, this message translates to:
  /// **'{who, select, you{This is your history again, sent {sent}: {periods}. It replaces the copy on this phone.} other{This is {name}’s history again, sent {sent}: {periods}. It replaces the copy on this phone.}}'**
  String groupsUpdateCopyBody(
    String who,
    String name,
    String sent,
    String periods,
  );

  /// who is 'you' for the phone's owner or 'other' for someone else tracked on the phone; name is that person's name. sent is a date; periods is a count like “3 periods”.
  ///
  /// In en, this message translates to:
  /// **'{who, select, you{This is your history, sent {sent}: {periods}. It replaces what’s on this phone for you, including anything logged here since.} other{This is {name}’s history, sent {sent}: {periods}. It replaces what’s on this phone for {name}, including anything logged here since.}}'**
  String groupsUpdateBody(String who, String name, String sent, String periods);

  /// Confirmation after receiving an update to someone's history in a group. {name} is a person's name, or "You".
  ///
  /// In en, this message translates to:
  /// **'{name} updated.'**
  String groupsUpdated(String name);

  /// Title of the name dialog. group is the group’s name.
  ///
  /// In en, this message translates to:
  /// **'Import into {group}'**
  String groupsImportInto(String group);

  /// periods is a count like “3 periods”; sent is a date.
  ///
  /// In en, this message translates to:
  /// **'{periods}, sent {sent}. Imported read-only: it can’t be changed here, and is brought up to date when it’s sent again.'**
  String groupsImportHint(String periods, String sent);

  /// Message after someone is imported into a group. name is what the user typed; group is the group's name.
  ///
  /// In en, this message translates to:
  /// **'{name} imported into {group}.'**
  String groupsImported(String name, String group);

  /// Fallback screen title while a group’s name is unknown.
  ///
  /// In en, this message translates to:
  /// **'Group'**
  String get groupsGroup;

  /// The path must match those Settings names.
  ///
  /// In en, this message translates to:
  /// **'No one is in this group yet. Add them in Settings → Advanced → Manage groups: tick people already on this phone, or add someone from their phone.'**
  String get groupsNoMembers;

  /// Section heading above a chart of everyone’s periods.
  ///
  /// In en, this message translates to:
  /// **'Periods'**
  String get groupsPeriods;

  /// Caption under the group chart, which draws each person's periods as bars in their own lane with moon lines across all of them.
  ///
  /// In en, this message translates to:
  /// **'Each bar is a period; an outline is one whose end wasn’t logged, drawn at the usual length. Solid lines run down from each full moon, dashed ones from each new moon.'**
  String get groupsChartHint;

  /// Button on the Groups screen, and the title of the name dialog for a new group.
  ///
  /// In en, this message translates to:
  /// **'New group'**
  String get groupsNew;

  /// Title of the name dialog when renaming a group.
  ///
  /// In en, this message translates to:
  /// **'Rename group'**
  String get groupsRename;

  /// Helper under the group name field.
  ///
  /// In en, this message translates to:
  /// **'For example, the name of your circle or club.'**
  String get groupsNameHint;

  /// Error under the group name field.
  ///
  /// In en, this message translates to:
  /// **'There’s already a group with that name.'**
  String get groupsNameTaken;

  /// A group with no members.
  ///
  /// In en, this message translates to:
  /// **'No one yet'**
  String get groupsNoOneYet;

  /// Title of the Groups screen.
  ///
  /// In en, this message translates to:
  /// **'Groups'**
  String get groupsTitle;

  /// The Groups screen when no group exists yet.
  ///
  /// In en, this message translates to:
  /// **'A group gathers people on this phone under one name — a circle or club that tracks together. Someone can be in more than one, and deleting a group never deletes anyone.'**
  String get groupsIntro;

  /// Title of the name dialog when adding a new person, tracked on this phone, straight into a group. group is the group's name.
  ///
  /// In en, this message translates to:
  /// **'Add someone to {group}'**
  String groupsAddSomeoneTo(String group);

  /// Helper under the name field in that dialog.
  ///
  /// In en, this message translates to:
  /// **'Tracked on this phone: you log and change their history here. Someone who tracks on their own phone can be imported instead.'**
  String get groupsAddSomeoneHint;

  /// Title of the dialog asking before an imported copy is unticked from the only group it is in. name is that person's name; group is the group's name.
  ///
  /// In en, this message translates to:
  /// **'Take {name} out of {group}?'**
  String groupsTakeOutTitle(String name, String group);

  /// Body of the dialog asking before an imported copy leaves its only group. name is that person's name, used three times.
  ///
  /// In en, this message translates to:
  /// **'{name} was imported from their phone and isn’t in any other group, so the imported history comes off this phone too. {name} can send it again to rejoin.'**
  String groupsTakeOutBody(String name);

  /// Button: remove someone from the group.
  ///
  /// In en, this message translates to:
  /// **'Take out'**
  String get groupsTakeOut;

  /// Title of the dialog asking before a group is deleted. group is the group's name.
  ///
  /// In en, this message translates to:
  /// **'Delete {group}?'**
  String groupsDeleteTitle(String group);

  /// Body of the 'Delete group?' dialog when no imported copy is only in this group (groupsDeleteBodySome otherwise).
  ///
  /// In en, this message translates to:
  /// **'Only the group goes. Everyone in it stays on this phone, with all their history.'**
  String get groupsDeleteBodyNone;

  /// names is a list of names, like “Sam, Alex”.
  ///
  /// In en, this message translates to:
  /// **'The people imported only into this group come off this phone too: {names}. Everyone else stays, with all their history.'**
  String groupsDeleteBodySome(String names);

  /// Button that confirms deleting the group.
  ///
  /// In en, this message translates to:
  /// **'Delete group'**
  String get groupsDeleteGroup;

  /// Tooltip of the rename button on the Groups screen.
  ///
  /// In en, this message translates to:
  /// **'Rename'**
  String get groupsRenameTooltip;

  /// Section heading: the group’s members.
  ///
  /// In en, this message translates to:
  /// **'Who’s in it'**
  String get groupsWhoIsIn;

  /// Under an imported person's name in a group's member list. date is when they sent it, already formatted.
  ///
  /// In en, this message translates to:
  /// **'Imported · read-only, as of {date}'**
  String groupsImportedAsOf(String date);

  /// Under the name of a group member whose history is logged on this phone.
  ///
  /// In en, this message translates to:
  /// **'Tracked on this phone'**
  String get groupsTrackedHere;

  /// Section heading.
  ///
  /// In en, this message translates to:
  /// **'Add to the group'**
  String get groupsAddTo;

  /// Item on a group's screen: add a new person tracked on this phone.
  ///
  /// In en, this message translates to:
  /// **'Add someone new'**
  String get groupsAddNew;

  /// Under the 'Add someone new' item on a group's screen.
  ///
  /// In en, this message translates to:
  /// **'Tracked on this phone: you log their periods here.'**
  String get groupsAddNewHint;

  /// Item on a group's screen: scan someone's codes from their own phone.
  ///
  /// In en, this message translates to:
  /// **'Import from their phone'**
  String get groupsImportFromPhone;

  /// Under the 'Import from their phone' item on a group's screen.
  ///
  /// In en, this message translates to:
  /// **'They keep tracking on their own phone and send it here, read-only. Importing them again brings them up to date.'**
  String get groupsImportFromPhoneHint;

  /// Item, in red, at the foot of a group's screen.
  ///
  /// In en, this message translates to:
  /// **'Delete this group'**
  String get groupsDeleteThis;

  /// Error under a name field when the name is already used by someone on this phone, including 'You'.
  ///
  /// In en, this message translates to:
  /// **'That name is already used on this phone.'**
  String get peopleNameTaken;

  /// Label of the field for a person’s (or group’s) name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get peopleName;

  /// Opens a view of everyone in the group side by side.
  ///
  /// In en, this message translates to:
  /// **'See {group} together'**
  String peopleSeeTogether(String group);

  /// Heading over people who are in no group.
  ///
  /// In en, this message translates to:
  /// **'Not in a group'**
  String get peopleNotInGroup;

  /// Item in the people chooser: start tracking another person on this phone.
  ///
  /// In en, this message translates to:
  /// **'Add someone'**
  String get peopleAddSomeone;

  /// Title of the dialog that adds a person.
  ///
  /// In en, this message translates to:
  /// **'Track someone else'**
  String get peopleTrackSomeoneElse;

  /// Helper under the name field when adding someone to track.
  ///
  /// In en, this message translates to:
  /// **'Just something to tell people apart — a first name, a nickname or an initial.'**
  String get peopleNameHint;

  /// A name given to an unnamed person when restoring a backup. Saved as their name; they can rename it.
  ///
  /// In en, this message translates to:
  /// **'Person {number}'**
  String backupUnnamedPerson(int number);

  /// Error raised while reading a backup file that isn't an Ebb backup; shown where the restore failed.
  ///
  /// In en, this message translates to:
  /// **'This file isn\'t an Ebb backup.'**
  String get backupNotEbb;

  /// Error when restoring or receiving a backup made by a newer Ebb.
  ///
  /// In en, this message translates to:
  /// **'This backup was made by a newer version of Ebb. Update Ebb, then try again.'**
  String get backupNewer;

  /// Error when a backup file has no people in it.
  ///
  /// In en, this message translates to:
  /// **'This backup has no one in it.'**
  String get backupNoOne;

  /// Error when a backup file has two people with the same id; the file is damaged.
  ///
  /// In en, this message translates to:
  /// **'This backup looks damaged: two people in it have the same id.'**
  String get backupSameId;

  /// date is written YYYY-MM-DD.
  ///
  /// In en, this message translates to:
  /// **'{date} is after the day this backup was made.'**
  String backupAfterExport(String date);

  /// Error when two people in a backup file share a name. name is as it appears in the file.
  ///
  /// In en, this message translates to:
  /// **'Two people in this backup are both called {name}.'**
  String backupSameName(String name);

  /// Error when two groups in a backup file share a name. group is as it appears in the file.
  ///
  /// In en, this message translates to:
  /// **'Two groups in this backup are both called {group}.'**
  String backupSameGroupName(String group);

  /// date is written YYYY-MM-DD.
  ///
  /// In en, this message translates to:
  /// **'The period starting {date} ends before it begins.'**
  String backupEndsBefore(String date);

  /// date is written YYYY-MM-DD.
  ///
  /// In en, this message translates to:
  /// **'Two periods start on {date} for the same person.'**
  String backupTwoStarts(String date);

  /// date is written YYYY-MM-DD.
  ///
  /// In en, this message translates to:
  /// **'{date} appears twice for the same person.'**
  String backupDayTwice(String date);

  /// date is written YYYY-MM-DD.
  ///
  /// In en, this message translates to:
  /// **'The period starting {date} overlaps the one before it.'**
  String backupOverlaps(String date);

  /// A backup file that can’t be restored because one part of it is unreadable.
  ///
  /// In en, this message translates to:
  /// **'This backup looks damaged: the backup could not be read.'**
  String get backupDamaged;

  /// A backup file that can’t be restored because one part of it is unreadable.
  ///
  /// In en, this message translates to:
  /// **'This backup looks damaged: the export date could not be read.'**
  String get backupDamagedExportDate;

  /// A backup file that can’t be restored because one part of it is unreadable.
  ///
  /// In en, this message translates to:
  /// **'This backup looks damaged: a group could not be read.'**
  String get backupDamagedGroup;

  /// A backup file that can’t be restored because one part of it is unreadable.
  ///
  /// In en, this message translates to:
  /// **'This backup looks damaged: a group’s name could not be read.'**
  String get backupDamagedGroupName;

  /// A backup file that can’t be restored because one part of it is unreadable.
  ///
  /// In en, this message translates to:
  /// **'This backup looks damaged: the people in the group {group} could not be read.'**
  String backupDamagedGroupPeople(String group);

  /// A backup file that can’t be restored because one part of it is unreadable.
  ///
  /// In en, this message translates to:
  /// **'This backup looks damaged: a person entry could not be read.'**
  String get backupDamagedPerson;

  /// A backup file that can’t be restored because one part of it is unreadable.
  ///
  /// In en, this message translates to:
  /// **'This backup looks damaged: a name could not be read.'**
  String get backupDamagedName;

  /// A backup file that can’t be restored because one part of it is unreadable.
  ///
  /// In en, this message translates to:
  /// **'This backup looks damaged: a person’s id could not be read.'**
  String get backupDamagedPersonId;

  /// A backup file that can’t be restored because one part of it is unreadable.
  ///
  /// In en, this message translates to:
  /// **'This backup looks damaged: the day a history was shared could not be read.'**
  String get backupDamagedSharedOn;

  /// A backup file that can’t be restored because one part of it is unreadable.
  ///
  /// In en, this message translates to:
  /// **'This backup looks damaged: a period entry could not be read.'**
  String get backupDamagedPeriod;

  /// A backup file that can’t be restored because one part of it is unreadable.
  ///
  /// In en, this message translates to:
  /// **'This backup looks damaged: a period start could not be read.'**
  String get backupDamagedPeriodStart;

  /// A backup file that can’t be restored because one part of it is unreadable.
  ///
  /// In en, this message translates to:
  /// **'This backup looks damaged: a period end could not be read.'**
  String get backupDamagedPeriodEnd;

  /// A backup file that can’t be restored because one part of it is unreadable.
  ///
  /// In en, this message translates to:
  /// **'This backup looks damaged: a day entry could not be read.'**
  String get backupDamagedDay;

  /// A backup file that can’t be restored because one part of it is unreadable. date is written YYYY-MM-DD.
  ///
  /// In en, this message translates to:
  /// **'This backup looks damaged: the flow on {date} could not be read.'**
  String backupDamagedFlow(String date);

  /// A backup file that can’t be restored because one part of it is unreadable. date is written YYYY-MM-DD.
  ///
  /// In en, this message translates to:
  /// **'This backup looks damaged: a symptom on {date} could not be read.'**
  String backupDamagedSymptom(String date);

  /// A backup file that can’t be restored because one part of it is unreadable. date is written YYYY-MM-DD.
  ///
  /// In en, this message translates to:
  /// **'This backup looks damaged: the rating on {date} could not be read.'**
  String backupDamagedRating(String date);

  /// A backup file that can’t be restored because one part of it is unreadable. date is written YYYY-MM-DD.
  ///
  /// In en, this message translates to:
  /// **'This backup looks damaged: the feeling on {date} could not be read.'**
  String backupDamagedFeeling(String date);

  /// A backup file that can’t be restored because one part of it is unreadable. date is written YYYY-MM-DD.
  ///
  /// In en, this message translates to:
  /// **'This backup looks damaged: the temperature on {date} could not be read.'**
  String backupDamagedTemperature(String date);

  /// A backup file that can’t be restored because one part of it is unreadable. date is written YYYY-MM-DD.
  ///
  /// In en, this message translates to:
  /// **'This backup looks damaged: the cervical mucus on {date} could not be read.'**
  String backupDamagedMucus(String date);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'de',
    'en',
    'es',
    'fr',
    'it',
    'pt',
    'ru',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'it':
      return AppLocalizationsIt();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
