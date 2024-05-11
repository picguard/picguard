import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:logging/logging.dart';
import 'package:picguard/app/navigator.dart';
import 'package:picguard/constants/constants.dart';
import 'package:picguard/i18n/i18n.dart';
import 'package:picguard/logger/logger.dart';
import 'package:picguard/modules/home/home.dart';
import 'package:picguard/theme/theme.dart';
import 'package:picguard/utils/utils.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:sentry_logging/sentry_logging.dart';
import 'package:window_manager/window_manager.dart';

Future<void> reportErrorAndLog(FlutterErrorDetails details) async {
  printErrorLog(details.exception, stackTrace: details.stack);
  if (PgEnv.sentryEnabled) {
    await Sentry.captureException(details.exception, stackTrace: details.stack);
  }
}

FlutterErrorDetails makeErrorDetails(Object error, StackTrace stackTrace) {
  return FlutterErrorDetails(exception: error, stack: stackTrace);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SpUtil.getInstance();

  Logger.root.level = kReleaseMode ? Level.OFF : Level.ALL; // defaults to Level.INFO
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
          ..addIntegration(LoggingIntegration(minEventLevel: Level.INFO))
          ..sendDefaultPii = true
          ..reportSilentFlutterErrors = true
          ..attachScreenshot = true
          ..screenshotQuality = SentryScreenshotQuality.low
          ..attachViewHierarchy = true
          ..debug = kDebugMode
          ..spotlight = Spotlight(enabled: true)
          ..enableTimeToFullDisplayTracing = true
          ..enableMetrics = true
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

  if (isDesktop) {
    await WindowManager.instance.ensureInitialized();
    await windowManager.waitUntilReadyToShow().then((_) async {
      await windowManager.show();
      await windowManager.setSize(const Size(1200, 800));
      await windowManager.center();
      await windowManager.setPreventClose(true);
      await windowManager.setSkipTaskbar(false);
    });
  }

  LocaleSettings.useDeviceLocale(); // initialize with the right locale
  runApp(
    TranslationProvider(
      child: SentryWidget(
        child: DefaultAssetBundle(
          bundle: SentryAssetBundle(),
          child: const MainApp(),
        ),
      ),
    ),
  );
}

///
class MainApp extends StatelessWidget {
  ///
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: AppNavigator.key,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      navigatorObservers: [
        if (PgEnv.sentryEnabled) SentryNavigatorObserver(),
      ],
      locale: TranslationProvider.of(context).flutterLocale,
      supportedLocales: AppLocaleUtils.supportedLocales,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      home: const HomePage(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.noScaling,
          ),
          child: child!,
        );
      },
    );
  }
}
