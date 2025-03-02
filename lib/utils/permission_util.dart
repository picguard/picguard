// Dart imports:
import 'dart:io';

// Package imports:
import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

// Project imports:
import 'package:picguard/constants/constants.dart';

enum Permissions {
  photos,
  storage,
  none,
}

class PermissionUtil {
  static Future<Permissions> checkPermission() async {
    if (isWeb) return Permissions.none;
    if (Platform.isAndroid) {
      final deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;
      if (androidInfo.version.sdkInt >= 33) {
        final status = await Permission.photos.request();
        final denied = [
          PermissionStatus.permanentlyDenied,
          PermissionStatus.denied,
        ].contains(status);
        return denied ? Permissions.photos : Permissions.none;
      } else {
        final status = await Permission.storage.request();
        final denied = [
          PermissionStatus.permanentlyDenied,
          PermissionStatus.denied,
        ].contains(status);
        return denied ? Permissions.storage : Permissions.none;
      }
    } else if (Platform.isIOS) {
      final status = await Permission.photos.request();
      final denied = [
        PermissionStatus.permanentlyDenied,
        PermissionStatus.denied,
      ].contains(status);
      return denied ? Permissions.photos : Permissions.none;
    }
    return Permissions.none;
  }
}
