# Changelog

## 3.0.2+450

1. fix(macos): update entitlements
2. chore(deps): update deps

## 3.0.1+449

1. refactor: update plugins
2. chore(deps): update deps
3. Update flutter to 3.32.4

## 3.0.0+448

1. feat(msi): add license dialog
2. chore(deps): update deps
3. refactor: update wix project (#394)
4. Migrate Gradle scripts to KTS (#398)
5. fix: rename the zip file to a portable file (#399)
6. Update flutter to 3.32.2

## 2.5.4+447

1. feat: add pro version for macos

## 2.5.3+446

1. fix: add libayatana-appindicator
2. fix(exe): specifies which architectures Setup is allowed to run on
3. ci(windows): remove invalid characters "`" in workflows
4. fix(exe): update the default installation directory
5. fix: update copyright
6. fix: replace `app_settings_plus` with `app_settings`
7. chore(deps): update deps
8. fix(web): update icons for pro version
9. fix: update the icon for the about page
10. docs: update readme
11. ci(snaps): update workflows

## 2.5.2+445

1. fix: add `rust-version` to the environment variables
2. fix(linux): update application id for pro version
3. fix: update icons for pro version
4. ci: add `run-name` to release-web.yml
5. fix: add the old id tag to a replaces tag
6. chore(deps): update deps

## 2.5.1+444

1. feat: add pro version for windows
2. feat: add pro version for linux
3. fix: Error information: "Error: SignerSign() failed."
4. ci: update workflows
5. chore(deps): update deps
6. test: add portable windows exe
7. fix(macos): modify the default window size
8. fix: update the default toolchain version for cargokit
9. fix: The element id in picguard-pro.metainfo.xml is not closed

## 2.5.0+443

1. drag and drop files to app
2. fix: add license.rtf to the windows folder
3. Revert "ci: update linux runner to ubuntu-24.04"
4. ci: update macos runner to macos-15
5. ci: update workflows

## 2.0.1+442

1. fix: update the color of the privacy dialog in dark mode
2. chore(deps): update deps
3. fix(macos): update macOS deployment target to 11.0

## 2.0.0+441

1. feat: add eula file to dmg and pkg
2. ci: update linux runner to ubuntu-24.04
3. build: migrate flutter_distributor to fastforge
4. fix: can not set icon file when packaging exe
5. feat: add tray manager
6. chore(deps): update deps
7. fix: update workflows

## 1.1.0+440

1. fix: update scripts
2. feat: add menu bar
3. chore(deps): update deps
4. feat: add about page
5. chore(deps): update deps

## 1.0.15+439

1. fix: update flavors for iOS and macOS
2. fix(deps): update deps
3. refactor: Enable adaptive layout on web and desktop platforms
4. fix: add i18n support for color labels
5. refactor: update ImageGroup widget

## 1.0.14+438

1. fix(deps): update deps
2. fix: update font family
3. fix: correct git errors in flutter

## 1.0.13+437

1. fix(deps): update deps

## 1.0.12+436

1. ci(linux): add snap support
2. ci(linux): add appimage support
3. fix(deps): update deps
4. fix(linux): remove zip support

## 1.0.11+435

1. fix(deps): update deps
2. fix: update slang config
3. fix: remove flatpack support
4. fix: remove snapcraft support
5. fix: remove pacman support

## 1.0.10+434

1. Update deps
2. Update workflows
3. Update android sdk to 35

## 1.0.9+433

1. Update deps

## 1.0.8+432

1. Update deps
2. Update workflows

## 1.0.7+429

1. fix: Incorrect environment variable name

## 1.0.7+428

1. fix: Crash on mobile browsers
2. fix: Update metainfo for F-Droid

## 1.0.6+427

1. Update deps
2. Update license

## 1.0.6+426

1. refactor: Update CI

## 1.0.5+425

1. Update deps
2. Disable multiple APKs for ABIs
3. refactor: remove unused workflows
4. fix: remove VCredist.wxs

## 1.0.5+424

1. Update deps
2. Building from source on Linux arm64
3. Update flutter to v3.24.5

## 1.0.5+423

1. Update deps
2. Update target

## 1.0.4+422

1. fix: The loading box won't disappear
2. chore(deps): update plugin com.android.application to v8.7.2

## 1.0.4+421

1. fix: update snap version
2. Update deps
3. Migrate to `com.kjxbyz.picguard`

## 1.0.4+420

1. Update macos deployment target
2. Remove deps
3. Replace pnpm with npm
4. Added callbacks to linux app

## 1.0.4+419

1. Update deps

## 1.0.4+418

1. fix: Macs with Apple silicon support issue
2. Update deps

## 1.0.3+417

1. Migrating to Linux ARM64

## 1.0.3+416

1. Update deps
2. Update icons

## 1.0.3+415

1. Fix Android Compilation issues
2. Update metainfo
3. Update deps
4. Fix Missing potentially required entitlement

## 1.0.3+414

1. Update developer
2. Update deps
3. Update msi

## 1.0.3+413

1. Update minSdkVersion to 24
2. fix: comply with F-Droid version code schema

## 1.0.3+412

1. Add pro version for windows
2. Fix privacy manifest for app_settings in macOS

## 1.0.2+411

1. Add pro version for windows
2. Fix privacy manifest for app_settings in macOS

## 1.0.2+410

1. Fix invalid language

## 1.0.2+409

1. Remove com.kjxbyz.PicGuard.metainfo.xml
2. Update deps

## 1.0.2+408

1. No certificate is required when publishing to the Microsoft Store.
2. Update deps

## 1.0.2+407

1. Add F-Droid support
2. Bug Fixes
3. Update docs
4. Update deps

## 1.0.1+406

1. Create Italian translation
2. Fixed UI overflow
3. Update deps

## 1.0.1+405

1. Update entitlements

## 1.0.0+404

1. Revert "Update Orientations"

## 1.0.0+403

1. Update deps
2. Update Orientations & entitlements
3. Revert "Add pro version for windows"

## 1.0.0+402

1. Configure multiple APKs for ABIs
2. fix: The bundle didn't include arm64 when building on Intel-based Macs

## 1.0.0+401

1. Update metainfo for linux

## 1.0.0+400

1. Add winget package automatic update

## 1.0.0+399

1. Update external data checker
2. Update metainfo for linux

## 1.0.0+398

1. Add pro version for windows

## 1.0.0+397

1. Add arm64 support for `snapcraft`

## 1.0.0+396

1. Fix needs in github actions
2. Added metainfo on linux
3. Update email

## 1.0.0+395

1. Update developer name
2. Update icons for mac

## 1.0.0+394

1. Update manifest for flatpak

## 1.0.0+393

1. Update manifest for flathub
2. Update image version
3. Update bottom padding for BottomSheet
4. Update FUNDING.yml
5. Update SettingsBtn
6. Update deps
7. Remove test.sh

## 1.0.0+392

1. Remove `Version` key from `desktop` file

## 1.0.0+391

1. Update logo for linux
