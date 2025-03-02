// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:collection/collection.dart';
import 'package:reorderables/reorderables.dart';

// Project imports:
import 'package:picguard/constants/constants.dart';
import 'package:picguard/extensions/extensions.dart';
import 'package:picguard/logger/logger.dart';
import 'package:picguard/models/models.dart';
import 'package:picguard/theme/colors.dart';
import 'package:picguard/utils/utils.dart';

/// 图片组
class ImageGroup extends StatelessWidget {
  const ImageGroup({
    required this.fileWrappers,
    required this.onRemove,
    required this.onReorder,
    this.pickImages,
    super.key,
  });

  final List<FileWrapper> fileWrappers;
  final void Function(int index) onRemove;
  final ReorderCallback onReorder;
  final VoidCallback? pickImages;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        final width = constraints.maxWidth;
        final contentWidth = width - paddingSize * 2;
        final itemWidth = ((contentWidth - spacing * 2) / 3).floorToDouble();
        final items = fileWrappers
            .mapIndexed(
              (index, element) {
                printDebugLog(element.path);
                final image = kIsWeb
                    ? Image.network(
                        element.path,
                        fit: BoxFit.cover,
                        errorBuilder: (context, url, error) => const Icon(
                          Icons.error,
                          color: errorTextColor,
                          size: 24,
                        ),
                      )
                    : Image.file(
                        File(element.path),
                        fit: BoxFit.cover,
                        errorBuilder: (context, url, error) => const Icon(
                          Icons.error,
                          color: errorTextColor,
                          size: 24,
                        ),
                      );

                Widget child = image;

                if (kIsWeb || isDesktop) {
                  child = SingleChildScrollView(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: child,
                    ),
                  );
                }

                return Stack(
                  children: [
                    child
                        .nestedSizedBox(width: itemWidth, height: itemWidth)
                        .nestedTap(() {
                      final imageProviders = fileWrappers.map((fileWrapper) {
                        return (kIsWeb
                                ? NetworkImage(fileWrapper.path)
                                : FileImage(File(fileWrapper.path)))
                            as ImageProvider;
                      }).toList();
                      DialogUtil.showImagePreviewDialog(
                        imageProviders,
                        initialPage: index,
                      );
                    }),
                    Positioned(
                      top: 2,
                      right: 2,
                      child: const Icon(
                        Icons.clear,
                        color: warnTextColor,
                        size: 14,
                      )
                          .nestedDecoratedBox(
                            decoration: BoxDecoration(
                              color: backgroundColor,
                              borderRadius: BorderRadius.circular(9),
                            ),
                          )
                          .nestedSizedBox(width: 18, height: 18)
                          .nestedTap(() => onRemove(index)),
                    ),
                  ],
                );
              },
            )
            .cast<Widget>()
            .toList();

        if (items.length < 9) {
          items.add(
            const Icon(
              Icons.add,
              size: 40,
              color: borderColor,
            )
                .nestedCenter()
                .nestedDecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: isDark ? Colors.black54 : secondaryGrayColor,
                    border: Border.all(color: borderColor),
                  ),
                )
                .nestedSizedBox(width: itemWidth, height: itemWidth)
                .nestedInkWell(onTap: pickImages),
          );
        }

        return ReorderableWrap(
          spacing: spacing,
          runSpacing: runSpacing,
          onReorder: onReorder,
          scrollPhysics: const NeverScrollableScrollPhysics(),
          alignment:
              fileWrappers.isEmpty ? WrapAlignment.center : WrapAlignment.start,
          children: items,
        );
      },
    );
  }
}
