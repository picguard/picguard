// Dart imports:
import 'dart:async';
import 'dart:typed_data';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:bot_toast/bot_toast.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:path/path.dart';
import 'package:super_drag_and_drop/super_drag_and_drop.dart';

// Project imports:
import 'package:picguard/constants/uuid.dart';
import 'package:picguard/logger/logger.dart';
import 'package:picguard/utils/utils.dart';

class DropArea extends StatelessWidget {
  const DropArea({
    required this.child,
    this.addImage,
    this.onDropOver,
    this.onDropEnter,
    this.onDropLeave,
    this.onDropEnded,
    super.key,
  });

  final Widget child;

  final void Function(ImageFile image)? addImage;

  final void Function(DropOverEvent)? onDropOver;

  /// Invoked once after inactive region accepts the drop.
  final void Function(DropEvent)? onDropEnter;

  /// Invoked when dragging leaves the region.
  final void Function(DropEvent)? onDropLeave;

  /// Invoked when drop session has finished.
  final void Function(DropEvent)? onDropEnded;

  @override
  Widget build(BuildContext context) {
    return DropRegion(
      formats: const [
        Formats.png,
        Formats.jpeg,
      ],
      hitTestBehavior: HitTestBehavior.opaque,
      onDropOver: (dropOverEvent) {
        // You can inspect local data here, as well as formats of each item.
        // However on certain platforms (mobile / web) the actual data is
        // only available when the drop is accepted (onPerformDrop).
        onDropOver?.call(dropOverEvent);
        final items = dropOverEvent.session.items;
        printDebugLog('[onDropOver] items: ${items.length}');

        final unsupportedFormats = items.where(
          (item) =>
              !(item.canProvide(Formats.png) || item.canProvide(Formats.jpeg)),
        );

        if (unsupportedFormats.isNotEmpty) {
          BotToast.showText(text: 'Only PNG and JPEG formats are supported');
          return DropOperation.none;
        }

        // This drop region only supports copy operation.
        return dropOverEvent.session.allowedOperations.firstOrNull ??
            DropOperation.none;
      },
      onPerformDrop: (performDropEvent) async {
        // Called when user dropped the item. You can now request the data.
        // Note that data must be requested before the performDrop callback
        // is over.
        final items = performDropEvent.session.items;
        printDebugLog('[onPerformDrop] items: ${items.length}');

        final unsupportedFormats = items.where(
          (item) =>
              !(item.canProvide(Formats.png) || item.canProvide(Formats.jpeg)),
        );

        if (unsupportedFormats.isNotEmpty) {
          BotToast.showText(text: 'Only PNG and JPEG formats are supported');
          return;
        }

        // data reader is available now
        for (final item in items) {
          final reader = item.dataReader!;
          if (reader.canProvide(Formats.png)) {
            reader.getFile(
              Formats.png,
              (file) async {
                // Binary files may be too large to be loaded in memory and thus
                // are exposed as stream.
                final fileName = file.fileName;

                printDebugLog('[PNG] fileName: $fileName');
                if (StringUtil.isBlank(fileName)) {
                  return;
                }

                final stream = file.getStream();
                final chunks = await stream.toList();
                final data = Uint8List.fromList(
                  chunks.expand((chunk) => chunk).toList(),
                );

                // printDebugLog('[PNG] data: $data');

                final imageFile = ImageFile(
                  'index_${uuid.v4()}',
                  name: fileName!,
                  extension: extension(fileName),
                  bytes: data,
                );

                addImage?.call(imageFile);
              },
              onError: (error) {
                printErrorLog('[PNG] Error reading value $error');
              },
            );
          } else if (item.canProvide(Formats.jpeg)) {
            reader.getFile(
              Formats.jpeg,
              (file) async {
                // Binary files may be too large to be loaded in memory and thus
                // are exposed as stream.
                final fileName = file.fileName;

                printDebugLog('[JPEG] fileName: $fileName');
                if (StringUtil.isBlank(fileName)) {
                  return;
                }

                final stream = file.getStream();
                final chunks = await stream.toList();
                final data = Uint8List.fromList(
                  chunks.expand((chunk) => chunk).toList(),
                );

                // printDebugLog('[JPEG] data: $data');

                final imageFile = ImageFile(
                  'index_${uuid.v4()}',
                  name: fileName!,
                  extension: extension(fileName),
                  bytes: data,
                );

                addImage?.call(imageFile);
              },
              onError: (error) {
                printErrorLog('[JPEG] Error reading value $error');
              },
            );
          }
        }
      },
      onDropEnter: onDropEnter,
      onDropLeave: onDropLeave,
      onDropEnded: onDropEnded,
      child: child,
    );
  }
}

class DropZone extends StatelessWidget {
  const DropZone({
    required this.body,
    required this.onDropOver,
    required this.onPerformDrop,
    this.onDropEnter,
    this.onDropLeave,
    this.onDropEnded,
    super.key,
  });

  final Widget body;

  /// Invoked when dragging happens over this region. Implementation should
  /// inspect the drag session from event and return a drop operation
  /// that it can support (or [DropOperation.none]).
  final FutureOr<DropOperation> Function(DropOverEvent) onDropOver;

  /// Invoked when user performs drop on this region.
  final Future<void> Function(PerformDropEvent) onPerformDrop;

  /// Invoked once after inactive region accepts the drop.
  final void Function(DropEvent)? onDropEnter;

  /// Invoked when dragging leaves the region.
  final void Function(DropEvent)? onDropLeave;

  /// Invoked when drop session has finished.
  final void Function(DropEvent)? onDropEnded;

  @override
  Widget build(BuildContext context) {
    return DropRegion(
      formats: const [Formats.png, Formats.jpeg],
      hitTestBehavior: HitTestBehavior.opaque,
      onDropOver: onDropOver,
      onPerformDrop: onPerformDrop,
      onDropEnter: onDropEnter,
      onDropLeave: onDropLeave,
      onDropEnded: onDropEnded,
      child: body,
    );
  }
}
