import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:picguard/app/navigator.dart';
import 'package:picguard/constraints/constraints.dart';
import 'package:picguard/firebase_options.dart';
import 'package:picguard/i18n/i18n.dart';
import 'package:picguard/pages/pages.dart';
import 'package:picguard/theme/theme.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb || isFirebaseSupported) {
    await Firebase.initializeApp(
      options: kIsWeb ? DefaultFirebaseOptions.web : null,
    );
  }

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
  runApp(TranslationProvider(child: const MainApp()));
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
      navigatorObservers: isFirebaseSupported
          ? <NavigatorObserver>[
              FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
            ]
          : [],
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
