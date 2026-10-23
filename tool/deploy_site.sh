#!/usr/bin/env bash
set -euo pipefail

# Build ebb.superdavelab.com and deploy it to Apache on the SuperDaveLab host.
#
# Assembles dist/site/ from site/ plus: the logo, the store-listing
# screenshots (fastlane/.../phoneScreenshots — one set of files for the README,
# F-Droid and the page), and the newest *release* APK from dist/release/
# (build it first with tool/build_release.sh --ref vX.Y.Z). The page's
# double-brace placeholders are filled from that release: version, date,
# size, SHA-256.
#
# site/beta/ (ebb.superdavelab.com/beta/) offers a preview of the next
# version instead: the newest *snapshot* build, an untagged commit signed with
# the release key and built after that release (tool/build_release.sh --ref
# <branch>). The main page asks for testers only while there's one; with
# none, the beta page says there's no preview right now.
#
# Then rsyncs dist/site/ to the server. Like LedgerSprout's deploy script, this
# never deletes anything remotely — old APKs stay downloadable until you remove
# them by hand.
#
# Usage:
#   tool/deploy_site.sh [--build-only | --dry-run]
#
# Options:
#   --build-only   Assemble dist/site/ and stop (open dist/site/index.html,
#                  and dist/site/beta/index.html)
#   --dry-run      Assemble, then show what rsync would send; touch nothing
#   -h, --help     Show this help
#
# Environment overrides:
#   SSH_TARGET     default root@davekoons.com
#   REMOTE_DIR     default /var/www/ebb
#   SITE_DOMAIN    default ebb.superdavelab.com (for the post-deploy check)

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SSH_TARGET="${SSH_TARGET:-root@davekoons.com}"
REMOTE_DIR="${REMOTE_DIR:-/var/www/ebb}"
SITE_DOMAIN="${SITE_DOMAIN:-ebb.superdavelab.com}"
MODE=deploy

# Prints the comment block at the top of this file, and nothing after it.
usage() { awk 'NR > 1 && /^#/ { sub(/^# ?/, ""); print; seen = 1; next } seen { exit }' "$0"; }
die() { echo "deploy_site: $*" >&2; exit 1; }
say() { echo "==> $*"; }

while [[ $# -gt 0 ]]; do
  case "$1" in
    --build-only) MODE=build; shift ;;
    --dry-run) MODE=dry; shift ;;
    -h|--help) usage; exit 0 ;;
    *) usage; exit 1 ;;
  esac
done

cd "$REPO"

# --- The release to offer ----------------------------------------------------

apk=""
for info in dist/release/ebb-*.BUILD-INFO.txt; do
  [[ -f $info ]] || continue
  grep -q '^kind *release$' "$info" || continue   # never a snapshot or debug build
  candidate="dist/release/$(sed -n 's/^name *//p' "$info")"
  [[ -f $candidate ]] && apk="$apk$candidate"$'\n'
done
apk="$(printf '%s' "$apk" | sort -V | tail -1)"
[[ -n $apk ]] || die "no release APK in dist/release/ — run tool/build_release.sh --ref vX.Y.Z"

# Checks an APK against its .sha256 and prints the hash.
apk_sha256() {
  [[ -f $1.sha256 ]] || die "missing $1.sha256"
  local sha
  sha="$(cut -d' ' -f1 "$1.sha256")"
  [[ "$(sha256sum "$1" | cut -d' ' -f1)" == "$sha" ]] || die "$(basename "$1") doesn't match its .sha256"
  echo "$sha"
}

apk_size() { awk '{ printf "%.0f MB", $1 / 1000000 }' <<< "$(stat -c %s "$1")"; }

APK_FILE="$(basename "$apk")"
VERSION="$(sed -E 's/^ebb-(.+)\.apk$/\1/' <<< "$APK_FILE")"
APK_SHA256="$(apk_sha256 "$apk")"
APK_SIZE="$(apk_size "$apk")"
# The tag's date, not the build's: the day the version was released.
RELEASE_DATE="$(git log -1 --format=%cd --date=format:'%B %-d, %Y' "v$VERSION" 2>/dev/null)" ||
  die "no tag v$VERSION"
YEAR="$(date +%Y)"

# --- The preview to offer -----------------------------------------------------

# The newest universal snapshot built after the release, so a preview whose
# changes have since been released stops being offered. Never a debug-signed
# build.
built_of() { sed -n 's/^built *//p' "$1"; }
release_built="$(built_of "${apk%.apk}.BUILD-INFO.txt")"
beta="" beta_info="" beta_built=""
for info in dist/release/ebb-*.BUILD-INFO.txt; do
  [[ -f $info ]] || continue
  grep -q '^kind *snapshot$' "$info" || continue
  grep -q '^signer .*Android Debug' "$info" && continue
  built="$(built_of "$info")"
  candidate="dist/release/$(sed -n 's/^name *//p' "$info")"
  [[ -f $candidate && $built > $beta_built && $built > $release_built ]] || continue
  beta="$candidate" beta_info="$info" beta_built="$built"
done

if [[ -n $beta ]]; then
  BETA_APK_FILE="$(basename "$beta")"
  BETA_VERSION="$(sed -E 's/^ebb-(.+)\.apk$/\1/' <<< "$BETA_APK_FILE")"
  BETA_APK_SHA256="$(apk_sha256 "$beta")"
  BETA_APK_SIZE="$(apk_size "$beta")"
  BETA_BUILT="$(date -d "$beta_built" +'%B %-d, %Y')"
  BETA_COMMIT="$(sed -n 's/^commit *//p' "$beta_info")"
  # The page links to the commit on GitHub.
  [[ -n "$(git branch -r --contains "$BETA_COMMIT" 2>/dev/null)" ]] ||
    echo "Note: preview commit ${BETA_COMMIT:0:9} isn't on any remote branch, so the beta page's"$'\n'"      source link won't work until it's pushed."
fi

# --- Assemble -----------------------------------------------------------------

OUT="dist/site"
say "Building $OUT for Ebb $VERSION"
rm -rf "$OUT"
mkdir -p "$OUT/assets/screenshots" "$OUT/downloads"
cp -r site/. "$OUT/"
cp assets/brand/ebb_logo_512.png "$OUT/assets/logo.png"
cp fastlane/metadata/android/en-US/images/phoneScreenshots/*.png "$OUT/assets/screenshots/"
cp "$apk" "$apk.sha256" "$OUT/downloads/"
[[ -n $beta ]] && cp "$beta" "$beta.sha256" "$OUT/downloads/"

# The stylesheet's URL changes with its content, so a browser holding an old
# copy can't pair it with new markup.
CSS_HASH="$(sha256sum site/style.css | cut -c1-10)"

sed -i \
  -e "s|{{CSS_HASH}}|$CSS_HASH|g" \
  -e "s|{{VERSION}}|$VERSION|g" \
  -e "s|{{APK_FILE}}|$APK_FILE|g" \
  -e "s|{{APK_SIZE}}|$APK_SIZE|g" \
  -e "s|{{APK_SHA256}}|$APK_SHA256|g" \
  -e "s|{{RELEASE_DATE}}|$RELEASE_DATE|g" \
  -e "s|{{YEAR}}|$YEAR|g" \
  "$OUT/index.html"

# The beta page keeps one of its two download blocks, and the main page's
# call for testers shows only while there's a preview to test.
if [[ -n $beta ]]; then
  sed -i -e '/<!-- \/\?BETA -->/d' "$OUT/index.html"
  sed -i \
    -e '/<!-- NO-BETA -->/,/<!-- \/NO-BETA -->/d' -e '/<!-- \/\?BETA -->/d' \
    -e "s|{{BETA_VERSION}}|$BETA_VERSION|g" \
    -e "s|{{BETA_LABEL}}|$BETA_VERSION|g" \
    -e "s|{{BETA_APK_FILE}}|$BETA_APK_FILE|g" \
    -e "s|{{BETA_APK_SIZE}}|$BETA_APK_SIZE|g" \
    -e "s|{{BETA_APK_SHA256}}|$BETA_APK_SHA256|g" \
    -e "s|{{BETA_BUILT}}|$BETA_BUILT|g" \
    -e "s|{{BETA_COMMIT}}|$BETA_COMMIT|g" \
    -e "s|{{BETA_COMMIT_SHORT}}|${BETA_COMMIT:0:9}|g" \
    "$OUT/beta/index.html"
else
  sed -i -e '/<!-- BETA -->/,/<!-- \/BETA -->/d' "$OUT/index.html"
  sed -i \
    -e '/<!-- BETA -->/,/<!-- \/BETA -->/d' -e '/<!-- \/\?NO-BETA -->/d' \
    -e "s|{{BETA_LABEL}}|none|g" \
    "$OUT/beta/index.html"
fi
sed -i \
  -e "s|{{CSS_HASH}}|$CSS_HASH|g" \
  -e "s|{{VERSION}}|$VERSION|g" \
  -e "s|{{YEAR}}|$YEAR|g" \
  "$OUT/beta/index.html"

for page in "$OUT/index.html" "$OUT/beta/index.html"; do
  if grep -o '{{[A-Z_]*}}' "$page" | sort -u | grep .; then
    die "unfilled placeholders above in $page"
  fi
done

echo "    $APK_FILE ($APK_SIZE), released $RELEASE_DATE"
echo "    sha256 $APK_SHA256"
if [[ -n $beta ]]; then
  echo "    preview: $BETA_APK_FILE ($BETA_APK_SIZE), built $BETA_BUILT"
else
  echo "    preview: none newer than the release; /beta/ says so"
fi

case "$MODE" in
  build)
    say "Built. Preview: $REPO/$OUT/index.html and $REPO/$OUT/beta/index.html"
    exit 0 ;;
  dry)
    say "Dry run: what would go to $SSH_TARGET:$REMOTE_DIR"
    rsync -avzn "$OUT/" "$SSH_TARGET:$REMOTE_DIR/"
    exit 0 ;;
esac

# --- Deploy -------------------------------------------------------------------

say "Deploying to $SSH_TARGET:$REMOTE_DIR (never deletes remote files)"
ssh "$SSH_TARGET" "mkdir -p '$REMOTE_DIR'"
rsync -avz "$OUT/" "$SSH_TARGET:$REMOTE_DIR/"

say "Checking https://$SITE_DOMAIN/"
if curl -fsS -o /dev/null "https://$SITE_DOMAIN/downloads/$APK_FILE" -r 0-0; then
  echo "    live: https://$SITE_DOMAIN/ serves $APK_FILE"
else
  echo "    not reachable yet — if the subdomain isn't set up, that's expected."
  echo "    Files are on the server in $REMOTE_DIR."
fi
