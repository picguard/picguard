// Copyright 2023 Qiazo. All rights reserved.
// This source code is licensed under the GNU General Public License v3.0.
// See the LICENSE file in the project root for full license information.

import 'package:flutter/material.dart';

import 'package:multi_image_picker_view/multi_image_picker_view.dart';

import 'package:picguard/generated/colors.gen.dart';
import 'package:picguard/widgets/widgets.dart';

/// 图片组
class ImageGroup extends StatefulWidget {
  const ImageGroup({
    required this.controller,
    super.key,
  });

  final MultiImagePickerController controller;

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
                  borderRadius: .circular(10),
                ),
                closeButtonIcon: const Icon(
                  Icons.delete_rounded,
                  color: Colors.red,
                  size: 16,
                ),
                closeButtonMargin: const .all(3),
              );
            },
            initialWidget: InitialWidget(
              margin: .zero,
              statesController: initWidgetStateController,
              height: initialWeightHeight,
              child: const Icon(Icons.add_a_photo),
            ),
            addMoreButton: AddMoreWidget(
              statesController: addMoreWidgetStateController,
              icon: const Icon(
                Icons.add,
                color: PGColors.white,
                size: 30,
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

  void addImage(ImageFile image) {
    final maxImages = widget.controller.maxImages;
    final images = widget.controller.images;
    if (maxImages > images.length) {
      widget.controller.addImage(image);
      setState(() {});
    }
  }
}
