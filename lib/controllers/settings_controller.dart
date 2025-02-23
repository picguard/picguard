// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

// Project imports:
import 'package:picguard/app/config.dart';
import 'package:picguard/logger/logger.dart';
import 'package:picguard/utils/utils.dart';

class SettingsController extends GetxController {
  final box = GetStorage(AppConfig.shared.container);

  ThemeMode getThemeMode() {
    final name = box.read<String?>('themeMode');
    printDebugLog('theme mode from storage: $name');
    if (StringUtil.isBlank(name)) return ThemeMode.system;
    return ThemeMode.values.asNameMap().containsKey(name)
        ? ThemeMode.values.byName(name!)
        : ThemeMode.system;
  }

  Rx<ThemeMode> themeMode = ThemeMode.system.obs;

  // 在初始化时读取存储的数据
  @override
  void onInit() {
    super.onInit();
    // 读取存储的数据，如果没有则设置默认值
    final themeModeFromStorage = getThemeMode();
    themeMode.value = themeModeFromStorage;
  }

  void switchThemeMode(ThemeMode themeMode) {
    this.themeMode.value = themeMode;
    box.write('themeMode', themeMode.name);
  }
}
