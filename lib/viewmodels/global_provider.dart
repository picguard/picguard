// Copyright 2023 Qiazo. All rights reserved.
// This source code is licensed under the GNU General Public License v3.0.
// See the LICENSE file in the project root for full license information.

import 'package:flutter/material.dart';
import 'package:sp_util/sp_util.dart';

import '../app/config.dart';
import '../logger/logger.dart';
import '../utils/utils.dart';

class GlobalProvider extends ChangeNotifier {
  GlobalProvider() {
    getThemeMode();
  }

  ThemeMode themeMode = .system;

  Future<void> switchThemeMode(ThemeMode themeMode) async {
    this.themeMode = themeMode;
    await SpUtil.putString('${AppConfig.shared.container}_theme_mode', themeMode.name);
    notifyListeners();
  }

  void getThemeMode() {
    final name = _getStringAsync('${AppConfig.shared.container}_theme_mode');
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

  String _getStringAsync(String key, {String defaultValue = ''}) {
    return SpUtil.getSp()?.getString(key) ?? defaultValue;
  }
}
