// Copyright 2023 Insco. All rights reserved.
// This source code is licensed under the GNU General Public License v3.0.
// See the LICENSE file in the project root for full license information.

/// string utils
class StringUtil {
  static const empty = '';

  static const space = ' ';

  /// 连字符
  static const hyphen = '-';

  static bool isBlank(String? str) {
    return str == null || str.isEmpty || str.trim().isEmpty;
  }

  static bool isNotBlank(String? str) {
    return !isBlank(str);
  }

  static bool isNull(String? str) {
    return str == null;
  }

  static bool isNotNull(String? str) {
    return !isNull(str);
  }

  static String getValue(String? str, {String defaultVal = empty}) {
    return isBlank(str) ? defaultVal : str!;
  }

  static String getHyphenValue(String? str) {
    return getValue(str, defaultVal: hyphen);
  }
}
