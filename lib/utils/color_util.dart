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
