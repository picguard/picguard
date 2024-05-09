import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:picguard/app/navigator.dart';
import 'package:picguard/constants/constants.dart';
import 'package:picguard/i18n/i18n.dart';
import 'package:picguard/modules/home/home.dart';
import 'package:picguard/theme/theme.dart';
import 'package:picguard/utils/utils.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SpUtil.getInstance();

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
