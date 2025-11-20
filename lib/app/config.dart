// Copyright 2023 Qiazo. All rights reserved.
// This source code is licensed under the GNU General Public License v3.0.
// See the LICENSE file in the project root for full license information.

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

  static AppConfig shared = AppConfig.create();
}
