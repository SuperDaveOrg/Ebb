# Releasing Ebb

How versions are numbered, how a release is built, and how the signing key is
kept. Modelled on LedgerSprout's release process, minus the server: Ebb has
nothing to deploy.

## Version numbers

Ebb uses [semantic versioning](https://semver.org), `MAJOR.MINOR.PATCH`,
starting at **0.1.0**. While the major number is 0 the app is early and the
rules are looser, as with LedgerSprout.

| Bump | When |
|---|---|
| **Patch** (0.1.0 → 0.1.1) | Fixes only. Nothing new to learn. |
| **Minor** (0.1.1 → 0.2.0) | New features, new screens, a database migration. |
| **Major** (0.x → 1.0, 1.x → 2.0) | 1.0 when it's been used for real and the open roadmap questions are settled. After that, only for a change existing users must know about — above all, anything that stops older backup files restoring. |

**The version lives in one place:** `pubspec.yaml`, as `NAME+CODE`. Android's
version code is derived from the name, never counted by hand:

```
code = major * 10000 + minor * 100 + patch        0.1.0 → 100, 1.2.3 → 10203
```

So minor and patch stay below 100, and the code always goes up with the
version, which Android and F-Droid require. `tool/bump_version.sh` enforces
both.

Three other version numbers exist and move **independently** of the app's:

| Number | Where | Changes when |
|---|---|---|
| Database schema | `EbbDatabase.version` | The tables change. Add a migration; never edit a shipped one. |
| Backup format | `ebbBackup` in files, `backupFormatVersion` | A field changes meaning. See `docs/backup-format.md`. |
| QR frame format | `EBB1` prefix | The transfer encoding changes. |

## Tags

A release is an annotated tag `vX.Y.Z` on `main`, matching `pubspec.yaml`.
F-Droid watches these tags to find new versions, so a tag is a promise: never
move or reuse one.

## The signing key

Every APK is signed, and Android will only install an update signed with the
**same key** as the version already installed. So:

- **Lose the key and you can never update the app** for anyone who has it —
  they'd have to uninstall, losing their data unless they'd backed up.
- **Leak the key** and someone else can publish "updates".

Keep it outside the repository, with a backup somewhere safe (an encrypted
USB stick, a password manager's file storage). The build refuses to use the
debug key for a release.

F-Droid publishes APKs signed with this key too: it rebuilds each release
and ships the one from the GitHub release if the two match (see
"Reproducible builds"). So one key covers every copy of Ebb — F-Droid,
GitHub releases, IzzyOnDroid, the website — and people can update from any
of them.

### Creating it (once)

```bash
mkdir -p ~/.android-keys
keytool -genkeypair -v \
  -keystore ~/.android-keys/ebb-release.jks \
  -alias ebb -keyalg RSA -keysize 4096 -validity 36500 \
  -dname "CN=SuperDaveLab"
```

Then create `android/key.properties` (gitignored — never commit it):

```properties
storeFile=/home/dave/.android-keys/ebb-release.jks
storePassword=…
keyAlias=ebb
keyPassword=…
```

## Cutting a release

`main` only changes through pull requests that pass CI (the "Protect main"
ruleset on GitHub), so the version bump goes through one too. Tags aren't
covered by the ruleset; the tag is pushed on its own once the bump is merged.

```bash
# 1. Make sure main is what you want to ship, and CHANGELOG.md's
#    "Unreleased" section describes it.
git switch main && git pull

# 2. Set the version on a branch. Turns "Unreleased" into this version's
#    section.
git switch -c release-0.2.0
tool/bump_version.sh minor          # or patch / major / an exact X.Y.Z

# 2b. Write the store's release notes: a short, user-facing summary of the
#     CHANGELOG.md section, 500 characters at most, in
#     fastlane/metadata/android/en-US/changelogs/<versionCode>.txt (200.txt
#     for 0.2.0). bump_version.sh prints the name; build_release.sh refuses to
#     build without it.

# 3. Commit, open a pull request, and merge it once CI passes. The notes are
#    a new file, so add them first: `commit -a` skips untracked files.
git add fastlane/metadata/android/en-US/changelogs/
git commit -am "Release v0.2.0"
git push -u origin release-0.2.0
gh pr create --fill && gh pr merge --rebase   # after CI is green

# 4. Tag the merged commit on main, and push only the tag.
git switch main && git pull
git tag -a v0.2.0 -m "Release v0.2.0"
git push origin v0.2.0

# 5. Build from the tag.
tool/build_release.sh --ref v0.2.0

# 6. Publish the APK and update the page at ebb.superdavelab.com.
tool/deploy_site.sh --dry-run       # check first
tool/deploy_site.sh

# 7. Publish the same APK as a GitHub release.
tool/github_release.sh --dry-run 0.2.0
tool/github_release.sh 0.2.0
```

`tool/deploy_site.sh` builds the page from `site/`, fills in the version,
date, size and SHA-256 from the newest release APK in `dist/release/` (never a
snapshot or debug-signed build), and rsyncs it to
`root@davekoons.com:/var/www/ebb`. Like LedgerSprout's deploy script, it never
deletes anything on the server, so earlier APKs stay downloadable.

`tool/build_release.sh` builds in a clean temporary checkout of exactly that
tag, runs `flutter analyze` and `flutter test`, and then **refuses** the APK if:

- it asks for any permission outside the allow-list at the top of the script
  (notifications, boot, vibrate, camera) — `INTERNET` above all;
- it's signed with the debug key;
- its version doesn't match `pubspec.yaml`, or the code doesn't match the
  formula.

Output lands in `dist/release/` (gitignored): `ebb-X.Y.Z.apk`, its `.sha256`,
and a `BUILD-INFO.txt` recording the commit, Flutter version and signing
certificate. Builds from an untagged commit are named
`ebb-X.Y.Z-<commit>.apk` so they can't pass for a release.

`build_release.sh` uploads nothing; publishing is steps 6 and 7, separate
and deliberate.

`tool/github_release.sh` attaches that same APK and its `.sha256` to a GitHub
release for the tag, with the version's CHANGELOG.md section and the signing
certificate's fingerprint as the notes. It checks the APK was built from the
commit the tag points to on GitHub. It's the same file the site offers:
signed by this key, not built by CI. IzzyOnDroid can pick new versions up
from these releases.

## Reproducible builds

F-Droid rebuilds each release from source and publishes the developer-signed
APK only if its own build matches byte for byte. What makes that work:

- `build_release.sh` always builds at `/tmp/ebb-build`, because Flutter
  writes the build path into the compiled app. F-Droid's recipe builds there
  too.
- Packages come from `pubspec.lock` exactly (`--enforce-lockfile`), fetched
  into the build directory.
- `android/app/build.gradle.kts` leaves out AGP's VCS info and the
  dependency-metadata signing block, which F-Droid rejects.
- F-Droid deletes the `signingConfigs` block and the `signingConfig =` line
  from `build.gradle.kts` before building, one whole line at a time, so its
  APK comes out unsigned. Keep that line a single line (the choice of key is
  made in `releaseSigning` above it): split over several lines, the leftover
  pieces stop the file compiling, which is how Ebb's first F-Droid build
  failed.
- `android/reproducible.cmake` drops the linker build ID from native plugin
  code (the QR scanner's zxing-cpp).

Checked for v0.3.0: a rebuild with the Flutter SDK at a different path gave
an APK that `apksigcopier compare` accepts against the released one — the
same check F-Droid runs. Not yet checked: a different Android SDK/NDK path.
F-Droid's first build settles that; if it doesn't match, remove `Binaries`
and `AllowedAPKSigningKeys` from the recipe and F-Droid signs with its own
key instead (then its users can't update from the website's APK, or back).

To run the check yourself (`sudo apt install apksigcopier`):

```bash
apksigcopier compare dist/release/ebb-X.Y.Z.apk other-build.apk && echo match
```

## F-Droid

The recipe is drafted in [fdroid/com.superdavelab.ebb.yml](fdroid/com.superdavelab.ebb.yml).
It follows fdroiddata's `templates/build-flutter.yml` and has no comments,
because fdroiddata wants none, so the reasoning lives here:

- Flutter comes from F-Droid's `flutter` srclib, checked out at the version
  pinned in `.github/workflows/ci.yml`. Bumping Flutter there is enough;
  F-Droid follows on the next release.
- The source is moved to `/tmp/ebb-build` for `pub get` and the build, the
  same path `build_release.sh` uses, then moved back.
- `PUB_CACHE` is inside the source, so F-Droid's scanner checks every
  package; `scandelete` removes any binary it flags.
- One universal APK (no `--split-per-abi`), because it has to match the APK
  on the GitHub release byte for byte.
Before changing the recipe or anything about the build, test it locally:
`tool/fdroid_build_test.sh --ref <commit>` runs F-Droid's own build of that
commit in the Docker image fdroiddata's CI uses, and, if `dist/release/` has
a signed APK from the same commit, checks F-Droid's build matches it. A
failure there costs ten minutes instead of a round trip through the merge
request's pipeline.

To submit: fork https://gitlab.com/fdroid/fdroiddata, add it as
`metadata/com.superdavelab.ebb.yml` with the version fields set to a real
release, and open a merge request. After that, F-Droid finds new versions
from the tags on its own — no new merge request per release. Store text,
screenshots and per-version changelogs come from `fastlane/metadata/android/`
in this repo, keyed by version code.

## Keeping up to date

Flutter moves fast. For one developer the aim is to upgrade on purpose, not
constantly.

- **Packages** (pub.dev): Dependabot opens **one grouped pull request a month**
  with minor and patch updates (`.github/dependabot.yml`). CI runs on it —
  tests plus the permission check — so a green one is safe to merge. Major
  versions are ignored; take those deliberately.
- **The Flutter SDK is pinned** — **3.47.5**, in `.github/workflows/ci.yml`.
  Dependabot never touches it. Upgrade it deliberately, once or twice a year
  or when a plugin demands it, and do it locally and in CI together:
  `flutter upgrade`, fix what breaks (usually Gradle, the Android Gradle
  Plugin or Kotlin), update `flutter-version` in `ci.yml`, commit both.
- **`pubspec.lock` is committed**, so nothing changes under you between
  upgrades — and F-Droid builds exactly those versions.
- **Why there's no rush:** with no network access, most published
  vulnerabilities in dependencies can't be reached. The risk that matters is
  a dependency *adding a permission*, and CI catches that on every push.
- **Fewer dependencies, less churn.** Prefer a few lines of platform code over
  a plugin when the need is small, as with the backup file pickers.

Known item to watch: `flutter_timezone` still applies the Kotlin Gradle Plugin
the old way, which Flutter warns will eventually stop building. Look for an
update before the next SDK upgrade.

## Not yet

- **Release builds in CI.** CI already checks every push, debug-signed. A
  tag-triggered signed build, like LedgerSprout's, would need the signing key
  as a repository secret. Worth it once releases are regular; until then the
  key stays on one machine.
- **Per-processor APKs.** The script builds one universal APK, and so does
  F-Droid's recipe, since it must match it.
- **Generated changelogs.** The per-version files in
  `fastlane/metadata/android/en-US/changelogs/` are written by hand;
  generating them from `CHANGELOG.md` would keep the two in step.
