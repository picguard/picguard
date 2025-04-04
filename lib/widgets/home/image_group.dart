// Dart imports:
import 'dart:async';
import 'dart:typed_data';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:bot_toast/bot_toast.dart';
import 'package:collection/collection.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:path/path.dart';
import 'package:super_drag_and_drop/super_drag_and_drop.dart';

// Project imports:
import 'package:picguard/constants/uuid.dart';
import 'package:picguard/generated/colors.gen.dart';
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

        // return MultiImagePickerView(
        //   controller: widget.controller,
        //   builder: (context, ImageFile imageFile) {
        //     return DefaultDraggableItemWidget(
        //       imageFile: imageFile,
        //       boxDecoration:
        //       BoxDecoration(borderRadius: BorderRadius.circular(10)),
        //       closeButtonIcon: const Icon(
        //         Icons.delete_rounded,
        //         color: Colors.red,
        //         size: 16,
        //       ),
        //       closeButtonMargin: const EdgeInsets.all(3),
        //     );
        //   },
        //   initialWidget: DropZone(
        //     onDropOver: _onDropOver,
        //     onPerformDrop: _onPerformDrop,
        //     onDropEnter: _onDropEnter,
        //     onDropLeave: _onDropLeave,
        //     onDropEnded: _onDropEnded,
        //     body: InitialWidget(
        //       margin: EdgeInsets.zero,
        //       statesController: initWidgetStateController,
        //       height: initialWeightHeight,
        //       child: const Icon(Icons.add_a_photo),
        //     ),
        //   ),
        //   addMoreButton: DropZone(
        //     onDropOver: _onDropOver,
        //     onPerformDrop: _onPerformDrop,
        //     onDropEnter: _onDropEnter,
        //     onDropLeave: _onDropLeave,
        //     onDropEnded: _onDropEnded,
        //     body: AddMoreWidget(
        //       statesController: addMoreWidgetStateController,
        //       icon:
        //       const Icon(Icons.add, color: PGColors.white, size: 30),
        //     ),
        //   ),
        //   // Use any Widget or DefaultAddMoreWidget. Use null to hide add more button.
        //   gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        //     maxCrossAxisExtent: width / 3,
        //     crossAxisSpacing: 10,
        //     mainAxisSpacing: 10,
        //   ),
        //   shrinkWrap: true,
        // );

        return SizedBox(
          width: maxWidth,
          height: double.maxFinite,
          child: Stack(
            children: [
              MultiImagePickerView(
                controller: widget.controller,
                builder: (context, ImageFile imageFile) {
                  return DefaultDraggableItemWidget(
                    imageFile: imageFile,
                    boxDecoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
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
                  // onDropEnter: _onDropEnter,
                  onDropLeave: widget.onDropLeave,
                  // onDropEnded: _onDropEnded,
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
                  // onDropEnter: _onDropEnter,
                  onDropLeave: widget.onDropLeave,
                  // onDropEnded: _onDropEnded,
                  body: AddMoreWidget(
                    statesController: addMoreWidgetStateController,
                    icon:
                        const Icon(Icons.add, color: PGColors.white, size: 30),
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
            ],
          ),
        );

        // return MultiImagePickerView(
        //   controller: widget.controller,
        //   builder: (context, ImageFile imageFile) {
        //     return DefaultDraggableItemWidget(
        //       imageFile: imageFile,
        //       boxDecoration:
        //           BoxDecoration(borderRadius: BorderRadius.circular(10)),
        //       closeButtonIcon:
        //           const Icon(Icons.delete_rounded, color: Colors.red, size: 16),
        //       closeButtonMargin: const EdgeInsets.all(3),
        //     );
        //   },
        //   initialWidget: DropZone(
        //     onDropOver: _onDropOver,
        //     onPerformDrop: _onPerformDrop,
        //     // onDropEnter: onDropEnter,
        //     onDropLeave: _onDropLeave,
        //     // onDropEnded: onDropEnded,
        //     body: _initWidget,
        //     preview: _preview,
        //     width: double.infinity,
        //     height: initialWeightHeight,
        //     opacity: _isDragOver ? 1.0 : 0.0,
        //     // addImage: addImage,
        //   ),
        //   addMoreButton: DropZone(
        //     onDropOver: _onDropOver,
        //     onPerformDrop: _onPerformDrop,
        //     // onDropEnter: onDropEnter,
        //     onDropLeave: _onDropLeave,
        //     // onDropEnded: onDropEnded,
        //     body: _addMoreWidget,
        //     preview: _preview,
        //     width: double.infinity,
        //     height: double.infinity,
        //     opacity: _isDragOver ? 1.0 : 0.0,
        //     // addImage: addImage,
        //   ),
        //   // Use any Widget or DefaultAddMoreWidget. Use null to hide add more button.
        //   gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        //     maxCrossAxisExtent: width / 3,
        //     crossAxisSpacing: 10,
        //     mainAxisSpacing: 10,
        //   ),
        //   shrinkWrap: true,
        // );
      },
    );
  }

  // Future<void> _onPerformDrop(PerformDropEvent event) async {
  //   printDebugLog('_onPerformDrop');
  //   final items = event.session.items;
  //   for (final item in items) {
  //     final reader = item.dataReader!;
  //     if (reader.canProvide(Formats.png)) {
  //       reader.getFile(Formats.png, (value) {
  //         final stream = file.getStream();
  //       }, onError: (error) {
  //         print('Error reading value $error');
  //       });
  //     }
  //
  //     if (reader.canProvide(Formats.jpeg)) {
  //       reader.getFile(Formats.jpeg, (file) {
  //         // Binary files may be too large to be loaded in memory and thus
  //         // are exposed as stream.
  //         final stream = file.getStream();
  //
  //         // Alternatively, if you know that that the value is small enough,
  //         // you can read the entire value into memory:
  //         // (note that readAll is mutually exclusive with getStream(), you
  //         // can only use one of them)
  //         // final data = file.readAll();
  //       }, onError: (error) {
  //         print('Error reading value $error');
  //       });
  //     }
  //   }
  //
  //   // Obtain additional reader information first
  //   // final readers = await Future.wait(
  //   //   event.session.items.map(
  //   //         (e) => ReaderInfo.fromReader(
  //   //       e.dataReader!,
  //   //       localData: e.localData,
  //   //     ),
  //   //   ),
  //   // );
  //   //
  //   // if (!mounted) {
  //   //   return;
  //   // }
  //   //
  //   // buildWidgetsForReaders(context, readers, (value) {
  //   //   setState(() {
  //   //     // Use super_sliver_list to get around bad sliver list performance
  //   //     // with large amount if items.
  //   //     final delegate = SliverChildListDelegate(value
  //   //         .intersperse(const SizedBox(height: 10))
  //   //         .toList(growable: false));
  //   //     _content = CustomScrollView(
  //   //       slivers: [
  //   //         SliverPadding(
  //   //           padding: const EdgeInsets.all(10),
  //   //           sliver: SuperSliverList(delegate: delegate),
  //   //         )
  //   //       ],
  //   //     );
  //   //   });
  //   // });
  // }

  DropOperation _onDropOver(DropOverEvent dropOverEvent) {
    // You can inspect local data here, as well as formats of each item.
    // However on certain platforms (mobile / web) the actual data is
    // only available when the drop is accepted (onPerformDrop).
    final items = dropOverEvent.session.items;
    printDebugLog('[_onDropOver] items: ${items.length}');

    widget.onDropOver?.call(dropOverEvent);

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
  }

  Future<void> _onPerformDrop(PerformDropEvent performDropEvent) async {
    // Called when user dropped the item. You can now request the data.
    // Note that data must be requested before the performDrop callback
    // is over.
    final items = performDropEvent.session.items;
    printDebugLog('[_onPerformDrop] items: ${items.length}');

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

  // void _onDropEnter(DropEvent dropEvent) {
  //   printDebugLog('_onDropEnter');
  //   if (widget.controller.hasNoImages) {
  //     initWidgetStateController.update(WidgetState.hovered, true);
  //   } else {
  //     addMoreWidgetStateController.update(WidgetState.hovered, true);
  //   }
  //   setState(() {});
  // }
  //
  // void _onDropLeave(DropEvent dropEvent) {
  //   printDebugLog('_onDropLeave');
  //   if (widget.controller.hasNoImages) {
  //     initWidgetStateController.update(WidgetState.hovered, false);
  //   } else {
  //     addMoreWidgetStateController.update(WidgetState.hovered, false);
  //   }
  //   setState(() {});
  // }
  //
  // void _onDropEnded(DropEvent dropEvent) {
  //   printDebugLog('_onDropEnded');
  //   if (widget.controller.hasNoImages) {
  //     initWidgetStateController.update(WidgetState.hovered, false);
  //   } else {
  //     addMoreWidgetStateController.update(WidgetState.hovered, false);
  //   }
  //   setState(() {});
  // }

  void addImage(ImageFile image) {
    printDebugLog('addImage');
    final maxImages = widget.controller.maxImages;
    final images = widget.controller.images;
    if (maxImages > images.length) {
      widget.controller.addImage(image);
      setState(() {});
    }
  }
}
