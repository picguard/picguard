// Copyright 2023 Insco. All rights reserved.
// This source code is licensed under the GNU General Public License v3.0.
// See the LICENSE file in the project root for full license information.

// Dart imports:
import 'dart:ui';

// Project imports:
import 'package:picguard/utils/string_util.dart';

///
class ColorUtil {
  ///
  static Color stringToColor(String hexColor, Color defaultColor) {
    if (StringUtil.isBlank(hexColor)) return defaultColor;

    final hexNumber = int.tryParse(
      hexColor.toUpperCase().replaceAll(RegExp('^(#|0X)'), '').padLeft(8, 'F'),
      radix: 16,
    );

    return hexNumber == null ? defaultColor : Color(hexNumber);
  }
}
