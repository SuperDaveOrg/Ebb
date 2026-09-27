#!/usr/bin/env bash
set -euo pipefail

# Run Ebb on the Android emulator, starting the emulator first if needed.
#
# Ends in an ordinary `flutter run`, so hot reload (r), hot restart (R) and
# quit (q) work as usual in this terminal.
#
# Usage:
#   tool/run_emulator.sh [options] [-- extra flutter run args]
#
# Options:
#   --avd <name>   Emulator to use (default: the first one, e.g. pixel_9_api36)
#   --sample       Put fictional histories in the emulator's Downloads.
#                  Restore one from Settings -> Restore from a backup:
#                    ebb-sample.json       "today" falls mid-cycle
#                    ebb-sample-gaps.json  periods left unlogged, a year
#                                          back and for the last two months
#   --fresh        Clear Ebb's data on the emulator first. Wipes whatever you
#                  had there.
#   --dark         Switch the emulator to dark mode
#   --light        Switch the emulator to light mode
#   -h, --help     Show this help
#
# Anything after -- goes to flutter run, e.g. `-- --profile`.
#
# A build signed with the release key can't install over a debug build (or
# the reverse), and --fresh doesn't help: that clears data, it doesn't
# uninstall. To switch, first: adb uninstall com.superdavelab.ebb

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PACKAGE="com.superdavelab.ebb"
SDK="${ANDROID_HOME:-${ANDROID_SDK_ROOT:-$HOME/Android/Sdk}}"
EMULATOR="$SDK/emulator/emulator"

AVD=""
SAMPLE=0
FRESH=0
THEME=""
FLUTTER_ARGS=()

# Prints the comment block at the top of this file, and nothing after it.
usage() { awk 'NR > 1 && /^#/ { sub(/^# ?/, ""); print; seen = 1; next } seen { exit }' "$0"; }
die() { echo "run_emulator: $*" >&2; exit 1; }
say() { echo "==> $*"; }

while [[ $# -gt 0 ]]; do
  case "$1" in
    --avd) AVD="$2"; shift 2 ;;
    --sample) SAMPLE=1; shift ;;
    --fresh) FRESH=1; shift ;;
    --dark) THEME=yes; shift ;;
    --light) THEME=no; shift ;;
    -h|--help) usage; exit 0 ;;
    --) shift; FLUTTER_ARGS=("$@"); break ;;
    *) usage; exit 1 ;;
  esac
done

command -v adb >/dev/null || die "adb not on PATH"
command -v flutter >/dev/null || die "flutter not on PATH"
[[ -x $EMULATOR ]] || die "no emulator at $EMULATOR (set ANDROID_HOME)"

if [[ -z $AVD ]]; then
  AVD="$("$EMULATOR" -list-avds | head -1)"
  [[ -n $AVD ]] || die "no emulators defined; create one in Android Studio"
fi

# An already-running emulator for this AVD, if any.
find_serial() {
  local s
  for s in $(adb devices | awk '/^emulator-/ {print $1}'); do
    if [[ "$(adb -s "$s" emu avd name 2>/dev/null | head -1 | tr -d '\r')" == "$AVD" ]]; then
      echo "$s"
      return
    fi
  done
}

SERIAL="$(find_serial)"
if [[ -z $SERIAL ]]; then
  say "Starting emulator $AVD"
  # Detached, so it outlives this script and the flutter session.
  nohup "$EMULATOR" -avd "$AVD" >/dev/null 2>&1 &
  for _ in $(seq 1 60); do
    sleep 2
    SERIAL="$(find_serial)"
    [[ -n $SERIAL ]] && break
  done
  [[ -n $SERIAL ]] || die "emulator didn't appear in adb within 2 minutes"
fi

say "Waiting for $SERIAL to finish booting"
adb -s "$SERIAL" wait-for-device
for _ in $(seq 1 120); do
  [[ "$(adb -s "$SERIAL" shell getprop sys.boot_completed 2>/dev/null | tr -d '\r')" == 1 ]] && break
  sleep 2
done
[[ "$(adb -s "$SERIAL" shell getprop sys.boot_completed | tr -d '\r')" == 1 ]] ||
  die "emulator didn't finish booting"

# A freshly booted emulator often sleeps, and the app would launch behind a
# dark, locked screen.
adb -s "$SERIAL" shell input keyevent KEYCODE_WAKEUP
adb -s "$SERIAL" shell wm dismiss-keyguard >/dev/null 2>&1 || true

if [[ -n $THEME ]]; then
  say "Emulator theme: $([[ $THEME == yes ]] && echo dark || echo light)"
  adb -s "$SERIAL" shell cmd uimode night "$THEME" >/dev/null
fi

if (( FRESH )); then
  if adb -s "$SERIAL" shell pm list packages | grep -q "package:$PACKAGE\$"; then
    say "Clearing Ebb's data on the emulator"
    adb -s "$SERIAL" shell pm clear "$PACKAGE" >/dev/null
  fi
fi

if (( SAMPLE )); then
  # The generator's end date sits 18 days ahead so that, as of today, the
  # owner is mid-cycle rather than "late". Every entry still lies in the past.
  sample="$(mktemp --suffix=.json)"
  (cd "$REPO" && dart run tool/sample_history.dart "$sample" "$(date -d '+18 days' +%F)" >/dev/null)
  adb -s "$SERIAL" push "$sample" /sdcard/Download/ebb-sample.json >/dev/null
  # Ends today, so the last two months really are empty.
  (cd "$REPO" && dart run tool/sample_history.dart --gaps "$sample" "$(date +%F)" >/dev/null)
  adb -s "$SERIAL" push "$sample" /sdcard/Download/ebb-sample-gaps.json >/dev/null
  rm -f "$sample"
  say "Sample histories in the emulator's Downloads: ebb-sample.json, ebb-sample-gaps.json"
  echo "    Restore one in Ebb: Settings -> Restore from a backup."
fi

say "flutter run on $SERIAL"
cd "$REPO"
exec flutter run -d "$SERIAL" "${FLUTTER_ARGS[@]}"
