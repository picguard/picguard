// Copyright 2023 Qiazo. All rights reserved.
// This source code is licensed under the GNU General Public License v3.0.
// See the LICENSE file in the project root for full license information.

import 'package:picguard/generated/assets.gen.dart';
import 'package:picguard/i18n/i18n.g.dart';

class AppConfig {
  factory AppConfig.create({
    Flavor flavor = Flavor.free,
  }) {
    return shared = AppConfig._(flavor);
  }

  AppConfig._(this.flavor);

  final Flavor flavor;

  bool get isFree => flavor == Flavor.free;

  bool get isPro => !isFree;

  String get container => isPro ? 'picguard_pro' : 'picguard';

  String get iosAppId => isPro ? '6737562597' : '6737562561';

  String get macAppId => iosAppId;

  String get microsoftProductId => isPro ? '9N0ZV9Q5SVCX' : '9NCC0LJBG7TB';

  String get snapName => isPro ? 'picguard-pro' : 'picguard';

  String get flathubAppId =>
      isPro ? 'com.kjxbyz.PicGuardPro' : 'com.kjxbyz.PicGuard';

  String get trayIcon =>
      isPro ? Assets.logo.pro.trayIcon : Assets.logo.trayIcon;

  String get trayLogo =>
      isPro ? Assets.logo.pro.trayLogo.keyName : Assets.logo.trayLogo.keyName;

  static AppConfig shared = AppConfig.create();
}
