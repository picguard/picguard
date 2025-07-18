// Copyright 2023 Insco. All rights reserved.
// This source code is licensed under the GNU General Public License v3.0.
// See the LICENSE file in the project root for full license information.

// Project imports:
import 'package:picguard/utils/utils.dart';

class PgEnv {
  static String sentryDsn = const String.fromEnvironment('SENTRY_DSN');
  static String gitCommitSha = const String.fromEnvironment('GIT_COMMIT_SHA');
  static String appPreview = const String.fromEnvironment('APP_PREVIEW');

  static bool sentryEnabled = StringUtil.isNotBlank(sentryDsn);
  static bool gitCommitShown = StringUtil.isNotBlank(gitCommitSha);
  static bool appPreviewEnabled = StringUtil.isNotBlank(appPreview);
}
