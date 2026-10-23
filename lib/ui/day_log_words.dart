import 'package:ebb/domain/moon.dart';
import 'package:ebb/models/day_log.dart';
import 'package:ebb/ui/wording.dart';

/// What can be logged on a day, and the moon's phases, in the language on
/// screen. Kept out of the models, which are stored by name and never say
/// anything.

extension FlowWords on Flow {
  /// "Spotting", on a chip under Flow.
  String get word => switch (this) {
    Flow.none => strings.dayFlowNone,
    Flow.spotting => strings.dayFlowSpotting,
    Flow.light => strings.dayFlowLight,
    Flow.medium => strings.dayFlowMedium,
    Flow.heavy => strings.dayFlowHeavy,
  };
}

extension MucusFeelWords on MucusFeel {
  /// On a chip under "How it felt", where "felt" goes without saying.
  String get chip => switch (this) {
    MucusFeel.dry => strings.dayMucusFeelDry,
    MucusFeel.nothing => strings.dayMucusNothing,
    MucusFeel.wet => strings.dayMucusFeelWet,
    MucusFeel.slippery => strings.dayMucusFeelSlippery,
  };

  /// Mid-sentence: "nothing felt".
  String get inline => strings.dayMucusFeelInline(name);
}

extension MucusLookWords on MucusLook {
  /// On a chip under "How it looked".
  String get chip => switch (this) {
    MucusLook.nothing => strings.dayMucusNothing,
    MucusLook.creamy => strings.dayMucusLookCreamy,
    MucusLook.eggWhite => strings.dayMucusLookEggWhite,
  };

  /// Mid-sentence: "nothing seen".
  String get inline => strings.dayMucusLookInline(name);
}

extension FeelingWords on Feeling {
  /// "Happy", beside its face.
  String get word => switch (this) {
    Feeling.happy => strings.dayFeelingHappy,
    Feeling.calm => strings.dayFeelingCalm,
    Feeling.loving => strings.dayFeelingLoving,
    Feeling.energetic => strings.dayFeelingEnergetic,
    Feeling.tired => strings.dayFeelingTired,
    Feeling.sad => strings.dayFeelingSad,
    Feeling.anxious => strings.dayFeelingAnxious,
    Feeling.irritable => strings.dayFeelingIrritable,
    Feeling.angry => strings.dayFeelingAngry,
    Feeling.confused => strings.dayFeelingConfused,
  };
}

extension MoonPhaseWords on MoonPhase {
  /// "Full moon".
  String get word => switch (this) {
    MoonPhase.newMoon => strings.calendarMoonNew,
    MoonPhase.firstQuarter => strings.calendarMoonFirstQuarter,
    MoonPhase.full => strings.calendarMoonFull,
    MoonPhase.lastQuarter => strings.calendarMoonLastQuarter,
  };
}
