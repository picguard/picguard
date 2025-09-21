// Copyright 2023 Insco. All rights reserved.
// This source code is licensed under the GNU General Public License v3.0.
// See the LICENSE file in the project root for full license information.

import 'package:flutter/material.dart';

import 'package:picguard/generated/colors.gen.dart';

///
class PGAppBar extends AppBar {
  ///
  PGAppBar({
    required this.isDark,
    this.titleName,
    this.titleWidget,
    this.showBottom = true,
    super.key,
    super.actions,
  }) : super(
          title: titleName == null
              ? titleWidget
              : Text(
                  titleName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
          centerTitle: true,
          elevation: 0,
          bottom: !showBottom
              ? null
              : PreferredSize(
                  preferredSize: const Size.fromHeight(0.5),
                  child: Container(
                    color: isDark
                        ? PGColors.secondaryTextColor
                        : PGColors.borderColor,
                    height: 1,
                  ),
                ),
        );

  final String? titleName;
  final Widget? titleWidget;
  final bool isDark;
  final bool showBottom;
}
