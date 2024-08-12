// Flutter imports:
import 'package:flutter/foundation.dart';

// Project imports:
import 'package:picguard/app/manager.dart';

/// Checks if the current environment is a desktop environment.
bool get isDesktop {
  if (kIsWeb || kIsWasm) return false;
  return [
    TargetPlatform.windows,
    TargetPlatform.linux,
    TargetPlatform.macOS,
  ].contains(defaultTargetPlatform);
}

/// Checks if the current environment is a mobile environment.
bool get isMobile {
  if (kIsWeb || kIsWasm) return false;
  return [
    TargetPlatform.iOS,
    TargetPlatform.android,
  ].contains(defaultTargetPlatform);
}

String? get appVersion {
  final version = AppManager.instance.version;
  final buildNumber = AppManager.instance.buildNumber;
  return '$version+$buildNumber';
}
