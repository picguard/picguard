// Dart imports:
import 'dart:typed_data';

///
class FileWrapper {
  ///
  const FileWrapper({
    required this.path,
    required this.bytes,
    required this.name,
  });

  ///
  final String path;

  final Uint8List bytes;

  ///
  final String name;
}

class ReturnWrapper {
  ///
  const ReturnWrapper({
    required this.bytes,
    required this.name,
  });

  final Uint8List bytes;

  ///
  final String name;
}
