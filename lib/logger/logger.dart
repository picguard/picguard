import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

final logger = Logger(
  printer: PrettyPrinter(),
);

void printDebugLog(Object? object) {
  if (!kReleaseMode) {
    final line = object?.toString();
    logger.d(line);
  }
}

void printWarningLog(Object? object) {
  if (!kReleaseMode) {
    final line = object?.toString();
    logger.w(line);
  }
}

void printErrorLog(
  dynamic error, {
  DateTime? time,
  StackTrace? stackTrace,
}) {
  if (!kReleaseMode) {
    logger.e(null, error: error, stackTrace: stackTrace);
  }
}

FutureOr<bool> printErrorStackLog(dynamic error, StackTrace stackTrace) async {
  if (!kReleaseMode) {
    logger.e(null, error: error, stackTrace: stackTrace);
  }

  return true;
}
