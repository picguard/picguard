// Copyright 2023 Qiazo. All rights reserved.
// This source code is licensed under the GNU General Public License v3.0.
// See the LICENSE file in the project root for full license information.

class AppManager {
  /// 私有构造器
  AppManager.internal();

  String? version;
  String? buildNumber;

  /// 静态变量指向自身
  static final AppManager _instance = AppManager.internal();

  /// 静态属性获得实例变量
  static AppManager get instance => _instance;
}
