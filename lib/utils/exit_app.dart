// Copyright 2023 Qiazo. All rights reserved.
// This source code is licensed under the GNU General Public License v3.0.
// See the LICENSE file in the project root for full license information.

import 'dart:ui';

import 'package:flutter/services.dart';

void exitApp([int exitCode = 0]) {
  ServicesBinding.instance.exitApplication(AppExitType.required, exitCode);
}
