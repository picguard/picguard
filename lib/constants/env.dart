// Project imports:
import 'package:picguard/utils/utils.dart';

class PgEnv {
  static String sentryDsn = const String.fromEnvironment('SENTRY_DSN');

  static bool sentryEnabled = StringUtil.isNotBlank(sentryDsn);
}
