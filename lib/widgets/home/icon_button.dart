// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:picguard/generated/colors.gen.dart';

/// 设置按钮
class IconBtn extends StatelessWidget {
  const IconBtn({
    required this.icon,
    this.iconColor = PGColors.primaryColor,
    this.overlayColor = PGColors.primaryBackgroundColor,
    this.padding = const EdgeInsets.all(10),
    this.iconSize = 24,
    this.borderRadius = const BorderRadius.all(Radius.circular(22)),
    this.onPressed,
    super.key,
  });

  final IconData icon;
  final Color iconColor;
  final Color overlayColor;
  final EdgeInsetsGeometry padding;
  final double iconSize;
  final BorderRadiusGeometry borderRadius;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: ButtonStyle(
        elevation: WidgetStateProperty.all(0),
        minimumSize: WidgetStateProperty.all(Size.zero),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: WidgetStateProperty.all(padding),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: borderRadius),
        ),
        overlayColor: WidgetStateProperty.all(overlayColor),
      ),
      onPressed: onPressed,
      icon: Icon(
        icon,
        size: iconSize,
        color: iconColor,
      ),
    );
  }
}
