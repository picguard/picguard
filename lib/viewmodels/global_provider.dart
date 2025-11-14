// Copyright 2023 Insco. All rights reserved.
// This source code is licensed under the GNU General Public License v3.0.
// See the LICENSE file in the project root for full license information.

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:picguard/app/config.dart';
import 'package:picguard/logger/logger.dart';
import 'package:picguard/utils/utils.dart';

class GlobalProvider extends ChangeNotifier {
  GlobalProvider() {
    getThemeMode();
  }

  ThemeMode themeMode = .system;

  Future<void> switchThemeMode(ThemeMode themeMode) async {
    this.themeMode = themeMode;
    await setValue('${AppConfig.shared.container}_theme_mode', themeMode.name);
    notifyListeners();
  }

  void getThemeMode() {
    final name = getStringAsync('${AppConfig.shared.container}_theme_mode');
    printDebugLog('theme mode from storage: $name');
    var themeMode = ThemeMode.system;
    if (StringUtil.isNotBlank(name)) {
      themeMode = ThemeMode.values.asNameMap().containsKey(name)
          ? ThemeMode.values.byName(name)
          : ThemeMode.system;
    }
    this.themeMode = themeMode;
    notifyListeners();
  }
}
