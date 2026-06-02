// Copyright 2023 Qiazo. All rights reserved.
// This source code is licensed under the GNU General Public License v3.0.
// See the LICENSE file in the project root for full license information.

import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

import '../constants/get.dart';

enum Permissions { photos, storage, none }

class PermissionUtil {
  static Future<Permissions> checkPermission({
    bool useAndroidPhotoPicker = false,
  }) async {
    if (isWeb) return .none;
    if (isAndroid && !useAndroidPhotoPicker) {
      final deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;
      if (androidInfo.version.sdkInt <= 28) {
        final status = await Permission.storage.request();
        final denied = <PermissionStatus>[
          .permanentlyDenied,
          .denied,
        ].contains(status);
        return denied ? .storage : .none;
      }
    } else if (isIOS) {
      final status = await Permission.photos.request();
      final denied = <PermissionStatus>[
        .permanentlyDenied,
        .denied,
      ].contains(status);
      return denied ? .photos : .none;
    }
    return .none;
  }
}
