// Copyright 2023 Qiazo. All rights reserved.
// This source code is licensed under the GNU General Public License v3.0.
// See the LICENSE file in the project root for full license information.

import 'package:flutter/material.dart';

import 'package:multi_image_picker_view/multi_image_picker_view.dart';

import 'package:picguard/generated/colors.gen.dart';

class AddMoreWidget extends StatelessWidget {
  const AddMoreWidget({
    this.icon,
    this.margin,
    this.backgroundColor,
    this.statesController,
    super.key,
  });

  final Widget? icon;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final WidgetStatesController? statesController;

  @override
  Widget build(BuildContext context) {
    final pickerView = MultiImagePickerView.of(context);
    final bgColor =
        backgroundColor ?? PGColors.primaryColor.withValues(alpha: 0.05);
    return Container(
      margin: margin ?? pickerView.padding,
      decoration: BoxDecoration(
        borderRadius: .circular(20),
        color: bgColor,
      ),
      width: double.infinity,
      height: double.infinity,
      clipBehavior: Clip.hardEdge,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          overlayColor: .resolveWith((states) {
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
            child: CircleAvatar(
              radius: 25,
              child: Padding(
                padding: const .all(10),
                child: icon ?? const Icon(Icons.add, color: PGColors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
