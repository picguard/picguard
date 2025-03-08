// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:multi_image_picker_view/multi_image_picker_view.dart';

/// 图片组
class ImageGroup extends StatelessWidget {
  const ImageGroup({
    required this.controller,
    super.key,
  });

  final MultiImagePickerController controller;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        return MultiImagePickerView(
          controller: controller,
          builder: (context, ImageFile imageFile) {
            // here returning DefaultDraggableItemWidget. You can also return your custom widget as well.
            return DefaultDraggableItemWidget(
              imageFile: imageFile,
              boxDecoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              closeButtonIcon:
                  const Icon(Icons.delete_rounded, color: Colors.red, size: 16),
              closeButtonMargin: const EdgeInsets.all(3),
            );
          },
          initialWidget: DefaultInitialWidget(
            centerWidget: const Icon(Icons.add_a_photo),
            backgroundColor:
                Theme.of(context).colorScheme.secondary.withValues(alpha: 0.05),
            margin: EdgeInsets.zero,
          ),
          addMoreButton: DefaultAddMoreWidget(
            icon: const Icon(Icons.add),
            backgroundColor:
                Theme.of(context).colorScheme.primary.withValues(alpha: 0.4),
          ),
          // Use any Widget or DefaultAddMoreWidget. Use null to hide add more button.
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: width / 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          shrinkWrap: true,
        );
      },
    );
  }
}
