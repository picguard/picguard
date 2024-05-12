import 'package:flutter/foundation.dart';
import 'package:picguard/app/manager.dart';

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

bool get isShowLicenseDialog {
  if (kIsWeb) return false;
  return [
    TargetPlatform.android,
    TargetPlatform.iOS,
    /// windows
  ].contains(defaultTargetPlatform);
}

String? get appVersion {
  final version = AppManager.instance.version;
  final buildNumber = AppManager.instance.buildNumber;
  if (kIsWeb) return '$version+$buildNumber';
  if ([
    TargetPlatform.android,
    TargetPlatform.iOS,
    TargetPlatform.macOS,
  ].contains(defaultTargetPlatform)) {
    return version;
  }
  return '$version+$buildNumber';
}
