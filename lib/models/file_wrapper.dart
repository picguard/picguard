// Copyright 2023 Insco. All rights reserved.
// This source code is licensed under the GNU General Public License v3.0.
// See the LICENSE file in the project root for full license information.

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
