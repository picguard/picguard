// Flutter imports:
import 'package:flutter/foundation.dart';

bool get isWeb {
  return kIsWeb || kIsWasm;
}

/// Checks if the current environment is a desktop environment.
bool get isDesktop {
  return isWindows || isMacOS || isLinux;
}

/// Checks if the current environment is a mobile environment.
bool get isMobile {
  return isAndroid || isIOS;
}
/// Check whether the current environment is an iOS environment.
bool get isIOS {
  if (isWeb) return false;
  return TargetPlatform.iOS == defaultTargetPlatform;
}

/// Check whether the current environment is an Android environment.
bool get isAndroid {
  if (isWeb) return false;
  return TargetPlatform.android == defaultTargetPlatform;
}

/// Check whether the current environment is a Linux environment.
bool get isLinux {
  if (isWeb) return false;
  return TargetPlatform.linux == defaultTargetPlatform;
}

/// Check whether the current environment is a macOS environment.
bool get isMacOS {
  if (isWeb) return false;
  return TargetPlatform.macOS == defaultTargetPlatform;
}

/// Check whether the current environment is a Windows environment.
bool get isWindows {
  if (isWeb) return false;
  return TargetPlatform.windows == defaultTargetPlatform;
}
