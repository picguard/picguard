// Dart imports:
import 'dart:developer';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart' hide Translations;
import 'package:get_storage/get_storage.dart';
import 'package:logging/logging.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:sentry_logging/sentry_logging.dart';
import 'package:url_launcher/url_launcher_string.dart';

// Project imports:
import 'package:picguard/app/config.dart';
import 'package:picguard/app/navigator.dart';
import 'package:picguard/constants/constants.dart';
import 'package:picguard/controllers/controllers.dart';
import 'package:picguard/i18n/i18n.dart';
import 'package:picguard/logger/logger.dart';
import 'package:picguard/pages/pages.dart';
import 'package:picguard/theme/theme.dart';
import 'package:picguard/utils/utils.dart';

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

  runApp(
    TranslationProvider(
      child: child,
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final easyLoadingBuilder = EasyLoading.init();

  bool showAll = false;

  @override
  Widget build(BuildContext context) {
    final mainController = Get.find<SettingsController>();
    return Obx(
      () {
        final t = Translations.of(context);
        final appName = t.appName(flavor: AppConfig.shared.flavor);

        final child = DefaultTextStyle.merge(
          style: const TextStyle(
            fontFamily: 'NotoSansSC',
            fontWeight: FontWeight.normal,
          ),
          child: const HomePage(),
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
          home: defaultTargetPlatform == TargetPlatform.macOS
              ? PlatformMenuBar(
                  menus: <PlatformMenuItem>[
                    PlatformMenu(
                      label: appName,
                      menus: <PlatformMenuItem>[
                        const PlatformMenuItemGroup(
                          members: <PlatformMenuItem>[
                            PlatformProvidedMenuItem(
                              type: PlatformProvidedMenuItemType.about,
                            ),
                          ],
                        ),
                        PlatformMenuItemGroup(
                          members: <PlatformMenuItem>[
                            PlatformMenuItem(
                              onSelected: DialogUtil.showSettingsModal,
                              shortcut:
                                  const CharacterActivator(',', meta: true),
                              label: t.dialogs.settingsDialog.settings,
                            ),
                          ],
                        ),
                        const PlatformProvidedMenuItem(
                          type: PlatformProvidedMenuItemType.quit,
                        ),
                      ],
                    ),
                    PlatformMenu(
                      label: t.menus.help,
                      menus: <PlatformMenuItem>[
                        PlatformMenuItemGroup(
                          members: <PlatformMenuItem>[
                            PlatformMenuItem(
                              onSelected: () async {
                                const uri = 'https://www.picguard.app/support';
                                if (await canLaunchUrlString(uri)) {
                                  await launchUrlString(uri);
                                }
                              },
                              label: t.menus.support,
                            ),
                            PlatformMenuItem(
                              onSelected: () async {
                                const uri =
                                    'https://www.picguard.app/legal/terms-of-use';
                                if (await canLaunchUrlString(uri)) {
                                  await launchUrlString(uri);
                                }
                              },
                              label: t.menus.userAgreement,
                            ),
                            PlatformMenuItem(
                              onSelected: () async {
                                const uri =
                                    'https://www.picguard.app/legal/privacy';
                                if (await canLaunchUrlString(uri)) {
                                  await launchUrlString(uri);
                                }
                              },
                              label: t.menus.privacy,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                  child: child,
                )
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
