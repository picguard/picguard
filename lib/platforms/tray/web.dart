// Copyright 2023 Qiazo. All rights reserved.
// This source code is licensed under the GNU General Public License v3.0.
// See the LICENSE file in the project root for full license information.

import 'package:flutter/widgets.dart';

/// Every `trayManager` call the app makes, in one place.
///
/// The compatibility API has no getters, so the controller remembers what it
/// last asked for; the chips in the window show that, and [bounds] is the one
/// value read back from the system.
class TrayController extends ChangeNotifier {
  /// [autoCreate] false leaves the tray alone, for rendering the window in a
  /// test, where there is no native library to call.
  TrayController({bool autoCreate = true});
}
