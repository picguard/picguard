// Copyright 2023 Insco. All rights reserved.
// This source code is licensed under the GNU General Public License v3.0.
// See the LICENSE file in the project root for full license information.

import 'dart:async';

import 'package:logging/logging.dart';

final logger = Logger('PicGuard');

void printDebugLog(Object? object) {
  logger.shout(object);
}

void printWarningLog(Object? object) {
  logger.warning(object);
}

void printErrorLog(
  dynamic error, {
  DateTime? time,
  StackTrace? stackTrace,
}) {
  logger.severe(null, error, stackTrace);
}

FutureOr<bool> printErrorStackLog(dynamic error, StackTrace stackTrace) async {
  logger.severe(null, error, stackTrace);
  return true;
}
