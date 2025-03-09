// Flutter imports:
import 'package:flutter/foundation.dart';

bool get isWeb {
  return kIsWeb || kIsWasm;
}

/// Checks if the current environment is a desktop environment.
bool get isDesktop {
  if (isWeb) return false;
  return [
    TargetPlatform.windows,
    TargetPlatform.linux,
    TargetPlatform.macOS,
  ].contains(defaultTargetPlatform);
}

/// Checks if the current environment is a mobile environment.
bool get isMobile {
  if (isWeb) return false;
  return [
    TargetPlatform.iOS,
    TargetPlatform.android,
  ].contains(defaultTargetPlatform);
}
