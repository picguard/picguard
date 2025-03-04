// Project imports:
import 'package:picguard/i18n/i18n.g.dart';

class AppConfig {
  factory AppConfig.create({
    Flavor flavor = Flavor.free,
  }) {
    return shared = AppConfig._(flavor);
  }

  AppConfig._(this.flavor);

  final Flavor flavor;

  bool get isFree => flavor == Flavor.free;

  bool get isPro => !isFree;

  String get container => isPro ? 'PicGuardPro' : 'PicGuard';

  static AppConfig shared = AppConfig.create();
}
