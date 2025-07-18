// Copyright 2023 Insco. All rights reserved.
// This source code is licensed under the GNU General Public License v3.0.
// See the LICENSE file in the project root for full license information.

// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart' hide Translations;
import 'package:get_storage/get_storage.dart';
import 'package:logging/logging.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:sentry_logging/sentry_logging.dart';
import 'package:tray_manager/tray_manager.dart';

// Project imports:
import 'package:picguard/app/config.dart';
import 'package:picguard/app/navigator.dart';
import 'package:picguard/constants/constants.dart';
import 'package:picguard/controllers/controllers.dart';
import 'package:picguard/enums/enums.dart';
import 'package:picguard/generated/assets.gen.dart';
import 'package:picguard/i18n/i18n.g.dart';
import 'package:picguard/logger/logger.dart';
import 'package:picguard/pages/pages.dart';
import 'package:picguard/theme/theme.dart';
import 'package:picguard/utils/utils.dart';
import 'package:picguard/widgets/widgets.dart';

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
    debugPrint('${record.level.name}: ${record.time}: ${record.message}');
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
          ..navigatorKey = AppNavigator.navigatorKey;
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

class _MainAppState extends State<MainApp> with TrayListener {
  final TransitionBuilder easyLoadingBuilder = EasyLoading.init();
  final TransitionBuilder botToastBuilder = BotToastInit();

  @override
  void initState() {
    trayManager.addListener(this);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      initTrayMenu();
    });
  }

  @override
  void dispose() {
    trayManager.removeListener(this);
    super.dispose();
  }

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
          navigatorKey: AppNavigator.navigatorKey,
          scaffoldMessengerKey: AppNavigator.scaffoldMessengerKey,
          navigatorObservers: [
            BotToastNavigatorObserver(),
            if (PgEnv.sentryEnabled) SentryNavigatorObserver(),
          ],
          themeMode: mainController.themeMode.value,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          locale: TranslationProvider.of(context).flutterLocale,
          supportedLocales: AppLocaleUtils.supportedLocales,
          localizationsDelegates: GlobalMaterialLocalizations.delegates,
          home: isMacOS
              ? MacOSMenuBar(child: child)
              : (isWindows || isLinux)
                  ? DesktopMenuBar(child: child)
                  : child,
          builder: (BuildContext context, Widget? child) {
            child = easyLoadingBuilder(context, child);
            child = botToastBuilder(context, child);
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

  Future<void> initTrayMenu() async {
    if (!isDesktop) {
      return;
    }

    final t = Translations.of(context);
    final appName = t.appName(flavor: AppConfig.shared.flavor);
    final isPro = AppConfig.shared.isPro;
    final trayIcon =
        isWindows
            ? (isPro ? Assets.logo.pro.trayIcon : Assets.logo.trayIcon)
            : (isPro
                ? Assets.logo.pro.trayLogo.keyName
                : Assets.logo.trayLogo.keyName);
    await trayManager.setIcon(trayIcon);

    final menu = Menu(
      items: [
        MenuItem(
          key: Menus.about.name,
          label: t.menus.about(appName: appName),
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
              MenuItem(
                key: Menus.support.name,
                label: t.menus.support,
              ),
              MenuItem.separator(),
              MenuItem(
                key: Menus.userAgreement.name,
                label: t.menus.userAgreement,
              ),
              MenuItem.separator(),
              MenuItem(
                key: Menus.privacy.name,
                label: t.menus.privacy,
              ),
            ],
          ),
        ),
        MenuItem.separator(),
        MenuItem(
          key: Menus.exit.name,
          label: t.menus.exit(appName: appName),
        ),
      ],
    );
    await trayManager.setContextMenu(menu);
  }

  @override
  void onTrayIconMouseDown() {
    trayManager.popUpContextMenu();
  }

  @override
  void onTrayMenuItemClick(MenuItem menuItem) {
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
    } else if (menuItem.key == Menus.exit.name) {
      exit(0);
    }
  }
}
