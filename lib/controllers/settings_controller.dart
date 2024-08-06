// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

class SettingsController extends GetxController {
  Rx<ThemeMode> themeMode = ThemeMode.system.obs;
  ThemeMode switchThemeMode(ThemeMode themeMode) =>
      this.themeMode.value = themeMode;
}
