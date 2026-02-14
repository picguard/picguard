// Copyright 2023 Qiazo. All rights reserved.
// This source code is licensed under the GNU General Public License v3.0.
// See the LICENSE file in the project root for full license information.

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

///
class NavigatorUtil {
  static Future<void> push<T extends Object?>(
    Widget widget, {
    RouteSettings? settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
    String? barrierLabel,
  }) async {
    await Navigator.push<T>(
      navigatorKey.currentContext!,
      MaterialPageRoute<T>(
        builder: (context) => widget,
        settings: settings,
        maintainState: maintainState,
        fullscreenDialog: fullscreenDialog,
      ),
    );
  }

  static Future<void> pushAndRemoveUntil<T extends Object?>(
    Widget widget,
    RoutePredicate predicate, {
    RouteSettings? settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
    String? barrierLabel,
  }) async {
    await Navigator.pushAndRemoveUntil<T>(
      navigatorKey.currentContext!,
      MaterialPageRoute<T>(
        builder: (context) => widget,
        settings: settings,
        maintainState: maintainState,
        fullscreenDialog: fullscreenDialog,
      ),
      predicate,
    );
  }

  static Future<void> pushReplacement<T extends Object?, TO extends Object?>(
    Widget widget, {
    RouteSettings? settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
    String? barrierLabel,
  }) async {
    await Navigator.pushReplacement<T, TO>(
      navigatorKey.currentContext!,
      MaterialPageRoute<T>(
        builder: (context) => widget,
        settings: settings,
        maintainState: maintainState,
        fullscreenDialog: fullscreenDialog,
      ),
    );
  }

  static void pop<T extends Object?>([T? result]) {
    Navigator.pop<T>(navigatorKey.currentContext!, result);
  }
}
