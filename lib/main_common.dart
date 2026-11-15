// Copyright 2023 Qiazo. All rights reserved.
// This source code is licensed under the GNU General Public License v3.0.
// See the LICENSE file in the project root for full license information.

import 'dart:async';

import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:logging/logging.dart';
import 'platforms/tray/io.dart'
if (dart.library.js_interop) 'platforms/tray/web.dart';
import 'package:provider/provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:sentry_logging/sentry_logging.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../app/config.dart';
import '../constants/constants.dart';
import '../i18n/i18n.g.dart';
import '../logger/logger.dart';
import '../pages/pages.dart';
import '../theme/theme.dart';
import '../utils/utils.dart';
import '../viewmodels/viewmodels.dart';
import '../widgets/widgets.dart';

void reportErrorAndLog(FlutterErrorDetails details) {
  printErrorLog(details.exception, stackTrace: details.stack);
  if (PgEnv.sentryEnabled) {
    unawaited(
      Sentry.captureException(details.exception, stackTrace: details.stack),
    );
  }
}

FlutterErrorDetails makeErrorDetails(Object error, StackTrace stackTrace) {
  return FlutterErrorDetails(exception: error, stack: stackTrace);
}

Future<void> runMainApp({Flavor flavor = Flavor.free}) async {
  SentryWidgetsFlutterBinding.ensureInitialized();

  await SpUtil.getInstance();

  AppConfig.create(flavor: flavor);

  if (PgEnv.sentryEnabled) {
    await SentryFlutter.init((options) {
      options
        ..dsn = PgEnv.sentryDsn
        ..tracesSampleRate = 1.0
        // ..profilesSampleRate = 1.0
        ..attachThreads = true
        ..enableWindowMetricBreadcrumbs = true
        ..enableAppHangTracking =
            false // https://github.com/getsentry/sentry-cocoa/issues/3472
        ..addIntegration(LoggingIntegration(minEventLevel: Level.INFO))
        ..sendDefaultPii = true
        ..reportSilentFlutterErrors = true
        ..attachScreenshot = true
        ..screenshotQuality = SentryScreenshotQuality.low
        // ..attachViewHierarchy = true
        ..debug = kDebugMode
        ..spotlight = Spotlight(enabled: true)
        ..enableTimeToFullDisplayTracing = true
        ..maxRequestBodySize = MaxRequestBodySize.always
        ..navigatorKey = navigatorKey;
    });
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

  EasyLoading.instance.maskType = .clear;

  // initialize with the right locale
  await LocaleSettings.useDeviceLocale();

  Widget child = MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => GlobalProvider())],
    child: const MainApp(),
  );
  if (PgEnv.sentryEnabled) {
    child = SentryWidget(
      child: DefaultAssetBundle(bundle: SentryAssetBundle(), child: child),
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
  final TransitionBuilder easyLoadingBuilder = EasyLoading.init();
  final TransitionBuilder botToastBuilder = BotToastInit();
  final TrayController _controller = TrayController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final appName = t.appName(flavor: AppConfig.shared.flavor);
    final themeMode = context.select<GlobalProvider, ThemeMode>(
      (provider) => provider.themeMode,
    );
    final child = DefaultTextStyle.merge(
      style: const TextStyle(
        fontFamily: 'NotoSansSC',
        fontWeight: FontWeight.normal,
      ),
      child: const SelectionArea(child: HomePage()),
    );
    return MaterialApp(
      title: appName,
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      navigatorObservers: [
        BotToastNavigatorObserver(),
        if (PgEnv.sentryEnabled) SentryNavigatorObserver(),
        TalkerRouteObserver(talker),
      ],
      themeMode: themeMode,
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
      builder: (context, child) {
        child = easyLoadingBuilder(context, child);
        child = botToastBuilder(context, child);
        child = MaterialUiCompatibilityBridge(child: child);
        child = CupertinoUiCompatibilityBridge(child: child);
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: .noScaling),
          child: child,
        );
      },
    );
  }
}
