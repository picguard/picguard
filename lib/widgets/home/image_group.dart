// Dart imports:
import 'dart:async';
import 'dart:typed_data';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:bot_toast/bot_toast.dart';
import 'package:collection/collection.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:path/path.dart' hide context;
import 'package:super_drag_and_drop/super_drag_and_drop.dart';

// Project imports:
import 'package:picguard/constants/uuid.dart';
import 'package:picguard/generated/colors.gen.dart';
import 'package:picguard/i18n/i18n.g.dart';
import 'package:picguard/logger/logger.dart';
import 'package:picguard/utils/utils.dart';
import 'package:picguard/widgets/widgets.dart';

/// 图片组
class ImageGroup extends StatefulWidget {
  const ImageGroup({
    required this.controller,
    this.onDropOver,
    this.onDropLeave,
    super.key,
  });

  final MultiImagePickerController controller;
  final void Function(DropOverEvent)? onDropOver;
  final void Function(DropEvent)? onDropLeave;

  @override
  State<ImageGroup> createState() => _ImageGroupState();
}

const initialWeightHeight = 160.0;

class _ImageGroupState extends State<ImageGroup> {
  final initWidgetStateController = WidgetStatesController();
  final addMoreWidgetStateController = WidgetStatesController();

  @override
  void dispose() {
    initWidgetStateController.dispose();
    addMoreWidgetStateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        return SizedBox(
          width: maxWidth,
          child: MultiImagePickerView(
            controller: widget.controller,
            builder: (context, ImageFile imageFile) {
              return DefaultDraggableItemWidget(
                imageFile: imageFile,
                boxDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                closeButtonIcon: const Icon(
                  Icons.delete_rounded,
                  color: Colors.red,
                  size: 16,
                ),
                closeButtonMargin: const EdgeInsets.all(3),
              );
            },
            initialWidget: DropZone(
              onDropOver: _onDropOver,
              onPerformDrop: _onPerformDrop,
              onDropEnded: widget.onDropLeave,
              onDropLeave: widget.onDropLeave,
              body: InitialWidget(
                margin: EdgeInsets.zero,
                statesController: initWidgetStateController,
                height: initialWeightHeight,
                child: const Icon(Icons.add_a_photo),
              ),
            ),
            addMoreButton: DropZone(
              onDropOver: _onDropOver,
              onPerformDrop: _onPerformDrop,
              onDropEnded: widget.onDropLeave,
              onDropLeave: widget.onDropLeave,
              body: AddMoreWidget(
                statesController: addMoreWidgetStateController,
                icon: const Icon(
                  Icons.add,
                  color: PGColors.white,
                  size: 30,
                ),
              ),
            ),
            // Use any Widget or DefaultAddMoreWidget. Use null to hide add more button.
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: maxWidth / 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            shrinkWrap: true,
          ),
        );
      },
    );
  }

  DropOperation _onDropOver(DropOverEvent dropOverEvent) {
    // You can inspect local data here, as well as formats of each item.
    // However on certain platforms (mobile / web) the actual data is
    // only available when the drop is accepted (onPerformDrop).
    final items = dropOverEvent.session.items;
    final maxImages = widget.controller.maxImages;
    final currentImages = widget.controller.images.length;

    final t = Translations.of(context);

    if (currentImages + items.length > maxImages) {
      BotToast.showText(
        text: t.homePage.limitValidator(
          maxImages: maxImages,
          lastImages: maxImages - currentImages,
        ),
      );
      return DropOperation.none;
    }

    final unsupportedFormats = items.where(
      (item) =>
          !(item.canProvide(Formats.png) || item.canProvide(Formats.jpeg)),
    );

    if (unsupportedFormats.isNotEmpty) {
      BotToast.showText(text: t.homePage.formatValidator);
      return DropOperation.none;
    }

    widget.onDropOver?.call(dropOverEvent);

    // This drop region only supports copy operation.
    return dropOverEvent.session.allowedOperations.firstOrNull ??
        DropOperation.none;
  }

  Future<void> _onPerformDrop(PerformDropEvent performDropEvent) async {
    // Called when user dropped the item. You can now request the data.
    // Note that data must be requested before the performDrop callback
    // is over.
    final items = performDropEvent.session.items;
    final maxImages = widget.controller.maxImages;
    final currentImages = widget.controller.images.length;

    if (currentImages + items.length > maxImages) {
      BotToast.showText(
        text: t.homePage.limitValidator(
          maxImages: maxImages,
          lastImages: maxImages - currentImages,
        ),
      );
      return;
    }

    final unsupportedFormats = items.where(
      (item) =>
          !(item.canProvide(Formats.png) || item.canProvide(Formats.jpeg)),
    );

    if (unsupportedFormats.isNotEmpty) {
      BotToast.showText(text: t.homePage.formatValidator);
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

            final imageFile = ImageFile(
              'index_${uuid.v4()}',
              name: fileName!,
              extension: extension(fileName),
              bytes: data,
            );

            addImage.call(imageFile);
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

            addImage.call(imageFile);
          },
          onError: (error) {
            printErrorLog('[JPEG] Error reading value $error');
          },
        );
      }
    }
  }

  void addImage(ImageFile image) {
    final maxImages = widget.controller.maxImages;
    final images = widget.controller.images;
    if (maxImages > images.length) {
      widget.controller.addImage(image);
      setState(() {});
    }
  }
}
