// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:multi_image_picker_view/multi_image_picker_view.dart';

// Project imports:
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
        borderRadius: BorderRadius.circular(20),
        color: bgColor,
      ),
      width: double.infinity,
      height: double.infinity,
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
            child: CircleAvatar(
              radius: 25,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: icon ?? const Icon(Icons.add, color: PGColors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
