// Copyright 2023 Insco. All rights reserved.
// This source code is licensed under the GNU General Public License v3.0.
// See the LICENSE file in the project root for full license information.

import 'package:flutter/material.dart';

import 'package:multi_image_picker_view/multi_image_picker_view.dart';

import 'package:picguard/generated/colors.gen.dart';

class InitialWidget extends StatelessWidget {
  const InitialWidget({
    this.child,
    this.margin,
    this.backgroundColor,
    this.height,
    this.statesController,
    super.key,
  });

  final Widget? child;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final double? height;
  final WidgetStatesController? statesController;

  @override
  Widget build(BuildContext context) {
    final pickerView = MultiImagePickerView.of(context);
    final bgColor =
        backgroundColor ?? PGColors.primaryColor.withValues(alpha: 0.05);
    return Container(
      margin: margin ?? pickerView.padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: bgColor,
      ),
      width: double.infinity,
      height: height ?? 160,
      clipBehavior: Clip.hardEdge,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          overlayColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.pressed)) {
              return PGColors.primaryColor.withValues(alpha: 0.15);
            }
            if (states.contains(WidgetState.hovered)) {
              return PGColors.primaryColor.withValues(alpha: 0.15);
            }
            return PGColors.primaryColor.withValues(alpha: 0.07);
          }),
          borderRadius: BorderRadius.circular(4),
          onTap: pickerView.controller.pickImages,
          statesController: statesController,
          child: Center(
            child: child ??
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.add_photo_alternate_outlined,
                      size: 30,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'ADD IMAGES',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
          ),
        ),
      ),
    );
  }
}
