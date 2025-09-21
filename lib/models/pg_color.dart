// Copyright 2023 Insco. All rights reserved.
// This source code is licensed under the GNU General Public License v3.0.
// See the LICENSE file in the project root for full license information.

import 'package:picguard/i18n/i18n.g.dart';

///
enum PGColor {
  white(0xFFFFFFFF),
  grey(0xFF9E9E9E),
  black(0xFF000000),
  red(0xFFF44336),
  orange(0xFFFF9800),
  blue(0xFF2196F3);

  ///
  const PGColor(this.color);

  /// 颜色值
  final int color;

  String get label {
    return switch (this) {
      PGColor.white => t.colors.white,
      PGColor.grey => t.colors.grey,
      PGColor.black => t.colors.black,
      PGColor.red => t.colors.red,
      PGColor.orange => t.colors.orange,
      PGColor.blue => t.colors.blue,
    };
  }
}
