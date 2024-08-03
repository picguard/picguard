enum Flavor { free, pro }

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

  static AppConfig shared = AppConfig.create();
}
