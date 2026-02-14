// Copyright 2023 Qiazo. All rights reserved.
// This source code is licensed under the GNU General Public License v3.0.
// See the LICENSE file in the project root for full license information.

import 'dart:async';

import 'package:talker_flutter/talker_flutter.dart';

final talker = Talker(
  settings: TalkerSettings(
    /// Length of history that saving logs data
    maxHistoryItems: 10000,
  ),

  /// Setup your implementation of logger
  logger: TalkerLogger(),
);

void printDebugLog(Object? object) {
  talker.debug(object);
}

void printWarningLog(Object? object) {
  talker.warning(object);
}

void printErrorLog(
  dynamic error, {
  DateTime? time,
  StackTrace? stackTrace,
}) {
  talker.error(error, null, stackTrace);
}

FutureOr<bool> printErrorStackLog(dynamic error, StackTrace stackTrace) async {
  talker.error(error, null, stackTrace);
  return true;
}
