// The example shows the deprecated 0.5.x compatible API on purpose.
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package

import 'dart:async';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:tray_manager/legacy.dart';

import '../../constants/get.dart';
import '../../enums/enums.dart';
import '../../i18n/i18n.g.dart';
import '../../utils/dialog_util.dart';
import '../../utils/exit_app.dart';
import '../../widgets/menu_bar.dart';

const kGlyphIcon = 'logo/tray-logo.png';
const kColourIcon = 'logo/tray-logo.png';
const kDefaultTooltip = 'PicGuard';

/// Every `trayManager` call the example makes, in one place.
///
/// The compatibility API has no getters, so the controller remembers what it
/// last asked for; the chips in the window show that, and [bounds] is the one
/// value read back from the system.
class TrayController extends ChangeNotifier with TrayListener {
  /// [autoCreate] false leaves the tray alone, for rendering the window in a
  /// test, where there is no native library to call.
  TrayController({bool autoCreate = true}) {
    if (isDesktop) {
      trayManager.addListener(this);
      if (autoCreate) create();
    }
  }

  bool created = false;
  String iconPath = kGlyphIcon;
  bool isTemplate = Platform.isMacOS;
  int iconSize = 18;
  TrayIconPosition iconPosition = TrayIconPosition.left;
  String title = '';
  String tooltip = kDefaultTooltip;
  bool notifications = true;
  Rect? bounds;

  String lastEvent = 'No events yet';
  final List<String> log = <String>[];

  /// Windows tray icons have no title; `setTitle` is accepted and ignored.
  static bool get titleSupported => !Platform.isWindows;

  /// Template images, icon sizes and icon positions are macOS concepts.
  static bool get iconLayoutSupported => Platform.isMacOS;

  /// A Linux tray icon is drawn by the shell: it has no bounds to ask for and
  /// only the shell can open its menu.
  static bool get boundsSupported => !Platform.isLinux;

  static bool get popUpSupported => !Platform.isLinux;

  // ---------------------------------------------------------------------
  // Lifecycle
  // ---------------------------------------------------------------------

  Future<void> create() async {
    await _applyIcon();
    await trayManager.setToolTip(tooltip);
    if (title.isNotEmpty) await trayManager.setTitle(title);
    await trayManager.setContextMenu(_buildMenu());
    created = true;
    _log('create  setIcon + setToolTip + setContextMenu');
    await refreshBounds();
  }

  Future<void> destroy() async {
    await trayManager.destroy();
    created = false;
    bounds = null;
    _log('destroy');
  }

  @override
  void dispose() {
    if (isDesktop) {
      trayManager.removeListener(this);
      trayManager.destroy();
    }
    super.dispose();
  }

  // ---------------------------------------------------------------------
  // Properties
  // ---------------------------------------------------------------------

  Future<void> setIcon(String path) async {
    iconPath = path;
    await _applyIcon();
    _log('setIcon  $path');
  }

  Future<void> setTemplate(bool value) async {
    isTemplate = value;
    await _applyIcon();
    _log('setIcon  isTemplate: $value');
  }

  Future<void> setIconSize(int value) async {
    iconSize = value;
    await _applyIcon();
    _log('setIcon  iconSize: $value');
    await refreshBounds();
  }

  Future<void> setIconPosition(TrayIconPosition value) async {
    iconPosition = value;
    await trayManager.setIconPosition(value);
    _log('setIconPosition  ${value.name}');
  }

  Future<void> setTitle(String value) async {
    title = value;
    await trayManager.setTitle(value);
    _log('setTitle  "$value"');
    await refreshBounds();
  }

  Future<void> setToolTip(String value) async {
    tooltip = value;
    await trayManager.setToolTip(value);
    _log('setToolTip  "${value.replaceAll('\n', r'\n')}"');
  }

  Future<void> popUpContextMenu() async {
    await trayManager.popUpContextMenu();
    _log('popUpContextMenu');
  }

  Future<void> refreshBounds() async {
    if (!created || !boundsSupported) return;
    // The menu bar lays the item out again after a change; ask afterwards.
    await Future<void>.delayed(const Duration(milliseconds: 200));
    bounds = await trayManager.getBounds();
    notifyListeners();
  }

  Future<void> _applyIcon() {
    return trayManager.setIcon(
      iconPath,
      isTemplate: isTemplate,
      iconSize: iconSize,
      iconPosition: iconPosition,
    );
  }

  // ---------------------------------------------------------------------
  // Context menu
  // ---------------------------------------------------------------------

  Menu _buildMenu() {
    return Menu(
      items: [
        MenuItem(
          key: Menus.about.name,
          label: t.menus.about(appName: title),
        ),
        MenuItem.separator(),
        MenuItem(
          key: Menus.settings.name,
          label: t.dialogs.settingsDialog.settings,
        ),
        MenuItem.separator(),
        MenuItem.submenu(
          key: Menus.help.name,
          label: t.menus.help,
          submenu: Menu(
            items: [
              MenuItem(key: Menus.support.name, label: t.menus.support),
              MenuItem(
                key: Menus.userAgreement.name,
                label: t.menus.userAgreement,
              ),
              MenuItem(key: Menus.privacy.name, label: t.menus.privacy),
              MenuItem.separator(),
              MenuItem(key: Menus.debug.name, label: t.menus.debug),
            ],
          ),
        ),
        MenuItem.separator(),
        MenuItem(
          key: Menus.exit.name,
          label: t.menus.exit(appName: title),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------
  // TrayListener
  // ---------------------------------------------------------------------

  @override
  void onTrayIconMouseDown() {
    _event('onTrayIconMouseDown');
  }

  @override
  void onTrayIconRightMouseDown() {
    _event('onTrayIconRightMouseDown');
    // The 0.5.x idiom: the app opens the menu itself on a right click.
    if (popUpSupported) trayManager.popUpContextMenu();
  }

  @override
  void onTrayMenuItemClick(MenuItem menuItem) {
    _event('onTrayMenuItemClick  ${menuItem.key}');

    if (menuItem.key == Menus.about.name) {
      DialogUtil.showAboutModal();
    } else if (menuItem.key == Menus.settings.name) {
      DialogUtil.showSettingsModal();
    } else if (menuItem.key == Menus.support.name) {
      gotoSupportPage();
    } else if (menuItem.key == Menus.userAgreement.name) {
      gotoTermsOfUsePage();
    } else if (menuItem.key == Menus.privacy.name) {
      gotoPrivacyPage();
    } else if (menuItem.key == Menus.debug.name) {
      DialogUtil.openDebugPage();
    } else if (menuItem.key == Menus.exit.name) {
      // Not from inside the click: let the menu finish closing first.
      Timer.run(() => trayManager.destroy().whenComplete(() => exit(0)));
      exitApp();
    }
  }

  // ---------------------------------------------------------------------
  // Log
  // ---------------------------------------------------------------------

  void clearLog() {
    log.clear();
    lastEvent = 'No events yet';
    notifyListeners();
  }

  /// Records a listener callback; also what a preview fills the footer with.
  void recordEvent(String text) => _event(text);

  void _event(String text) {
    lastEvent = text;
    _log(text);
  }

  void _log(String text) {
    final now = DateTime.now();
    String two(int value) => value.toString().padLeft(2, '0');
    log.insert(
      0,
      '${two(now.hour)}:${two(now.minute)}:${two(now.second)}  $text',
    );
    if (log.length > 50) log.removeLast();
    notifyListeners();
  }
}
