// Copyright 2023 Insco. All rights reserved.
// This source code is licensed under the GNU General Public License v3.0.
// See the LICENSE file in the project root for full license information.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:menu_bar/menu_bar.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'package:picguard/app/config.dart';
import 'package:picguard/constants/values.dart';
import 'package:picguard/generated/colors.gen.dart';
import 'package:picguard/i18n/i18n.g.dart';
import 'package:picguard/logger/logger.dart';
import 'package:picguard/utils/utils.dart';

const macosMenuChannel = MethodChannel('macos_menu_channel');

/// menu bar for macOS
class MacOSMenuBar extends StatelessWidget {
  const MacOSMenuBar({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final appName = t.appName(flavor: AppConfig.shared.flavor);
    return PlatformMenuBar(
      menus: <PlatformMenuItem>[
        PlatformMenu(
          label: appName,
          menus: <PlatformMenuItem>[
            PlatformMenuItemGroup(
              members: <PlatformMenuItem>[
                PlatformMenuItem(
                  onSelected: DialogUtil.showAboutModal,
                  // onSelected: () async {
                  //   try {
                  //     await macosMenuChannel.invokeMethod('showAboutPanel');
                  //   } on PlatformException catch (e) {
                  //     printErrorLog(
                  //       'Cannot display the About window: ${e.message}',
                  //     );
                  //   }
                  // },
                  label: t.menus.about(appName: appName),
                ),
              ],
            ),
            PlatformMenuItemGroup(
              members: <PlatformMenuItem>[
                PlatformMenuItem(
                  onSelected: DialogUtil.showSettingsModal,
                  shortcut: const CharacterActivator(',', meta: true),
                  label: t.dialogs.settingsDialog.settings,
                ),
              ],
            ),
            PlatformMenuItemGroup(
              members: <PlatformMenuItem>[
                PlatformMenuItem(
                  onSelected: () async {
                    try {
                      await macosMenuChannel.invokeMethod('hideApp');
                    } on PlatformException catch (e) {
                      printErrorLog(
                        'Cannot hide this app: ${e.message}',
                      );
                    }
                  },
                  shortcut: const CharacterActivator('H', meta: true),
                  label: t.menus.hide(appName: appName),
                ),
                PlatformMenuItem(
                  onSelected: () async {
                    try {
                      await macosMenuChannel.invokeMethod('hideOtherApps');
                    } on PlatformException catch (e) {
                      printErrorLog(
                        'Cannot hide other apps: ${e.message}',
                      );
                    }
                  },
                  shortcut: const CharacterActivator(
                    ',',
                    control: true,
                    meta: true,
                  ),
                  label: t.menus.hideOthers,
                ),
                PlatformMenuItem(
                  onSelected: () async {
                    try {
                      await macosMenuChannel.invokeMethod('showAllApps');
                    } on PlatformException catch (e) {
                      printErrorLog(
                        'Cannot unhide all apps: ${e.message}',
                      );
                    }
                  },
                  label: t.menus.showAll,
                ),
              ],
            ),
            const PlatformMenuItemGroup(
              members: <PlatformMenuItem>[
                PlatformProvidedMenuItem(
                  type: PlatformProvidedMenuItemType.quit,
                ),
              ],
            ),
          ],
        ),
        PlatformMenu(
          label: t.menus.help,
          menus: <PlatformMenuItem>[
            PlatformMenuItemGroup(
              members: <PlatformMenuItem>[
                PlatformMenuItem(
                  onSelected: gotoSupportPage,
                  label: t.menus.support,
                ),
                PlatformMenuItem(
                  onSelected: gotoTermsOfUsePage,
                  label: t.menus.userAgreement,
                ),
                PlatformMenuItem(
                  onSelected: gotoPrivacyPage,
                  label: t.menus.privacy,
                ),
              ],
            ),
          ],
        ),
      ],
      child: child,
    );
  }
}

/// menu bar for Windows and Linux
class DesktopMenuBar extends StatelessWidget {
  const DesktopMenuBar({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;
    final t = Translations.of(context);
    final appName = t.appName(flavor: AppConfig.shared.flavor);
    return MenuBarWidget(
      barStyle: MenuStyle(
        backgroundColor: WidgetStateProperty.all(
          isDark ? PGColors.primaryTextColor : PGColors.primaryBackgroundColor,
        ),
      ),
      barButtonStyle: ButtonStyle(
        overlayColor: WidgetStateProperty.all(
          PGColors.primaryHoverColor.withValues(alpha: 0.3),
        ),
      ),
      menuButtonStyle: ButtonStyle(
        overlayColor: WidgetStateProperty.all(
          PGColors.primaryHoverColor.withValues(alpha: 0.3),
        ),
      ),
      barButtons: [
        BarButton(
          text: Text(appName, textAlign: TextAlign.center),
          submenu: SubMenu(
            menuItems: [
              MenuButton(
                text: Text(t.menus.about(appName: appName)),
                onTap: DialogUtil.showAboutModal,
                icon: const Icon(Icons.info),
                shortcut: const CharacterActivator('A', control: true),
                shortcutText: 'Ctrl+A',
              ),
              const MenuDivider(height: 1),
              MenuButton(
                text: Text(t.dialogs.settingsDialog.settings),
                onTap: DialogUtil.showSettingsModal,
                icon: const Icon(Icons.settings),
                shortcut: const CharacterActivator(',', control: true),
                shortcutText: 'Ctrl+,',
              ),
              const MenuDivider(height: 1),
              MenuButton(
                text: Text(t.menus.exit(appName: appName)),
                onTap: SystemNavigator.pop,
                icon: const Icon(Icons.exit_to_app),
                shortcut: const CharacterActivator('Q', control: true),
                shortcutText: 'Ctrl+Q',
              ),
            ],
          ),
        ),
        BarButton(
          text: Text(t.menus.help, textAlign: TextAlign.center),
          submenu: SubMenu(
            menuItems: [
              MenuButton(
                text: Text(t.menus.support),
                onTap: gotoTermsOfUsePage,
                icon: const Icon(Icons.support),
              ),
              MenuButton(
                text: Text(t.menus.userAgreement),
                onTap: gotoSupportPage,
                icon: const Icon(Icons.account_circle),
              ),
              MenuButton(
                text: Text(t.menus.privacy),
                onTap: gotoPrivacyPage,
                icon: const Icon(Icons.privacy_tip),
              ),
            ],
          ),
        ),
      ],
      child: child,
    );
  }
}

Future<void> gotoPage(String pageUrl) async {
  final uri = '$githubBaseUrl$pageUrl';
  if (await canLaunchUrlString(uri)) {
    await launchUrlString(uri);
  }
}

Future<void> gotoSupportPage() async {
  const uri = '$websiteBaseUrl/support';
  if (await canLaunchUrlString(uri)) {
    await launchUrlString(uri);
  }
}

Future<void> gotoTermsOfUsePage() async {
  const uri = '$websiteBaseUrl/legal/terms-of-use';
  if (await canLaunchUrlString(uri)) {
    await launchUrlString(uri);
  }
}

Future<void> gotoPrivacyPage() async {
  const uri = '$websiteBaseUrl/legal/privacy';
  if (await canLaunchUrlString(uri)) {
    await launchUrlString(uri);
  }
}
