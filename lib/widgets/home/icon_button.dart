// Copyright 2023 Insco. All rights reserved.
// This source code is licensed under the GNU General Public License v3.0.
// See the LICENSE file in the project root for full license information.

import 'package:flutter/material.dart';

import 'package:picguard/generated/colors.gen.dart';

/// 设置按钮
class IconBtn extends StatelessWidget {
  const IconBtn({
    required this.icon,
    this.iconColor = PGColors.primaryColor,
    this.overlayColor = PGColors.primaryBackgroundColor,
    this.padding = const .all(10),
    this.iconSize = 24,
    this.borderRadius = const .all(Radius.circular(22)),
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
        elevation: .all(0),
        minimumSize: .all(Size.zero),
        tapTargetSize: .shrinkWrap,
        padding: .all(padding),
        shape: .all(
          RoundedRectangleBorder(borderRadius: borderRadius),
        ),
        overlayColor: .all(overlayColor),
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
