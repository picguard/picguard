import 'package:flutter/foundation.dart';

/// Checks if the current environment is a desktop environment.
bool get isDesktop {
  if (kIsWeb) return false;
  return [
    TargetPlatform.windows,
    TargetPlatform.linux,
    TargetPlatform.macOS,
  ].contains(defaultTargetPlatform);
}

/// Checks if the current environment is a mobile environment.
bool get isMobile {
  if (kIsWeb) return false;
  return [
    TargetPlatform.iOS,
    TargetPlatform.android,
  ].contains(defaultTargetPlatform);
}

/// 是否支持Firebase
bool get isFirebaseSupported {
  if (kIsWeb) return false;
  return [
    TargetPlatform.android,
    TargetPlatform.iOS,
    TargetPlatform.macOS,
  ].contains(defaultTargetPlatform);
}
