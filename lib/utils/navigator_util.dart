// Copyright 2023 Insco. All rights reserved.
// This source code is licensed under the GNU General Public License v3.0.
// See the LICENSE file in the project root for full license information.

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

///
class NavigatorUtil {
  static void push<T extends Object?>(
    Widget widget, {
    RouteSettings? settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
    String? barrierLabel,
  }) {
    Navigator.push<T>(
      navigatorKey.currentContext!,
      MaterialPageRoute<T>(
        builder: (BuildContext context) => widget,
        settings: settings,
        maintainState: maintainState,
        fullscreenDialog: fullscreenDialog,
      ),
    );
  }

  static void pushAndRemoveUntil<T extends Object?>(
    Widget widget,
    RoutePredicate predicate, {
    RouteSettings? settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
    String? barrierLabel,
  }) {
    Navigator.pushAndRemoveUntil<T>(
      navigatorKey.currentContext!,
      MaterialPageRoute<T>(
        builder: (BuildContext context) => widget,
        settings: settings,
        maintainState: maintainState,
        fullscreenDialog: fullscreenDialog,
      ),
      predicate,
    );
  }

  static void pushReplacement<T extends Object?, TO extends Object?>(
    Widget widget, {
    RouteSettings? settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
    String? barrierLabel,
  }) {
    Navigator.pushReplacement<T, TO>(
      navigatorKey.currentContext!,
      MaterialPageRoute<T>(
        builder: (BuildContext context) => widget,
        settings: settings,
        maintainState: maintainState,
        fullscreenDialog: fullscreenDialog,
      ),
    );
  }

  static void pop() {
    Navigator.pop(navigatorKey.currentContext!);
  }
}
