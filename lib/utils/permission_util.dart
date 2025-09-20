// Copyright 2023 Insco. All rights reserved.
// This source code is licensed under the GNU General Public License v3.0.
// See the LICENSE file in the project root for full license information.

import 'package:device_info_plus/device_info_plus.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:permission_handler/permission_handler.dart';

enum Permissions {
  photos,
  storage,
  none,
}

class PermissionUtil {
  static Future<Permissions> checkPermission() async {
    if (isWeb) return Permissions.none;
    if (isAndroid) {
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
    } else if (isIOS) {
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
