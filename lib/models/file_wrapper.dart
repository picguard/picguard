// Project imports:
import 'package:picguard/rust/api/picguard.dart';

///
class FileWrapper extends ReturnWrapper {
  ///
  const FileWrapper({
    required this.path,
    required super.bytes,
    required super.name,
  });

  ///
  final String path;
}
