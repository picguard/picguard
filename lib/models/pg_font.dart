///
class PGFont {
  ///
  const PGFont({
    required this.fontFamily,
    required this.name,
    required this.path,
    required this.boldPath,
  });

  /// 字体家族
  final String fontFamily;

  /// 字体名称
  final String name;

  final String path;
  final String boldPath;
}
