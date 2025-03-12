// Dart imports:
import 'dart:developer';
import 'dart:io';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart' hide Translations;
import 'package:get_storage/get_storage.dart';
import 'package:logging/logging.dart';
import 'package:menu_bar/menu_bar.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:sentry_logging/sentry_logging.dart';
import 'package:url_launcher/url_launcher_string.dart';

// Project imports:
import 'package:picguard/app/config.dart';
import 'package:picguard/app/navigator.dart';
import 'package:picguard/constants/constants.dart';
import 'package:picguard/controllers/controllers.dart';
import 'package:picguard/generated/colors.gen.dart';
import 'package:picguard/i18n/i18n.g.dart';
import 'package:picguard/logger/logger.dart';
import 'package:picguard/pages/pages.dart';
import 'package:picguard/theme/theme.dart';
import 'package:picguard/utils/utils.dart';

const macosMenuChannel = MethodChannel('macos_menu_channel');

Future<void> reportErrorAndLog(FlutterErrorDetails details) async {
  printErrorLog(details.exception, stackTrace: details.stack);
  if (PgEnv.sentryEnabled) {
    await Sentry.captureException(details.exception, stackTrace: details.stack);
  }
}

FlutterErrorDetails makeErrorDetails(Object error, StackTrace stackTrace) {
  return FlutterErrorDetails(exception: error, stack: stackTrace);
}

Future<void> runMainApp({
  Flavor flavor = Flavor.free,
}) async {
  SentryWidgetsFlutterBinding.ensureInitialized();
  await SpUtil.getInstance();

  AppConfig.create(flavor: flavor);

  Logger.root.level =
      kReleaseMode ? Level.OFF : Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    log('${record.level.name}: ${record.time}: ${record.message}');
  });

  if (PgEnv.sentryEnabled) {
    await SentryFlutter.init(
      (options) {
        options
          ..dsn = PgEnv.sentryDsn
          ..tracesSampleRate = 1.0
          ..profilesSampleRate = 1.0
          ..attachThreads = true
          ..enableWindowMetricBreadcrumbs = true
          ..enableAppHangTracking =
              false // https://github.com/getsentry/sentry-cocoa/issues/3472
          ..addIntegration(LoggingIntegration(minEventLevel: Level.INFO))
          ..sendDefaultPii = true
          ..reportSilentFlutterErrors = true
          ..attachScreenshot = true
          ..screenshotQuality = SentryScreenshotQuality.low
          ..attachViewHierarchy = true
          ..debug = kDebugMode
          ..spotlight = Spotlight(enabled: true)
          ..enableTimeToFullDisplayTracing = true
          ..maxRequestBodySize = MaxRequestBodySize.always
          ..maxResponseBodySize = MaxResponseBodySize.always
          ..navigatorKey = AppNavigator.key;
      },
    );
  } else {
    printWarningLog('sentry is not enabled, please check the .env file');
  }

  final onError = FlutterError.onError;
  FlutterError.onError = (details) {
    onError?.call(details);
    reportErrorAndLog(details);
  };

  /// Pass all uncaught asynchronous errors
  /// that aren't handled by the Flutter Framework to Sentry
  PlatformDispatcher.instance.onError = (error, stack) {
    reportErrorAndLog(makeErrorDetails(error, stack));
    return true;
  };

  EasyLoading.instance.maskType = EasyLoadingMaskType.clear;

  // initialize with the right locale
  await LocaleSettings.useDeviceLocale();

  await GetStorage.init(AppConfig.shared.container);
  Get.lazyPut(SettingsController.new, fenix: true);

  Widget child = const MainApp();
  if (PgEnv.sentryEnabled) {
    child = SentryWidget(
      child: DefaultAssetBundle(
        bundle: SentryAssetBundle(),
        child: child,
      ),
    );
  }

  runApp(TranslationProvider(child: child));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final easyLoadingBuilder = EasyLoading.init();

  @override
  Widget build(BuildContext context) {
    final mainController = Get.find<SettingsController>();
    return Obx(
      () {
        final child = DefaultTextStyle.merge(
          style: const TextStyle(
            fontFamily: 'NotoSansSC',
            fontWeight: FontWeight.normal,
          ),
          child: const SelectionArea(child: HomePage()),
        );
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: AppNavigator.key,
          navigatorObservers: [
            if (PgEnv.sentryEnabled) SentryNavigatorObserver(),
          ],
          themeMode: mainController.themeMode.value,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          locale: TranslationProvider.of(context).flutterLocale,
          supportedLocales: AppLocaleUtils.supportedLocales,
          localizationsDelegates: GlobalMaterialLocalizations.delegates,
          home: !isWeb && defaultTargetPlatform == TargetPlatform.macOS
              ? MacOSMenuBar(child: child)
              : !isWeb &&
                      [
                        TargetPlatform.windows,
                        TargetPlatform.linux,
                      ].contains(defaultTargetPlatform)
                  ? DesktopMenuBar(child: child)
                  : child,
          builder: (BuildContext context, Widget? child) {
            child = easyLoadingBuilder(context, child);
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: TextScaler.noScaling,
              ),
              child: child,
            );
          },
        );
      },
    );
  }
}

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
            PlatformMenuItemGroup(
              members: <PlatformMenuItem>[
                PlatformMenuItem(
                  onSelected: () {
                    exit(0);
                  },
                  shortcut: const CharacterActivator('Q', meta: true),
                  label: t.menus.exit(appName: appName),
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
        overlayColor: WidgetStateProperty.all(PGColors.primaryHoverColor.withValues(alpha: 0.3)),
      ),
      menuButtonStyle: ButtonStyle(
        overlayColor: WidgetStateProperty.all(PGColors.primaryHoverColor.withValues(alpha: 0.3)),
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
                onTap: () {
                  exit(0);
                },
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
