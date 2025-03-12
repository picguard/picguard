// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:picguard/generated/colors.gen.dart';
import 'package:picguard/utils/utils.dart';

/// 设置按钮
class SettingsBtn extends StatelessWidget {
  const SettingsBtn({
    this.padding = const EdgeInsets.all(10),
    this.iconSize = 24,
    this.borderRadius = const BorderRadius.all(Radius.circular(22)),
    super.key,
  });

  final EdgeInsetsGeometry padding;
  final double iconSize;
  final BorderRadiusGeometry borderRadius;

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
        overlayColor: WidgetStateProperty.all(PGColors.primaryBackgroundColor),
      ),
      onPressed: DialogUtil.showSettingsModal,
      icon: Icon(
        Icons.settings,
        size: iconSize,
        color: PGColors.primaryColor,
      ),
    );
  }
}

class AboutBtn extends StatelessWidget {
  const AboutBtn({
    this.padding = const EdgeInsets.all(10),
    this.iconSize = 24,
    this.borderRadius = const BorderRadius.all(Radius.circular(22)),
    super.key,
  });

  final EdgeInsetsGeometry padding;
  final double iconSize;
  final BorderRadiusGeometry borderRadius;

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
        overlayColor: WidgetStateProperty.all(PGColors.backgroundColor),
      ),
      onPressed: DialogUtil.showAboutModal,
      icon: Icon(
        Icons.info,
        size: iconSize,
        color: PGColors.warnTextColor,
      ),
    );
  }
}
