// Copyright 2023 Qiazo. All rights reserved.
// This source code is licensed under the GNU General Public License v3.0.
// See the LICENSE file in the project root for full license information.

import 'package:flutter/material.dart';

import 'package:desktop_drop/desktop_drop.dart';

class DropArea extends StatelessWidget {
  const DropArea({
    required this.child,
    this.onDragUpdated,
    this.onDragEntered,
    this.onDragExited,
    this.onDragDone,
    super.key,
  });

  final Widget child;

  /// Callback when drag hover on target area.
  final void Function(DropEventDetails)? onDragUpdated;

  /// Invoked once after inactive region accepts the drop.
  final void Function(DropEventDetails)? onDragEntered;

  /// Callback when drag exited target area.
  final void Function(DropEventDetails)? onDragExited;

  /// Callback when drag dropped on target area.
  final OnDragDoneCallback? onDragDone;

  @override
  Widget build(BuildContext context) {
    return DropTarget(
      onDragUpdated: onDragUpdated,
      onDragEntered: onDragEntered,
      onDragExited: onDragExited,
      onDragDone: onDragDone,
      child: child,
    );
  }
}
