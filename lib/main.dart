import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:watermark_assistant/constrants/get.dart';

import 'package:watermark_assistant/firebase_options.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb || isFirebaseSupported) {
    await Firebase.initializeApp(
      options: kIsWeb ? DefaultFirebaseOptions.web : null,
    );
  }

  if (isFirebaseSupported) {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }

  if (isDesktop) {
    await WindowManager.instance.ensureInitialized();
    await windowManager.waitUntilReadyToShow().then((_) async {
      await windowManager.center();
      await windowManager.show();
      await windowManager.setPreventClose(true);
      await windowManager.setSkipTaskbar(false);
    });
  }

  runApp(const MyApp());
}

///
class MyApp extends StatelessWidget {
  ///
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      navigatorObservers: isFirebaseSupported
          ? <NavigatorObserver>[
              FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
            ]
          : [],
      home: const MyHomePage(title: 'Home Page'),
    );
  }
}

///
class MyHomePage extends StatefulWidget {
  ///
  const MyHomePage({required this.title, super.key});

  ///
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WindowListener {
  int _counter = 0;

  @override
  void initState() {
    windowManager.addListener(this);
    super.initState();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Title(
      title: 'Watermark Assistant',
      color: Colors.black,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  @override
  Future<void> onWindowClose() async {
    final isPreventClose = await windowManager.isPreventClose();
    if (isDesktop && isPreventClose) {
      if (!mounted) return;
      await showDialog<void>(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: const Text('Confirm close'),
            content: const Text('Are you sure you want to close this window?'),
            actions: [
              TextButton(
                child: const Text('Yes'),
                onPressed: () {
                  Navigator.pop(context);
                  windowManager.destroy();
                },
              ),
              TextButton(
                child: const Text('No'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
  }
}
